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
    input wire clk,      // 28MHz, reloj del sistema
    input wire wssclk,   //  5MHz, reloj de la se�al WSS
    input wire clk14,
    input wire clk7,
    input wire clk3d5,
    input wire power_on_reset_n,
    
    // E/S
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire csync,
    inout wire clkps2,
    inout wire dataps2,
    input wire ear,
    output wire audio_out,
    
    // SRAM
    output wire [18:0] sram_addr,
    inout wire [7:0] sram_data,
    output wire sram_we_n,

    // Flash SPI
    output wire flash_cs_n,
    output wire flash_clk,
    output wire flash_di,
    input wire flash_do,
    
    // SD/MMC
    output wire sd_cs_n,    
    output wire sd_clk,     
    output wire sd_mosi,    
    input wire sd_miso,
    
    // DB9 JOYSTICK
    input wire joyup,
    input wire joydown,
    input wire joyleft,
    input wire joyright,
    input wire joyfire,
	 
    // MOUSE
    inout wire mouseclk,
    inout wire mousedata
    );

   // Se�ales de la CPU
   wire mreq_n,iorq_n,rd_n,wr_n,int_n,m1_n,nmi_n,rfsh_n;
   wire enable_nmi_n;
   wire [15:0] cpuaddr;
   wire [7:0] cpudin;
   wire [7:0] cpudout;
   wire cpuclk;
   wire [7:0] ula_dout;

   // Se�ales acceso RAM por parte de la ULA
   wire [13:0] vram_addr;
   wire [7:0] vram_dout;

   // Se�ales acceso RAM por parte de la CPU
   wire [7:0] memory_dout;
   wire oe_n_romyram;
   
   // Se�ales de acceso del AY por parte de la CPU
   wire [7:0] ay_dout;
   wire bc1,bdir;
   wire oe_n_ay;   

   // Se�ales de acceso a registro de direcciones ZX-Uno
   wire [7:0] zxuno_addr_to_cpu;  // al bus de datos de entrada del Z80
   wire [7:0] zxuno_addr;   // direccion de registro actual
   wire regaddr_changed;    // indica que se ha escrito un nuevo valor en el registro de direcciones
   wire oe_n_zxunoaddr;     // el dato en el bus de entrada del Z80 es v�lido
   wire zxuno_regrd;     // Acceso de lectura en el puerto de datos de ZX-Uno
   wire zxuno_regwr;     // Acceso de escritura en el puerto de datos del ZX-Uno
   wire in_boot_mode;   // Vae 1 cuando el sistema est� en modo boot (ejecutando la BIOS)

   // Se�ales de acceso al m�dulo Flash SPI
   wire [7:0] spi_dout;
   wire oe_n_spi;
   
   // Fuentes de sonido
   wire mic;
   wire spk;
   wire [7:0] ay1_audio;
   wire [7:0] ay2_audio;
   
   // Interfaz de acceso al teclado
   wire [4:0] kbdcol;
   wire [7:0] kbdrow = cpuaddr[15:8];  // las filas del teclado son A8-A15 de la CPU;
   wire mrst_n,rst_n;  // los dos resets suministrados por el teclado
   wire [7:0] scancode_dout;  // scancode original desde el teclado PC
   wire oe_n_scancode;
   wire [7:0] keymap_dout;
   wire oe_n_keymap;
   wire [7:0] kbstatus_dout;
   wire oe_n_kbstatus;
   wire [4:0] user_toggles;
   
   // Interfaz joystick configurable
   wire oe_n_joystick;
   wire [4:0] kbd_joy;
   wire [7:0] joystick_dout;   
   wire [4:0] kbdcol_to_ula;
   
   // Configuraci�n ULA
   wire timming_ula;
   wire issue2_keyboard;
   wire disable_contention;
   wire access_to_screen;

   // CoreID
   wire oe_n_coreid;
   wire [7:0] coreid_dout;
   
   // Scratch register
   wire oe_n_scratch;
   wire [7:0] scratch_dout;

   // NMI events
   wire [7:0] nmievents_dout;
   wire oe_n_nmievents;
   wire nmispecial_n;
   wire page_configrom_active;
   
   // Kempston mouse
   wire [7:0] kmouse_dout;
   wire [7:0] mousedata_dout;
   wire [7:0] mousestatus_dout;
   wire oe_n_kmouse, oe_n_mousedata, oe_n_mousestatus;

   // Multiboot
   wire boot_second_core = user_toggles[1];  // KB triggered booting

   // Asignaci�n de dato para la CPU segun la decodificaci�n de todos los dispositivos
   // conectados a ella.
   assign cpudin = (oe_n_romyram==1'b0)?        memory_dout :
                   (oe_n_ay==1'b0)?             ay_dout :
                   (oe_n_joystick==1'b0)?       joystick_dout :
                   (oe_n_zxunoaddr==1'b0)?      zxuno_addr_to_cpu :
                   (oe_n_spi==1'b0)?            spi_dout :
                   (oe_n_scancode==1'b0)?       scancode_dout :
                   (oe_n_kbstatus==1'b0)?       kbstatus_dout :
                   (oe_n_coreid==1'b0)?         coreid_dout :
                   (oe_n_keymap==1'b0)?         keymap_dout :
                   (oe_n_scratch==1'b0)?        scratch_dout :
                   (oe_n_nmievents==1'b0)?      nmievents_dout :
                   (oe_n_kmouse==1'b0)?         kmouse_dout :
                   (oe_n_mousedata==1'b0)?      mousedata_dout :
                   (oe_n_mousestatus==1'b0)?    mousestatus_dout :
                                                ula_dout;

   tv80n_wrapper el_z80 (
      .m1_n(m1_n),
      .mreq_n(mreq_n),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .rfsh_n(rfsh_n),
      .halt_n(),
      .busak_n(),
      .A(cpuaddr),
      .dout(cpudout),

      .reset_n(rst_n & mrst_n & power_on_reset_n),  // cualquiera de los dos resets
      .clk(cpuclk),
      .wait_n(1'b1),
      .int_n(int_n),
      .nmi_n((nmi_n | enable_nmi_n) & nmispecial_n),
      .busrq_n(1'b1),
      .di(cpudin)
  );

   ula_radas la_ula (
	  // Clocks
     .clk14(clk14),     // 14MHz master clock
     .clk7(clk7),
     .wssclk(wssclk),   // 5MHz WSS clock
     .rst_n(mrst_n & rst_n & power_on_reset_n),

	 // CPU interface
	 .a(cpuaddr),
     .access_to_contmem(access_to_screen),
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
	 .kbd(kbdcol_to_ula),
     .issue2_keyboard(issue2_keyboard),
     .timming(timming_ula),
     .disable_contention(disable_contention),

    // Video
	 .r(r),
	 .g(g),
	 .b(b),
	 .csync(csync)
    );

   zxunoregs addr_reg_zxuno (
      .clk(clk),
      .rst_n(rst_n & mrst_n & power_on_reset_n),
      .a(cpuaddr),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .din(cpudout),
      .dout(zxuno_addr_to_cpu),
      .oe_n(oe_n_zxunoaddr),
      .addr(zxuno_addr),
      .read_from_reg(zxuno_regrd),
      .write_to_reg(zxuno_regwr),
      .regaddr_changed(regaddr_changed)
   );

   flash_and_sd cacharros_con_spi (
      .clk(clk),
      .a(cpuaddr),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .addr(zxuno_addr),
      .ior(zxuno_regrd),
      .iow(zxuno_regwr),
      .din(cpudout),
      .dout(spi_dout),
      .oe_n(oe_n_spi),
   
      .in_boot_mode(in_boot_mode),
      .flash_cs_n(flash_cs_n),
      .flash_clk(flash_clk),
      .flash_di(flash_di),
      .flash_do(flash_do),
      
      .sd_cs_n(sd_cs_n),
      .sd_clk(sd_clk),
      .sd_mosi(sd_mosi),
      .sd_miso(sd_miso)
   );

   memory bootrom_rom_y_ram (
   // Relojes y reset
      .clk(clk),        // Reloj del sistema CLK7
      .mclk(clk),        // Reloj para el modulo de memoria de doble puerto
      .mrst_n(mrst_n & power_on_reset_n),
      .rst_n(rst_n & power_on_reset_n),
   
   // Interface con la CPU
      .a(cpuaddr),
      .din(cpudout),  // proveniente del bus de datos de salida de la CPU
      .dout(memory_dout), // hacia el bus de datos de entrada de la CPU
      .oe_n(oe_n_romyram),       // el dato es valido   
      .mreq_n(mreq_n),
      .iorq_n(iorq_n),
      .rd_n(rd_n),
      .wr_n(wr_n),
      .m1_n(m1_n),        // Necesarios para implementar DIVMMC
      .rfsh_n(rfsh_n),
      .enable_nmi_n(enable_nmi_n),
      .page_configrom_active(page_configrom_active),  // Para habilitar la ROM de ayuda y configuraci�n
   
   // Interface con la ULA
      .vramaddr(vram_addr),
      .vramdout(vram_dout),
      .issue2_keyboard_enabled(issue2_keyboard),
      .timming_ula(timming_ula),
      .disable_contention(disable_contention),
      .access_to_screen(access_to_screen),
   
   // Interface para registros ZXUNO
      .addr(zxuno_addr),
      .ior(zxuno_regrd),
      .iow(zxuno_regwr),
      .in_boot_mode(in_boot_mode),
   
   // Interface con la SRAM
      .sram_addr(sram_addr),
      .sram_data(sram_data),
      .sram_we_n(sram_we_n)
   );

    ps2_keyb el_teclado (
      .clk(clk),
      .clkps2(clkps2),
      .dataps2(dataps2),
      .rows(kbdrow),
      .cols(kbdcol),
      .joy(kbd_joy), // Implementaci�n joystick kempston en teclado numerico
      .rst_out_n(rst_n),   // esto son salidas, no entradas
      .nmi_out_n(nmi_n),   // Se�ales de reset y NMI
      .mrst_out_n(mrst_n),  // generadas por pulsaciones especiales del teclado
      .user_toggles(user_toggles),  // funciones de usuario
      //----------------------------
      .zxuno_addr(zxuno_addr),
      .zxuno_regrd(zxuno_regrd),
      .zxuno_regwr(zxuno_regwr),
      .regaddr_changed(regaddr_changed),
      .din(cpudout),
      .keymap_dout(keymap_dout),
      .oe_n_keymap(oe_n_keymap),
      .scancode_dout(scancode_dout),
      .oe_n_scancode(oe_n_scancode),
      .kbstatus_dout(kbstatus_dout),
      .oe_n_kbstatus(oe_n_kbstatus)
      );

    joystick_protocols los_joysticks (
        .clk(clk),
        //-- cpu interface
        .a(cpuaddr),
        .iorq_n(iorq_n),
        .rd_n(rd_n),
        .din(cpudout),
        .dout(joystick_dout),
        .oe_n(oe_n_joystick),
        //-- interface with ZXUNO reg bank
        .zxuno_addr(zxuno_addr),
        .zxuno_regrd(zxuno_regrd),
        .zxuno_regwr(zxuno_regwr),
        //-- actual joystick and keyboard signals
        .kbdjoy_in(kbd_joy),
        .db9joy_in({joyfire, joyup, joydown, joyleft, joyright}),
        .kbdcol_in(kbdcol),
        .kbdcol_out(kbdcol_to_ula),
        .vertical_retrace_int_n(int_n) // this is used as base clock for autofire
    );

    coreid identificacion_del_core (
        .clk(clk),
        .rst_n(rst_n & mrst_n & power_on_reset_n),
        .zxuno_addr(zxuno_addr),
        .zxuno_regrd(zxuno_regrd),
        .regaddr_changed(regaddr_changed),
        .dout(coreid_dout),
        .oe_n(oe_n_coreid)
    );

    scratch_register scratch (
        .clk(clk),
        .poweron_rst_n(power_on_reset_n),
        .zxuno_addr(zxuno_addr),
        .zxuno_regrd(zxuno_regrd),
        .zxuno_regwr(zxuno_regwr),
        .din(cpudout),
        .dout(scratch_dout),
        .oe_n(oe_n_scratch)
    );

    nmievents nmi_especial_de_antonio (
        .clk(clk),
        .rst_n(rst_n & mrst_n & power_on_reset_n),
        //------------------------------
        .zxuno_addr(zxuno_addr),
        .zxuno_regrd(zxuno_regrd),
        //------------------------------
        .userevents(user_toggles),
        //------------------------------
        .a(cpuaddr),
        .m1_n(m1_n),
        .mreq_n(mreq_n),
        .rd_n(rd_n),
        .dout(nmievents_dout),
        .oe_n(oe_n_nmievents),
        .nmiout_n(nmispecial_n),
        .page_configrom_active(page_configrom_active)
    );

    ps2_mouse_kempston el_raton (
        .clk(clk),
        .rst_n(rst_n & mrst_n & power_on_reset_n),
        .clkps2(mouseclk),
        .dataps2(mousedata),
        //---------------------------------
        .a(cpuaddr),
        .iorq_n(iorq_n),
        .rd_n(rd_n),
        .kmouse_dout(kmouse_dout),
        .oe_n_kmouse(oe_n_kmouse),
        //---------------------------------
        .zxuno_addr(zxuno_addr),
        .zxuno_regrd(zxuno_regrd),
        .zxuno_regwr(zxuno_regwr),
        .din(cpudout),
        .mousedata_dout(mousedata_dout),
        .oe_n_mousedata(oe_n_mousedata),
        .mousestatus_dout(mousestatus_dout),
        .oe_n_mousestatus(oe_n_mousestatus)
    );

    multiboot el_multiboot (
        .clk(clk7),
        .clk_icap(clk7),
        .rst_n(rst_n & mrst_n & power_on_reset_n),
        .kb_boot_core(boot_second_core),
        .zxuno_addr(zxuno_addr),
        .zxuno_regwr(zxuno_regwr),
        .din(cpudout)
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

  turbosound dos_ays (
    .clk(clk),
    .clkay(clk3d5),
    .reset_n(rst_n & mrst_n & power_on_reset_n),
    .bdir(bdir),
    .bc1(bc1),
    .din(cpudout),
    .dout(ay_dout),
    .oe_n(oe_n_ay),
    .audio_out_ay1(ay1_audio),
    .audio_out_ay2(ay2_audio)
	 );
  
///////////////////////////////////
// SOUND MIXER
///////////////////////////////////
   // 8-bit mixer to generate different audio levels according to input sources
	mixer audio_mix(
		.clkdac(clk),
		.reset(1'b0),
		.mic(mic),
		.spk(spk),
        .ear(ear),
        .ay1(ay1_audio),
		.ay2(ay2_audio),
		.audio(audio_out)
	);

endmodule
