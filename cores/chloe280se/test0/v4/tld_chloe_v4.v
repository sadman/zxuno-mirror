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
   output wire stdn,
   output wire stdnb,
   output wire audio_out_left,
   output wire audio_out_right
   );

   assign stdn = 1'b1;  // fijar norma NTSC
   assign stdnb = 1'b0; // y conectamos reloj NTSC
   assign vsync = 1'b1;
   
   wire clk7;
   
   relojes clock_generator
   (// Clock in ports
    .CLK_IN1            (clk50mhz),
    // Clock out ports
    .CLK_OUT1           (clk7)
    );

    chloe_logo_demo the_demo (  
      .clk(clk7),
      .r(r),
      .g(g),
      .b(b),
      .csync_n(hsync),
      .audio_left(audio_out_left),
      .audio_right(audio_out_right)
    );

endmodule
