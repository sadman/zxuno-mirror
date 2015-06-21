`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:03:14 06/22/2015 
// Design Name: 
// Module Name:    tld_player 
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
module tld_player (
    input wire clk28,
    input wire rst_n,
    input wire [15:0] a,
    inout wire [7:0] d,
    input wire iorq_n,
    input wire rd_n,
    input wire wr_n,
    output wire data_en_n,
    //------------------
    input wire play,
    input wire stop,
    output wire ear,
    output wire ear_enabled_n,
    //------------------
    output wire [20:0] sramaddr,
    inout wire [7:0] sramdata,
    output wire sramwe_n
    );
    
    wire [7:0] dout;
    assign d = (data_en_n==1'b0)? dout : 8'hZZ;
    
    alltogether the_player (
        // clock and control
        .clk(clk28),
        .rst_n(rst_n),
        // CPU interface
        .a(a),
        .din(dout),  // from device to CPU
        .dout(d),  // from CPU to device
        .oe_n(data_en_n),
        .iorq_n(iorq_n),
        .rd_n(rd_n),
        .wr_n(wr_n),
        // PZX file player interface
        .play(play),
        .stop(stop),
        .ear(ear),
        .oe_ear_n(ear_enabled_n),
        // SRAM interface
        .sramaddr(sramaddr),
        .sramdata(sramdata),
        .sramwe_n(sramwe_n)
    );
endmodule
