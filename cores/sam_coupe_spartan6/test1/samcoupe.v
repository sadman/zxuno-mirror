`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:54:40 07/25/2015 
// Design Name: 
// Module Name:    samcoupe 
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
module samcoupe (
    input wire clk12,
    input wire clk6,
    input wire rst_n,
    input wire nmi_n,
    // ROM device
    output wire [14:0] romaddr,
    input wire [7:0] data_from_rom,
    // RAM device
    output wire [18:0] ramaddr,
    input wire [7:0] data_from_ram,
    output wire [7:0] data_to_ram,
    output wire ram_we_n,
    // Keyboard
    output wire [8:0] kbrows,
    input wire [7:0] kbcolumns,
    // Video output
    output wire [1:0] r,
    output wire [1:0] g,
    output wire [1:0] b,
    output wire bright,
    output wire csync,
    // Audio output
    input wire ear,
    output wire beep
    );
    
    // CPU signals
    wire mreq_n, iorq_n, rd_n, wr_n, int_n, wait_n;
    wire [15:0] cpuaddr;
    wire [7:0] data_from_cpu;
    wire [7:0] data_to_cpu;
    
    // keyboard signals
    wire rdmsel;
    assign kbrows = {rdmsel, cpuaddr[15:8]};
    
    // ASIC signals
    wire [7:0] data_from_asic;
    wire asic_oe_n;
    wire rom_oe_n;
    
    // ROM signals
    assign romaddr = {cpuaddr[15], cpuaddr[13:0]};
    
    // RAM signals
    assign data_to_ram = data_from_cpu;
    wire ram_oe_n;
    
    // MUX from memory/devices to Z80 data bus
    assign data_to_cpu = (rom_oe_n == 1'b0)?  data_from_rom :
                         (ram_oe_n == 1'b0)?  data_from_ram :
                         (asic_oe_n == 1'b0)? data_from_asic :
                         8'hFF;

//    asic la_ula_del_sam (
//        .clk(clk12),
//        .rst_n(1'b1),
//        // CPU interface
//        .mreq_n(1'b1),
//        .iorq_n(1'b1),
//        .rd_n(1'b1),
//        .wr_n(1'b1),
//        .cpuaddr(16'h1234),
//        .data_from_cpu(8'h88),
//        .data_to_cpu(),
//        .data_enable_n(),
//        .wait_n(),
//        // RAM/ROM interface
//        .ramaddr(),
//        .data_from_ram(8'h0F),
//        .ramwr_n(),
//        .romcs_n(),
//        // audio I/O
//        .ear(1'b0),
//        .mic(),
//        .beep(beep),
//        // keyboard I/O
//        .keyboard(8'hFF),
//        .rdmsel(rdmsel),
//        // disk I/O
//        .disc1_n(),
//        .disc2_n(),
//        // video output
//        .r(r),
//        .g(g),
//        .b(b),
//        .bright(bright),
//        .csync(csync),
//        .int_n(int_n)
//    );

    tv80n_wrapper el_z80 (
      .m1_n(),
      .mreq_n(mreq_n),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .rfsh_n(),
      .halt_n(),
      .busak_n(),
      .A(cpuaddr),
      .dout(data_from_cpu),

      .reset_n(rst_n),
      .clk(clk6),
      .wait_n(wait_n),
      .int_n(int_n),
      .nmi_n(nmi_n),
      .busrq_n(1'b1),
      .di(data_to_cpu)
    );
    
    asic la_ula_del_sam (
        .clk(clk12),
        .rst_n(rst_n),
        // CPU interface
        .mreq_n(mreq_n),
        .iorq_n(iorq_n),
        .rd_n(rd_n),
        .wr_n(wr_n),
        .cpuaddr(cpuaddr),
        .data_from_cpu(data_from_cpu),
        .data_to_cpu(data_from_asic),
        .data_enable_n(asic_oe_n),
        .wait_n(wait_n),
        // RAM/ROM interface
        .ramaddr(ramaddr),
        .data_from_ram(data_from_ram),
        .ramwr_n(ram_we_n),
        .romcs_n(rom_oe_n),
        .ramcs_n(ram_oe_n),
        // audio I/O
        .ear(ear),
        .mic(beep),
        .beep(),
        // keyboard I/O
        .keyboard(kbcolumns),
        .rdmsel(rdmsel),
        // disk I/O
        .disc1_n(),
        .disc2_n(),
        // video output
        .r(r),
        .g(g),
        .b(b),
        .bright(bright),
        .csync(csync),
        .int_n(int_n)
    );
endmodule
