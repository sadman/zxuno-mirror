`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:57:57 12/30/2014 
// Design Name: 
// Module Name:    sistema 
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
module sistema(
    input wire clk,
    input wire clkps2,
    input wire dataps2,
    output reg led,
    output reg [36:1] salida
    );

    reg [19:0] divisor = 20'h00000;
    always @(posedge clk)
        divisor <= divisor + 1;
    wire parpadeo = divisor[19];  // unas 5 veces por segundo
    
    reg [7:0] codigo = 8'd99;
    
    always @* begin
        salida[3:1] = 3'b000;
        salida[36:7] = 30'h00000000;
        salida[6:4] = 3'bXXX;
        led = 1'b0;
        if (codigo == 8'd99)
            led = parpadeo;
        else if ( (codigo>=8'h01 && codigo<=8'h03) || (codigo>=8'h07 && codigo<=8'h36) )  //EXT4 a EXT6 no existen
            salida[codigo] = parpadeo;
    end

    wire [7:0] tecla;
    wire nueva_tecla, soltada, extendida;
    
	ps2_port el_teclado (
		.clk(clk),
		.enable_rcv(1'b1),
		.ps2clk_ext(clkps2),
		.ps2data_ext(dataps2),
		.kb_interrupt(nueva_tecla),
		.scancode(tecla),
		.released(soltada),
		.extended(extendida)
    );
    
    reg hilo = 1'b0;
    reg [3:0] buffer[0:1];
    always @(posedge clk) begin
        if (nueva_tecla) begin
            if (!soltada && extendida && tecla==8'h5A) begin // se pulso Intro
                codigo <= buffer[0]*10 + buffer[1];  // conversion cutre de BCD a binario
                hilo <= 1'b0;
            end
            else if (!soltada && !extendida) begin
                case (tecla)  // solo respondemos a las teclas del bloque numerico del keypad
                    8'h70: begin
                             buffer[hilo] <= 4'h0;
                             hilo <= ~hilo;
                           end
                    8'h69: begin
                             buffer[hilo] <= 4'h1;
                             hilo <= ~hilo;
                           end
                    8'h72: begin
                             buffer[hilo] <= 4'h2;
                             hilo <= ~hilo;
                           end
                    8'h7A: begin
                             buffer[hilo] <= 4'h3;
                             hilo <= ~hilo;
                           end
                    8'h6B: begin
                             buffer[hilo] <= 4'h4;
                             hilo <= ~hilo;
                           end
                    8'h73: begin
                             buffer[hilo] <= 4'h5;
                             hilo <= ~hilo;
                           end
                    8'h74: begin
                             buffer[hilo] <= 4'h6;
                             hilo <= ~hilo;
                           end
                    8'h6C: begin
                             buffer[hilo] <= 4'h7;
                             hilo <= ~hilo;
                           end
                    8'h75: begin
                             buffer[hilo] <= 4'h8;
                             hilo <= ~hilo;
                           end
                    8'h7D: begin
                             buffer[hilo] <= 4'h9;
                             hilo <= ~hilo;
                           end
                endcase
            end
        end
    end        
endmodule
