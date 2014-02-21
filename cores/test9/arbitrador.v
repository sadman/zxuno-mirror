`timescale 1ns / 1ns
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:30:13 02/09/2014 
// Design Name: 
// Module Name:    arbitrador 
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

`define ADDR_7FFD (a[0] && !a[1] && a[14] && !a[15])
`define ADDR_1FFD (a[0] && !a[1] && a[12] && a[15:13]==3'b000)

`define PAGE0 3'b000
`define PAGE1 3'b001
`define PAGE2 3'b010
`define PAGE3 3'b011
`define PAGE4 3'b100
`define PAGE5 3'b101
`define PAGE6 3'b110
`define PAGE7 3'b111

module mapper (
   input wire clk,
   input wire mrst_n,   // reset total, para mapear la ROM interna del cargador de ROMs
   input wire cpurst_n, // reset convencional, sin cambiar mapeo de ROM
   
   input wire [15:0] a,
   input wire mreq_n,
   input wire iorq_n,
   input wire rd_n,
   input wire wr_n,
   input wire [7:0] din,
   
   output wire vrampage,
   output reg [15:0] addr_rom,
   output reg oe_n_rom,
   output reg [18:0] addr_ram,
   output reg oe_n_ram,
   output reg we_n_ram
   );
   
   reg [7:0] bank128 = 8'h00;
   reg [7:0] bankplus3 = 8'h00;
   wire puerto_bloqueado = bank128[5];
   wire [2:0] banco_ram = bank128[2:0];
   assign vrampage = bank128[3];
   wire banco_rom = {bankplus3[2],bank128[4]};
   wire modo_paginacion = bankplus3[0];
   wire [1:0] configuracion_mapa_plus3 = bankplus3[2:1];
   
   always @(posedge clk) begin
      if (!mrst_n || !cpurst_n) begin
         bank128 <= 8'h00;
         bankplus3 <= 8'h00;
      end
      else if (!iorq_n && !wr_n && `ADDR_7FFD && !puerto_bloqueado)
         bank128 <= din;
      else if (!iorq_n && !wr_n && `ADDR_1FFD && !puerto_bloqueado)
         bankplus3 <= din;
   end
      
   always @* begin
      oe_n_rom = 1'b1;
      oe_n_ram = 1'b1;
      we_n_ram = 1'b1;
      addr_rom = 16'h0000;
      addr_ram = 19'h00000;

      if (!mreq_n) begin
         if (modo_paginacion == 1'b0) begin  // paginación estándar
            case (a[15:14])
               2'b00 : if (!rd_n) begin
                         oe_n_rom = 1'b0;
                         addr_rom = {banco_rom,a[13:0]};
                       end
               2'b01 : begin
                         addr_ram = {2'b00,`PAGE5,a[13:0]};
                         oe_n_ram = 1'b0;
                         we_n_ram = wr_n;
                       end
               2'b10 : begin
                         addr_ram = {2'b00,`PAGE2,a[13:0]};
                         oe_n_ram = 1'b0;
                         we_n_ram = wr_n;
                       end
               2'b11 : begin
                         addr_ram = {2'b00, banco_ram,a[13:0]};
                         oe_n_ram = 1'b0;
                         we_n_ram = wr_n;
                       end
            endcase
         end
         else begin  // paginación especial, modo all-RAM
           case (a[15:14])
              2'b00 : case (configuracion_mapa_plus3)
                         2'b00 : begin
                                   addr_ram = {2'b00,`PAGE0,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                         2'b01,
                         2'b10,
                         2'b11 : begin
                                   addr_ram = {2'b00,`PAGE4,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                      endcase
              2'b01 : case (configuracion_mapa_plus3)
                         2'b00 : begin
                                   addr_ram = {2'b00,`PAGE1,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                         2'b01,
                         2'b10 : begin
                                   addr_ram = {2'b00,`PAGE5,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                         2'b11 : begin
                                   addr_ram = {2'b00,`PAGE7,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                      endcase
              2'b10 : case (configuracion_mapa_plus3)
                         2'b00 : begin
                                   addr_ram = {2'b00,`PAGE2,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                         2'b01,
                         2'b10,
                         2'b11 : begin
                                   addr_ram = {2'b00,`PAGE6,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                      endcase
              2'b11 : case (configuracion_mapa_plus3)
                         2'b00,
                         2'b10,
                         2'b11: begin
                                   addr_ram = {2'b00,`PAGE3,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                         2'b01 : begin
                                   addr_ram = {2'b00,`PAGE7,a[13:0]};
                                   oe_n_ram = 1'b0;
                                   we_n_ram = wr_n;
                                 end
                      endcase
           endcase   
         end
      end
   end
endmodule
