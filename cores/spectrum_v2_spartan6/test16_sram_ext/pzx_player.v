`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:22 06/16/2015 
// Design Name: 
// Module Name:    pzx_player 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pzx_player(
    input wire clk,
    input wire rst_n,
    //--------------------
    input wire [7:0] zxuno_addr,
    input wire regaddr_changed,
    input wire zxuno_regrd,
    input wire zxuno_regwr,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire oe_n,
    //--------------------
    input wire play_in,
    input wire stop_in,
    output wire pulse_out,
    //--------------------
    output wire [20:0] addr,
    output wire we_n,
    inout wire [7:0] data
    );
    
    parameter SRAMDATA      = 8'hFD,
              SRAMADDRINC   = 8'hFC,
              SRAMADDR      = 8'hFB;
              
    parameter IDLE          = 2'd0,
              PROGRESS      = 2'd1,
              INCADD        = 2'd2;
    
    reg [20:0] a = 21'h000000;
    assign addr = a;
    
    assign oe_n = ~(zxuno_addr == SRAMDATA && zxuno_regrd == 1'b1);
    assign we_n = ~(zxuno_addr == SRAMDATA && zxuno_regwr == 1'b1);
    assign data = (we_n == 1'b0)? din : 8'hZZ;
    assign dout = data;
    
    reg [1:0] edplay = 2'b00;
    reg [1:0] edstop = 2'b00;
    wire play = (edplay == 2'b01);
    wire stop = (edstop == 2'b01);
    always @(posedge clk) begin
        edplay <= {edplay[0], play_in};
        edstop <= {edstop[1], stop_in};
    end
        
    // Variables para la reproducción de audio
    reg play_enabled = 1'b0;
    reg [7:0] tag = 8'h00;
    reg [31:0] lblock = 32'h00000000;      // longitud en bytes del bloque actual
    reg [31:0] duration = 32'h00000000;
    reg [34:0] cduration = 35'h000000000; // cuenta ciclos de 28MHz hasta alcanzar el valor de duration
    reg pulse = 1'b0;
    assign pulse_out = pulse;
    
    reg [1:0] state = IDLE;
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            state <= IDLE;
            play_enabled <= 1'b0;
            a <= 21'h000000;            
        end
        else if (play) begin
            play_enabled <= ~play_enabled;
        end    
        else if (state == IDLE) begin
            if ((zxuno_addr == SRAMDATA || zxuno_addr == SRAMADDRINC) && (zxuno_regrd == 1'b1 || zxuno_regwr == 1'b1))
                state <= PROGRESS;
            else if (zxuno_addr == SRAMADDR && zxuno_regwr == 1'b1) begin
                a <= {a[12:0],din};
                state <= PROGRESS;
            end
            else if (play_enabled == 1'b1) begin
                a <= 21'h000000;
                pulse <= 1'b0;
                state <= READTAG;
            end
        end
        else if (state == PROGRESS) begin
            if (zxuno_regrd == 1'b0 && zxuno_regwr == 1'b0) begin
                if (zxuno_addr == SRAMADDRINC)
                    state <= INCADD;
                else
                    state <= IDLE;
            end
        end
        else if (state == INCADD) begin
            a <= a + 1;
            state <= IDLE;
        end
        //------------------------------------------
        else if (play_enabled == 1) begin
            if (state == READTAG) begin
                tag <= data;
                a <= a + 1;
                state <= READLTAG1;
            end
            else if (state == READLTAG1) begin
                lblock[7:0] <= data;  // LSB
                a <= a + 1;
                state <= READLTAG2;
            end
            else if (state == READLTAG2) begin
                lblock[15:8] <= data;
                a <= a + 1;
                state <= READLTAG3;
            end
            else if (state == READLTAG3) begin
                lblock[23:16] <= data;
                a <= a + 1;
                state <= READLTAG3;
            end
            else if (state == READLTAG4) begin
                lblock[31:24] <= data;  // Ya tenemos en lblock el tamaño del bloque
                a <= a + 1;
                pulse <= 1'b0;  // Valor inicial del pulso en cada bloque
                if (tag == STOP)
                    state <= STOP1;
                else if (tag == PAUSE)
                    state <= PAUSE1;
                else if (tag == PULSE)
                    state <= PULSE1;
                else if (tag == DATA)
                    state <= DATA1;
                else
                    state <= FULLSTOP;
            end

            else if (state == FULLSTOP) begin
                play_enabled <= 1'b0;
                state <= IDLE;
            end

            else if (state == STOP1) begin
                play_enabled <= 1'b0;  // se para la maquina de estados
                state <= READTAG;
            end

            else if (state == PAUSE1) begin
                duration[7:0] <= data;  // LSB
                a <= a + 1;
                state <= PAUSE2;
            end
            else if (state == PAUSE2) begin
                duration[15:8] <= data;
                a <= a + 1;
                state <= PAUSE3;
            end
            else if (state == PAUSE3) begin
                duration[23:16] <= data;
                a <= a + 1;
                state <= PAUSE4;
            end
            else if (state == PAUSE4) begin
                duration[31:24] <= {1'b0,data[6:0]};  // Ya tenemos en duration la duracion en estados de CPU
                pulse <= data[7];
                cduration <= 35'h000000000;
                a <= a + 1;
                state <= DOPAUSE;
            end
            else if (state == DOPAUSE) begin
                if (cduration[34:3] == duration)
                    state <= READTAG;
                else
                    cduration <= cduration + 1;
            end
            
            else if (state == PULSE1) begin
                if (lblock !=32'h00000000) begin
                    cduration <= 35'h000000000;
                    duration[7:0] <= data;
                    pulsecounter <= 16'h0001;
                    a <= a + 1;
                    lblock <= lblock - 1;
                    state <= PULSE2;
                end
                else begin
                    state <= READTAG;
                end
            end
            else if (state == PULSE2) begin
                duration[|5:8] <= data;
                a <= a + 1;
                lblock <= lblock - 1;
                state <= PULSE3;
            end
            else if (state == PULSE3) begin
                if (duration[15:0]>16'h8000) begin
                    pulsecounter <= {1'b0,duration[14:0]};
                    duration[7:0] <= data;
                    a <= a + 1;
                    lblock <= lblock - 1;
                    state <= PULSE4;
                end
                else begin
                    state <= PULSE5;
                end
            end
            else if (state == PULSE4) begin
                duration[15:8] <= data;
                a <= a + 1;
                lblock <= lblock - 1;
                state <= PULSE5;
            end
            else if (state == PULSE5) begin
                if (duration[15] == 1'b1) begin
                    duration[30:16] <= {1'b0,duration[14:0]};
                    duration[7:0] <= data;
                    a <= a + 1;
                    lblock <= lblock - 1;
                    state <= PULSE6;
                end
                else begin
                    state <= DOPULSE1;
                end
            end
            else if (state == PULSE6) begin
                duration[15:8] <= data;
                a <= a + 1;
                lblock <= lblock - 1;
                state <= DOPULSE1;
            end
            else if (state == DOPULSE1) begin  // caso especial de duration=0
                if (duration==32'h00000000) begin
                    pulse <= pulsecounter[0];
                    state <= PULSE1;
                end
                else if (cduration[35:3] == duration) begin
                    pulse <= ~pulse;
                    cduration <= 35'h000000000;
                    if (pulsecounter == 16'h0001) begin // se ha acabado el tren de pulsos
                        state <= PULSE1;
                    end
                    else begin
                        pulsecounter <= pulsecounter - 1;
                    end
                end
                else begin
                    cduration <= cduration + 1;
                end
            end
                
        end // de toda la FSM de reproduccion
    end
endmodule
