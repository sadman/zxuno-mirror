`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:24:02 08/15/2016 
// Design Name: 
// Module Name:    tld_test_prod_v4 
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
module tld_test_prod_v4 (
   input wire clk50mhz,
   input wire clkps2,
   input wire dataps2,
   output wire testled,
   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire hsync,
   output wire vsync,
   output wire stdn,
   output wire stdnb,
   output wire audio_out_left,
   output wire audio_out_right
    );

   wire clk50, clk14, clk7;

   wire mode, vga;
   assign stdn = mode;
   assign stdnb = ~mode;

   wire [2:0] r_to_vga, g_to_vga, b_to_vga;
   wire hsync_to_vga, vsync_to_vga, csync_to_vga;

   relojes instance_name (
    .CLK_IN1(clk50mhz),
    .CLK_OUT1(clk50),
    .CLK_OUT2(clk14),
    .CLK_OUT3(clk7));

   switch_mode teclas (
      .clk(clk7),
      .clkps2(clkps2),
      .dataps2(dataps2),
      .mode(mode),
      .vga(vga)
   );

   updater mensajes (
     .clk(clk7),
     .mode(mode),
     .r(r_to_vga),
     .g(g_to_vga),
     .b(b_to_vga),
     .hsync(hsync_to_vga),
     .vsync(vsync_to_vga),
     .csync(csync_to_vga)
     );

   vga_scandoubler #(.CLKVIDEO(7000)) modo_vga (
      .clkvideo(clk7),
      .clkvga(clk14),
      .enable_scandoubling(vga),
      .disable_scaneffect(1'b0),
      .ri(r_to_vga),
      .gi(g_to_vga),
      .bi(b_to_vga),
      .hsync_ext_n(hsync_to_vga),
      .vsync_ext_n(vsync_to_vga),
      .csync_ext_n(csync_to_vga),
      .ro(r),
      .go(g),
      .bo(b),
      .hsync(hsync),
      .vsync(vsync)
   );
   
   audio_test audio (
      .clk(clk14),
      .left(audio_out_left),
      .right(audio_out_right),
      .led(testled)
   );

endmodule
