//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module mem
(
	input  wire       clock,
	input  wire       wr,
	input  wire[ 7:0] di,
	output wire[ 7:0] do,
	input  wire[15:0] a,
	input  wire       vmmClock,
	output wire[ 7:0] vmmData,
	input  wire[12:0] vmmAddr,

	input  wire       romPage,
	input  wire[ 2:0] ramPage,
	input  wire       vmmPage,

	output wire       sramWr,
	inout  wire[ 7:0] sramData,
	output wire[18:0] sramAddr
);

wire[7:0] romData;

wire vmmWr = wr || a[15:13] != 3'b010;

rom #
(
	.D     (8),
	.A     (14),
	.FILE  ("brendan alford zx 033.hex")
)
Urom
(
	.clock (clock   ),
	.do    (romData ),
	.a     (a[13:0] )
);
vmm Uvmm
(
	.clock1(clock   ),
	.wr    (vmmWr   ),
	.di    (di      ),
	.a1    ({ vmmPage, a[12:0] }),
	.clock2(vmmClock),
	.do    (vmmData ),
	.a2    ({ vmmPage, vmmAddr })
);

assign do = a[15:14] == 2'b00 ? romData : sramData;

assign sramAddr
	= a[15:14] == 2'b01 ? { 2'b00,  3'b101, a[13:0] }
	: a[15:14] == 2'b10 ? { 2'b00,  3'b010, a[13:0] }
	: a[15:14] == 2'b11 ? { 2'b00, ramPage, a[13:0] }
	: { 3'b000, a };

assign sramWr   = wr;
assign sramData = !wr ? di : 8'bZ;

endmodule
