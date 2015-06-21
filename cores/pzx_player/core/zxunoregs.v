`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:21 03/01/2014 
// Design Name: 
// Module Name:    zxunoregs 
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
module zxunoregs (
   input wire clk,
   input wire rst_n,
   input wire [15:0] a,
   input wire iorq_n,
   input wire rd_n,
   input wire wr_n,
   input wire [7:0] din,
   output reg [7:0] dout,
   output reg oe_n,
   output wire [7:0] addr,
   output wire read_from_reg,
   output wire write_to_reg,
   output wire regaddr_changed
   );
   
   parameter
      IOADDR = 16'hFC3B,
      IODATA = 16'hFD3B;

// Manages register addr ($00 - $FF)   
   reg [7:0] raddr = 8'h00;
   assign addr = raddr;

   assign regaddr_changed = (!iorq_n && a==IOADDR && !wr_n);
   assign read_from_reg = (a==IODATA && !iorq_n && !rd_n);
   assign write_to_reg = (a==IODATA && !iorq_n && !wr_n);
   
   always @(posedge clk) begin
      if (!rst_n) begin
         raddr <= 8'h00;
      end
      else if (!iorq_n && a==IOADDR && !wr_n) begin
         raddr <= din;
      end
   end
    
   always @* begin
      if (!iorq_n && a==IOADDR && !rd_n) begin
         dout = raddr;
         oe_n = 1'b0;
      end
      else begin
         dout = 8'hZZ;
         oe_n = 1'b1;
      end
   end
endmodule
