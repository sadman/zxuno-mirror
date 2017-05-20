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
    
    output wire z80_reset_n,
    output wire z80_clk,
    output wire z80_int_n,
    output wire z80_nmi_n,    
    output wire z80_busrq_n,
    output wire z80_wait_n,
    input wire z80_halt_n,
    input wire z80_rfsh_n,
    input wire z80_m1_n,
    input wire z80_mreq_n,
    input wire z80_iorq_n,
    input wire z80_rd_n,
    input wire z80_wr_n,
    input wire z80_busak_n,
    input wire [15:0] z80_a,
    inout wire [7:0] z80_d
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
        .clkforz80(clk),
        .clkps2(clkps2),
        .dataps2(dataps2),
        .led(led),
	 
        .z80_reset_n(z80_reset_n),
        .z80_clk(z80_clk),
        .z80_int_n(z80_int_n),
        .z80_nmi_n(z80_nmi_n),
        .z80_m1_n(z80_m1_n),
        .z80_mreq_n(z80_mreq_n),
        .z80_iorq_n(z80_iorq_n),
        .z80_rd_n(z80_rd_n),
        .z80_wr_n(z80_wr_n),
        .z80_a(z80_a),
        .z80_d(z80_d)
    );
endmodule
