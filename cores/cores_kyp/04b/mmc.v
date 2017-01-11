//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module mmc
(
	input  wire       clock,
	output wire       wa1t,
	input  wire       iorq,
	input  wire       rd,
	input  wire       wr,
	output wire       oe,
	input  wire[ 7:0] di,
	output wire[ 7:0] do,
	input  wire[15:0] a,
	//
	output wire       mmcClock,
	output reg        mmcCs,
	output wire       mmcDi,
	input  wire       mmcDo
);

wire rx;
wire tx;

always @ (posedge clock) if(!iorq && !wr && (a[7:0] == 8'h1F || a[7:0] == 8'hE7)) mmcCs = di[0];

assign rx = !iorq && !rd && (a[7:0] == 8'h3F || a[7:0] == 8'hEB);
assign tx = !iorq && !wr && (a[7:0] == 8'h3F || a[7:0] == 8'hEB);

spi Uspi
(
	.clk          (clock   ),
	.enviar_dato  (tx      ),
	.recibir_dato (rx      ),
	.din          (di      ),
	.dout         (do      ),
	.oe_n         (oe      ),
	.wait_n       (wa1t    ),
	//
	.spi_clk      (mmcClock),
	.spi_di       (mmcDi   ),
	.spi_do       (mmcDo   )
);

 endmodule
