`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:14 10/18/2012 
// Design Name: 
// Module Name:    dummy_ula 
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

module dummy_ula(
    input wire clk,
    input wire mode,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b,
    output wire csync
    );

	 reg [2:0] ri = 3'b000;
	 reg [2:0] gi = 3'b000;
	 reg [2:0] bi = 3'b000;
	 wire [8:0] hc;
	 wire [8:0] vc;
     wire blank;

    sync_generator_pal_ntsc sincronismos (
    .clk(clk),   // 7 MHz
    .in_mode(mode),  // 0: PAL, 1: NTSC
    .csync_n(csync),
    .hc(hc),
    .vc(vc),
    .blank(blank)
    );
    
    always @* begin
        if (blank == 1'b1) begin
            r = 3'b000;
            g = 3'b000;
            b = 3'b000;
        end
        else begin
            r = 3'b000;
            g = 3'b000;
            b = 3'b000;
            if (hc >= (44*0) && hc <= (44*1-1)) begin
                r = 3'b000;
                g = 3'b000;
                b = 3'b000;
            end
            if (hc >= (44*1) && hc <= (44*2-1)) begin
                r = 3'b000;
                g = 3'b000;
                b = 3'b111;
            end
            if (hc >= (44*2) && hc <= (44*3-1)) begin
                r = 3'b111;
                g = 3'b000;
                b = 3'b000;
            end
            if (hc >= (44*3) && hc <= (44*4-1)) begin
                r = 3'b111;
                g = 3'b000;
                b = 3'b111;
            end
            if (hc >= (44*4) && hc <= (44*5-1)) begin
                r = 3'b000;
                g = 3'b111;
                b = 3'b000;
            end
            if (hc >= (44*5) && hc <= (44*6-1)) begin
                r = 3'b000;
                g = 3'b111;
                b = 3'b111;
            end
            if (hc >= (44*6) && hc <= (44*7-1)) begin
                r = 3'b111;
                g = 3'b111;
                b = 3'b000;
            end
            if (hc >= (44*7) && hc <= (44*8-1)) begin
                r = 3'b111;
                g = 3'b111;
                b = 3'b111;
            end
        end
    end        
endmodule
