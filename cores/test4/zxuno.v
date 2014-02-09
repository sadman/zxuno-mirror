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
    input wire clk,     // 28MHz, reloj del sistema
    input wire wssclk,  // 5MHz, reloj de la señal WSS
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n
    );

   wire [14:0] vram_addr;
   wire [7:0] vram_dout;
   wire vram_we_n;

   ula la_ula (
	 // Clocks
    .clk28(clk),       // 28MHz master clock
    .wssclk(wssclk),   // 5MHz WSS clock

	 // CPU interface
	 .a(16'h0000),
	 .mreq_n(1'b1),
	 .iorq_n(1'b1),
	 .rd_n(1'b1),
	 .wr_n(1'b1),
	 .cpuclk(),
	 .int_n(),
	 .din(8'h00),
    .dout(),

    // VRAM interface
	 .va(vram_addr),  // 16KB videoram
    .vram_we_n(vram_we_n),
    .vramdata(vram_dout),
	 
	 // ROM interface
	 .romcs_n(),

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


   dp_memory dos_memorias (  // Controlador de memoria, que convierte a la SRAM en una memoria de doble puerto
      .clk(clk),
      .a1({4'b0000,vram_addr}),
      .a2(18'h00000),
      .oe1_n(1'b0),
      .oe2_n(1'b1),
      .we1_n(vram_we_n),
      .we2_n(1'b1),
      .din1(8'h00),
      .din2(8'h00),
      .dout1(vram_dout),
      .dout2(),
      
      .a(sram_addr),  // Interface con la SRAM real
      .d(sram_data),
      .ce_n(),        // Estos pines ya están a GND en el esquemático
      .oe_n(),        // así que no los conecto.
      .we_n(sram_we_n)
      );

endmodule
