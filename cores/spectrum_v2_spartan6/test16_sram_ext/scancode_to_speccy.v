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
    output wire [4:0] user_toggles,
    //------------------------
    input wire [7:0] din,
    output reg [7:0] dout,
    input wire cpuwrite,
    input wire cpuread,
    input wire rewind
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
    reg [7:0] keymap[0:16383];  // 16K x 8 bits
    reg [13:0] addr = 14'h0000;
    reg [13:0] cpuaddr = 14'h0000;  // Direcci�n E/S desde la CPU. Se autoincrementa en cada acceso
    initial begin
        $readmemh ("keyb_es_hex.txt", keymap);
    end
    
    reg [2:0] keyrow1 = 3'h0;
    reg [4:0] keycol1 = 5'h00;
    reg [2:0] keyrow2 = 3'h0;
    reg [4:0] keycol2 = 5'h00;
    reg [2:0] keymodifiers = 3'b000;
    reg [2:0] signalstate = 3'b000;
    reg [4:0] joystate = 5'b00000;
    reg [4:0] togglestate = 5'h00;

    reg rmaster_reset = 1'b0, ruser_reset = 1'b0, ruser_nmi = 1'b0;
    reg rjoyup = 1'b0, rjoydown = 1'b0, rjoyleft = 1'b0, rjoyright = 1'b0, rjoyfire = 1'b0;
    reg [4:0] ruser_toggles = 5'h00;
    assign joyup = rjoyup;
    assign joydown = rjoydown;
    assign joyleft = rjoyleft;
    assign joyright = rjoyright;
    assign joyfire = rjoyfire;
    assign master_reset = rmaster_reset;
    assign user_reset = ruser_reset;
    assign user_nmi = ruser_nmi;
    assign user_toggles = ruser_toggles;
    
    // Asi funciona la matriz de teclado cuando se piden semifilas
    // desde la CPU.
    // Un always @* hubiera quedado m�s claro en la descripci�n
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
        CLEANMATRIX = 4'd0, 
        IDLE        = 4'd1, 
        ADDR0PUT    = 4'd2, 
        ADDR1PUT    = 4'd3, 
        ADDR2PUT    = 4'd4, 
        ADDR3PUT    = 4'd5, 
        TRANSLATE1  = 4'd6,
        TRANSLATE2  = 4'd7,
        TRANSLATE3  = 4'd8,
        CPUTIME     = 4'd9,
        CPUREAD     = 4'd10,
        CPUWRITE    = 4'd11,
        CPUINCADD   = 4'd12,
        UPDCOUNTERS1= 4'd13,
        UPDCOUNTERS2= 4'd14;
        
    reg [3:0] state = CLEANMATRIX;
    reg key_is_pending = 1'b0;
    
    always @(posedge clk) begin
        if (scan_received == 1'b1)
            key_is_pending <= 1'b1;
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
        else if (state == IDLE) begin
            if (key_is_pending == 1'b1) begin
                addr <= {modifiers, extended, scan, 2'b00};  // 1 scan tiene 8 bits + 1 bit para indicar scan extendido + 3 bits para el modificador usado
                state <= ADDR0PUT;
                key_is_pending <= 1'b0;
            end
            else if (cpuread == 1'b1 || cpuwrite == 1'b1 || rewind == 1'b1)
                state <= CPUTIME;
        end
        else if (state == ADDR0PUT) begin
            {keyrow1,keycol1} <= keymap[addr];
            addr <= {modifiers, extended, scan, 2'b01};
            state <= ADDR1PUT;
        end
        else if (state == ADDR1PUT) begin
            {keyrow2,keycol2} <= keymap[addr];
            addr <= {modifiers, extended, scan, 2'b10};
            state <= ADDR2PUT;
        end
        else if (state == ADDR2PUT) begin
            {signalstate,joystate} <= keymap[addr];
            addr <= {modifiers, extended, scan, 2'b11};
            state <= ADDR3PUT;
        end
        else if (state == ADDR3PUT) begin
            {keymodifiers,togglestate} <= keymap[addr];
            state <= TRANSLATE1;
        end
        else if (state == TRANSLATE1) begin
            // Actualiza las 8 semifilas del teclado con la primera tecla
            if (~released) begin            
              row[keyrow1] <= row[keyrow1] & ~keycol1;
            end
            else begin
              row[keyrow1] <= row[keyrow1] | keycol1;
            end
            state <= TRANSLATE2;
        end
        else if (state == TRANSLATE2) begin
            // Actualiza las 8 semifilas del teclado con la segunda tecla
            if (~released) begin            
              row[keyrow2] <= row[keyrow2] & ~keycol2;
            end
            else begin
              row[keyrow2] <= row[keyrow2] | keycol2;
            end
            state <= TRANSLATE3;
         end
         else if (state == TRANSLATE3) begin
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
                ruser_toggles <= ruser_toggles | togglestate;
            else
                ruser_toggles <= ruser_toggles & ~togglestate;
                            
            //state <= UPDCOUNTERS1;
            state <= IDLE;
        end
        else if (state == CPUTIME) begin            
            if (rewind == 1'b1) begin
                cpuaddr = 14'h0000;
                state <= IDLE;
            end
            else if (cpuread == 1'b1) begin
                addr <= cpuaddr;
                state <= CPUREAD;
            end
            else if (cpuwrite == 1'b1) begin
                addr <= cpuaddr;
                state <= CPUWRITE;
            end
            else
                state <= IDLE;
        end
        else if (state == CPUREAD) begin   // CPU wants to read from keymap
            dout <= keymap[addr];
            state <= CPUINCADD;
        end
        else if (state == CPUWRITE) begin
            keymap[addr] <= din;
            state <= CPUINCADD;
        end
        else if (state == CPUINCADD) begin
            if (cpuread == 1'b0 && cpuwrite == 1'b0) begin
                cpuaddr <= cpuaddr + 1;
                state <= IDLE;
            end
        end
//        else if (state == UPDCOUNTERS1) begin            
//            if (~released)
//                keycount <= keycount + 4'b0001;  // suma 1 al contador de pulsaciones
//            else if (released && keycount != 4'b0000)
//                keycount <= keycount + 4'b1111;  // o le resta 1 al contador de pulsaciones, pero sin bajar de 0
//            state <= UPDCOUNTERS2;
//        end
//        else if (state == UPDCOUNTERS2) begin
//            if (keycount == 4'b0000)  // si es la �ltima tecla soltada, limpia la matriz de teclado del Spectrum
//                state <= CLEANMATRIX;
//            else
//                state <= IDLE;
//        end
        else begin
            state <= IDLE;
        end
    end
endmodule
