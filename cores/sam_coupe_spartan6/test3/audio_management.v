`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:04:00 04/01/2012 
// Design Name: 
// Module Name:    sigma_delta_dac 
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

`define MSBI 8 // Most significant Bit of DAC input

//This is a Delta-Sigma Digital to Analog Converter
module dac (DACout, DACin, Clk, Reset);
	output DACout; // This is the average output that feeds low pass filter
	input [`MSBI:0] DACin; // DAC input (excess 2**MSBI)
	input Clk;
	input Reset;

	reg DACout; // for optimum performance, ensure that this ff is in IOB
	reg [`MSBI+2:0] DeltaAdder; // Output of Delta adder
	reg [`MSBI+2:0] SigmaAdder; // Output of Sigma adder
	reg [`MSBI+2:0] SigmaLatch = 1'b1 << (`MSBI+1); // Latches output of Sigma adder
	reg [`MSBI+2:0] DeltaB; // B input of Delta adder

	always @(SigmaLatch) DeltaB = {SigmaLatch[`MSBI+2], SigmaLatch[`MSBI+2]} << (`MSBI+1);
	always @(DACin or DeltaB) DeltaAdder = DACin + DeltaB;
	always @(DeltaAdder or SigmaLatch) SigmaAdder = DeltaAdder + SigmaLatch;
	always @(posedge Clk or posedge Reset)
	begin
		if(Reset)
		begin
			SigmaLatch <= #1 1'b1 << (`MSBI+1);
			DACout <= #1 1'b0;
		end
		else
		begin
			SigmaLatch <= #1 SigmaAdder;
			DACout <= #1 SigmaLatch[`MSBI+2];
		end
	end
endmodule

module mixer (
	input wire clk,
	input wire rst_n,
	input wire ear,
	input wire mic,
	input wire spk,
	input wire [7:0] saa_left,
	input wire [7:0] saa_right,
	output wire audio_left,
    output wire audio_right
	);

    reg [7:0] beeper;
    always @* begin
        case ({ear,spk,mic})
            3'b000 : beeper = 8'd0;
            3'b001 : beeper = 8'd36;
            3'b010 : beeper = 8'd184;
            3'b011 : beeper = 8'd192;
            3'b100 : beeper = 8'd22;
            3'b101 : beeper = 8'd48;
            3'b110 : beeper = 8'd244;
            default: beeper = 8'd255;
        endcase
    end
	
    wire [8:0] next_sample_l = beeper + saa_left;
    wire [8:0] next_sample_r = beeper + saa_right;
	
    reg [8:0] sample_l, sample_r;
	always @(posedge clk) begin
        sample_l <= next_sample_l;
		sample_r <= next_sample_r;
    end

	dac audio_dac_left (
		.DACout(audio_left),
		.DACin(sample_l),
		.Clk(clk),
		.Reset(~rst_n)
		);
        
	dac audio_dac_right (
		.DACout(audio_right),
		.DACin(sample_r),
		.Clk(clk),
		.Reset(~rst_n)
		);
        
endmodule
