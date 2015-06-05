`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:40 06/01/2015 
// Design Name: 
// Module Name:    scancode_to_speccy 
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
module scancode_to_speccy (
    input wire clk,  // el mismo clk de ps/2
    input wire rst,
    input wire scan_received,
    input wire [7:0] scan,
    input wire extended,
    input wire released,
    //------------------------
    input wire [7:0] sp_row,
    output wire [4:0] sp_col,
    output wire user_reset,
    output wire master_reset,
    output wire user_nmi,
    output wire joyup,
    output wire joydown,
    output wire joyleft,
    output wire joyright,
    output wire joyfire,
    output wire [7:0] user_toogles
    );
    
    // las 40 teclas del Spectrum. Se inicializan a "no pulsadas".
    reg [4:0] row[0:7];
    initial begin
        row[0] = 5'b11111;
        row[1] = 5'b11111;
        row[2] = 5'b11111;
        row[3] = 5'b11111;
        row[4] = 5'b11111;
        row[5] = 5'b11111;
        row[6] = 5'b11111;
        row[7] = 5'b11111;
    end
        
    // El gran mapa de teclado y sus registros de acceso
    reg [31:0] keymap[0:4095];  // 4K x 32 bits
    reg [11:0] addr = 12'h000;
    initial begin
        $readmemh ("keyb_es_hex.txt", keymap);
    end
    
    reg [7:0] keyrow = 8'h00;
    reg [4:0] keycol = 5'h00;
    reg [2:0] keymodifiers = 3'b000;
    reg [2:0] signalstate = 3'b000;
    reg [4:0] joystate = 5'b00000;
    reg [7:0] tooglestate = 8'h00;
    always @(posedge clk) begin  // añadir clausula para poder escribir
        keyrow       <= keymap[addr][31:24];
        keycol       <= keymap[addr][23:19];
        keymodifiers <= keymap[addr][18:16];
        signalstate  <= keymap[addr][15:13];
        joystate     <= keymap[addr][12:8];
        tooglestate  <= keymap[addr][7:0];
    end

    reg rmaster_reset = 1'b0, ruser_reset = 1'b0, ruser_nmi = 1'b0;
    reg rjoyup = 1'b0, rjoydown = 1'b0, rjoyleft = 1'b0, rjoyright = 1'b0, rjoyfire = 1'b0;
    reg [7:0] ruser_toogles = 8'h00;
    assign joyup = rjoyup;
    assign joydown = rjoydown;
    assign joyleft = rjoyleft;
    assign joyright = rjoyright;
    assign joyfire = rjoyfire;
    assign master_reset = rmaster_reset;
    assign user_reset = ruser_reset;
    assign user_nmi = ruser_nmi;
    assign user_toogles = ruser_toogles;
    
    // Asi funciona la matriz de teclado cuando se piden semifilas
    // desde la CPU.
    // Un always @* hubiera quedado más claro en la descripción
    // pero por algun motivo, el XST no lo ha admitido en este caso
    assign sp_col = ((sp_row[0] == 1'b0)? row[0] : 5'b11111) &
                    ((sp_row[1] == 1'b0)? row[1] : 5'b11111) &
                    ((sp_row[2] == 1'b0)? row[2] : 5'b11111) &
                    ((sp_row[3] == 1'b0)? row[3] : 5'b11111) &
                    ((sp_row[4] == 1'b0)? row[4] : 5'b11111) &
                    ((sp_row[5] == 1'b0)? row[5] : 5'b11111) &
                    ((sp_row[6] == 1'b0)? row[6] : 5'b11111) &
                    ((sp_row[7] == 1'b0)? row[7] : 5'b11111);
                    
    reg [2:0] modifiers = 3'b000;
    reg [3:0] keycount = 4'b0000;
        
    parameter 
        CLEANMATRIX = 3'd0, 
        IDLE        = 3'd1, 
        ADDRPUT     = 3'd2, 
        TRANSLATE   = 3'd3,
        UPDCOUNTERS = 3'd4;
        
    reg [2:0] state = CLEANMATRIX;
    always @(posedge clk) begin
        if (rst == 1'b1)
            state <= CLEANMATRIX;
        else if (state == CLEANMATRIX) begin
            modifiers <= 3'b000;
            keycount <= 4'b0000;
            row[0] <= 5'b11111;
            row[1] <= 5'b11111;
            row[2] <= 5'b11111;
            row[3] <= 5'b11111;
            row[4] <= 5'b11111;
            row[5] <= 5'b11111;
            row[6] <= 5'b11111;
            row[7] <= 5'b11111;
            state <= IDLE;
        end
        else if (state == IDLE && scan_received == 1'b1) begin
            addr <= {modifiers, extended, scan};  // 1 scan tiene 8 bits + 1 bit para indicar scan extendido + 3 bits para el modificador usado
            state <= ADDRPUT;
        end
        else if (state == ADDRPUT) begin   // deja 1 ciclo de reloj para leer el mapa de teclado a keyrow, keycol, etc.
            state <= TRANSLATE;
        end
        else if (state == TRANSLATE) begin
            // Actualiza las 8 semifilas del teclado
            if (keyrow[0] == 1'b1) begin
                if (~released)
                    row[0] <= row[0] & ~keycol;
                else
                    row[0] <= row[0] | keycol;
            end
            if (keyrow[1] == 1'b1) begin
                if (~released)
                    row[1] <= row[1] & ~keycol;
                else
                    row[1] <= row[1] | keycol;
            end
            if (keyrow[2] == 1'b1) begin
                if (~released)
                    row[2] <= row[2] & ~keycol;
                else
                    row[2] <= row[2] | keycol;
            end
            if (keyrow[3] == 1'b1) begin
                if (~released)
                    row[3] <= row[3] & ~keycol;
                else
                    row[3] <= row[3] | keycol;
            end
            if (keyrow[4] == 1'b1) begin
                if (~released)
                    row[4] <= row[4] & ~keycol;
                else
                    row[4] <= row[4] | keycol;
            end
            if (keyrow[5] == 1'b1) begin
                if (~released)
                    row[5] <= row[5] & ~keycol;
                else
                    row[5] <= row[5] | keycol;
            end
            if (keyrow[6] == 1'b1) begin
                if (~released)
                    row[6] <= row[6] & ~keycol;
                else
                    row[6] <= row[6] | keycol;
            end
            if (keyrow[7] == 1'b1) begin
                if (~released)
                    row[7] <= row[7] & ~keycol;
                else
                    row[7] <= row[7] | keycol;
            end

            // Actualiza modificadores
            if (~released)
                modifiers <= modifiers | keymodifiers;
            else
                modifiers <= modifiers & ~keymodifiers;
                
            // Y de la misma forma tendria que actualizar el joystick, resets y los user_toogles
            if (~released)
                {rjoyup,rjoydown,rjoyleft,rjoyright,rjoyfire} <= {rjoyup,rjoydown,rjoyleft,rjoyright,rjoyfire} | joystate;
            else
                {rjoyup,rjoydown,rjoyleft,rjoyright,rjoyfire} <= {rjoyup,rjoydown,rjoyleft,rjoyright,rjoyfire} & ~joystate;
                
            if (~released)
                {rmaster_reset,ruser_reset,ruser_nmi} <= {rmaster_reset,ruser_reset,ruser_nmi} | signalstate;
            else
                {rmaster_reset,ruser_reset,ruser_nmi} <= {rmaster_reset,ruser_reset,ruser_nmi} & ~signalstate;
                
            if (~released)
                ruser_toogles <= ruser_toogles | tooglestate;
            else
                ruser_toogles <= ruser_toogles & ~tooglestate;
                
            state <= IDLE;
        end
//        else if (state == UPDCOUNTERS) begin
//            state <= IDLE;
//            if (~released)
//                keycount <= keycount + 4'b0001;  // suma 1 al contador de pulsaciones
//            else if (released && keycount != 4'b000) begin
//                keycount <= keycount + 4'b1111;  // o le resta 1 al contador de pulsaciones, pero sin bajar de 0
//                if (keycount == 4'b0001)  // si es la última tecla soltada, limpia la matriz de teclado del Spectrum
//                    state <= CLEANMATRIX;
//            end
//        end
        else begin
            state <= IDLE;
        end
    end
endmodule
