`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:34:41 03/03/2014
// Design Name:   flash_spi
// Module Name:   C:/Users/rodriguj/Documents/zxspectrum/zxuno/repositorio/cores/test10/tb_flash_spi.v
// Project Name:  zxuno
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: flash_spi
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_flash_spi;

	// Inputs
	reg clk;
	reg [7:0] addr;
	reg rd;
	reg wr;
	reg [7:0] din;
	reg flash_do;

	// Outputs
	wire [7:0] dout;
	wire oe_n;
	wire flash_cs_n;
	wire flash_clk;
	wire flash_di;

	// Instantiate the Unit Under Test (UUT)
	flash_spi uut (
		.clk(clk), 
		.addr(addr), 
		.rd(rd), 
		.wr(wr), 
		.din(din), 
		.dout(dout), 
		.oe_n(oe_n), 
		.flash_cs_n(flash_cs_n), 
		.flash_clk(flash_clk), 
		.flash_di(flash_di), 
		.flash_do(flash_do)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		addr = 2;
		rd = 0;
		wr = 0;
		din = 8'b10101010;
      flash_do = 0;

		#300;
      
      wr = 1;
      #700;
      wr = 0;

      #300;
      rd = 1;

      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);
      flash_do = 1;
      @(negedge flash_clk);

      #300;
      rd = 0;

	end
         
   always begin
      clk = #17.85714285714285714285714285714 ~clk;  // 28MHz
   end
      
endmodule
