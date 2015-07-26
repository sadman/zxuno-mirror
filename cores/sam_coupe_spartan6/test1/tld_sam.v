`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:39:25 07/25/2015 
// Design Name: 
// Module Name:    tld_sam 
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
module tld_sam (
    input wire clk50mhz,
    // Audio I/O
    input wire ear,
    output wire audio_out_left,
    output wire audio_out_right,
    // Video output
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    output wire stdn,
    output wire stdnb,
    // SRAM interface
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n,
    // PS/2 keyoard interface
    input wire clkps2,
    input wire dataps2
    );

    // Interface with ROM
    wire [14:0] romaddr;
    wire [7:0] data_from_rom;

    // Interface with RAM
    wire [18:0] ramaddr;
    wire [7:0] data_from_ram;
    wire [7:0] data_to_ram;
    wire ram_we_n;
    
    // Audio and video
    wire [1:0] sam_r, sam_g, sam_b;
    wire sam_bright;
    
    wire sam_beep;
    
    assign r = {sam_r, sam_bright};
    assign g = {sam_g, sam_bright};
    assign b = {sam_b, sam_bright};

    assign stdn = 1'b0;  // fijar norma PAL
	assign stdnb = 1'b1; // y conectamos reloj PAL
    
    assign audio_out_left = sam_beep;
    assign audio_out_right = sam_beep;

    // Keyboard
    wire [8:0] kbrows;
    wire [7:0] kbcolumns;


    // Control signals
    wire kb_nmi_n;
    wire kb_rst_n;
    
    wire clk12, clk6, clk8;

    relojes los_relojes (
        .CLK_IN1            (clk50mhz),      // IN
        // Clock out ports
        .CLK_OUT1           (clk12),      // OUT
        .CLK_OUT2           (clk6),       // OUT
        .CLK_OUT3           (clk8)        // OUT
    );

    samcoupe maquina (
        .clk12(clk12),
        .clk6(clk6),
        .rst_n(kb_rst_n),
        .nmi_n(kb_nmi_n),
        // ROM device
        .romaddr(romaddr),
        .data_from_rom(data_from_rom),
        // RAM device
        .ramaddr(ramaddr),
        .data_from_ram(data_from_ram),
        .data_to_ram(data_to_ram),
        .ram_we_n(ram_we_n),
        // Keyboard
        .kbrows(kbrows),
        .kbcolumns({3'b111,kbcolumns[4:0]}),
        // Video output
        .r(sam_r),
        .g(sam_g),
        .b(sam_b),
        .bright(sam_bright),
        .csync(csync),
        // Audio output
        .ear(~ear),
        .beep(sam_beep)
    );
    
    rom rom_32k (
        .clk(clk12),
        .a(romaddr),
        .dout(data_from_rom)
    );
    
    ram ram_512k (
        .a(ramaddr),
        .we_n(ram_we_n),
        .din(data_to_ram),
        .dout(data_from_ram),
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
