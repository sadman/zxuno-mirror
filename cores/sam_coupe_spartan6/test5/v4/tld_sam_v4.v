`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:39:25 07/25/2015 
// Design Name: 
// Module Name:    tld_sam 
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
module tld_sam_v4 (
    input wire clk50mhz,
    // Audio I/O
    input wire ear,
    output wire audio_out_left,
    output wire audio_out_right,
    // Video output
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire hsync,
	 output wire vsync,
    output wire stdn,
    output wire stdnb,
    // SRAM interface
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n,
    // PS/2 keyoard interface
    inout wire clkps2,
    inout wire dataps2
    );

    // Interface with RAM
    wire [18:0] ramaddr;
    wire [7:0] data_from_ram;
    wire [7:0] data_to_ram;
    wire ram_we_n;
    
    // Audio and video
    wire [1:0] sam_r, sam_g, sam_b;
    wire sam_bright;
    
	 // scandoubler
	 wire hsync_pal, vsync_pal;
    wire [2:0] ri = {sam_r, sam_bright};
    wire [2:0] gi = {sam_g, sam_bright};
    wire [2:0] bi = {sam_b, sam_bright};

    assign stdn = 1'b0;  // fijar norma PAL
	assign stdnb = 1'b1; // y conectamos reloj PAL
    
    wire clk24, clk12, clk6, clk8;

    relojes los_relojes (
        .CLK_IN1            (clk50mhz),      // IN
        // Clock out ports
        .CLK_OUT1           (clk24),  // modulo multiplexor de SRAM
        .CLK_OUT2           (clk12),  // ASIC
        .CLK_OUT3           (clk6),   // CPU y teclado PS/2
        .CLK_OUT4           (clk8)    // SAA1099 y DAC
    );

    samcoupe maquina (
        .clk24(clk24),
        .clk12(clk12),
        .clk6(clk6),
        .clk8(clk8),
        .master_reset_n(1'b1),  // esta se�al es s�lo para simulaci�n
        // Video output
        .r(sam_r),
        .g(sam_g),
        .b(sam_b),
        .bright(sam_bright),
	    .hsync_pal(hsync_pal),
		.vsync_pal(vsync_pal),
        // Audio output
        .ear(~ear),
        .audio_out_left(audio_out_left),
        .audio_out_right(audio_out_right),
        // PS/2 keyboard
        .clkps2(clkps2),
        .dataps2(dataps2),
        // SRAM external interface
        .sram_addr(sram_addr),
        .sram_data(sram_data),
        .sram_we_n(sram_we_n)
    );        
	 
	vga_scandoubler #(.CLKVIDEO(12000)) salida_vga (
		.clkvideo(clk12),
		.clkvga(clk24),
		.enable_scandoubling(1'b1),
        .disable_scaneffect(1'b1),
		.ri(ri),
		.gi(gi),
		.bi(bi),
		.hsync_ext_n(hsync_pal),
		.vsync_ext_n(vsync_pal),
		.ro(r),
		.go(g),
		.bo(b),
		.hsync(hsync),
		.vsync(vsync)
   );	 	 
	 
endmodule
