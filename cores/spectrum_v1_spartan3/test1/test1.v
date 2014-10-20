`timescale 1ns / 1ns
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:28:18 02/06/2014 
// Design Name: 
// Module Name:    test1 
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

module test1 (
   input wire clk,
   output wire led
   );

   reg [24:0] divisor = 25'h0000000;
   always @(posedge clk)
      divisor <= divisor + 1;
      
   assign led = divisor[24];
endmodule
