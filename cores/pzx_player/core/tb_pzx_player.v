`timescale 1ns / 1ps
`default_nettype none

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:30:42 06/19/2015
// Design Name:   pzx_player
// Module Name:   C:/Users/rodriguj/Documents/zxspectrum/zxuno/cores/pzx_player/core/tb_pzx_player.v
// Project Name:  pzxplayer
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pzx_player
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_pzx_player;

	// Inputs
	reg clk;
	reg rst_n;
	reg [7:0] zxuno_addr;
	reg zxuno_regrd;
	reg zxuno_regwr;
	reg [7:0] din;
	reg play_in;
	reg stop_in;

	// Outputs
	wire [7:0] dout;
	wire oe_n;
	wire pulse_out;
	wire [20:0] addr;
	wire we_n;
    wire playing;

	// Bidirs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	pzx_player uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.zxuno_addr(zxuno_addr), 
		.zxuno_regrd(zxuno_regrd), 
		.zxuno_regwr(zxuno_regwr), 
		.din(din), 
		.dout(dout), 
		.oe_n(oe_n), 
		.play_in(play_in), 
		.stop_in(stop_in), 
		.pulse_out(pulse_out), 
        .playing(playing),
		.addr(addr), 
		.we_n(we_n), 
		.data(data)
	);
    
    async_ram ram (
        .a(addr[15:0]),
        .d(data)
        );

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		zxuno_addr = 0;
		zxuno_regrd = 1;
		zxuno_regwr = 1;
		din = 0;
		play_in = 0;
		stop_in = 0;

		// Wait 100 ns for global reset to finish
		#200;
        rst_n = 1;
        
		// Add stimulus here
        play_in = 1;
        #400;
        play_in = 0;
	end
      
    always begin
      clk = #17.857142857142857142857142857143 ~clk;
    end
endmodule

module async_ram (
    input wire [15:0] a,
    output wire [7:0] d
    );
    
    reg [7:0] ram[0:65535];  // 64K de RAM, para probar solamente
    integer i;
    initial begin
        for (i=0;i<65536;i=i+1)
            ram[i] = 8'h00;
        $readmemh ("carga_estandar.hex", ram);
    end
    
    assign #10 d = ram[a];
endmodule
