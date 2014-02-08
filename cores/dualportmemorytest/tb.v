`timescale 1ns / 1ps
`default_nettype none

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:41:18 02/07/2014
// Design Name:   tld_para_simulacion
// Module Name:   C:/Users/rodriguj/Documents/proyectos_xilinx/zxuno/dualportmemorytest/tb.v
// Project Name:  dualportmemorytest
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tld_para_simulacion
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg clk;
	reg [9:0] a1;
	reg [9:0] a2;
	reg [7:0] din1;
	reg [7:0] din2;
	reg oe1_n;
	reg oe2_n;
	reg we1_n;
	reg we2_n;

	// Outputs
	wire [7:0] dout1;
	wire [7:0] dout2;
   
   // Vars
   integer i,j;

	// Instantiate the Unit Under Test (UUT)
	tld_para_simulacion uut (
		.clk(clk), 
		.a1(a1), 
		.a2(a2), 
		.din1(din1), 
		.din2(din2), 
		.dout1(dout1), 
		.dout2(dout2), 
		.oe1_n(oe1_n), 
		.oe2_n(oe2_n), 
		.we1_n(we1_n), 
		.we2_n(we2_n)
	);

   task pokea (input [9:0] a, input [7:0] d);
   begin
      a1 = a;
      din1 = d;
      we1_n = 0;
      repeat (7) @(posedge clk);
      we1_n = 1;
		@(posedge clk);
   end
   endtask
   
   task pokeb (input [9:0] a, input [7:0] d);
   begin
      a2 = a;
      din2 = d;
      we2_n = 0;
      repeat (7) @(posedge clk);
      we2_n = 1;
		@(posedge clk);
   end
   endtask

   task peeka (input [9:0] a);
   begin
      a1 = a;
      we1_n = 1;
      repeat (4) @(posedge clk);
   end
   endtask

   task peekb (input [9:0] a);
   begin
      a2 = a;
      we2_n = 1;
      repeat (4) @(posedge clk);
   end
   endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		a1 = 0;
		a2 = 0;
		din1 = 0;
		din2 = 0;
		oe1_n = 0;
		oe2_n = 0;
		we1_n = 1;
		we2_n = 1;

      repeat (2) @(posedge clk);  

		// Add stimulus here
      fork
         begin
            for (i=0;i<16;i=i+2)
               pokea (i,i);
         end
         begin
            for (j=1;j<16;j=j+2)
               pokeb (j,j);
         end
      join
      
      fork
         begin
            for (i=0;i<16;i=i+2)
               peeka (i);
         end
         begin
            for (j=1;j<16;j=j+2)
               peekb (j);
         end
      join
      
      @(posedge clk);
      $finish;
	end
   
   always begin
      clk = #17.857 ~clk;  // reloj de 28MHz
   end
endmodule

