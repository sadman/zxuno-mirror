`timescale 1ns / 1ps
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
  // Outputs
  m1_n, mreq_n, iorq_n, rd_n, wr_n, rfsh_n, halt_n, busak_n, A, dout,
  // Inputs
  reset_n, clk, wait_n, int_n, nmi_n, busrq_n, di
  );

  input         reset_n; 
  input         clk; 
  input         wait_n; 
  input         int_n; 
  input         nmi_n; 
  input         busrq_n; 
  output        m1_n; 
  output        mreq_n; 
  output        iorq_n; 
  output        rd_n; 
  output        wr_n; 
  output        rfsh_n; 
  output        halt_n; 
  output        busak_n; 
  output [15:0] A;
  input [7:0]   di;
  output [7:0]  dout;

  wire [7:0] d;

z80_top_direct_n TheCPU (
    .nM1(m1_n),
    .nMREQ(mreq_n),
    .nIORQ(iorq_n),
    .nRD(rd_n),
    .nWR(wr_n),
    .nRFSH(rfsh_n),
    .nHALT(halt_n),
    .nBUSACK(busak_n),

    .nWAIT(wait_n),
    .nINT(int_n),
    .nNMI(nmi_n),
    .nRESET(reset_n),
    .nBUSRQ(busrq_n),

    .CLK(clk),
    .A(A),
    .D(d)
    );
	
	assign dout = d; 
	assign d = ( (!mreq_n || !iorq_n) && !rd_n)? di : 
               ( (!mreq_n || !iorq_n) && !wr_n)? 8'hZZ :
               8'hFF;
endmodule
