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
    input wire clk24,
    input wire clk12,
    input wire clk6,
    input wire master_reset_n,
    // Video output
    output wire [1:0] r,
    output wire [1:0] g,
    output wire [1:0] b,
    output wire bright,
    output wire csync,
    // Audio output
    input wire ear,
    output wire audio_out_left,
    output wire audio_out_right,
    // PS/2 keyoard interface
    input wire clkps2,
    input wire dataps2,
    // SRAM interface
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n
    );
    
    // ROM memory
    wire [14:0] romaddr;
    wire [7:0] data_from_rom;
    
    // RAM memory
    wire [18:0] vramaddr, cpuramaddr;
    wire [7:0] data_from_ram;
    wire [7:0] data_to_asic;
    wire ram_we_n;
    wire asic_is_using_ram;
    
    // Keyboard
    wire [8:0] kbrows;
    wire [7:0] kbcolumns;
    wire kb_nmi_n;
    wire kb_rst_n;
    wire rdmsel;
    assign kbrows = {rdmsel, cpuaddr[15:8]};
    
    // CPU signals
    wire mreq_n, iorq_n, rd_n, wr_n, int_n, wait_n, rfsh_n;
    wire [15:0] cpuaddr;
    wire [7:0] data_from_cpu;
    wire [7:0] data_to_cpu;
    
    // ASIC signals
    wire [7:0] data_from_asic;
    wire asic_oe_n;
    wire rom_oe_n;
    
    // ROM signals
    assign romaddr = {cpuaddr[15], cpuaddr[13:0]};
    
    // RAM signals
    wire ram_oe_n;
    
    // Audio signals
    wire mic, beep;
    assign audio_out_left = mic;
    assign audio_out_right = beep;
    
    // MUX from memory/devices to Z80 data bus
    assign data_to_cpu = (rom_oe_n == 1'b0)?  data_from_rom :
                         (ram_oe_n == 1'b0)?  data_from_ram :
                         (asic_oe_n == 1'b0)? data_from_asic :
                         8'hFF;

    tv80n el_z80 (
      .m1_n(),
      .mreq_n(mreq_n),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .rfsh_n(rfsh_n),
      .halt_n(),
      .busak_n(),
      .A(cpuaddr),
      .dout(data_from_cpu),

      .reset_n(kb_rst_n & master_reset_n),
      .clk(clk6),
      .wait_n(wait_n),
      .int_n(int_n),
      .nmi_n(kb_nmi_n),
      .busrq_n(1'b1),
      .di(data_to_cpu)
    );
    
    asic la_ula_del_sam (
        .clk(clk12),
        .rst_n(kb_rst_n & master_reset_n),
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
        .vramaddr(vramaddr),
        .cpuramaddr(cpuramaddr),
        .data_from_ram(data_to_asic),
        .ramwr_n(ram_we_n),
        .romcs_n(rom_oe_n),
        .ramcs_n(ram_oe_n),
        .asic_is_using_ram(asic_is_using_ram),
        // audio I/O
        .ear(ear),
        .mic(mic),
        .beep(beep),
        // keyboard I/O
        .keyboard({3'b111,kbcolumns[4:0]}),
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
    
    rom rom_32k (
        .clk(clk12),
        .a(romaddr),
        .dout(data_from_rom)
    );
    
//    ram_dual_port_turnos ram_512k (
//        .clk(clk24),
//        .whichturn(asic_is_using_ram),
//        .vramaddr(vramaddr),
//        .cpuramaddr(cpuramaddr),
//        .cpu_we_n(ram_we_n),
//        .data_from_cpu(data_from_cpu),
//        .data_to_asic(data_to_asic),
//        .data_to_cpu(data_from_ram),
//        // Actual interface with SRAM
//        .sram_a(sram_addr),
//        .sram_we_n(sram_we_n),
//        .sram_d(sram_data)
//    );
    
    ram_dual_port ram_512k (
        .clk(clk24),
        .whichturn(asic_is_using_ram),
        .vramaddr(vramaddr),
        .cpuramaddr(cpuramaddr),
        .mreq_n(ram_oe_n),
        .rd_n(rd_n),
        .wr_n(ram_we_n),
        .rfsh_n(rfsh_n),
        .data_from_cpu(data_from_cpu),
        .data_to_asic(data_to_asic),
        .data_to_cpu(data_from_ram),
        // Actual interface with SRAM
        .sram_a(sram_addr),
        .sram_we_n(sram_we_n),
        .sram_d(sram_data)
    );

    ps2k el_teclado (
      .clk(clk6),
      .ps2clk(clkps2),
      .ps2data(dataps2),
      .rows(kbrows[7:0]),
      .cols(kbcolumns[4:0]),
      .joy(), // Implementación joystick kempston en teclado numerico
      .scancode(),  // El scancode original desde el teclado
      .rst(kb_rst_n),   // esto son salidas, no entradas
      .nmi(kb_nmi_n),   // Señales de reset y NMI
      .mrst()  // generadas por pulsaciones especiales del teclado
      );
    
endmodule
