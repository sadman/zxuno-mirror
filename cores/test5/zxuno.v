`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:16 02/06/2014 
// Design Name: 
// Module Name:    zxuno 
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
module zxuno (
    // Relojes
    input wire clk,     // 28MHz, reloj del sistema
    input wire wssclk,  // 5MHz, reloj de la señal WSS
    input wire system_reset_n,
    
    // E/S
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    
    // ROM y SRAM
    output wire [13:0] addr_rom_16k,
    input wire [7:0] rom_dout,
    
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n
    );

   // Señales acceso RAM por parte de la ULA
   wire [13:0] vram_addr;
   wire [7:0] vram_dout;
   wire vrampage;

   // Señales acceso ROM por parte de la CPU
   wire [15:0] addr_rom;
   wire oe_n_rom;
   assign addr_rom_16k = addr_rom[13:0];

   // Señales acceso RAM por parte de la CPU
   wire [18:0] addr_ram;
   wire [7:0] ram_dout;
   wire oe_n_ram;
   wire we_n_ram;
   
   // Señales de la CPU
   wire mreq_n,iorq_n,rd_n,wr_n,int_n;
   wire [15:0] cpuaddr;
   wire [7:0] cpudin;
   wire [7:0] cpudout;
   wire cpuclk;
   wire [7:0] ula_dout;

   assign cpudin = (oe_n_rom==1'b0)? rom_dout :
                   (oe_n_ram==1'b0)? ram_dout :
                                     ula_dout;

   tv80n_wrapper el_z80 (
      .m1_n(),
      .mreq_n(mreq_n),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .rfsh_n(),
      .halt_n(),
      .busak_n(),
      .A(cpuaddr),
      .dout(cpudout),

      .reset_n(system_reset_n),
      .clk(cpuclk),
      .wait_n(1'b1),
      .int_n(int_n),
      .nmi_n(1'b1),
      .busrq_n(1'b1),
      .di(cpudin)
  );

   ula la_ula (
	 // Clocks
    .clk28(clk),       // 28MHz master clock
    .wssclk(wssclk),   // 5MHz WSS clock

	 // CPU interface
	 .a(cpuaddr),
	 .mreq_n(mreq_n),
	 .iorq_n(iorq_n),
	 .rd_n(rd_n),
	 .wr_n(wr_n),
	 .cpuclk(cpuclk),
	 .int_n(int_n),
	 .din(cpudout),
    .dout(ula_dout),

    // VRAM interface
	 .va(vram_addr),  // 16KB videoram
    .vramdata(vram_dout),
	 
    // I/O ports
	 .ear(1'b0),
    .audio_out(),
	 .kbd(5'b11111),

    // Video
	 .r(r),
	 .g(g),
	 .b(b),
	 .csync(csync),
    .y_n()
    );

    mapper mapeador (
   .clk(clk),
   .mrst_n(system_reset_n),   // reset total, para mapear la ROM interna del cargador de ROMs
   .cpurst_n(1'b1), // reset convencional, sin cambiar mapeo de ROM
   
   .a(cpuaddr),
   .mreq_n(mreq_n),
   .iorq_n(iorq_n),
   .rd_n(rd_n),
   .wr_n(wr_n),
   .din(cpudout),
   
   .vrampage(vrampage),
   .addr_rom(addr_rom),
   .oe_n_rom(oe_n_rom),
   .addr_ram(addr_ram),
   .oe_n_ram(oe_n_ram),
   .we_n_ram(we_n_ram)
   );

   dp_memory dos_memorias (  // Controlador de memoria, que convierte a la SRAM en una memoria de doble puerto
      .clk(clk),
      .a1({3'b001,vrampage,1'b1,vram_addr}),
      .a2(addr_ram),
      .oe1_n(1'b0),
      .oe2_n(oe_n_ram),
      .we1_n(1'b1),
      .we2_n(we_n_ram),
      .din1(8'h00),
      .din2(cpudout),
      .dout1(vram_dout),
      .dout2(ram_dout),
      
      .a(sram_addr),  // Interface con la SRAM real
      .d(sram_data),
      .ce_n(),        // Estos pines ya están a GND en el esquemático
      .oe_n(),        // así que no los conecto.
      .we_n(sram_we_n)
      );

endmodule
