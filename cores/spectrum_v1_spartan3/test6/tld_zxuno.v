`timescale 1ns / 1ns
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:28:18 02/06/2014 
// Design Name: 
// Module Name:    test1 
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

module tld_zxuno (
   input wire clk50mhz,
   input wire system_reset_n,

   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire csync,
   input wire ear,
   input wire clkps2,
   input wire dataps2,
   output wire audio_out_left,
   output wire audio_out_right,
   
   output wire [18:0] sram_addr,
   inout wire [7:0] sram_data,
   output wire sram_we_n
   );

   wire wssclk,sysclk;
   relojes los_relojes_del_sistema (
    .CLKIN_IN(clk50mhz), 
    .CLKDV_OUT(wssclk), //  5MHz
    .CLKFX_OUT(sysclk), // 28MHz 
    .CLKIN_IBUFG_OUT(), 
    .CLK0_OUT(), 
    .LOCKED_OUT()
    );

   // Instanciación del sistema
   wire [13:0] addr_rom_16k;
   wire [7:0] rom_dout;
   
   wire [4:0] kbdcol;
   wire [7:0] kbdrow;
   wire audio_out;
   assign audio_out_left = audio_out;
   assign audio_out_right = audio_out;
   
   zxuno la_maquina (
    .clk(sysclk),
    .wssclk(wssclk),
    .system_reset_n(system_reset_n),
    .r(r),
    .g(g),
    .b(b),
    .csync(csync),
    .kbdcol(kbdcol),
    .kbdrow(kbdrow),
    .ear(~ear),  // negada porque el hardware tiene un transistor inversor
    .audio_out(audio_out),

    .addr_rom_16k(addr_rom_16k),
    .rom_dout(rom_dout),

    .sram_addr(sram_addr),
    .sram_data(sram_data),
    .sram_we_n(sram_we_n)
    );

    rom rom_inicial (
      .clk(sysclk),
      .a(addr_rom_16k),
      .dout(rom_dout)
    );
    
    ps2kbd el_teclado (
    .clk(sysclk),
	 .reset(1'b0),
	 .clkps2(clkps2),
	 .dataps2(dataps2),
	 .semifila(kbdrow),
	 .columna(kbdcol)
    );
    
endmodule
