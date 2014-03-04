`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:52:19 03/03/2014 
// Design Name: 
// Module Name:    flash_spi 
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

module flash_spi (
   input wire clk,  // 50MHz o mas. Transferencia SPI en menos tiempo que lo que dura un ciclo de E/S en el Z80
   input wire [7:0] addr,  // numero de registro almacenado en puerto ZXUNOADDR. Este módulo atiende a $02 y $03
   input wire rd,          // lectura a un registro ZXUNO
   input wire wr,          // escritura a un registro ZXUNO
   input wire [7:0] din,   // del bus de datos de salida de la CPU
   output reg [7:0] dout,  // al bus de datos de entrada de la CPU
   output reg oe_n,        // el dato en dout es válido
   
   output wire flash_cs_n, //
   output wire flash_clk,  // Interface SPI con la Flash
   output wire flash_di,   //
   input wire flash_do     //
   );

   parameter
      CSPIN   = 8'h03,     // bit 0: estado/control de la señal FLASH_CS
      SPIPORT = 8'h02;     // registro de lectura/escritura SPI

   // Control del pin CS de la flash
   reg pincs = 1'b1;
   assign flash_cs_n = pincs;
   always @(posedge clk) begin
      if (addr == CSPIN && wr)
         pincs <= din[0];
   end   

   // Modulo SPI. Reloj de la flash: 25MHz
   reg ciclo_lectura = 1'b0;       // ciclo de lectura en curso
   reg ciclo_escritura = 1'b0;     // ciclo de escritura en curso
   reg [4:0] contador = 5'b00000;  // contador del FSM (ciclos)
   reg [7:0] data_to_flash;        // dato a enviar a la flash por DI
   reg [7:0] data_to_cpu;          // dato a enviar a la CPU leido desde DO
   
   assign flash_clk = contador[0];  // FLASH_CLK es la mitad que el reloj del módulo
   assign flash_di = data_to_flash[7];  // la transmisión es del bit 7 al 0
   
   always @(posedge clk) begin
      if (addr == SPIPORT && wr && !ciclo_escritura) begin  // si hay escritura en SPIPORT, iniciar ciclo de escritura
         ciclo_escritura <= 1'b1;
         ciclo_lectura <= 1'b0;
         contador <= 5'b00000;
         data_to_flash <= din;
      end
      else if (addr == SPIPORT && rd && !ciclo_lectura) begin // si no, si hay lectura en SPIPORT, iniciar ciclo de lectura
         ciclo_lectura <= 1'b1;
         ciclo_escritura <= 1'b0;
         contador <= 5'b00000;
         data_to_cpu <= 8'h00;
      end
      
      // FSM para enviar un dato a la flash
      else if (ciclo_escritura==1'b1) begin
         if (contador!=5'b10000) begin
            if (flash_clk==1'b1)
               data_to_flash <= {data_to_flash[6:0],1'b0};
            contador <= contador + 1;
         end
         else begin
            if (addr != SPIPORT || !wr)
               ciclo_escritura <= 1'b0;
         end
      end
      
      // FSM para leer un dato de la flash
      else if (ciclo_lectura==1'b1) begin
         if (contador!=5'b10000) begin
            if (flash_clk==1'b1)
               data_to_cpu <= {data_to_cpu[6:0],flash_do};
            contador <= contador + 1;
         end
         else begin
            if (addr != SPIPORT || !rd)
               ciclo_lectura <= 1'b0;
         end
      end
   end
   
   always @* begin
      if (addr == CSPIN && rd) begin
         dout = {7'h00,pincs};
         oe_n = 1'b0;
      end
      else if (addr == SPIPORT && rd) begin
         dout = data_to_cpu;
         oe_n = 1'b0;
      end
      else begin
         dout = 8'hZZ;
         oe_n = 1'b1;
      end
   end   
endmodule
