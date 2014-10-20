`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:33:55 02/07/2014 
// Design Name: 
// Module Name:    tld_para_simulacion 
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

module tld_para_simulacion (
    input wire clk,
    input wire [9:0] a1,
    input wire [9:0] a2,
    input wire [7:0] din1,
    input wire [7:0] din2,
    output wire [7:0] dout1,
    output wire [7:0] dout2,
    input wire oe1_n,
    input wire oe2_n,
    input wire we1_n,
    input wire we2_n
    );

   wire [9:0] a;
   wire [7:0] d;
   wire ce_n, oe_n, we_n;

   sram la_memoria (
    .a(a),
    .d(d),
    .ce_n(ce_n),
    .oe_n(oe_n),
    .we_n(we_n)
    );
    
    dp_memory el_controlador (
    .clk(clk),
    .a1(a1),
    .a2(a2),
    .oe1_n(oe1_n),
    .oe2_n(oe2_n),
    .we1_n(we1_n),
    .we2_n(we2_n),
    .din1(din1),
    .din2(din2),
    .dout1(dout1),
    .dout2(dout2),
    .a(a),
    .d(d),
    .ce_n(ce_n),
    .oe_n(oe_n),
    .we_n(we_n)
    );
endmodule
