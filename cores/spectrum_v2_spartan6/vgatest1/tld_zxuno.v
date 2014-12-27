`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    13:16:23 05/29/2014
// Design Name:
// Module Name:    tld_basys
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
    input wire clk50,
    output wire [2:0] r,
    output wire [2:0] g,
    output wire [2:0] b,
    output wire hs,
    output wire vs,

    input wire ps2clk,
    input wire ps2data,

    output wire led,
    output wire audio_out_left,
    output wire audio_out_right
    );

	 wire [7:0] r8b,g8b,b8b;
	 assign r = r8b[7:5];
	 assign g = g8b[7:5];
	 assign b = b8b[7:5];

     wire clk_kbd;  // 5Mhz
     wire clk50buffered;
	 relojes reloj_kbd (
		.CLKIN_IN(clk50),
		.CLKFX_OUT(clk_kbd),
		.CLKIN_IBUFG_OUT(),
		.CLK0_OUT(clk50buffered)
    );

	 wire clkvideo;
     reg start_pll_config = 1'b0;
     reg [2:0] pll_config_scheme;

    pll_top reloj28
    (
      // SSTEP is the input to start a reconfiguration.  It should only be
      // pulsed for one clock cycle.
      .SSTEP(start_pll_config),

      // STATE determines which state the PLL_ADV will be reconfigured to.  A
      .STATE(pll_config_scheme),

      // RST will reset the entire reference design including the PLL_ADV
      .RST(1'b0),

      // CLKIN is the input clock that feeds the PLL_ADV CLKIN as well as the
      // clock for the PLL_DRP module
      .CLKIN(clk50buffered),

      // SRDY pulses for one clock cycle after the PLL_ADV is locked and the 
      // PLL_DRP module is ready to start another re-configuration
      .SRDY(),
      
      // These are the clock outputs from the PLL_ADV.
      .CLK0OUT(clkvideo),
      .CLK1OUT(),
      .CLK2OUT(),
      .CLK3OUT(),
      .CLK4OUT(),
      .CLK5OUT()
   );

	 gradiente circuito (
		.clk(clkvideo),
		.r(r8b),
		.g(g8b),
		.b(b8b),
		.hs(hs),
		.vs(vs)
		);

     reg rled = 1'b0;
     assign led = rled;
     wire toogle_led;
     always @(posedge clkvideo) begin
        if (toogle_led && !soltada)
            rled <= 1'b1;
        else if (toogle_led && soltada)
            rled <= 1'b0;
     end
     
     wire [7:0] tecla;
     wire soltada;
     wire extendida;
     ps2_port teclado (
        .clk(clk_kbd),
        .enable_rcv(1'b1),
        .ps2clk_ext(ps2clk),
        .ps2data_ext(ps2data),
        .kb_interrupt(toogle_led),
        .scancode(tecla),
        .released(soltada),
        .extended(extendida)
        );

    `define TECLA_1 8'h16
    `define TECLA_2 8'h1e
    `define TECLA_3 8'h26
    `define TECLA_4 8'h25
    `define TECLA_5 8'h2e
    `define TECLA_6 8'h36
    `define TECLA_7 8'h3d
    `define TECLA_8 8'h3e
    reg [3:0] rom_acciones[0:255];
    integer i;
    initial begin
        for (i=0;i<256;i=i+1) begin
            rom_acciones[i] = 4'b0000;
        end
        rom_acciones[`TECLA_1] = 4'b1000;
        rom_acciones[`TECLA_2] = 4'b1001;
        rom_acciones[`TECLA_3] = 4'b1010;
        rom_acciones[`TECLA_4] = 4'b1011;
        rom_acciones[`TECLA_5] = 4'b1100;
        rom_acciones[`TECLA_6] = 4'b1101;
        rom_acciones[`TECLA_7] = 4'b1110;
        rom_acciones[`TECLA_8] = 4'b1111;
    end    
    always @(posedge clk_kbd) begin
        if (toogle_led && !soltada && !extendida) begin
            start_pll_config <= rom_acciones[tecla][3];
            pll_config_scheme <= rom_acciones[tecla][2:0];
        end
        else begin
            start_pll_config <= 1'b0;
        end
    end

    reg [15:0] audiocnt = 16'h0000;
    assign audio_out_left = audiocnt[15];
    assign audio_out_right = audiocnt[15];
    always @(posedge clkvideo)
        audiocnt <= audiocnt + 1;

endmodule

module relojes(CLKIN_IN,
               CLKDV_OUT,
               CLKFX_OUT,
               CLKIN_IBUFG_OUT,
               CLK0_OUT,
               LOCKED_OUT);

    input CLKIN_IN;
   output CLKDV_OUT;
   output CLKFX_OUT;
   output CLKIN_IBUFG_OUT;
   output CLK0_OUT;
   output LOCKED_OUT;

   wire CLKDV_BUF;
   wire CLKFB_IN;
   wire CLKFX_BUF;
   wire CLKIN_IBUFG;
   wire CLK0_BUF;
   wire GND_BIT;

   assign GND_BIT = 0;
   assign CLKIN_IBUFG_OUT = CLKIN_IBUFG;
   assign CLK0_OUT = CLKFB_IN;
   BUFG  CLKDV_BUFG_INST (.I(CLKDV_BUF), 
                         .O(CLKDV_OUT));
   BUFG  CLKFX_BUFG_INST (.I(CLKFX_BUF), 
                         .O(CLKFX_OUT));
   IBUFG  CLKIN_IBUFG_INST (.I(CLKIN_IN), 
                           .O(CLKIN_IBUFG));
   BUFG  CLK0_BUFG_INST (.I(CLK0_BUF), 
                        .O(CLKFB_IN));
   DCM_SP #( .CLK_FEEDBACK("1X"), .CLKDV_DIVIDE(10.0), .CLKFX_DIVIDE(10), 
         .CLKFX_MULTIPLY(2), .CLKIN_DIVIDE_BY_2("FALSE"), 
         .CLKIN_PERIOD(20.000), .CLKOUT_PHASE_SHIFT("NONE"), 
         .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), .DFS_FREQUENCY_MODE("LOW"), 
         .DLL_FREQUENCY_MODE("LOW"), .DUTY_CYCLE_CORRECTION("TRUE"), 
         .FACTORY_JF(16'hC080), .PHASE_SHIFT(0), .STARTUP_WAIT("FALSE") ) 
         DCM_SP_INST (.CLKFB(CLKFB_IN), 
                       .CLKIN(CLKIN_IBUFG), 
                       .DSSEN(GND_BIT), 
                       .PSCLK(GND_BIT), 
                       .PSEN(GND_BIT), 
                       .PSINCDEC(GND_BIT), 
                       .RST(GND_BIT), 
                       .CLKDV(CLKDV_BUF), 
                       .CLKFX(CLKFX_BUF), 
                       .CLKFX180(), 
                       .CLK0(CLK0_BUF), 
                       .CLK2X(), 
                       .CLK2X180(), 
                       .CLK90(), 
                       .CLK180(), 
                       .CLK270(), 
                       .LOCKED(LOCKED_OUT), 
                       .PSDONE(), 
                       .STATUS());
endmodule
