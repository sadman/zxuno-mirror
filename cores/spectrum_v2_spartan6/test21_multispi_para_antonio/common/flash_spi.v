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

module flash_and_sd (
   input wire clk,         //
   input wire [15:0] a,    //
   input wire iorq_n,      // Señales de control de E/S estándar
   input wire rd_n,        // para manejar los puertos ZXMMC y DIVMMC
   input wire wr_n,        //
   input wire [7:0] addr,  // numero de registro almacenado en puerto ZXUNOADDR. Este módulo atiende a $02 y $03
   input wire ior,         // lectura a un registro ZXUNO
   input wire iow,         // escritura a un registro ZXUNO
   input wire [7:0] din,   // del bus de datos de salida de la CPU
   output reg [7:0] dout, // al bus de datos de entrada de la CPU
   output reg oe_n,       // el dato en dout es válido
   output wire wait_n,     // pausa para la CPU. Mejora estabilidad
   
   input wire in_boot_mode,// Esta interfaz sólo es válida en modo boot
   output wire flash_cs_n, //
   output wire flash_clk,  // Interface SPI con la Flash
   output wire flash_di,   //
   input wire flash_do,    //
   
   input wire disable_spisd,
   output wire sd_cs_n,    //
   output wire sd_clk,     // Interface SPI con la SD/MMC
   output wire sd_mosi,    //
   input wire sd_miso,     //
   
   input wire ext_do,
   output wire ext_di,
   output wire ext_clk,
   output wire [15:0] ext_cs   
   );

   wire sclk,miso,mosi;
   
   parameter
      CSPIN   = 8'h03,     // bit 0: estado/control de la señal FLASH_CS
      EXTCS1  = 8'h30,
      EXTCS2  = 8'h31,
      SPIPORT = 8'h02,     // registro de lectura/escritura SPI
      SDCS    = 8'h1F,     //
      SDSPI   = 8'h3F,     // Puertos de la ZXMMC
      DIVCS   = 8'he7,     //
      DIVSPI  = 8'heb;     // Puertos del DIVMMC

   reg flashpincs = 1'b1;
   assign flash_cs_n = flashpincs;
   reg sdpincs = 1'b1;
   assign sd_cs_n = sdpincs;

   assign flash_clk = sclk;
   assign flash_di = mosi;   
   assign sd_clk = sclk;
   assign sd_mosi = mosi;

   assign ext_clk = sclk;
   assign ext_di = mosi;   

   assign miso = (sd_cs_n == 1'b0)   ? sd_miso : 
                 (flash_cs_n == 1'b0)? flash_do :
                                       ext_do;
                                       
   reg [15:0] ext_cs_pins = 16'hFFFF;
   assign ext_cs = ext_cs_pins;

   // Control del pin CS de la flash y de la SD
   always @(posedge clk) begin
      if (addr == CSPIN && iow && in_boot_mode) begin
         flashpincs <= din[0];
         sdpincs <= 1'b1;   // si accedemos a la flash para cambiar su estado CS, automaticamente deshabilitamos la SD
         ext_cs_pins <= 16'hFFFF;
      end
      else if (!disable_spisd && !iorq_n && (a[7:0]==SDCS || a[7:0]==DIVCS) && !wr_n) begin
         sdpincs <= din[0];
         flashpincs <= 1'b1; // y lo mismo hacemos si es la SD a la que estamos accediendo
         ext_cs_pins <= 16'hFFFF;         
      end
      else if (addr == EXTCS1 && iow) begin
         flashpincs <= 1'b1;
         sdpincs <= 1'b1;
         ext_cs_pins[7:0] <= din;
      end
      else if (addr == EXTCS2 && iow) begin
         flashpincs <= 1'b1;
         sdpincs <= 1'b1;
         ext_cs_pins[15:8] <= din;
      end
   end
   
   // Control del modulo SPI
   reg enviar_dato;
   reg recibir_dato;
   always @* begin
      if ((addr==SPIPORT && ior && in_boot_mode) || (!disable_spisd && !iorq_n && (a[7:0]==SDSPI || a[7:0]==DIVSPI) && !rd_n))
         recibir_dato = 1'b1;
      else
         recibir_dato = 1'b0;
      if ((addr==SPIPORT && iow && in_boot_mode) || (!disable_spisd && !iorq_n && (a[7:0]==SDSPI || a[7:0]==DIVSPI) && !wr_n))
         enviar_dato = 1'b1;
      else
         enviar_dato = 1'b0;
   end
   
   wire [7:0] dout_spi;
   wire oe_n_spi;
   always @* begin
      oe_n = 1'b1;
      dout = 8'hZZ;
      if (oe_n_spi == 1'b0) begin
         dout = dout_spi;
         oe_n = 1'b0;
      end
      else if (addr == CSPIN && ior && in_boot_mode) begin
         dout = {7'b0000000, flashpincs};
         oe_n = 1'b0;
      end
      else if (addr == EXTCS1 && ior) begin
         dout = ext_cs_pins[7:0];
         oe_n = 1'b0;
      end
      else if (addr == EXTCS2 && ior) begin
         dout = ext_cs_pins[15:8];
         oe_n = 1'b0;
      end
   end
         
   // Instanciación del modulo SPI   
   spi mi_spi (
      .clk(clk),
      .enviar_dato(enviar_dato),
      .recibir_dato(recibir_dato),
      .din(din),
      .dout(dout_spi),
      .oe_n(oe_n_spi),
      .wait_n(wait_n),
   
      .spi_clk(sclk),
      .spi_di(mosi),
      .spi_do(miso)
      );
    
endmodule
