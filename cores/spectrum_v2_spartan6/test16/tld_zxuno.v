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

   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire csync,
   input wire ear,
   input wire clkps2,
   input wire dataps2,
   output wire audio_out_left,
   output wire audio_out_right,
	output wire stdn,
	output wire stdnb,
   
   output wire [18:0] sram_addr,
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
   output wire testled   // nos servir� como testigo de uso de la SPI
   );

   wire wssclk,sysclk;
//   relojes los_relojes_del_sistema (
//    .CLKIN_IN(clk50mhz), 
//    .CLKDV_OUT(wssclk), //  5MHz
//    .CLKFX_OUT(sysclk), // 28MHz 
//    .CLKIN_IBUFG_OUT(), 
//    .CLK0_OUT(), 
//    .LOCKED_OUT()
//    );

	assign wssclk = 1'b0;  // de momento, sin WSS
	assign stdn = 1'b0;  // fijar norma PAL
	assign stdnb = 1'b1; // y conectamos reloj PAL
   pll reloj_maestro
   (// Clock in ports
    .CLK_IN1            (clk50mhz),      // IN
    // Clock out ports
    .CLK_OUT1           (sysclk),     // OUT
    // Dynamic reconfiguration ports
    .PROGCLK            (1'b0),      // IN
    .PROGDATA           (1'b0),     // IN
    .PROGEN             (1'b0),       // IN
    .PROGDONE           ());    // OUT

   reg [2:0] clkdiv = 3'b000;
   wire clk14i = clkdiv[0];
   wire clk7i = clkdiv[1];
   wire clk35i = clkdiv[2];
   always @(posedge sysclk)
      clkdiv <= clkdiv + 1;
   
   wire clk14, clk7, clk35;
   BUFG clk14b (.I(clk14i), .O(clk14));
   BUFG clk7b (.I(clk7i), .O(clk7));
   BUFG clk35b (.I(clk35i), .O(clk35));
   
   wire audio_out;
   assign audio_out_left = audio_out;
   assign audio_out_right = audio_out;
   
   zxuno la_maquina (
    .clk(sysclk),         // 28MHz, reloj base para la memoria de doble puerto, y de ah�, para el resto del circuito
    .wssclk(wssclk),      //  5MHz, reloj para el WSS
    .clk14(clk14),
    .clk7(clk7),
    .clk35(clk35),
    .power_on_reset_n(1'b1),  // s�lo para simulaci�n. Para implementacion, dejar a 1
    .r(r),
    .g(g),
    .b(b),
    .csync(csync),
    .clkps2(clkps2),
    .dataps2(dataps2),
    .ear(~ear),  // negada porque el hardware tiene un transistor inversor
    .audio_out(audio_out),

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
    .sd_miso(sd_miso)
    );
       
    //assign testled = (!flash_cs_n || !sd_cs_n);
    // This is to enlarge the CS signal so the led is on for longer time
    // so the visual feedback is better
    reg [19:0] monoestable = 20'hFFFFF;
    always @(posedge sysclk) begin
        if (!flash_cs_n || !sd_cs_n)
            monoestable <= 0;
        else if (monoestable[19] == 1'b0)
            monoestable <= monoestable + 1;
    end
    assign testled = ~monoestable[19];

endmodule