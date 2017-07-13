`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:18 07/11/2017 
// Design Name: 
// Module Name:    chloe_logo_demo 
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
module chloe_logo_demo (  
    input wire clk,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b,
    output wire csync_n,
    output wire audio_left,
    output wire audio_right
    );
    
    // Area activa: [0 - 319], [0 - 239]
    wire [8:0] hc, vc;
    wire blank;
    
    assign audio_left = 1'b0;
    assign audio_right = 1'b0;
    
    sync_generator_pal_ntsc ntsc_syncs (
      .clk(clk),   // 7 MHz
      .in_mode(1'b1),  // 0: PAL, 1: NTSC
      .csync_n(csync_n),
      .hsync_n(),
      .vsync_n(),
      .hc(hc),
      .vc(vc),
      .blank(blank)
    );

    wire [2:0] rbk, gbk, bbk;
    background_generator bk (
      .clk(clk),
      .hc(hc),
      .vc(vc),
      .r(rbk),
      .g(gbk),
      .b(bbk)
      );
    
    wire [2:0] rsp1, gsp1, bsp1;
    wire trans1;
    sprite_generator #(.INITIAL_X(9'd7), .INITIAL_Y(9'd17), .INITIAL_DX(9'd1), .INITIAL_DY(9'd1), .INITIAL_COLOR(3'b001) ) sprite1 (
      .clk(clk),
      .hc(hc),
      .vc(vc),
      .r(rsp1),
      .g(gsp1),
      .b(bsp1),
      .transparency(trans1)
      );

    wire [2:0] rsp2, gsp2, bsp2;
    wire trans2;
    sprite_generator #(.INITIAL_X(9'd97), .INITIAL_Y(9'd157), .INITIAL_DX(9'b111111111), .INITIAL_DY(9'd1), .INITIAL_COLOR(3'b010) ) sprite2 (
      .clk(clk),
      .hc(hc),
      .vc(vc),
      .r(rsp2),
      .g(gsp2),
      .b(bsp2),
      .transparency(trans2)
      );

    wire [2:0] rsp3, gsp3, bsp3;
    wire trans3;
    sprite_generator #(.INITIAL_X(9'd1), .INITIAL_Y(9'd89), .INITIAL_DX(9'd1), .INITIAL_DY(9'b111111111), .INITIAL_COLOR(3'b111) ) sprite3 (
      .clk(clk),
      .hc(hc),
      .vc(vc),
      .r(rsp3),
      .g(gsp3),
      .b(bsp3),
      .transparency(trans3)
      );

    wire [2:0] rsp4, gsp4, bsp4;
    wire trans4;
    sprite_generator #(.INITIAL_X(9'd253), .INITIAL_Y(9'd37), .INITIAL_DX(9'b111111111), .INITIAL_DY(9'b111111111), .INITIAL_COLOR(3'b100) ) sprite4 (
      .clk(clk),
      .hc(hc),
      .vc(vc),
      .r(rsp4),
      .g(gsp4),
      .b(bsp4),
      .transparency(trans4)
      );

    always @* begin
      r = 3'b000;
      g = 3'b000;
      b = 3'b000;
      if (blank == 1'b0) begin
        casex ({trans1,trans2,trans3,trans4})
          4'b0xxx: begin
                     r = rsp1;
                     g = gsp1;
                     b = bsp1;
                   end
          4'b10xx: begin
                     r = rsp2;
                     g = gsp2;
                     b = bsp2;
                   end
          4'b110x: begin
                     r = rsp3;
                     g = gsp3;
                     b = bsp3;
                   end
          4'b1110: begin
                     r = rsp4;
                     g = gsp4;
                     b = bsp4;
                   end
          default: begin
                     r = rbk;
                     g = gbk;
                     b = bbk;
                   end
        endcase
      end
    end
endmodule


module background_generator (
    input wire clk,
    input wire [8:0] hc,
    input wire [8:0] vc,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b
    );
    
    parameter
      BRIGHT = 3'b010;
    
    reg bkpattern[0:16383];
    initial begin
      $readmemh ("escher.hex", bkpattern);
    end
    
    reg pixel;
    always @(posedge clk) begin
      pixel <= bkpattern[{vc[6:0],hc[6:0]}];
    end
    reg [2:0] curr = 3'b000, curg = BRIGHT, curb = 3'b000;
    reg [2:0] nextr, nextg, nextb;
    reg [8:0] cntframes = 9'd64;
    always @(posedge clk) begin
      if (vc == 9'd241 && hc == 9'd0) begin
        cntframes <= cntframes + 9'd1;
        if (cntframes == 9'd0) begin
          if (curr == BRIGHT) begin
            nextr <= 3'b000;
            nextg <= BRIGHT;
            nextb <= 3'b000;
          end
          else if (curg == BRIGHT) begin
            nextr <= 3'b000;
            nextg <= 3'b000;
            nextb <= BRIGHT;
          end
          else if (curb == BRIGHT) begin
            nextr <= BRIGHT;
            nextg <= 3'b000;
            nextb <= 3'b000;
          end
        end
        else if (cntframes >= 9'd1 && cntframes <= 9'd8) begin
          if (curr != 3'b000)
            curr <= curr + 3'b111;            
          if (curg != 3'b000)
            curg <= curg + 3'b111;
          if (curb != 3'b000)
            curb <= curb + 3'b111;
        end
        else if (cntframes >= 9'd9 && cntframes <= 9'd16) begin
          if (curr != nextr)
            curr <= curr + 3'd1;
          if (curg != nextg)
            curg <= curg + 3'd1;
          if (curb != nextb)
            curb <= curb + 3'd1;
        end        
      end
    end
    
    always @* begin
      if (pixel == 1'b0) begin
        r = 3'b000;
        g = 3'b000;
        b = 3'b000;
      end
      else begin  // background (deep blue)
        r = curr;
        g = curg;
        b = curb;
      end
    end
endmodule      
      

module sprite_generator (
    input wire clk,
    input wire [8:0] hc,
    input wire [8:0] vc,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b,
    output reg transparency
    );
    
    parameter
      INITIAL_X  = 9'd160,
      INITIAL_Y  = 9'd120,
      INITIAL_DX = 9'd1,
      INITIAL_DY = 9'd1,
      INITIAL_COLOR = 3'b111;
    
    reg sprite[0:65535];
    initial begin
      $readmemh ("chloe_16_frames.hex", sprite);
    end
    
    reg signed [8:0] startx = INITIAL_X;
    reg signed [8:0] starty = INITIAL_Y;
    reg signed [8:0] deltax = INITIAL_DX;
    reg signed [8:0] deltay = INITIAL_DY;

    reg [2:0] color = INITIAL_COLOR;
    reg [5:0] frame = 6'd0;
    
    always @(posedge clk) begin
      if (hc == 9'd0 && vc == 9'd241) begin
        if (startx == 9'd0 || startx == 9'd256) begin
          deltax <= -deltax;
        end
        if (starty == 9'd0 || starty == 9'd176) begin
          deltay <= -deltay;
        end
      end
      else if (hc == 9'd1 && vc == 9'd241) begin
        startx <= startx + deltax;
        starty <= starty + deltay;
        frame <= frame + 6'd1;
      end
    end

    reg [15:0] addrsprite;
    reg [5:0] row, column;
    always @* begin
      row = vc-starty;
      column = hc-startx;
      addrsprite = {frame[5:2],row,column};
    end      

    reg pixel;
    always @(posedge clk) begin
      if (hc >= startx && hc < (startx + 9'd64) && vc >= starty && vc < (starty + 9'd64)) begin
        pixel <= sprite[addrsprite];
      end
      else begin
        pixel <= 1'b1;
      end
    end
        
    always @* begin    
      r = {3{color[1]}};
      g = {3{color[2]}};
      b = {3{color[0]}};
      transparency = pixel;
    end
endmodule      
