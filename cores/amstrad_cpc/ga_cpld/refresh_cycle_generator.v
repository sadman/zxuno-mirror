`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:55:32 08/13/2017 
// Design Name: 
// Module Name:    refresh_cycle_generator 
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

module rfsh_generator (
  input wire clk16,
  input wire reset_n,
  input wire mreq_n,
  input wire m1_n,
  output wire rfsh_n
  );
  
  reg m1_delayed = 1'b1;
  reg mreq_delayed = 1'b1;
  reg refresh_cycle = 1'b0;
  
  always @(posedge clk16) begin
    if (reset_n == 1'b0) begin
      m1_delayed <= 1'b1;
      mreq_delayed <= 1'b1;
      refresh_cycle <= 1'b0;
    end
    else begin
      m1_delayed <= m1_n;
      mreq_delayed <= mreq_n;
      if (refresh_cycle == 1'b0 && m1_n == 1'b1 && m1_delayed == 1'b0)  // flanco de subida de M1 acaba de producirse. Comienza el ciclo de refresco
        refresh_cycle <= 1'b1;
      else if (refresh_cycle == 1'b1 && mreq_n == 1'b1 && mreq_delayed == 1'b0)  // flanco de subida de MREQ acaba de producirse. Termina el ciclo de refresco
        refresh_cycle <= 1'b0;
    end
  end
  
  assign rfsh_n = ~refresh_cycle;
endmodule
