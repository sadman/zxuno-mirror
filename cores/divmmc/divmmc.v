`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: ZX Projects
// Engineer: Miguel Angel Rodriguez Jodar
// 
// Create Date:    16:41:57 09/08/2015 
// Design Name:    divmmc
// Module Name:    divmmc 
// Project Name:   DivMMC CPLD control logic
// Target Devices: XC9572XL-VQ64
// Tool versions:  ISE 14.7
// Description: 
//
// License: GNU GPLv3
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: This module has been ripped from the ZX-Uno core. Not tested on real devices!
//
//////////////////////////////////////////////////////////////////////////////////
module divmmc(
    // Interface with CPU
    input wire clk,
    input wire rst_n,
    input wire [15:0] a,
    inout wire [7:0] d,
    input wire mreq_n,
    input wire iorq_n,
    input wire rd_n,
    input wire wr_n,
    input wire m1_n,
    input wire nmi_button_n,  // Button push connects to GND
    output wire nmi_to_cpu_n, // Actual NMI signal to CPU
    // Spectrum ROM shadowing
    input wire divmmc_enable_n, // Jumper to GND to enable automatic mapping. Also allows EEPROM flash if removed
    output wire zxromcs,      // 1 to disable ZX ROM. Use with emitter follower transistor
    // DivMMC onboard memory control
    output reg eeprom_cs_n,   // OE is tied to GND
    output reg eeprom_we_n,
    output reg sram_cs_n,     // OE is tied to GND
    output reg sram_we_n,
    output reg [5:0] sram_hiaddr,  // up to 512KB of SRAM can be addressed
    // SPI interface
    output wire ss_n,
    output wire sck,
    output wire mosi,
    input wire miso    
    );

    parameter
        DIVMMC_CTRL = 8'hE3;

    wire [7:0] dout_sd_card_control;
    wire oe_n_sd_card;
    reg [7:0] dout;

    // DIVMMC control register
    reg [7:0] divmmc_ctrl = 8'h00;
    wire mapram_mode = divmmc_ctrl[6];
    wire conmem = divmmc_ctrl[7];
    wire [5:0] divmmc_sram_page = divmmc_ctrl[5:0];
    always @(posedge clk) begin
        if (!rst_n)
            divmmc_ctrl <= 8'h00;
        else if (a[7:0]==DIVMMC_CTRL && !iorq_n && !wr_n)
            divmmc_ctrl <= d;
    end

    // DIVMMC automapper
    reg divmmc_is_autopaged = 1'b0;
    reg divmmc_autopage_status_after_m1 = 1'b0;   
    always @(posedge clk) begin
        if (!rst_n) begin
            divmmc_is_autopaged <= 1'b0;
            divmmc_autopage_status_after_m1 <= 1'b0;
        end
        else begin
            if ((!divmmc_enable_n || mapram_mode) && !mreq_n && !rd_n && !m1_n &&
                                           (a==16'h0000 ||
                                            a==16'h0008 ||
                                            a==16'h0038 ||
                                            a==16'h0066 ||
                                            a==16'h04C6 ||
                                            a==16'h0562)) begin  // Deferred automapping (maps at the next CPU clock cycle)
                divmmc_autopage_status_after_m1 <= 1'b1;
            end
            else if ((!divmmc_enable_n || mapram_mode) && !mreq_n && !rd_n && !m1_n && a[15:8]==8'h3D) begin  // Non deferred automapping (Current CPU clock cycle)
                divmmc_is_autopaged <= 1'b1;
                divmmc_autopage_status_after_m1 <= 1'b1;
            end
            else if ((!divmmc_enable_n || mapram_mode) && !mreq_n && !rd_n && !m1_n && a[15:3]==13'b0001111111111) begin  // Deferred automapping deactivation
                divmmc_autopage_status_after_m1 <= 1'b0;
            end
        end
        if (m1_n == 1'b1) begin  // After M1/T2, the actual automapping happens
            divmmc_is_autopaged <= divmmc_autopage_status_after_m1;
        end
    end

    // Signal NMI only when DivMMC memory is not paged. This prevents signal bouncing
    assign nmi_to_cpu_n = (nmi_button_n == 1'b0 && divmmc_is_autopaged == 1'b0)? 1'b0 : 1'bz;
    
    // Disable ZX ROM when DivMMC is paged (use an emitter follower with base connected 
    // to "zxromcs" pin and emitter to ROMCS signal on the rear bus. Collector to +5V.
    assign zxromcs = (divmmc_is_autopaged || conmem);

    // EEPROM and SRAM control and address lines
    always @* begin
        eeprom_cs_n = 1'b1;
        sram_cs_n = 1'b1;
        sram_hiaddr = divmmc_sram_page;
        sram_we_n = 1'b1;
        eeprom_we_n = 1'b1;
        if (!mreq_n) begin
            if (divmmc_is_autopaged || conmem) begin  // DivMMC is mapped (either automatically or forced)
                if (a[15:13] == 3'b000) begin // CPU is accessing memory 0000-1FFF
                    if (conmem || !mapram_mode) begin // not MAPRAM mode
                        eeprom_cs_n = 1'b0;  // EEPROM activates
                        if (wr_n == 1'b0 && divmmc_enable_n == 1'b0)  // DivMMC automapping disabled and write bus cycle?
                            eeprom_we_n = 1'b0;                       // then enable EEPROM writting
                    end
                    else begin  // mapram mode: SRAM page 3 in region 0000-1FFF
                        sram_cs_n = 1'b0;       // SRAM activates
                        sram_hiaddr = 6'd3;  // SRAM page 3
                    end
                end
                else if (a[15:13] == 3'b001) begin  // CPU is accessing memory 2000-3FFF                    
                    sram_cs_n = 1'b0;  // this region is handled by the SRAM, so activate it
                    if (conmem || !mapram_mode || (mapram_mode && divmmc_sram_page != 6'd3)) begin
                        sram_we_n = wr_n;
                    end
                end
            end
        end
    end

    // CPU data in from the SPI interface. This allows signal "d"
    // to be either in or out (bidir)
    always @* begin
        if (oe_n_sd_card == 1'b0)
            dout = dout_sd_card_control;
        else
            dout = 8'hZZ;
    end
    
    assign d = dout;
        
    sd_card_control sd (
       .clk(clk),
       .a(a[7:0]),
       .iorq_n(iorq_n),
       .rd_n(rd_n),
       .wr_n(wr_n),
       .din(d),
       .dout(dout_sd_card_control),
       .oe_n(oe_n_sd_card),
       
       .sd_cs_n(ss_n),
       .sd_clk(sck),
       .sd_mosi(mosi),
       .sd_miso(miso)
       );

endmodule

module sd_card_control (
   input wire clk,
   input wire [7:0] a,    //
   input wire iorq_n,      // Señales de control de E/S estándar
   input wire rd_n,        // para manejar los puertos DIVMMC
   input wire wr_n,        //
   input wire [7:0] din,   // del bus de datos de salida de la CPU
   output wire [7:0] dout, // al bus de datos de entrada de la CPU
   output wire oe_n,       // el dato en dout es válido
   
   output wire sd_cs_n,    //
   output wire sd_clk,     // Interface SPI con la SD/MMC
   output wire sd_mosi,    //
   input wire sd_miso      //
   );

   wire sclk,miso,mosi;
   
   parameter
      DIVCS   = 8'hE7,     //
      DIVSPI  = 8'hEB;     // Puertos del DIVMMC

   reg sdpincs = 1'b1;
   assign sd_cs_n = sdpincs;

   assign sd_clk = sclk;
   assign sd_mosi = mosi;   
   assign miso = sd_miso;

   // Control del pin CS de la SD
   always @(posedge clk) begin
      if (!iorq_n && a==DIVCS && !wr_n) begin
         sdpincs <= din[0];
      end
   end
   
   // Control del modulo SPI
   reg enviar_dato;
   reg recibir_dato;
   always @* begin
      if (a==DIVSPI && !rd_n && !iorq_n)
         recibir_dato = 1'b1;
      else
         recibir_dato = 1'b0;
      if (a==DIVSPI && !wr_n && !iorq_n)
         enviar_dato = 1'b1;
      else
         enviar_dato = 1'b0;
   end
   
   // Instanciación del modulo SPI   
   spi mi_spi (
      .clk(clk),
      .enviar_dato(enviar_dato),
      .recibir_dato(recibir_dato),
      .din(din),
      .dout(dout),
      .oe_n(oe_n),
   
      .spi_clk(sclk),
      .spi_di(mosi),
      .spi_do(miso)
      );
    
endmodule

module spi (
   input wire clk,
   input wire enviar_dato, // a 1 para indicar que queremos enviar un dato por SPI
   input wire recibir_dato,// a 1 para indicar que queremos recibir un dato
   input wire [7:0] din,   // del bus de datos de salida de la CPU
   output reg [7:0] dout,  // al bus de datos de entrada de la CPU
   output reg oe_n,        // el dato en dout es válido
   
   output wire spi_clk,    // Interface SPI
   output wire spi_di,     //
   input wire spi_do       //
   );

   // Modulo SPI.
   reg ciclo_lectura = 1'b0;       // ciclo de lectura en curso
   reg ciclo_escritura = 1'b0;     // ciclo de escritura en curso
   reg [4:0] contador = 5'b00000;  // contador del FSM (ciclos)
   reg [7:0] data_to_spi;          // dato a enviar a la spi por DI
   reg [7:0] data_from_spi;        // dato a recibir desde la spi
   reg [7:0] data_to_cpu;          // ultimo dato recibido correctamente
   
   assign spi_clk = contador[0];   // spi_CLK es la mitad que el reloj del módulo
   assign spi_di = data_to_spi[7]; // la transmisión es del bit 7 al 0
   
   always @(posedge clk) begin
      if (enviar_dato && !ciclo_escritura) begin  // si ha sido señalizado, iniciar ciclo de escritura
         ciclo_escritura <= 1'b1;
         ciclo_lectura <= 1'b0;
         contador <= 5'b00000;
         data_to_spi <= din;
      end
      else if (recibir_dato && !ciclo_lectura) begin // si no, si mirar si hay que iniciar ciclo de lectura
         ciclo_lectura <= 1'b1;
         ciclo_escritura <= 1'b0;
         contador <= 5'b00000;
         data_to_cpu <= data_from_spi;
         data_from_spi <= 8'h00;
         data_to_spi <= 8'hFF;  // mientras leemos, MOSI debe estar a nivel alto!
      end
      
      // FSM para enviar un dato a la spi
      else if (ciclo_escritura == 1'b1) begin
         if (contador != 5'b10000) begin
            if (spi_clk==1'b1) begin
               data_to_spi <= {data_to_spi[6:0],1'b0};
               data_from_spi <= {data_from_spi[6:0],spi_do};
            end
            contador <= contador + 1;
         end
         else begin
            if (!enviar_dato)
               ciclo_escritura <= 1'b0;
         end
      end
      
      // FSM para leer un dato de la spi
      else if (ciclo_lectura == 1'b1) begin
         if (contador!=5'b10000) begin
            if (spi_clk == 1'b1)
               data_from_spi <= {data_from_spi[6:0],spi_do};
            contador <= contador + 1;
         end
         else begin
            if (!recibir_dato)
               ciclo_lectura <= 1'b0;
         end
      end
   end
   
   always @* begin
      if (recibir_dato == 1'b1) begin
         dout = data_to_cpu;
         oe_n = 1'b0;
      end
      else begin
         dout = 8'hZZ;
         oe_n = 1'b1;
      end
   end   
endmodule
