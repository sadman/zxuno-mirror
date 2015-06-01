`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:37 02/09/2015 
// Design Name: 
// Module Name:    sistema 
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
module sistema(
    input wire clkps2,
    input wire clkdisplay,
    inout wire ps2clk,
    inout wire ps2data,

    input wire boton1,
    input wire boton2,
    input wire boton3,
    input wire boton4,
    input wire [7:0] addr,
    
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire ledreleased,
    output wire ledextended,
    output wire lederror,
    output wire [4:0] keycol
    );
    
    reg [15:0] digitos = 16'h0000;
    wire [7:0] scancode;
    wire [7:0] dato_a_escribir;
    wire dataload;
    wire ps2busy;
    wire nueva_tecla;
    
    always @(posedge clkps2) begin
        if (nueva_tecla)
            digitos <= { digitos[7:0], scancode };
    end
    
    ps2_port lectura_de_teclado (
        .clk(clkps2),
        .enable_rcv(~ps2busy),
        .ps2clk_ext(ps2clk),
        .ps2data_ext(ps2data),
        .kb_interrupt(nueva_tecla),
        .scancode(scancode),
        .released(ledreleased),
        .extended(ledextended)
    );

    kbdata_generator generador (
        .clk(clkps2),
        .bt1ex(boton1),
        .bt2ex(boton2),
        .bt3ex(boton3),
        .bt4ex(boton4),
        .sw(addr),
        .busy(ps2busy),
        .data(dato_a_escribir),
        .dataload(dataload)
    );
            
    ps2_host_to_kb escritura_a_teclado (
        .clk(clkps2),
        .ps2clk_ext(ps2clk),
        .ps2data_ext(ps2data),
        .data(dato_a_escribir),
        .dataload(dataload),
        .ps2busy(ps2busy),
        .ps2error(lederror)
    );
    
    display el_display (
        .clk(clkdisplay),
        .d(digitos),
        .an(an),
        .seg(seg)
    );
    
    assign keycol = 5'b00000;
endmodule

module detectpress (
  input wire clk,
  input wire incrin,
  output wire incrout
  );
  
  // Synchronizer
  reg incr1=1'b0, incr2=1'b0;
  always @(posedge clk) begin
    incr1 <= incrin;
    incr2 <= incr1;
  end
  wire increment_synched = incr2;
  
  // Deglitch and edge-detect, version 1
  reg [15:0] incrhistory = 16'h0000;
  reg incr_detectedv1 = 1'b0;
  always @(posedge clk) begin
    incrhistory <= { incrhistory[14:0] , increment_synched };
    if (incrhistory == 16'h0FFF)
      incr_detectedv1 <= 1'b1;
    else
      incr_detectedv1 <= 1'b0;
  end
  assign incrout = incr_detectedv1;  
endmodule

module kbdata_generator (
    input wire clk,
    input wire bt1ex,
    input wire bt2ex,
    input wire bt3ex,
    input wire bt4ex,
    input wire [7:0] sw,
    input wire busy,
    output wire [7:0] data,
    output wire dataload
    );
    
    wire bt1,bt2,bt3,bt4;
    
    reg rdataload = 1'b0;
    reg [7:0] rdata = 8'h00;
    assign dataload = rdataload;
    assign data = rdata;
    
    detectpress p1 (clk, bt1ex, bt1);
    detectpress p2 (clk, bt2ex, bt2);
    detectpress p3 (clk, bt3ex, bt3);
    detectpress p4 (clk, bt4ex, bt4);
    
    always @(posedge clk) begin
        if (bt1 && ~busy && ~rdataload) begin
            rdataload <= 1'b1;
            rdata <= 8'hFF;
        end
        else if (bt2 && ~busy && ~rdataload) begin
            rdataload <= 1'b1;
            rdata <= 8'hFC;
        end
        else if (bt3 && ~busy && ~rdataload) begin
            rdataload <= 1'b1;
            rdata <= 8'hED;
        end
        else if (bt4 && ~busy && ~rdataload) begin
            rdataload <= 1'b1;
            rdata <= sw;
        end
        else if (rdataload) begin
            rdataload <= 1'b0;
        end
    end
endmodule
    