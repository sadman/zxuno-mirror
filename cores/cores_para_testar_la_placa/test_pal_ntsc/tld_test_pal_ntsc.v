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

module tld_test_pal_ntsc (
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
	
	wire clk7;
		
	master_clk clkgen (
    .CLKIN_IN(clk50mhz), 
    .CLKDV_OUT(), 
    .CLKFX_OUT(clk7), 
    .CLKIN_IBUFG_OUT(), 
    .CLK0_OUT()
    );
	
    // sonido de 1khz por la salida de audio
    reg [11:0] divisor = 12'h000;
    reg sqwave1khz = 1'b0;
    assign audio_out_left = sqwave1khz;
    assign audio_out_right = sqwave1khz;    
    always @(posedge clk7) begin
        if (divisor == 12'd3499) begin
            divisor <= 12'd0;
            sqwave1khz <= ~sqwave1khz;
        end
        else
            divisor <= divisor + 12'd1;
    end

    reg mode = 1'b0; // PAL
    assign stdn = mode;  // fijar norma PAL (0), NTSC (1)
    assign stdnb = ~mode; // y conectamos reloj PAL
    
	dummy_ula ula (
		.clk(clk7),
		.mode(stdn),
		.r(r),
		.g(g),
		.b(b),
		.csync(csync)
		);
        
    wire [7:0] tecla;
    wire nueva_tecla, soltada, extendida;

	ps2_port el_teclado (
		.clk(clk7),
		.enable_rcv(1'b1),
		.ps2clk_ext(clkps2),
		.ps2data_ext(dataps2),
		.kb_interrupt(nueva_tecla),
		.scancode(tecla),
		.released(soltada),
		.extended(extendida)
    );
    
    always @(posedge clk7) begin
        if (nueva_tecla) begin
            if (!soltada && !extendida) begin
                case (tecla)  // solo respondemos a las teclas N y P
                    8'h4D: begin // P
                             mode <= 1'b0;
                           end
                    8'h31: begin // N
                             mode <= 1'b1;
                           end
                endcase
            end
        end
    end        
endmodule
