`timescale 1ns / 100ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:42 11/29/2013 
// Design Name: 
// Module Name:    vga 
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
module videosyncs (
   input wire clk,

   input wire [7:0] rin,
   input wire [7:0] gin,
   input wire [7:0] bin,

   output reg [7:0] rout,
   output reg [7:0] gout,
   output reg [7:0] bout,
    	
   output reg hs,
   output reg vs,
	
	output wire [10:0] hc,
	output wire [10:0] vc
   );
	
   /* http://www.abramovbenjamin.net/calc.html */
   parameter htotal = 896;
   parameter vtotal = 625;
   parameter hactive = 800;
   parameter vactive = 600;
   parameter hfrontporch = 24;
   parameter hsyncpulse = 40;
   parameter vfrontporch = 4;
   parameter vsyncpulse = 3;
   parameter hsyncpolarity = 1;
   parameter vsyncpolarity = 1;

   // 800x600@50Hz,28MHz
//   parameter htotal = 896;
//   parameter vtotal = 625;
//   parameter hactive = 800;
//   parameter vactive = 600;
//   parameter hfrontporch = 24;
//   parameter hsyncpulse = 40;
//   parameter vfrontporch = 4;
//   parameter vsyncpulse = 3;
//   parameter hsyncpolarity = 0;
//   parameter vsyncpolarity = 0;

   // 704x576@50Hz,28MHz
//   parameter htotal = 896;
//   parameter vtotal = 625;
//   parameter hactive = 704;
//   parameter vactive = 576;
//   parameter hfrontporch = 56;
//   parameter hsyncpulse = 80;
//   parameter vfrontporch = 23;
//   parameter vsyncpulse = 3;
//   parameter hsyncpolarity = 0;
//   parameter vsyncpolarity = 0;

   // VGA 640x480@60Hz,25MHz
//	  parameter htotal = 800;
//   parameter vtotal = 524;
//   parameter hactive = 640;
//   parameter vactive = 480;
//   parameter hfrontporch = 16;
//   parameter hsyncpulse = 96;
//   parameter vfrontporch = 11;
//   parameter vsyncpulse = 2;
//   parameter hsyncpolarity = 0;
//   parameter vsyncpolarity = 0;

   reg [10:0] hcont = 0;
   reg [10:0] vcont = 0;
   reg active_area;
	
	assign hc = hcont;
	assign vc = vcont;

   always @(posedge clk) begin
      if (hcont == htotal-1) begin
         hcont <= 0;
         if (vcont == vtotal-1) begin
            vcont <= 0;
         end
         else begin
            vcont <= vcont + 1;
         end
      end
      else begin
         hcont <= hcont + 1;
      end
   end
   
   always @* begin
      if (hcont>=0 && hcont<hactive && vcont>=0 && vcont<vactive)
         active_area = 1'b1;
      else
         active_area = 1'b0;
      if (hcont>=(hactive+hfrontporch) && hcont<(hactive+hfrontporch+hsyncpulse))
         hs = hsyncpolarity;
      else
         hs = ~hsyncpolarity;
      if (vcont>=(vactive+vfrontporch) && vcont<(vactive+vfrontporch+vsyncpulse))
         vs = vsyncpolarity;
      else
         vs = ~vsyncpolarity;
	end
         
   always @* begin
      if (active_area) begin
			gout = gin;
         rout = rin;
         bout = bin;
      end
      else begin
         gout = 8'h00;
         rout = 8'h00;
         bout = 8'h00;
      end
   end
endmodule   
