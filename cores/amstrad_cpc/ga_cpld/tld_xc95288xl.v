`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:06 07/18/2017 
// Design Name: 
// Module Name:    tld_xc95216 
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

module tld_xc95288xl (
  // clock y reset
  input wire ck16,
  input wire reset_n,
  // interface con la CPU
  input wire a15,
  input wire a14,
  input wire mreq_n,
  input wire iorq_n,
  input wire m1_n,
  input wire rd_n,
  output wire phi_n,
  output wire ready,
  output wire int_n,
  input wire [7:0] d,
  // interface con el 6845
  input wire vsync,
  input wire hsync,
  input wire dispen,
  output wire cclk,
  // control para la glue logic
  output wire en244_n,
  output wire cpu_n,
  output wire romen_n,
  output wire ramrd_n,
  // interface para la DRAM
  output wire ras_n,
  output wire cas_n,
  output wire casad_n,
  output wire mwe_n,
  // salida de video
  output wire sync_n,    // necesita adaptacion a 5V  
  output wire r,         // 
  output wire r_oe_n,
  output wire g,         // 1, Z, o 0
  output wire g_oe_n,
  output wire b,         //
  output wire b_oe_n
  );

  wire red_oe, green_oe, blue_oe;
  wire clk_cpu;
  
  wire rfsh_n;
  rfsh_generator senal_refresh (
    .clk16(ck16),
    .reset_n(reset_n),
    .mreq_n(mreq_n),
    .m1_n(m1_n),
    .rfsh_n(rfsh_n)
  );
    
	ga40010 gate_array (
		.ck16(ck16), 
		.reset_n(reset_n), 
		.a15(a15), 
		.a14(a14), 
		.mreq_n(mreq_n), 
		.iorq_n(iorq_n), 
		.m1_n(m1_n), 
		.rd_n(rd_n), 
    .rfsh_n(rfsh_n),
		.phi_n(clk_cpu), 
		.ready(ready), 
		.int_n(int_n), 
		.d(d), 
		.vsync(vsync), 
		.hsync(hsync), 
		.dispen(dispen), 
		.cclk(cclk), 
		.en244_n(en244_n), 
		.cpu_n(cpu_n), 
		.romen_n(romen_n), 
		.ramrd_n(ramrd_n), 
		.ras_n(ras_n), 
		.cas_n(cas_n), 
		.casad_n(casad_n), 
		.mwe_n(mwe_n), 
		.sync_n(sync_n), 
		.red(r), 
		.red_oe(red_oe), 
		.green(g), 
		.green_oe(green_oe), 
		.blue(b), 
		.blue_oe(blue_oe)
	);
  
  assign r_oe_n = ~red_oe;
  assign g_oe_n = ~green_oe;
  assign b_oe_n = ~blue_oe;
  assign phi_n = clk_cpu;

endmodule
