`timescale 1ns / 1ps
`default_nettype none

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:15:24 01/27/2017
// Design Name:   NextZ80
// Module Name:   D:/Users/rodriguj/Documents/zxspectrum/zxuno/repositorio/cores/chloe280se/testnextz80/tb_nextz80.v
// Project Name:  testnextz80
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NextZ80
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_nextz80;

	// Inputs
	reg [7:0] DI;
	reg CLK;
	reg RESET;
	reg INT;
	reg NMI;
	wire WAIT;

	// Outputs
	wire [7:0] DO;
	wire [15:0] ADDR;
	wire WR;
	wire MREQ;
	wire IORQ;
	wire HALT;
	wire M1;
   reg AfterM1 = 1'b0;

   reg [7:0] mem[0:255];
   integer i,f;
   initial begin
     for (i=0;i<256;i=i+1) begin
       mem[i] = 8'd0;
     end     
     f = $fopen ("testprog.bin", "rb");
     i = $fread (mem, f, 0, 256);
     $fclose (f);
   end

   always @(posedge CLK) begin
      if (MREQ==1'b1 && ADDR[15:8]==8'd0) begin
         if (WR == 1'b0) begin
            DI <= mem[ADDR[7:0]];
         end
         else begin
            mem[ADDR[7:0]] <= DO;
         end
      end
   end

   always @(posedge CLK) begin
      if (AfterM1 == 1'b0 && M1 == 1'b1 && MREQ == 1'b1 && WAIT == 1'b0) begin
         AfterM1 <= 1'b1;
      end
      if (AfterM1 == 1'b1) begin
         AfterM1 <= 1'b0;
      end
   end

   waitgen espera (
      .clk(CLK),
      .divisor(8'd2),
      .wt(WAIT)
   );

	// Instantiate the Unit Under Test (UUT)
	NextZ80 cpu (
		.DI(DI), 
		.DO(DO), 
		.ADDR(ADDR), 
		.WR(WR), 
		.MREQ(MREQ), 
		.IORQ(IORQ), 
		.HALT(HALT), 
		.M1(M1), 
		.CLK(CLK), 
		.RESET(RESET), 
		.INT(INT), 
		.NMI(NMI), 
		.WAIT(WAIT)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 0;
		INT = 0;
		NMI = 0;

		//#1;
      //RESET = 1;
      //#83;
      //RESET = 0;
      
		// Add stimulus here
      @(posedge HALT);
      $finish;
	end      
   
   always begin
      CLK = #5 ~CLK;
   end
endmodule

module waitgen (
   input wire clk,
   input wire [7:0] divisor,
   output reg wt
   );
         
   reg [7:0] cnt = 8'd0;
   initial wt = 1'b0;
   always @(posedge clk) begin
      if (cnt == divisor) begin
         cnt <= 8'd0;
         wt <= 1'b0;
      end
      else begin
         cnt <= cnt + 8'd1;
         wt <= 1'b1;
      end
   end
endmodule
