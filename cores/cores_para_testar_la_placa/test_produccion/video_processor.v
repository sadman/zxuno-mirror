`timescale 1ns / 1ps
`default_nettype none
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

module background (
    input wire clk,
    input wire mode,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b,
    output wire [8:0] hc,
    output wire [8:0] vc,
    output wire hsync,
    output wire vsync,
    output wire csync    
    );

    wire blank;

    sync_generator_pal_ntsc sincronismos (
    .clk(clk),   // 7 MHz
    .in_mode(mode),  // 0: PAL, 1: NTSC
    .csync_n(csync),
    .hsync_n(hsync),
    .vsync_n(vsync),
    .hc(hc),
    .vc(vc),
    .blank(blank)
    );
    
    always @* begin
        if (blank == 1'b1) begin
            {g,r,b} = 9'b000000000;
        end
        else begin
            {g,r,b} = 9'b000000000;
            if (hc >= (39*0) && hc <= (39*1-1)) begin
                {g,r,b} = 9'b100000000;
            end
            if (hc >= (39*1) && hc <= (39*2-1)) begin
                {g,r,b} = 9'b010000000;
            end
            if (hc >= (39*2) && hc <= (39*3-1)) begin
                {g,r,b} = 9'b001000000;
            end
            if (hc >= (39*3) && hc <= (39*4-1)) begin
                {g,r,b} = 9'b000100000;
            end
            if (hc >= (39*4) && hc <= (39*5-1)) begin
                {g,r,b} = 9'b000010000;
            end
            if (hc >= (39*5) && hc <= (39*6-1)) begin
                {g,r,b} = 9'b000001000;
            end
            if (hc >= (39*6) && hc <= (39*7-1)) begin
                {g,r,b} = 9'b000000100;
            end
            if (hc >= (39*7) && hc <= (39*8-1)) begin
                {g,r,b} = 9'b000000010;
            end
            if (hc >= (39*8) && hc <= (39*9-1)) begin
                {g,r,b} = 9'b000000001;
            end
        end
    end        
endmodule

module window_on_background (
    input wire clk,
    input wire mode,
    input wire [8:0] addr,
    input wire [7:0] data,
    input wire we,
    output reg [2:0] r,
    output reg [2:0] g,
    output reg [2:0] b,
    output wire hsync,
    output wire vsync,
    output wire csync
    );
   
    parameter
      BEGINX = 9'd40,
      ENDX = 9'd296,
      BEGINY = 9'd64,
      ENDY = 9'd192;

    wire [2:0] rb,gb,bb;
    wire [8:0] hc,vc;
   
    background bg (
    .clk(clk),
    .mode(mode),
    .r(rb),
    .g(gb),
    .b(bb),
    .hc(hc),
    .vc(vc),
    .hsync(hsync),
    .vsync(vsync),
    .csync(csync)
    );
    
    reg [7:0] charrom[0:2047];
    initial begin
      $readmemh ("CP437.hex", charrom);
    end
    
    wire in_text_window = (hc >= BEGINX && hc < ENDX && vc >= BEGINY && vc < ENDY);
    wire showing_text_window = (hc >= (BEGINX+9'd8) && hc < (ENDX+9'd8) && vc >= BEGINY && vc < ENDY);
    
    reg [7:0] chc = 8'h00;
    reg [6:0] cvc = 7'h00;
    reg [7:0] shiftreg;
    reg [7:0] character;
    wire [7:0] dout;
    reg [8:0] charaddr = 9'd0;

   screenfb buffer_pantalla (
      .clk(clk),
      .addr_read(charaddr),
      .addr_write(addr),
      .we(we),
      .din(data),
      .dout(dout)
   );

   always @(posedge clk) begin
      // H and C counters for text window
      if (hc == (BEGINX-9'd1)) begin  // empezamos a contar 8 pixeles antes, para tener ya el shiftreg cargado cuando comencemos de verdad
         chc <= 8'd0;
         if (vc == BEGINY)
            cvc <= 7'd0;
         else
            cvc <= cvc + 7'd1;
      end
      else begin
         chc <= chc + 8'd1;
      end

      // char generator
      if (in_text_window) begin
         if (chc[2:0] == 3'b010) begin
            charaddr <= {cvc[6:3],5'b00000} + {2'b00,chc[7:3]};
         end
         if (chc[2:0] == 3'b100) begin         
            character <= dout; // lee el caracter siguiente
         end
         if (chc[2:0] == 3'b111) begin
            shiftreg <= charrom[{character,cvc[2:0]}];
         end
      end
      if (showing_text_window && chc[2:0] != 3'b111) begin
         shiftreg <= {shiftreg[6:0],1'b0};
      end
    end
    
    always @* begin
      {r,g,b} = {rb,gb,bb};
      if (showing_text_window)  // ventana de 24x16 caracteres de 8x8
         {r,g,b} = {9{shiftreg[7]}};  // texto blanco sobre fondo negro
    end
endmodule

module screenfb (
   input wire clk,
   input wire [8:0] addr_read,
   input wire [8:0] addr_write,
   input wire we,
   input wire [7:0] din,
   output reg [7:0] dout
   );
   
   reg [7:0] screenrom[0:511];
   integer i;
   initial begin
     for (i=0; i<512; i=i+1)
        screenrom[i] = i[7:0];
   end
    
   always @(posedge clk) begin
      dout <= screenrom[addr_read];
      if (we)
         screenrom[addr_write] <= din;
   end
endmodule

module teletype (
   input wire clk,
   input wire mode,
   input wire [7:0] chr,
   input wire we,
   output reg busy,
   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire hsync,
   output wire vsync,
   output wire csync
   );

   reg [8:0] addr = 9'd0;
   reg [7:0] data = 8'h00, dscreen = 8'h00;
   reg wescreen = 1'b0;
   initial busy = 1'b0;
    
   window_on_background screen (
    .clk(clk),
    .mode(mode),
    .addr(addr),
    .data(dscreen),
    .we(wescreen),
    .r(r),
    .g(g),
    .b(b),
    .hsync(hsync),
    .vsync(vsync),
    .csync(csync)
    );
    
   parameter
      IDLE = 4'd0,
      PCOMMAND = 4'd1,
      ATR = 4'd3,
      ATC = 4'd4,
      CLS = 4'd5,
      PUTCHAR = 4'd6
      ;
      
   parameter
      AT = 8'd22,
      CR = 8'd13,
      HOME = 8'd12
      ;
            
   reg [2:0] estado = IDLE;
   reg [3:0] row = 4'd0;
    
   always @(posedge clk) begin
      case (estado)
         IDLE,ATR,ATC: 
            begin
               if (we) begin
                  data <= chr;
                  if (estado == ATR) begin
                     row <= chr[3:0];
                     estado <= ATC;
                  end
                  else if (estado == ATC) begin
                     addr <= {row,chr[4:0]};
                     estado <= IDLE;
                  end
                  else begin
                     busy <= 1'b1;
                     estado <= PCOMMAND;
                  end                  
               end
            end
         PCOMMAND:
            begin
               if (data == AT) begin
                  busy <= 1'b0;
                  estado <= ATR;               
               end
               else if (data == HOME) begin
                  addr <= 9'd0;
                  wescreen <= 1'b1;
                  dscreen <= 8'h20;
                  estado <= CLS;
               end
               else if (data == CR) begin
                  addr <= {(addr[8:5] + 4'd1),5'b0000};
                  busy <= 1'b0;
                  estado <= IDLE;
               end
               else begin
                  dscreen <= data;
                  wescreen <= 1'b1;
                  estado <= PUTCHAR;
               end
            end
         CLS:
            begin
               if (addr == 9'h1FF) begin
                  busy <= 1'b0;
                  estado <= IDLE;
                  wescreen <= 1'b0;
                  addr <= 9'd0;
               end
               else
                  addr <= addr + 9'd1;
            end
         PUTCHAR:
            begin
               busy <= 1'b0;
               wescreen <= 1'b0;
               addr <= addr + 9'd1;
               estado <= IDLE;
            end
      endcase
   end
endmodule    

module updater (
   input wire clk,
   input wire mode,
   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire hsync,
   output wire vsync,
   output wire csync
   );
      
   parameter
      AT = 8'd22,
      CR = 8'd13,
      HOME = 8'd12
      ;

   reg [7:0] chr = 8'd0;
   reg we = 1'b0;
   wire busy;
   
   teletype teletipo (
     .clk(clk),
     .mode(mode),
     .chr(chr),
     .we(we),
     .busy(busy),
     .r(r),
     .g(g),
     .b(b),
     .hsync(hsync),
     .vsync(vsync),
     .csync(csync)
     );
   
   reg [7:0] stringlist[0:511];
   integer i;
   initial begin
      for (i=0;i<512;i=i+1) begin
         stringlist[i] = 8'hFF;
      end
      $readmemh ("cadenas.hex", stringlist);
   end
   reg [8:0] addrstr = 8'd0;
   
   reg [3:0] estado = INIT, 
             retorno_de_sendchar = INIT, 
             retorno_de_sendstr = INIT;
   parameter
      INIT = 4'd0,
      SENDCHAR = 4'd1,
      SENDCHAR1 = 4'd2,
      SENDSTR = 4'd3,
      SENDSTR1 = 4'd4,
      MSG = 4'd5,
      HALT = 4'd15
      ;
      
   always @(posedge clk) begin
      case (estado)
         INIT:
            begin
               chr <= HOME;
               estado <= SENDCHAR;
               retorno_de_sendchar <= MSG;
            end
         MSG:
            begin
               addrstr <= 8'd0;
               estado <= SENDSTR;
               retorno_de_sendstr <= HALT;
            end         

         SENDSTR:
            begin
               chr <= stringlist[addrstr];
               addrstr <= addrstr + 9'd1;
               estado <= SENDSTR1;
            end
         SENDSTR1:
            begin
               if (chr == 8'hFF)
                  estado <= retorno_de_sendstr;
               else begin
                  estado <= SENDCHAR;
                  retorno_de_sendchar <= SENDSTR;
               end
            end
         
         SENDCHAR:
            begin
               if (busy == 1'b0) begin
                  we <= 1'b1;
                  estado <= SENDCHAR1;
               end
            end
         SENDCHAR1:
            begin
               we <= 1'b0;
               estado <= retorno_de_sendchar;
            end
      endcase
   end
endmodule
