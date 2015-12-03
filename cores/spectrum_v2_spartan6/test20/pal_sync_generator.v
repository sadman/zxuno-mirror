`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:02:15 03/12/2015 
// Design Name: 
// Module Name:    pal_generator 
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

module pal_sync_generator (
    input wire clk,
    input wire mode_changed,
    input wire [1:0] mode,  // 00: 48K, 01: 128K, 10: Pentagon, 11: Reserved
    input wire [2:0] ri,
    input wire [2:0] gi,
    input wire [2:0] bi,
    output wire [8:0] hcnt,
    output wire [8:0] vcnt,
    output reg [2:0] ro,
    output reg [2:0] go,
    output reg [2:0] bo,
    output reg hsync,
    output reg vsync,
    output reg in_int_line
    );

	reg [8:0] hc = 9'h000;
	reg [8:0] vc = 9'h000;

  reg [8:0] end_count_h = 9'd447;
  reg [8:0] end_count_v = 9'd311;
  reg [8:0] begin_hblank = 9'd320;
  reg [8:0] end_hblank = 9'd415;
  reg [8:0] begin_hsync = 9'd344;
  reg [8:0] end_hsync = 9'd375;
  reg [8:0] begin_vblank = 9'd248;
  reg [8:0] end_vblank = 9'd255;
  reg [8:0] begin_vsync = 9'd248;
  reg [8:0] end_vsync = 9'd251;
  reg [8:0] int_line_number = 9'd248;

	assign hcnt = hc;
	assign vcnt = vc;
  
	always @(posedge clk) begin
    if (mode_changed == 1'b0) begin
      if (hc == end_count_h) begin
        hc <= 0;
        if (vc == end_count_v)
          vc <= 0;
        else
          vc <= vc + 1;
      end
      else
        hc <= hc + 1;
    end
    else begin
      hc <= 9'd0;
      vc <= 9'd0;
      case (mode)
        2'b00: begin // timings for Sinclair 48K
                  end_count_h <= 9'd447;
                  end_count_v <= 9'd311;
                  begin_hblank <= 9'd320;
                  end_hblank <= 9'd415;
                  begin_hsync <= 9'd344;
                  end_hsync <= 9'd375;
                  begin_vblank <= 9'd248;
                  end_vblank <= 9'd255;
                  begin_vsync <= 9'd248;
                  end_vsync <= 9'd251;
                  int_line_number <= 9'd248;
               end
        2'b01: begin // timings for Sinclair 128K/+2 grey
                  end_count_h <= 9'd455;
                  end_count_v <= 9'd310;
                  begin_hblank <= 9'd320;
                  end_hblank <= 9'd415;
                  begin_hsync <= 9'd344;
                  end_hsync <= 9'd375;
                  begin_vblank <= 9'd248;
                  end_vblank <= 9'd255;
                  begin_vsync <= 9'd248;
                  end_vsync <= 9'd251;
                  int_line_number <= 9'd248;
               end
        2'b10,
        2'b11: begin // timings for Pentagon 128
                  end_count_h <= 9'd447;
                  end_count_v <= 9'd319;
                  begin_hblank <= 9'd312;
                  end_hblank <= 9'd375;
                  begin_hsync <= 9'd336;
                  end_hsync <= 9'd367;
                  begin_vblank <= 9'd240;
                  end_vblank <= 9'd255;
                  begin_vsync <= 9'd240;
                  end_vsync <= 9'd243;
                  int_line_number <= 9'd240;
               end
      endcase
    end
	end

    always @* begin
        ro = ri;
        go = gi;
        bo = bi;
        hsync = 1'b1;
        vsync = 1'b1;
        if (vc == int_line_number)
          in_int_line = 1'b1;
        else
          in_int_line = 1'b0;
        if ( (hc >= begin_hblank && hc <= end_hblank) || (vc >= begin_vblank && vc <= end_vblank) ) begin
            ro = 3'b000;
            go = 3'b000;
            bo = 3'b000;
            if (hc >= begin_hsync && hc <= end_hsync)
                hsync = 1'b0;
            if (vc >= begin_vsync && vc <= end_vsync) 
                vsync = 1'b0;
        end
     end        
endmodule
