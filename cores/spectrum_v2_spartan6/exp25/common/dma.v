`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:02:46 02/13/2017 
// Design Name: 
// Module Name:    dma 
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

module dma (
    input wire clk,
    input wire rst_n,
    input wire [7:0] zxuno_addr,
    input wire zxuno_regrd,
    input wire zxuno_regwr,
    input wire [7:0] din,
    output reg [7:0] dout,
    output reg oe_n,
    //---- DMA bus -----
    output reg busrq_n,
    input wire busak_n,
    output reg [15:0] dma_a,
    output reg dma_mreq_n,
    output reg dma_iorq_n,
    output reg dma_rd_n,
    output reg dma_wr_n   
    );

    reg [1:0] modo = 2´b00;  // 00: apagado, 01: burst sin reinicio, 10: timed, sin reinicio, 11: timed, con reinicio    
    reg [1:0] srcdest = 2´b00; // 00: memoria a memoria, 01: memoria a I/O, 10: I/O a memoria, 11: I/O a I/O
    reg [15:0] src = 16´h0000, dst = 16´h0000;
    reg [15:0] divisor = 16´h0000;
    reg [15:0] contador = 16´h0000;
    reg [2:0] estado = NODMA;
    
    always @(posedge clk) begin
      if (rst_n == 1´b0) begin
        modo <= 2´b00;
        busrq_n <= 1´b1;
        divisor <= 16´h0000;
        contador <= 16´h0000;
        estado <= NODMA;
      end
      else begin
        case (estado)
          NODMA:
            begin
              
    

endmodule
