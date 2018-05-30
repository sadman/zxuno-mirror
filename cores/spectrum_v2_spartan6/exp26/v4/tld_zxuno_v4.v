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

module tld_zxuno_v4 (
   input wire clk50mhz,

   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire hsync,
   output wire vsync,
   input wire ear,
   inout wire clkps2,
   inout wire dataps2,
   inout wire mouseclk,
   inout wire mousedata,
   output wire audio_out_left,
   output wire audio_out_right,
   output wire stdn,
   output wire stdnb,
   
   output wire [20:0] sram_addr,
   inout wire [7:0] sram_data,
   output wire sram_we_n,
   
   output wire flash_cs_n,
   output wire flash_clk,
   output wire flash_mosi,
   input wire flash_miso,
   
   output wire sd_cs_n,    
   output wire sd_clk,     
   output wire sd_mosi,    
   input wire sd_miso,
   output wire testled,   // nos servirá como testigo de uso de la SPI
   
   input wire joyup,
   input wire joydown,
   input wire joyleft,
   input wire joyright,
   input wire joyfire,
   input wire joybtn2
   );

   wire sysclk,clk14,clk7,clk3d5,cpuclk;
   wire CPUContention;
   wire clkcpu_enable;
   wire [1:0] turbo_enable;
   wire [2:0] pll_frequency_option;
   
   clock_generator relojes_maestros
   (// Clock in ports
    .CLK_IN1            (clk50mhz),
    .CPUContention      (CPUContention),
    .pll_option         (pll_frequency_option),
    .turbo_enable       (turbo_enable),
    // Clock out ports
    .CLK_OUT1           (sysclk),
    .CLK_OUT2           (clk14),
    .CLK_OUT3           (clk7),
    .CLK_OUT4           (clk3d5),
    .cpuclk             (cpuclk),
    .clkcpu_enable      (clkcpu_enable)
    );

   wire [2:0] ri, gi, bi;
   wire hsync_pal, vsync_pal, csync_pal;   
   
   wire vga_enable, scanlines_enable;

   zxuno la_maquina (
    .clk28(sysclk),
    .clk14(clk14),
    .clk7(clk7),
    .clk3d5(clk3d5),
    .cpuclk(cpuclk),
    .CPUContention(CPUContention),
    .clkcpu_enable(clkcpu_enable),
    .power_on_reset_n(1'b1),  // sólo para simulación. Para implementacion, dejar a 1
    .r(ri),
    .g(gi),
    .b(bi),
    .hsync(hsync_pal),
    .vsync(vsync_pal),
    .csync(csync_pal),
    .clkps2(clkps2),
    .dataps2(dataps2),
    .ear_ext(~ear),  // negada porque el hardware tiene un transistor inversor
    .audio_out_left(audio_out_left),
    .audio_out_right(audio_out_right),

    .sram_addr(sram_addr),
    .sram_data(sram_data),
    .sram_we_n(sram_we_n),
    
    .flash_cs_n(flash_cs_n),
    .flash_clk(flash_clk),
    .flash_di(flash_mosi),
    .flash_do(flash_miso),
    
    .sd_cs_n(sd_cs_n),
    .sd_clk(sd_clk),
    .sd_mosi(sd_mosi),
    .sd_miso(sd_miso),
    
    .joyup(joyup),
    .joydown(joydown),
    .joyleft(joyleft),
    .joyright(joyright),
    .joyfire(joyfire),
    .joybtn2(joybtn2),    
	 
    .mouseclk(mouseclk),
    .mousedata(mousedata),
    
    .vga_enable(vga_enable),
    .scanlines_enable(scanlines_enable),
    .freq_option(pll_frequency_option),
    .turbo_enable(turbo_enable),
    
    .ad724_xtal(stdnb),
    .ad724_mode(stdn)
    );

	vga_scandoubler #(.CLKVIDEO(14000)) salida_vga (
		.clkvideo(clk14),
		.clkvga(sysclk),
    .enable_scandoubling(vga_enable),
    .disable_scaneffect(~scanlines_enable),
		.ri(ri),
		.gi(gi),
		.bi(bi),
		.hsync_ext_n(hsync_pal),
		.vsync_ext_n(vsync_pal),
    .csync_ext_n(csync_pal),
		.ro(r),
		.go(g),
		.bo(b),
		.hsync(hsync),
		.vsync(vsync)
   );	 
       
    assign testled = (!flash_cs_n || !sd_cs_n);
endmodule
