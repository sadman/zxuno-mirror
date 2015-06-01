`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:22:32 12/26/2014
// Design Name:   ps2_port
// Module Name:   C:/Users/rodriguj/Documents/zxspectrum/zxuno/repositorio/cores/spectrum_v2_spartan6/vgatest1/tb_ps2_port.v
// Project Name:  vgatest
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ps2_port
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_ps2_port;

	// Inputs
	reg clk;
	reg ps2clk_ext;
	reg ps2data_ext;

	// Outputs
	wire kb_interrupt;
	wire [7:0] scancode;
	wire released;
	wire extended;

	// Instantiate the Unit Under Test (UUT)
	ps2_port uut (
		.clk(clk), 
        .enable_rcv(1'b1),
		.ps2clk_ext(ps2clk_ext), 
		.ps2data_ext(ps2data_ext), 
		.kb_interrupt(kb_interrupt), 
		.scancode(scancode), 
		.released(released), 
		.extended(extended)
	);

task enviarps2 (input [7:0] code);
    begin
        ps2clk_ext = 1;
        ps2data_ext = 0;
        #500;
        ps2clk_ext = 0;
        #500;

        repeat (8) begin
            ps2clk_ext = 1;
            ps2data_ext = code[0];
            #500;
            ps2clk_ext = 0;
            code = {code[0],code[7:1]};
            #500;
        end
        
        ps2clk_ext = 1;
        ps2data_ext = ~^code;
        #500;
        ps2clk_ext = 0;
        #500;

        ps2clk_ext = 1;
        ps2data_ext = 1;
        #500;
        ps2clk_ext = 0;
        #500;
    
        ps2clk_ext = 1;
        #500;
    end
endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		ps2clk_ext = 0;
		ps2data_ext = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        
        enviarps2(8'h55);
        $finish;
	end
      
    always begin
        clk = #10 ~clk;
    end
endmodule

