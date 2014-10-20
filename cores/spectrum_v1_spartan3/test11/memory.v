`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:14 03/03/2014 
// Design Name: 
// Module Name:    memory 
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
module memory (
   // Relojes y reset
   input wire clk,        // Reloj del sistema CLK7
   input wire mclk,       // Reloj para el modulo de memoria de doble puerto
   input wire mrst_n,
   input wire rst_n,
   
   // Interface con la CPU
   input wire [15:0] a,
   input wire [7:0] din,  // proveniente del bus de datos de salida de la CPU
   output reg [7:0] dout, // hacia el bus de datos de entrada de la CPU
   output reg oe_n,       // el dato es valido   
   input wire mreq_n,
   input wire iorq_n,
   input wire rd_n,
   input wire wr_n,
   input wire m1_n,       //
   input wire int_n,      // Necesarios para implementar DIVMMC
   input wire nmi_n,      //
   
   // Internface con la ULA
   input wire [13:0] vramaddr,
   output wire [7:0] vramdout,
   
   // Interface para registros ZXUNO
   input wire [7:0] addr,
   input wire ior,
   input wire iow,
   
   // Interface con la SRAM
   output wire [18:0] sram_addr,
   inout wire [7:0] sram_data,
   output wire sram_we_n
   );
   
   parameter
      MASTERCONF = 8'h00,
      MASTERMAPPER = 8'h01;

   reg enable_boot = 1'b1;
   reg enable_divmmc = 1'b0;
   always @(posedge clk) begin
      if (!mrst_n)
         {enable_divmmc,enable_boot} <= 2'b01;
      else if (addr==MASTERCONF && iow && enable_boot)
         {enable_divmmc,enable_boot} <= din[1:0];
   end
   
   reg [4:0] mastermapper = 5'h00;
   always @(posedge clk) begin
      if (!mrst_n)
         mastermapper <= 5'h00;
      else if (addr==MASTERMAPPER && iow && enable_boot)
         mastermapper <= din[4:0];
   end
   
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

   reg [7:0] bank128 = 8'h00;
   reg [7:0] bankplus3 = 8'h00;
   wire puerto_bloqueado = bank128[5];
   wire [2:0] banco_ram = bank128[2:0];
   wire vrampage = bank128[3];
   wire [1:0] banco_rom = {bankplus3[2],bank128[4]};
   wire modo_paginacion = bankplus3[0];
   wire [1:0] configuracion_mapa_plus3 = bankplus3[2:1];
   
   always @(posedge clk) begin
      if (!mrst_n || !rst_n) begin
         bank128 <= 8'h00;
         bankplus3 <= 8'h00;
      end
      else if (!iorq_n && !wr_n && `ADDR_7FFD && !puerto_bloqueado)
         bank128 <= din;
      else if (!iorq_n && !wr_n && `ADDR_1FFD && !puerto_bloqueado)
         bankplus3 <= din;
   end
   
   reg [18:0] addr_port2;
   reg oe_memory_n;
   reg oe_bootrom_n;
   reg we2_n;
   
   // Calculo de la dirección en la SRAM a la que se va a acceder
   
   always @* begin
      oe_memory_n = mreq_n | rd_n;
      we2_n = mreq_n | wr_n;
      oe_bootrom_n = 1'b1;
      addr_port2 = 19'h00000;
      
      if (!mreq_n && a[15:14]==2'b00) begin   // la CPU quiere acceder al espacio de ROM, $0000-$3FFF
         if (enable_boot) begin   // en el modo boot, sólo se accede a la ROM interna
            oe_memory_n = 1'b1;
            oe_bootrom_n = 1'b0;
            we2_n = 1'b1;
         end
         else begin  // estamos en modo normal de ejecución
            // TODO: añadir aquí el codigo para comprobar si ha de paginarse la ROM del DIVMMC!!!!!!!!!!
            if (!modo_paginacion) begin   // en el modo normal de paginación, hay 4 bancos de ROMs
               addr_port2 = {3'b010,banco_rom,a[13:0]};
               we2_n = 1'b1;
            end
            else begin   // en el modo especial de paginación, tenemos el all-RAM
               case (configuracion_mapa_plus3)
                  2'b00 : addr_port2 = {2'b00,`PAGE0,a[13:0]};
                  2'b01,
                  2'b10,
                  2'b11 : addr_port2 = {2'b00,`PAGE4,a[13:0]};
               endcase
            end
         end
      end
      
      else if (!mreq_n && a[15:14]==2'b01) begin   // la CPU quiere acceder al espacio de RAM de $4000-$7FFF
         if (enable_boot || !modo_paginacion) begin   // en modo normal de paginación, o en modo boot, hacemos lo mismo, que es
            addr_port2 = {2'b00,`PAGE5,a[13:0]};      // paginar el banco 5 de RAM aquí
         end
         else begin   // en el modo especial de paginación del +3...
            case (configuracion_mapa_plus3)
               2'b00 : addr_port2 = {2'b00,`PAGE1,a[13:0]};
               2'b01,
               2'b10 : addr_port2 = {2'b00,`PAGE5,a[13:0]};
               2'b11 : addr_port2 = {2'b00,`PAGE7,a[13:0]};
            endcase
         end
      end
      
      else if (!mreq_n && a[15:14]==2'b10) begin   // la CPU quiere acceder al espacio de RAM de $8000-$BFFF
         if (enable_boot || !modo_paginacion) begin
            addr_port2 = {2'b00,`PAGE2,a[13:0]};
         end
         else begin   // en el modo especial de paginación del +3...
            case (configuracion_mapa_plus3)
               2'b00 : addr_port2 = {2'b00,`PAGE2,a[13:0]};
               2'b01,
               2'b10,
               2'b11 : addr_port2 = {2'b00,`PAGE6,a[13:0]};
            endcase
         end
      end

      else if (!mreq_n && a[15:14]==2'b11) begin   // la CPU quiere acceder al espacio de RAM de $C000-$FFFF
         if (enable_boot) begin  // en el modo de boot, este area contiene una página de 16K de la SRAM, la que sea
            addr_port2 = {mastermapper,a[13:0]};
         end
         else begin
            if (!modo_paginacion) begin
               addr_port2 = {2'b00,banco_ram,a[13:0]};
            end
            else begin
               case (configuracion_mapa_plus3)
                  2'b00,
                  2'b10,
                  2'b11 : addr_port2 = {2'b00,`PAGE3,a[13:0]};
                  2'b01 : addr_port2 = {2'b00,`PAGE7,a[13:0]};
               endcase
            end
         end
      end
      
      else begin
         oe_memory_n = 1'b1;
         oe_bootrom_n = 1'b1;
      end
   end

   // Conexiones internas
   wire [7:0] bootrom_dout;
   wire [7:0] ram_dout;

   dp_memory dos_memorias (  // Controlador de memoria, que convierte a la SRAM en una memoria de doble puerto
      .clk(mclk),
      .a1({3'b001,vrampage,1'b1,vramaddr}),
      .a2(addr_port2),
      .oe1_n(1'b0),
      .oe2_n(1'b0),
      .we1_n(1'b1),
      .we2_n(we2_n),
      .din1(8'h00),
      .dout1(vramdout),
      .din2(din),
      .dout2(ram_dout),
      
      .a(sram_addr),  // Interface con la SRAM real
      .d(sram_data),
      .ce_n(),        // Estos pines ya están a GND en el esquemático
      .oe_n(),        // así que no los conecto.
      .we_n(sram_we_n)
      );

   rom boot_rom (
      .clk(mclk),
      .a(a[13:0]),
      .dout(bootrom_dout)
    );    

   // Elección del dato a entregar a la CPU
   always @* begin
      if (!oe_bootrom_n) begin
         dout = bootrom_dout;
         oe_n = 1'b0;
      end
      else if (!oe_memory_n) begin
         dout = ram_dout;
         oe_n = 1'b0;
      end
      else if (addr==MASTERCONF && ior) begin
         dout = {6'h00,enable_divmmc,enable_boot};
         oe_n = 1'b0;
      end
      else if (addr==MASTERMAPPER && ior) begin
         dout = {3'b000,mastermapper};
         oe_n = 1'b0;
      end
      else begin
         dout = 8'hFF;
         oe_n = 1'b1;
      end
   end

endmodule
