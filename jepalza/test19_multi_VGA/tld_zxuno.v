`timescale 1ns / 1ns
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:28:18 02/06/2014 
// Design Name: 
// Module Name:    test1 
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

module tld_zxuno (
   input wire clk50mhz,

   output wire [2:0] r,
   output wire [2:0] g,
   output wire [2:0] b,
   output wire hsync, // modo VGA (jepalza)
	output wire vsync,
	
   input wire ear,
   inout wire clkps2,
   inout wire dataps2,
   inout wire mouseclk,
   inout wire mousedata,
   output wire audio_out_left,
   output wire audio_out_right,
   output wire stdn,
   output wire stdnb,
   
   output wire [18:0] sram_addr,
   inout wire [7:0] sram_data,
   output wire sram_we_n,
   
   output wire flash_cs_n,
   output wire flash_clk,
   output wire flash_mosi,
   input wire flash_miso,
   
   output wire sd_cs_n,    
   output wire sd_clk,     
   output wire sd_mosi,    
   input wire sd_miso,
   output wire testled,   // nos servirá como testigo de uso de la SPI
   
   input wire joyup,
   input wire joydown,
   input wire joyleft,
   input wire joyright,
   input wire joyfire
   );

   wire wssclk,sysclk,clk14,clk7,clk3d5;
//   relojes los_relojes_del_sistema (
//    .CLKIN_IN(clk50mhz), 
//    .CLKDV_OUT(wssclk), //  5MHz
//    .CLKFX_OUT(sysclk), // 28MHz 
//    .CLKIN_IBUFG_OUT(), 
//    .CLK0_OUT(), 
//    .LOCKED_OUT()
//    );

	assign wssclk = 1'b0;  // de momento, sin WSS
	assign stdn = 1'b0;  // fijar norma PAL
	assign stdnb = 1'b1; // y conectamos reloj PAL

//   pll reloj_maestro
//   (// Clock in ports
//    .CLK_IN1            (clk50mhz),      // IN
//    // Clock out ports
//    .CLK_OUT1           (sysclk),     // OUT
//    // Dynamic reconfiguration ports
//    .PROGCLK            (1'b0),      // IN
//    .PROGDATA           (1'b0),     // IN
//    .PROGEN             (1'b0),       // IN
//    .PROGDONE           ());    // OUT
//
//   reg [2:0] divclk = 3'b000;
//   always @(posedge sysclk)
//        divclk <= divclk + 1;
//   assign clk14  = divclk[0];
//   assign clk7   = divclk[1];
//   assign clk3d5 = divclk[2];

  cuatro_relojes relojes_maestros
   (// Clock in ports
    .CLK_IN1            (clk50mhz),      // IN
    // Clock out ports
    .CLK_OUT1           (sysclk) ,     // OUT
    .CLK_OUT2           (clk14),     // OUT
    .CLK_OUT3           (clk7),    // OUT
    .CLK_OUT4           (clk3d5));    // OUT


	// ---------------------------------------------------------------
	//	rutina conversora de formato ULA a VGA
	//	cogida del repositorio de la placa de desarrollo PIPISTRELLO
	//	con algún cambio menor por jepalza
	//-----------------------------------------------------------------
	//-- video scan converter required to display video on VGA hardware
	//-----------------------------------------------------------------
	//-- active resolution 192x256
	//-- take note: the values below are relative to the CLK period not standard VGA clock period
	VGA_SCANCONV inst_scan_conv
	(
      .I_VIDEO             ( {5'b0,s_red,1'b0,s_grn,1'b0,s_blu} ),
		.I_HSYNC					( hs_int),
		.I_VSYNC					( vs_int),
		//
      .O_VIDEO             ( O_VIDEO ),
		.O_HSYNC					( hsync ),
		.O_VSYNC					( vsync ),
		.O_CMPBLK_N				( ),
		//
		.CLK						( clk7 ),
		.CLK_x2					( clk14 )
	);
	// señales requeridas por VGACONV
	wire hs_int;
	wire vs_int;
	wire [2:0]s_red;
	wire [2:0]s_grn;
	wire [2:0]s_blu;
	wire [15:0]O_VIDEO;
	assign r = O_VIDEO[10:8];
	assign g = O_VIDEO[ 6:4];
	assign b = O_VIDEO[ 2:0];
	// -----------------------------------




   wire audio_out;
   assign audio_out_left = audio_out;
   assign audio_out_right = audio_out;
   
   zxuno la_maquina (
    .clk(sysclk),         // 28MHz, reloj base para la memoria de doble puerto, y de ahí, para el resto del circuito
    .wssclk(wssclk),      //  5MHz, reloj para el WSS
    .clk14(clk14),
    .clk7(clk7),
    .clk3d5(clk3d5),
    .power_on_reset_n(1'b1),  // sólo para simulación. Para implementacion, dejar a 1
    .r(s_red),
    .g(s_grn),
    .b(s_blu),
    .hsync(hs_int), // modo VGA (jepalza)
	 .vsync(vs_int),
	 
    .clkps2(clkps2),
    .dataps2(dataps2),
    .ear(~ear),  // negada porque el hardware tiene un transistor inversor
    .audio_out(audio_out),

    .sram_addr(sram_addr),
    .sram_data(sram_data),
    .sram_we_n(sram_we_n),
    
    .flash_cs_n(flash_cs_n),
    .flash_clk(flash_clk),
    .flash_di(flash_mosi),
    .flash_do(flash_miso),
    
    .sd_cs_n(sd_cs_n),
    .sd_clk(sd_clk),
    .sd_mosi(sd_mosi),
    .sd_miso(sd_miso),
    
    .joyup(joyup),
    .joydown(joydown),
    .joyleft(joyleft),
    .joyright(joyright),
    .joyfire(joyfire),
	 
	 .user_toggles(user_toggles), //Q
    
    .mouseclk(mouseclk),
    .mousedata(mousedata)
    );
       
    assign testled = (!flash_cs_n || !sd_cs_n);
//    reg [21:0] monoestable = 22'hFFFFFF;
//    always @(posedge sysclk) begin
//        if (!flash_cs_n || !sd_cs_n)
//            monoestable <= 0;
//        else if (monoestable[21] == 1'b0)
//            monoestable <= monoestable + 1;
//    end
//    assign testled = ~monoestable[21];


//Multiboot
wire [4:0] user_toggles;
wire REBOOT;

wire    [15:0] icap_dout;
reg     [4:0] q;
reg     reboot_ff;

assign REBOOT =  user_toggles[1];    //Trigger 2º core = Ctrl+F2 (keymap ES)

multiboot multiboot_inst
   (
    .CLK                    (clk14),
    .MBT_RESET              (1'b0),
    .MBT_REBOOT             (reboot_ff)
   );

always@(posedge clk14)
begin
      q[0] <= REBOOT;
      q[1] <= q[0];
      q[2] <= q[1];
      q[3] <= q[2];
      q[4] <= q[3];
      reboot_ff <= (q[4] && (!q[3]) && (!q[2]) && (!q[1]) );
end

endmodule
