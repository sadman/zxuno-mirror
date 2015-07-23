`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:06:10 07/23/2015
// Design Name:   asic
// Module Name:   C:/Users/rodriguj/Documents/zxspectrum/zxuno/repositorio/cores/sam_coupe_spartan6/test1/tb_asic.v
// Project Name:  samcoupe
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: asic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_asic;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [1:0] r;
	wire [1:0] g;
	wire [1:0] b;
	wire bright;
	wire csync;
	wire int_n;

	// Instantiate the Unit Under Test (UUT)
	asic uut (
		.clk(clk), 
		.rst(rst), 
		.r(r), 
		.g(g), 
		.b(b), 
		.bright(bright), 
		.csync(csync), 
		.int_n(int_n)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
    always begin
        clk = #(1000.0/24.0) ~clk;
    end
    
endmodule

