`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:26 05/29/2014 
// Design Name: 
// Module Name:    gradiente 
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
module gradiente(
    input wire clk,
    output wire [7:0] r,
    output wire [7:0] g,
    output wire [7:0] b,
    output wire hs,
    output wire vs
    );
	 
	 wire [10:0] hc,vc;

	 reg [7:0] rojo;
	 reg [7:0] verde;
	 reg [7:0] azul;
	 
	 videosyncs syncs (
		.clk(clk),
		.rin(rojo),
		.gin(verde),
		.bin(azul),
		.rout(r),
		.gout(g),
		.bout(b),
		.hs(hs),
		.vs(vs),
		.hc(hc),
		.vc(vc)
		);
		
	 `define XRES 800
    `define YRES 600
    `define XRESZX 704
    `define YRESZX 576
    `define OFSXBOR (`XRES-`XRESZX)/2
    `define OFSYBOR (`YRES-`YRESZX)/2
    `define XRESPAPER 512
    `define YRESPAPER 384
    `define SIZEBORH (`XRESZX-`XRESPAPER)/2
    `define SIZEBORV (`YRESZX-`YRESPAPER)/2
    `define OFSXPAPER (`OFSXBOR + `SIZEBORV)
    `define OFSYPAPER (`OFSYBOR + `SIZEBORH)
	
	wire [10:0] hcdly = hc-`OFSXPAPER;
	always @* begin
		rojo = 8'hFF;
		verde = 8'h00;
		azul = 8'hFF;
		if ( (vc>=0 && vc<`OFSYBOR) ||
		     (vc>=(`OFSYBOR+`YRESZX) && vc<`YRES) ||
			  (hc>=0 && hc<`OFSXBOR) ||
			  (hc>=(`OFSXBOR+`XRESZX) && hc<`XRES)
		   )
		begin
			 rojo = 8'hFF;
			 verde = 8'hFF;
			 azul = 8'h00;
	   end
		else if (vc>=`OFSYPAPER && 
		         vc<(`OFSYPAPER+`YRESPAPER) && 
					hc>=`OFSXPAPER &&
					hc<(`OFSXPAPER+`XRESPAPER)
			) begin
			if (vc>=`OFSYPAPER && vc<(`OFSYPAPER+128)) begin
				rojo = hcdly[8:1];
				verde = 8'h00;
				azul = 8'h00;
		   end
			else if (vc>=(`OFSYPAPER+128) && vc<(`OFSYPAPER+256)) begin
				verde = hcdly[8:1];
				rojo = 8'h00;
				azul = 8'h00;
		   end
			if (vc>=(`OFSYPAPER+256) && vc<(`OFSYPAPER+384)) begin
				azul = hcdly[8:1];
				verde = 8'h00;
				rojo = 8'h00;
		   end
		end
	end
endmodule
