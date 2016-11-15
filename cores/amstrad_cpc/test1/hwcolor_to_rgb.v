`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:13 11/15/2016 
// Design Name: 
// Module Name:    hwcolor_to_rgb 
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
module hwcolor_to_rgb (
  input wire [4:0] color,
  output reg [1:0] r,
  output reg [1:0] g,
  output reg [1:0] b
  );

  always @* begin
    case (color)
      5'd00: {r,g,b} = 6'b01_01_01;
      5'd01: {r,g,b} = 6'b01_01_01;
      5'd02: {r,g,b} = 6'b00_11_01;
      5'd03: {r,g,b} = 6'b11_11_01;
      5'd04: {r,g,b} = 6'b00_00_01;
      5'd05: {r,g,b} = 6'b11_00_01;
      5'd06: {r,g,b} = 6'b00_01_01;
      5'd07: {r,g,b} = 6'b11_01_01;
      5'd08: {r,g,b} = 6'b11_00_01;
      5'd09: {r,g,b} = 6'b11_11_01;
      5'd10: {r,g,b} = 6'b11_11_00;
      5'd11: {r,g,b} = 6'b11_11_11;
      5'd12: {r,g,b} = 6'b11_00_00;
      5'd13: {r,g,b} = 6'b11_00_11;
      5'd14: {r,g,b} = 6'b11_01_00;
      5'd15: {r,g,b} = 6'b11_01_11;
      5'd16: {r,g,b} = 6'b00_00_01;
      5'd17: {r,g,b} = 6'b00_01_11;
      5'd18: {r,g,b} = 6'b00_11_00;
      5'd19: {r,g,b} = 6'b00_11_11;
      5'd20: {r,g,b} = 6'b00_00_00;
      5'd21: {r,g,b} = 6'b00_00_11;
      5'd22: {r,g,b} = 6'b00_01_00;
      5'd23: {r,g,b} = 6'b00_01_11;
      5'd24: {r,g,b} = 6'b01_00_01;
      5'd25: {r,g,b} = 6'b01_11_01;
      5'd26: {r,g,b} = 6'b01_11_00;
      5'd27: {r,g,b} = 6'b01_11_11;
      5'd28: {r,g,b} = 6'b01_00_00;
      5'd29: {r,g,b} = 6'b01_00_11;
      5'd30: {r,g,b} = 6'b01_01_00;
      5'd31: {r,g,b} = 6'b01_01_11;
    endcase
  end
endmodule
