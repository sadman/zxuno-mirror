`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:11 02/13/2014 
// Design Name: 
// Module Name:    dp_memory_v2 
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
module dp_memory_v2 (
    input wire clk,  // 20MHz
    input wire [18:0] a1,
    input wire [18:0] a2,
    input wire oe1_n,
    input wire oe2_n,
    input wire we1_n,
    input wire we2_n,
    input wire [7:0] din1,
    input wire [7:0] din2,
    output wire [7:0] dout1,
    output wire [7:0] dout2,
    
    output reg [18:0] a,
    inout wire [7:0] d,
    output reg ce_n,
    output reg oe_n,
    output reg we_n
    );

   reg ff = 1'b0;
	reg [7:0] doutput1 = 8'hFF;
	reg [7:0] doutput2 = 8'hFF;

   always @(posedge clk) begin
      ff <= ~ff;
   end

   reg [7:0] dsram;
   assign d = dsram;
   always @* begin
      if (ff == 1'b0) begin
         a = a1;
         we_n = we1_n;
         if (we1_n==1'b0)
            dsram = din1;
         else
            dsram = 8'hZZ;
      end
      else begin
         a = a2;
         we_n = we2_n;
         if (we2_n==1'b0)
            dsram = din2;
         else
            dsram = 8'hZZ;
      end
   end
   
   assign dout1 = (oe1_n == 1'b0)? d : 8'hZZ;
   assign dout2 = (oe2_n == 1'b0)? d : 8'hZZ;
endmodule
