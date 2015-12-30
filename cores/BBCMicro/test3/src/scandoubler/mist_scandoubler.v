//
// scandoubler.v
// 
// Copyright (c) 2015 Till Harbaum <till@harbaum.org> 
// 
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or 
// (at your option) any later version. 
// 
// This source file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of 
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License 
// along with this program.  If not, see <http://www.gnu.org/licenses/>. 

// TODO: Delay vsync one line

module mist_scandoubler (
  // system interface
  input 	   clk,     // 31.875 MHz
  input        clk_16,  // from shifter
  input		   clk_16_en,
  input        scanlines,
  
  // shifter video interface
  input 	   hs_in,
  input 	   vs_in,
  input  	r_in,
  input  	g_in,
  input  	b_in,

  // output interface
  output reg      hs_out,
  output reg 	   vs_out,
  output reg [1:0] r_out,
  output reg [1:0] g_out,
  output reg [1:0] b_out,

  output 	   is15k
);

// scan doubler output register
reg [2:0]  sd_out;

// --------------------- create output signals -----------------
// latch everything once more to make it glitch free and apply scanline effect
reg scanline;

always @(posedge clk) begin
   hs_out <= hs_sd;
   vs_out <= vs_in;

   // reset scanlines at every new screen
   if(vs_out != vs_in)
     scanline <= 1'b0;
   
    // toggle scanlines at begin of every hsync
    if(hs_out && !hs_sd)
         scanline <= !scanline;

    // if no scanlines or not a scanline
	 if(!scanlines || !scanline) begin
		r_out <= { sd_out[2], sd_out[2] };
		g_out <= { sd_out[1], sd_out[1] };
		b_out <= { sd_out[0], sd_out[0] };
	end else begin
		r_out <= { 1'b0, sd_out[2] };
		g_out <= { 1'b0, sd_out[1] };
		b_out <= { 1'b0, sd_out[0] };
	end
end
   

   
// ==================================================================
// ======================== the line buffers ========================
// ==================================================================

// 2 lines of 1024 pixels 3*4 bit RGB
reg [2:0] sd_buffer [2047:0];

// use alternating sd_buffers when storing/reading data   
reg vsD;
reg line_toggle;
always @(negedge clk_16) begin

	if (clk_16_en) begin 
	
   vsD <= vs_in;

   if(vsD != vs_in) 
     line_toggle <= 1'b0;

   // begin of incoming hsync
   if(hsD && !hs_in) 
     line_toggle <= !line_toggle;
	 
	end
end
   
always @(negedge clk_16) begin 

	if (clk_16_en) begin 
	
		sd_buffer[{line_toggle, hcnt}] <= { r_in, g_in, b_in };
	
	end
	
 end
   
// ==================================================================
// =================== horizontal timing analysis ===================
// ==================================================================

// signal detection of 15khz if hsync frequency is less than 20KHz
assign is15k = hs_max > (16000000/20000);

// total hsync time (in 16MHz cycles), hs_total reaches 1024
reg [9:0] hs_max;
reg [9:0] hs_rise;
reg [9:0] hcnt;
reg hsD;
   
always @(negedge clk_16) begin

   if (clk_16_en) begin 
   
	   hsD <= hs_in;

	   // falling edge of hsync indicates start of line
	   if(hsD && !hs_in) begin
		  hs_max <= hcnt;
		  hcnt <= 10'd0;
	   end else
		 hcnt <= hcnt + 10'd1;

	   // save position of rising edge
	   if(!hsD && hs_in)
		 hs_rise <= hcnt;
	 
	end
end
   
// ==================================================================
// ==================== output timing generation ====================
// ==================================================================

reg [9:0] sd_hcnt;
reg hs_sd;

// timing generation runs 32 MHz (twice the input signal analysis speed)
always @(posedge clk) begin

   // output counter synchronous to input and at twice the rate
   sd_hcnt <= sd_hcnt + 10'd1;
   if(hsD && !hs_in)     sd_hcnt <= hs_max;
   if(sd_hcnt == hs_max) sd_hcnt <= 10'd0;

   // replicate horizontal sync at twice the speed
   if(sd_hcnt == hs_max)  hs_sd <= 1'b0;
   if(sd_hcnt == hs_rise) hs_sd <= 1'b1;

   // read data from line sd_buffer
   sd_out <= sd_buffer[{~line_toggle, sd_hcnt}];
end
   
endmodule
    
