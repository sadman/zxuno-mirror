`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:39:55 05/13/2012 
// Design Name: 
// Module Name:    tv80_to_t80_wrapper 
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

module tv80n_wrapper (
  input wire    reset_n,
  input wire    clk,
  input wire    wait_n,
  input wire    int_n,
  input wire    nmi_n,
  input wire    busrq_n,
  output wire   m1_n,
  output wire   mreq_n,
  output wire   iorq_n,
  output wire   rd_n,
  output wire   wr_n,
  output wire   rfsh_n,
  output wire   halt_n,
  output wire   busak_n,
  output wire [15:0] A,
  input wire [7:0]   di,
  output wire [7:0]  dout,
  
  output wire z80_reset_n,
  output wire z80_clk,
  output wire z80_int_n,
  output wire z80_nmi_n,
  input wire z80_m1_n,
  input wire z80_mreq_n,
  input wire z80_iorq_n,
  input wire z80_rd_n,
  input wire z80_wr_n,
  input wire [15:0] z80_a,
  inout wire [7:0] z80_d
  );
  
  assign z80_reset_n = reset_n;
  assign z80_clk = clk;
  assign z80_int_n = int_n;
  assign z80_nmi_n = nmi_n;
  assign A = z80_a;
  assign m1_n = z80_m1_n;
  assign mreq_n = z80_mreq_n;
  assign iorq_n = z80_iorq_n;
  assign rd_n = z80_rd_n;
  assign wr_n = z80_wr_n;
  assign rfsh_n = 1'b1;
  assign halt_n = 1'b1;
  assign busak_n = 1'b1;

  assign dout = z80_d; 
  assign z80_d = ( (!mreq_n || !iorq_n) && !rd_n)? di : 
               ( (!mreq_n || !iorq_n) && !wr_n)? 8'hZZ :
               8'hFF;

endmodule
