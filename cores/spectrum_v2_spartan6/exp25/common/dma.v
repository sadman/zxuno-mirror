`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:02:46 02/13/2017 
// Design Name: 
// Module Name:    dma 
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

module dma (
   input wire clk,
   input wire rst_n,
   input wire [7:0] zxuno_addr,
   input wire zxuno_regrd,
   input wire zxuno_regwr,
   input wire [7:0] din,
   output reg [7:0] dout,
   output reg oe_n,
   //---- DMA bus -----
   output reg busrq_n,
   input wire busak_n,
   output reg [15:0] dma_a,
   output reg dma_mreq_n,
   output reg dma_iorq_n,
   output reg dma_rd_n,
   output reg dma_wr_n   
   );


endmodule
