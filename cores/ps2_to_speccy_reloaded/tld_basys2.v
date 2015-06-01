`timescale 1ns / 1ps
`default_nettype none

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
    inout wire ps2clk,
    inout wire ps2data,
    
    input wire boton1,
    input wire boton2,
    input wire boton3,
    input wire boton4,
    input wire [7:0] sw,
    
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire ledreleased,
    output wire ledextended,
    output wire lederror,
    output wire [4:0] leds
    );

    reg [9:0] divisor = 10'h000;
    always @(posedge clk50)
        divisor <= divisor + 1;

    wire clkps2;
    wire clkdisplay;
    BUFG relojps2 (.I(divisor[3]), .O(clkps2));
    BUFG relojdisplay (.I(divisor[9]), .O(clkdisplay));

    sistema el_circuito (
        .clkps2(clkps2),
        .clkdisplay(clkdisplay),
        .ps2clk(ps2clk),
        .ps2data(ps2data),
        .boton1(boton1),
        .boton2(boton2),
        .boton3(boton3),
        .boton4(boton4),
        .addr(sw),
        .an(an),
        .seg(seg),
        .ledreleased(ledreleased),
        .ledextended(ledextended),
        .lederror(lederror),
        .keycol(leds)
    );
endmodule
