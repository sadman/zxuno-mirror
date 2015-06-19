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
module pzx_player (
    input wire clk,
    input wire rst_n,
    //--------------------
    input wire [7:0] zxuno_addr,
    input wire zxuno_regrd,
    input wire zxuno_regwr,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire oe_n,
    //--------------------
    input wire play_in,
    input wire stop_in,
    output wire pulse_out,
    output wire playing,
    //--------------------
    output wire [20:0] addr,
    output wire we_n,
    inout wire [7:0] data
    );
    
    parameter SRAMDATA      = 8'hFD,
              SRAMADDRINC   = 8'hFC,
              SRAMADDR      = 8'hFB;
              
    parameter IDLE          = 6'd0,
              PROGRESS      = 6'd1,
              INCADD        = 6'd2,
              READTAG       = 6'd3,
              READLTAG1     = 6'd4,
              READLTAG2     = 6'd5,
              READLTAG3     = 6'd6,
              READLTAG4     = 6'd7,
              STOP1         = 6'd8,
              PAUSE1        = 6'd9,
              PAUSE2        = 6'd10,
              PAUSE3        = 6'd11,
              PAUSE4        = 6'd12,
              DOPAUSE       = 6'd13,
              PULSE1        = 6'd14,
              PULSE2        = 6'd15,
              PULSE3        = 6'd16,
              PULSE4        = 6'd17,
              PULSE5        = 6'd18,
              PULSE6        = 6'd19,
              DOPULSE       = 6'd20,
              FULLSTOP1     = 6'd21,
              DATA1         = 6'd22,
              DATA2         = 6'd23,
              DATA3         = 6'd24,
              DATA4         = 6'd25,
              DATATAIL1     = 6'd26,
              DATATAIL2     = 6'd27,
              READNPULSE0   = 6'd28,
              READNPULSE1   = 6'd29,
              READDPULSE0_1 = 6'd30,
              READDPULSE0_2 = 6'd31,
              READDPULSE1_1 = 6'd32,
              READDPULSE1_2 = 6'd33,
              READDATA1     = 6'd34,
              OUTPUTBIT1    = 6'd35,
              OUTPUTBIT2    = 6'd36,
              DATADOTAIL    = 6'd37;

    parameter FULLSTOP      = 8'd0,
              STOP          = 8'd1,
              PULSE         = 8'd2,
              DATA          = 8'd3,
              PAUSE         = 8'd4;
    
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
        edstop <= {edstop[0], stop_in};
    end
        
    // Variables para la reproducción de audio
    reg play_enabled = 1'b0;
    reg [7:0] tag = 8'h00;
    reg [31:0] lblock = 32'h0;      // longitud en bytes del bloque actual
    reg [30:0] duration = 32'h0;
    reg [33:0] cduration = 34'h0; // cuenta ciclos de 28MHz hasta alcanzar el valor de duration
    reg [15:0] pulsecounter = 16'h0;
    reg [15:0] pulse0[0:31];
    reg [15:0] pulse1[0:31];
    reg [4:0] indexpulse = 5'd0;
    reg [4:0] numberpulse0 = 5'd0;
    reg [4:0] numberpulse1 = 5'd0;
    reg [30:0] numberofbits = 31'h0;
    reg [15:0] durationextrapulse = 16'h0000;
    reg [7:0] databyte = 3'd0;
    reg [3:0] countbits = 4'd0;
    reg pulse = 1'b0;
    assign pulse_out = pulse;
    assign playing = play_enabled;
    
    reg [5:0] state = IDLE;
    always @(posedge clk) begin
        if (rst_n == 1'b0) begin
            state <= IDLE;
            play_enabled <= 1'b0;
            a <= 21'h000000;            
        end
        else if (play) begin
            play_enabled <= ~play_enabled;
        end    
        else if (stop) begin
            play_enabled <= 1'b0;
            a <= 21'h000000;
            state <= IDLE;
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
            a <= a + 21'b1;
            state <= IDLE;
        end
        //------------------------------------------
        else if (play_enabled == 1'b1) begin
            if (state == READTAG) begin
                tag <= data;
                a <= a + 21'b1;
                state <= READLTAG1;
            end
            else if (state == READLTAG1) begin
                lblock[7:0] <= data;  // LSB
                a <= a + 21'b1;
                state <= READLTAG2;
            end
            else if (state == READLTAG2) begin
                lblock[15:8] <= data;
                a <= a + 21'b1;
                state <= READLTAG3;
            end
            else if (state == READLTAG3) begin
                lblock[23:16] <= data;
                a <= a + 21'b1;
                state <= READLTAG4;
            end
            else if (state == READLTAG4) begin
                lblock[31:24] <= data;  // Ya tenemos en lblock el tamaño del bloque
                a <= a + 21'b1;
                if (tag == STOP)
                    state <= STOP1;
                else if (tag == PAUSE)
                    state <= PAUSE1;
                else if (tag == PULSE) begin
                    pulse <= 1'b0;  // Valor inicial del pulso en este bloque
                    state <= PULSE1;
                end
                else if (tag == DATA)
                    state <= DATA1;
                else
                    state <= FULLSTOP1;
            end

            else if (state == FULLSTOP1) begin
                play_enabled <= 1'b0;
                a <= 21'h000000;
                state <= IDLE;
            end

            else if (state == STOP1) begin
                play_enabled <= 1'b0;  // se para la maquina de estados
                state <= READTAG;
            end

            else if (state == PAUSE1) begin
                duration[7:0] <= data;  // LSB
                a <= a + 21'b1;
                state <= PAUSE2;
            end
            else if (state == PAUSE2) begin
                duration[15:8] <= data;
                a <= a + 21'b1;
                state <= PAUSE3;
            end
            else if (state == PAUSE3) begin
                duration[23:16] <= data;
                a <= a + 21'b1;
                state <= PAUSE4;
            end
            else if (state == PAUSE4) begin
                {pulse,duration[30:24]} <= data;  // Ya tenemos en duration la duracion en estados de CPU
                cduration <= 34'h000000000;
                a <= a + 21'b1;
                state <= DOPAUSE;
            end
            else if (state == DOPAUSE) begin
                if (cduration == {duration,3'b000})
                    state <= READTAG;
                else
                    cduration <= cduration + 34'd1;
            end
            
            else if (state == PULSE1) begin
                if (lblock !=32'h00000000) begin
                    cduration <= 34'h000000000;
                    duration[7:0] <= data;
                    pulsecounter <= 16'h0001;
                    a <= a + 21'b1;
                    lblock <= lblock - 1;
                    state <= PULSE2;
                end
                else begin
                    state <= READTAG;
                end
            end
            else if (state == PULSE2) begin
                duration[15:8] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= PULSE3;
            end
            else if (state == PULSE3) begin
                if (duration[15:0]>16'h8000) begin
                    pulsecounter <= {1'b0,duration[14:0]};
                    duration[7:0] <= data;
                    a <= a + 21'b1;
                    lblock <= lblock - 1;
                    state <= PULSE4;
                end
                else begin
                    state <= PULSE5;
                end
            end
            else if (state == PULSE4) begin
                duration[15:8] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= PULSE5;
            end
            else if (state == PULSE5) begin
                if (duration[15] == 1'b1) begin
                    duration[30:16] <= {1'b0,duration[14:0]};
                    duration[7:0] <= data;
                    a <= a + 21'b1;
                    lblock <= lblock - 1;
                    state <= PULSE6;
                end
                else begin
                    state <= DOPULSE;
                end
            end
            else if (state == PULSE6) begin
                duration[15:8] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DOPULSE;
            end
            else if (state == DOPULSE) begin  // caso especial de duration=0
                if (duration==32'h00000000) begin
                    pulse <= pulsecounter[0];
                    state <= PULSE1;
                end
                else if (cduration == {duration,3'b000} ) begin
                    pulse <= ~pulse;
                    cduration <= 34'h000000000;
                    if (pulsecounter == 16'h0001) begin // se ha acabado el tren de pulsos
                        state <= PULSE1;
                    end
                    else begin
                        pulsecounter <= pulsecounter - 16'd1;
                    end
                end
                else begin
                    cduration <= cduration + 34'd1;
                end
            end
            else if (state == DATA1) begin  // DATA1 a 4 para leer numero de bits en bloque
                numberofbits[7:0] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DATA2;
            end
            else if (state == DATA2) begin
                numberofbits[15:8] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DATA3;
            end
            else if (state == DATA3) begin
                numberofbits[23:16] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DATA4;
            end
            else if (state == DATA4) begin
                {pulse,numberofbits[30:24]} <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DATATAIL1;
            end
            else if (state == DATATAIL1) begin  // DATATAIL1 y 2 leen la duración del pulso extra
                durationextrapulse[7:0] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= DATATAIL2;
            end
            else if (state == DATATAIL2) begin
                durationextrapulse[15:8] <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= READNPULSE0;
            end
            else if (state == READNPULSE0) begin  // Leer cantidad de pulsos para bit 0
                numberpulse0 <= data[4:0];
                indexpulse <= 5'd0;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= READNPULSE1;
            end
            else if (state == READNPULSE1) begin  // Leer cantidad de pulsos para bit 1
                numberpulse1 <= data[4:0];
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= READDPULSE0_1;
            end
            else if (state == READDPULSE0_1) begin  // Leer secuencia de pulsos para 0
                if (indexpulse == numberpulse0) begin
                    indexpulse <= 5'd0;
                    state <= READDPULSE1_1;
                end
                else begin
                    pulse0[indexpulse][7:0] <= data;
                    a <= a + 21'b1;
                    lblock <= lblock - 1;
                    state <= READDPULSE0_2;
                end
            end
            else if (state == READDPULSE0_2) begin
                pulse0[indexpulse][15:8] <= data;
                indexpulse <= indexpulse + 5'd1;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= READDPULSE0_1;
            end
            else if (state == READDPULSE1_1) begin  // Leer secuencia de pulsos para 1
                if (indexpulse == numberpulse1) begin
                    state <= READDATA1;
                end
                else begin
                    pulse1[indexpulse][7:0] <= data;
                    a <= a + 21'b1;
                    lblock <= lblock - 1;
                    state <= READDPULSE1_2;
                end
            end
            else if (state == READDPULSE1_2) begin
                pulse1[indexpulse][15:8] <= data;
                indexpulse <= indexpulse + 5'd1;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                state <= READDPULSE1_1;
            end
            else if (state == READDATA1) begin
                databyte <= data;
                a <= a + 21'b1;
                lblock <= lblock - 1;
                countbits <= 4'd8;
                indexpulse <= 5'd0;
                state <= OUTPUTBIT1;
            end
            else if (state == OUTPUTBIT1) begin
                if (numberofbits == 31'h0) begin
                    duration <= {16'h0000,durationextrapulse};
                    cduration <= 34'h0;
                    state <= DATADOTAIL;
                end
                else if (countbits == 0) begin
                    state <= READDATA1;                    
                end
                else if ((databyte[7] == 1'b0 && indexpulse == numberpulse0) ||
                         (databyte[7] == 1'b1 && indexpulse == numberpulse1)) begin
                    databyte <= {databyte[6:0],1'b0};
                    numberofbits <= numberofbits - 31'd1;
                    countbits <= countbits - 4'd1;
                    indexpulse <= 5'd0;
                end
                else begin
                    if (databyte[7] == 1'b0)
                        duration <= {16'h0000,pulse0[indexpulse]};
                    else
                        duration <= {16'h0000,pulse1[indexpulse]};
                    cduration <= 34'h0;
                    indexpulse <= indexpulse + 5'd1;
                    state <= OUTPUTBIT2;
                end
            end
            else if (state == OUTPUTBIT2) begin
                if (cduration == {duration,3'b000}) begin
                    pulse <= ~pulse;
                    state <= OUTPUTBIT1;
                end
                else begin
                    cduration <= cduration + 34'd1;
                end
            end
            else if (state == DATADOTAIL) begin
                if (cduration == {duration,3'b000}) begin
                    pulse <= ~pulse;
                    state <= READTAG;
                end
                else begin
                    cduration <= cduration + 34'd1;
                end
            end                
        end // de toda la FSM de reproduccion
    end
endmodule
