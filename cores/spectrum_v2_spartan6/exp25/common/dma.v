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
  input wire [7:0] dma_din,
  output reg [7:0] dma_dout,
  output reg dma_mreq_n,
  output reg dma_iorq_n,
  output reg dma_rd_n,
  output reg dma_wr_n   
  );

  parameter
    NODMA      = 3'd0,
    DOBURST    = 3'd1,
    DOTIMED    = 3'd2,
    DOTIMED_2  = 3'd3,
    DOTRANSFER = 3'd4,
    TRANSFER_2 = 3'd5,
    TRANSFER_3 = 3'd6,
    TRANSFER_4 = 3'd7;

  parameter
    DMACTRL = 8'hA0,
    DMASRC  = 8'hA1,
    DMADST  = 8'hA2,
    DMADIV  = 8'hA3,
    DMALEN  = 8'hA4,
    DMASTAT = 8'hA5;

  reg [1:0] mode = 2'b00;  // 00: apagado, 01: burst sin reinicio, 10: timed, sin reinicio, 11: timed, con reinicio    
  reg [1:0] srcdst = 2'b00; // 00: memoria a memoria, 01: memoria a I/O, 10: I/O a memoria, 11: I/O a I/O
  reg [15:0] src = 16'h0000, dst = 16'h0000;
  reg [15:0] srcidx = 16'h0000, dstidx = 16'h0000;
  reg [15:0] divisor = 16'h0000;
  reg [15:0] cntdivisor = 16'h0000;
  reg [15:0] transferlength = 16'h0000;
  reg [15:0] cnttransfers = 16'h0000;
  reg [2:0] state = NODMA;
  reg [2:0] returnstate = NODMA;
  reg [7:0] dma_data, data;
  reg data_received = 1'b0;
  initial busrq_n = 1'b1;
  initial dma_mreq_n = 1'b1;
  initial dma_iorq_n = 1'b1;
  initial dma_rd_n = 1'b1;
  initial dma_wr_n = 1'b1;

  // CPU reads DMA registers
  always @* begin
    oe_n = 1'b1;
    dout = 8'hFF;
    if (zxuno_addr == DMACTRL && zxuno_regrd == 1'b1) begin
      dout = {4'b0000, srcdst, mode};
      oe_n = 1'b0;
    end
    else if (zxuno_addr == DMASTAT && zxuno_regrd == 1'b1) begin
      dout = 

  // CPU writes DMA registers
  always @(posedge clk) begin
    if (rst_n == 1'b0) begin
      data_received <= 1'b0;
      mode <= 2'b00;
      srcdst <= 2'b00;      
      divisor <= 16'h0000;
      transferlength <= 16'h0000;
      src <= 16'h0000;
      dst <= 16'h0000;
    end
    else begin
      if (zxuno_addr == DMACTRL && zxuno_regwr == 1'b1)
        {srcdst,mode} <= din[3:0];
      else if (zxuno_regwr == 1'b1 && (zxuno_addr == DMASRC || zxuno_addr == DMADST || zxuno_addr == DMADIV || zxuno_addr == DMALEN)) begin
        data_received <= 1'b1;
        data <= din;
      end
      else if (data_received == 1'b1 && zxuno_regwr == 1'b0) begin  // just after the I/O write operation has finished, 16-bit registers are updated
        case (zxuno_addr)
          DMASRC: src <= {data, src[15:8]};
          DMADST: dst <= {data, dst[15:8]};
          DMADIV: divisor <= {data, divisor[15:8]};
          DMALEN: transferlength <= {data, transferlength[15:8]};
        endcase
        data_received <= 1'b0;
      end
    end
  end

  // DMA FSM
  always @(posedge clk) begin
    if (rst_n == 1'b0) begin
      busrq_n <= 1'b1;
      dma_mreq_n <= 1'b1;
      dma_iorq_n <= 1'b1;
      dma_rd_n <= 1'b1;
      dma_wr_n <= 1'b1;
      cntdivisor <= 16'h0000;
      cnttransfers <= 16'h0000;
      state <= NODMA;
    end
    else begin
      if (cntdivisor == 16'h0000)
        cntdivisor <= divisor;
      else
        cntdivisor <= cntdivisor + 16'hFFFF ; // -1         
      case (state)
        NODMA:
        begin
          if (mode == 2'b01) begin
            state <= DOBURST;
            busrq_n <= 1'b0;
            cnttransfers <= transferlength;
          end
          else if (mode == 2'b10 || mode == 2'b11) begin
            state <= DOTIMED;
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
              state <= DOTRANSFER;
              srcidx <= src;
              dstidx <= dst;
              dma_a <= src;
              returnstate <= DOBURST;
            end
          end
        end
        
        DOTIMED:
        begin
          if (mode == 2'b00) begin
            state <= NODMA;
            busrq_n <= 1'b1;
          end
          else if (cntdivisor == 16'h0000) begin
            busrq_n <= 1'b0;
            srcidx <= src;
            dstidx <= dst;
            state <= DOTIMED_2;
          end
          else
            busrq_n <= 1'b1;
        end
        
        DOTIMED_2:
        begin
          if (busak_n == 1'b0) begin
            if (cnttransfers != 16'h0000) begin
              state <= DOTRANSFER;
              dma_a <= src;
              returnstate <= DOTIMED;
            end
            else if (mode == 2'b11) begin
              cnttransfers <= transferlength;
              srcidx <= src;
              dstidx <= dst;
            end
          end
        end
        
        //--- One transfer ---
        DOTRANSFER:
        begin
          if (src[1] == 1'b0)
            dma_mreq_n <= 1'b0;
          else
            dma_iorq_n <= 1'b0;
          dma_rd_n <= 1'b0;
          state <= TRANSFER_2;
        end
        
        TRANSFER_2:
        begin
          dma_data <= dma_din;
          dma_rd_n <= 1'b1;
          dma_mreq_n <= 1'b1;
          dma_iorq_n <= 1'b1;
          dma_a <= dstidx;
          state <= TRANSFER_3;
        end
        
        TRANSFER_3:
        begin
          if (src[0] == 1'b0)
            dma_mreq_n <= 1'b0;
          else
            dma_iorq_n <= 1'b0;
          dma_wr_n <= 1'b0;
          dma_dout <= dma_data;
          state <= TRANSFER_4;
        end
        
        TRANSFER_4:
        begin
          dma_mreq_n <= 1'b1;
          dma_iorq_n <= 1'b1;
          dma_wr_n <= 1'b1;
          cnttransfers <= cnttransfers + 16'hFFFF; // -1
          if (srcdst[1] == 1'b0)
              srcidx <= srcidx + 16'd1;
          if (srcdst[0] == 1'b0)
              dstidx <= dstidx + 16'd1;
          state <= returnstate;
        end
      endcase
    end
  end    
endmodule
