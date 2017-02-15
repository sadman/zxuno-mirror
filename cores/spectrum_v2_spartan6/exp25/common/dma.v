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

   reg [1:0] mode = 2´b00;  // 00: apagado, 01: burst sin reinicio, 10: timed, sin reinicio, 11: timed, con reinicio    
   reg [1:0] srcdest = 2´b00; // 00: memoria a memoria, 01: memoria a I/O, 10: I/O a memoria, 11: I/O a I/O
   reg [15:0] src = 16´h0000, dst = 16´h0000;
   reg [15:0] srcidx = 16'h0000, dstidx = 16'h0000;
   reg [15:0] divisor = 16´h0000;
   reg [15:0] cntdivisor = 16´h0000;
   reg [15:0] transferlength = 16'h0000;
   reg [15:0] cnttransfers = 16'h0000;
   reg [2:0] state = NODMA;
   initial busrq_n = 1'b1;
   initial dma_mreq_n = 1'b1;
   initial dma_iorq_n = 1'b1;
   initial dma_rd_n = 1'b1;
   initial dma_wr_n = 1'b1;
    
   always @(posedge clk) begin
      if (rst_n == 1´b0) begin
        mode <= 2´b00;
        busrq_n <= 1´b1;
        dma_mreq_n <= 1'b1;
        dma_iorq_n <= 1'b1;
        dma_rd_n <= 1'b1;
        dma_wr_n <= 1'b1;
        divisor <= 16´h0000;
        cntdivisor <= 16´h0000;
        transferlength <= 16'h0000;
        cnttransfers <= 16'h0000;
        state <= NODMA;
      end
      else begin
         case (state)
            NODMA:
            begin
               if (mode == 2'b01) begin
                  state <= DOBURST;
                  busrq_n <= 1'b0;
                  cnttransfers <= transferlength;
               end
               else if (mode == 2'b10 || mode == 2'b11) begin
                  state <= INITTIMED;
                  cntdivisor <= divisor;
                  cnttransfers <= transferlength;
               end
            end
            
            DOBURST:
            begin
               if (busak_n == 1'b0) begin
                  if (cnttransfers == 16'h0000) begin
                     state <= NODMA;
                     busrq_n <= 1'b1;
                  end
                  else begin
                     case (srcdest)
                        2'b00: begin
                                 state <= DOMEM2MEM;
                                 srcidx <= src;
                                 dstidx <= dst;
                                 dma_a <= src;
                               end  
                        2'b01: state <= DOMEM2IO;
                        2'b10: state <= DOIO2MEM;
                        2'b11: state <= DOIO2IO;
                     endcase
                     returnstate <= DOBURST;
                  end
            end
            
            DOMEM2MEM:
            begin
               dma_mreq <= 1'b0;
               dma_rd_n <= 1'b0;
               state <= MEM2MEM_2;
            end
            
            MEM2MEM_2:
            begin
               data <= din;
               dma_mreq <= 1'b1;
               dma_a <= dstidx;
               state <= MEM2MEM_3;
            end
            
            MEM2MEM_3:
            begin
               dma_wr_n <= 1'b0;
               
               state <= MEM2MEM4;
            end
            
            MEM2MEM_4:
            begin
               
                  
                  
              
    

endmodule
