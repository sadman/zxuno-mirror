`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:12:04 02/07/2014 
// Design Name: 
// Module Name:    sram 
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

module sram (
    input wire [9:0] a,
    inout wire [7:0] d,
    input wire ce_n,
    input wire oe_n,
    input wire we_n
    );

   reg [7:0] memory[0:1023];
   always @* begin
      if (!ce_n && !we_n)
         memory[a] = d;
   end
   assign #45 d = (ce_n || oe_n || (!ce_n && !we_n))? 8'hZZ : memory[a];
endmodule
