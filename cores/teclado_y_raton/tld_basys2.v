`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:35 02/09/2015 
// Design Name: 
// Module Name:    tld_basys2 
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
module tld_basys2(
    input wire clk50,
    input wire ps2clk,
    input wire ps2data,
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire ledreleased,
    output wire ledextended
    );

    reg [9:0] divisor = 10'h000;
    wire clkps2 = divisor[1];
    wire clkdisplay = divisor[9];
    always @(posedge clk50)
        divisor <= divisor + 1;

    sistema el_circuito (
        .clkps2(clkps2),
        .clkdisplay(clkdisplay),
        .ps2clk(ps2clk),
        .ps2data(ps2data),
        .an(an),
        .seg(seg),
        .ledreleased(ledreleased),
        .ledextended(ledextended)
    );
endmodule
