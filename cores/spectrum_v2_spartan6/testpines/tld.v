`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:42 12/30/2014 
// Design Name: 
// Module Name:    tld 
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
module tld (
    input wire clk50,
    input wire clkps2,
    input wire dataps2,
    output wire led,
    output wire [36:1] ext
    );

    wire clk;
    
    relojes reloj (
        .CLKIN_IN(clk50), 
        .CLKDV_OUT(), 
        .CLKFX_OUT(clk), 
        .CLKIN_IBUFG_OUT(), 
        .CLK0_OUT(), 
        .LOCKED_OUT()
    );

    sistema el_sistema (
        .clk(clk),
        .clkps2(clkps2),
        .dataps2(dataps2),
        .led(led),
        .salida(ext)
    );
endmodule
