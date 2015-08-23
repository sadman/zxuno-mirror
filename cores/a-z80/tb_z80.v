`timescale 1ns / 1ps
`default_nettype none

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:18:34 08/22/2015
// Design Name:   tv80n_wrapper
// Module Name:   C:/Users/rodriguj/Documents/a-z80/gdevic-a-z80-b985679730ee/gdevic-a-z80-b985679730ee/cpu/deploy/tb_z80.v
// Project Name:  az80
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: tv80n_wrapper
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_z80;

	// Inputs
	reg reset_n;
	reg clk;
	reg wait_n;
	reg int_n;
	reg nmi_n;
	reg busrq_n;
	wire [7:0] di;

	// Outputs
	wire m1_n;
	wire mreq_n;
	wire iorq_n;
	wire rd_n;
	wire wr_n;
	wire rfsh_n;
	wire halt_n;
	wire busak_n;
	wire [15:0] A;
	wire [7:0] dout;

	// Instantiate the Unit Under Test (UUT)
	tv80n_wrapper uut (
		.m1_n(m1_n), 
		.mreq_n(mreq_n), 
		.iorq_n(iorq_n), 
		.rd_n(rd_n), 
		.wr_n(wr_n), 
		.rfsh_n(rfsh_n), 
		.halt_n(halt_n), 
		.busak_n(busak_n), 
		.A(A), 
		.dout(dout), 
		.reset_n(reset_n), 
		.clk(clk), 
		.wait_n(wait_n), 
		.int_n(int_n), 
		.nmi_n(nmi_n), 
		.busrq_n(busrq_n), 
		.di(di)
	);

    rom the_rom (!(mreq_n == 1'b0 && rd_n == 1'b0 && A<16'd256), A[7:0], di);
    ram the_ram (!(mreq_n == 1'b0 && A>=16'd256), wr_n, A[7:0], dout, di);

	initial begin
		// Initialize Inputs
		reset_n = 0;
		clk = 0;
		wait_n = 1;
		int_n = 1;
		nmi_n = 1;
		busrq_n = 1;

		// Wait 100 ns for global reset to finish
		#50;
        reset_n = 1;
        
		// Add stimulus here
        wait(!halt_n);
        $finish;
	end
    
    always begin
        clk = #5 ~clk;
    end      
endmodule

module rom (
    input wire cs_n,
    input wire [7:0] a,
    output wire [7:0] d
    );
    
    reg [7:0] m[0:255];
    initial begin
        m[ 0] = 8'd33;
        m[ 1] = 8'd0;
        m[ 2] = 8'd1;   // LD HL,256
        m[ 3] = 8'd17;
        m[ 4] = 8'd1;
        m[ 5] = 8'd1;   // LD DE,257
        m[ 6] = 8'd1;
        m[ 7] = 8'd255;
        m[ 8] = 8'd0;   // LD BC,255
        m[ 9] = 8'd116; // LD (HL),H
        m[10] = 8'd237;
        m[11] = 8'd176; // LDIR
        m[12] = 8'd211;
        m[13] = 8'd254; // OUT (254),A
        m[14] = 8'd118; // HALT
        m[15] = 8'd170; // just test
    end
    
    assign d = (cs_n == 1'b0)? m[a] : 8'hZZ;
endmodule
    
module ram (
    input wire cs_n,
    input wire we_n,
    input wire [7:0] a,
    input wire [7:0] din,
    output wire [7:0] dout
    );
    
    reg [7:0] m[0:255];
    integer i;
    initial begin
        for (i=0;i<256;i=i+1)
            m[i] = 8'h00;
    end
    
    assign dout = (cs_n == 1'b0 && we_n == 1'b1)? m[a] : 8'hZZ;
    always @* begin
        if (cs_n == 1'b0 && we_n == 1'b0)
            m[a] = din;
    end
endmodule
        