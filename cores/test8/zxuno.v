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
    input wire ramclk,  // 20MHz, reloj de la SRAM
    
    // Reset inicial poweron
    input wire power_on_reset,
    
    // E/S
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    input wire clkps2,
    input wire dataps2,
    input wire ear,
    output wire audio_out,
    
    // ROM y SRAM
    output wire [13:0] addr_rom_16k,
    input wire [7:0] rom_dout,
    
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n
    );

   // Señales de la CPU
   wire mreq_n,iorq_n,rd_n,wr_n,int_n;
   wire [15:0] cpuaddr;
   wire [7:0] cpudin;
   wire [7:0] cpudout;
   wire cpuclk;
   wire [7:0] ula_dout;

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
   
   // Señales de acceso del AY por parte de la CPU
   wire [7:0] ay_dout;
   wire bc1,bdir;
   wire oe_n_ay;   
   wire clkay;  // suministrado por la ULA (3.5MHz)
   wire clkdac; // suministrado por la ULA (7MHz)
   
   // Fuentes de sonido
   wire mic;
   wire spk;
   wire [7:0] ay1_audio;
   
   // Interfaz de acceso al teclado
   wire clkkbd;  // suministrado por la ULA (218kHz)
   wire [4:0] kbdcol;
   wire [7:0] kbdrow;
   wire mrst_n, rst_n;  // los dos resets suministrados por el teclado
   wire nmi_n;  // suministrado por el teclado
   
   // Interfaz kempston
   wire [4:0] kbd_joy;
   wire oe_n_kempston = !(!iorq_n && !rd_n && cpuaddr[7:0]==8'd31);
   
   assign kbdrow = cpuaddr[15:8];  // las filas del teclado son A8-A15 de la CPU

   assign cpudin = (oe_n_rom==1'b0)?      rom_dout :
                   (oe_n_ram==1'b0)?      ram_dout :
                   (oe_n_ay==1'b0)?       ay_dout :
                   (oe_n_kempston==1'b0)? {3'b000,kbd_joy} :
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

      .reset_n(rst_n & mrst_n & ~power_on_reset),  // cualquiera de los resets
      .clk(cpuclk),
      .wait_n(1'b1),
      .int_n(int_n),
      .nmi_n(nmi_n),
      .busrq_n(1'b1),
      .di(cpudin)
  );

   ula la_ula (
	 // Clocks
    .clk28(clk),       // 28MHz master clock
    .wssclk(wssclk),   // 5MHz WSS clock
    .rst_n(mrst_n & rst_n & ~power_on_reset),  // este será cualquiera de los resets

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
	 .ear(ear),
    .mic(mic),
    .spk(spk),
	 .kbd(kbdcol),
    .clkay(clkay),
    .clkdac(clkdac),
    .clkkbd(clkkbd),

    // Video
	 .r(r),
	 .g(g),
	 .b(b),
	 .csync(csync),
    .y_n()
    );

    mapper mapeador (
   .clk(clk),
   .mrst_n(mrst_n & ~power_on_reset),   // reset total, para mapear la ROM interna del cargador de ROMs
   .cpurst_n(rst_n & ~power_on_reset), // reset convencional, sin cambiar mapeo de ROM
   
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

    ps2k el_teclado (
      .clk(clkkbd),
      .ps2clk(clkps2),
      .ps2data(dataps2),
      .rows(kbdrow),
      .cols(kbdcol),
      .joy(kbd_joy),
      .rst(rst_n),
      .nmi(nmi_n),
      .mrst(mrst_n)
      );

///////////////////////////////////
// AY-3-8912 SOUND
///////////////////////////////////
  // BDIR BC2 BC1 MODE
  //   0   1   0  inactive
  //   0   1   1  read
  //   1   1   0  write
  //   1   1   1  address

  assign bdir = (cpuaddr[15] && cpuaddr[1:0]==2'b01 && !iorq_n && !wr_n)? 1'b1 : 1'b0;
  assign bc1 = (cpuaddr[15] && cpuaddr[1:0]==2'b01 && cpuaddr[14] && !iorq_n)? 1'b1 : 1'b0;                                                              
  
  YM2149 ay1 (
  .I_DA(cpudout),
  .O_DA(ay_dout),
  .O_DA_OE_L(oe_n_ay),
  .I_A9_L(1'b0),
  .I_A8(1'b1),
  .I_BDIR(bdir),
  .I_BC2(1'b1),
  .I_BC1(bc1),
  .I_SEL_L(1'b0),
  .O_AUDIO(ay1_audio),
  .I_IOA(8'h00),
  .O_IOA(),
  .O_IOA_OE_L(),
  .I_IOB(8'h00),
  .O_IOB(),
  .O_IOB_OE_L(),
  .ENA(1'b1),
  .RESET_L(rst_n & mrst_n & ~power_on_reset),  // cualquiera de los dos resets
  .CLK(clkay)
  );

///////////////////////////////////
// SOUND MIXER
///////////////////////////////////
   // 8-bit mixer to generate different audio levels according to input sources
	mixer audio_mix(
		.clkdac(clkdac),
		.reset(power_on_reset),
		.mic(mic),
		.spk(spk),
      .ear(ear),
      .ay1(ay1_audio),
		.audio(audio_out)
	);

endmodule
