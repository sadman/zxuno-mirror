`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:37 02/09/2015 
// Design Name: 
// Module Name:    sistema 
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
module sistema(
    input wire clkps2,
    input wire clkdisplay,
    input wire ps2clk,
    input wire ps2data,
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire ledreleased,
    output wire ledextended
    );
    
    wire [7:0] scancode;        
    ps2_port el_teclado (
        .clk(clkps2),
        .enable_rcv(1'b1),
        .ps2clk_ext(ps2clk),
        .ps2data_ext(ps2data),
        .kb_interrupt(),
        .scancode(scancode),
        .released(ledreleased),
        .extended(ledextended)
    );
    
    display el_display (
        .clk(clkdisplay),
        .d({8'h00,scancode}),
        .an(an),
        .seg(seg)
    );
endmodule
