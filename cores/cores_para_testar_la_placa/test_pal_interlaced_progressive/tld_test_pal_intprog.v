`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:54:29 10/17/2012 
// Design Name: 
// Module Name:    tld_pal_gen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: Pulsa P para modo PAL, N para NTSC.
//   Se genera un patron de barras de color con señal de 1 kHz de audio
//////////////////////////////////////////////////////////////////////////////////

module tld_test_pal_intprog (
    input wire clk50mhz,
    input wire clkps2,
    input wire dataps2,
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    output wire audio_out_left,
    output wire audio_out_right,
    output wire stdn,
    output wire stdnb
    );
	
	wire clk, clkkbd;
		
	master_clk clkgen (
    .CLKIN_IN(clk50mhz), 
    .CLKDV_OUT(), 
    .CLKFX_OUT(clk),  // 10MHz
    .CLKIN_IBUFG_OUT(), 
    .CLK0_OUT()
    );
	
   assign stdn = 1'b0;  // fijar norma PAL (0), NTSC (1)
   assign stdnb = 1'b1; // y conectamos reloj PAL
   
   reg mode = 1'b0;  // 0=interlaced, 1=progressive   
	genframe the_frame (
		.clk(clk),
		.mode(mode),
		.r(r),
		.g(g),
		.b(b),
		.csync(csync)
		);
        
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
    
    always @(posedge clk) begin
        if (nueva_tecla) begin
            if (!soltada && !extendida) begin
                case (tecla)  // solo respondemos a las teclas N y P
                    8'h4D: begin // P
                             mode <= 1'b1;
                           end
                    8'h31: begin // N
                             mode <= 1'b0;
                           end
                endcase
            end
        end
    end        
endmodule
