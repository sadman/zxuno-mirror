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
	input  wire[12:0] vmmAddr
);

wire[7:0] romData;
wire[7:0] ramData;

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
ram Uram
(
	.clock1(clock   ),
	.wr1   (wr      ),
	.di1   (di      ),
	.do1   (ramData ),
	.a1    (a[13:0] ),
	.clock2(vmmClock),
	.wr2   (1'b1    ),
	.di2   (8'h00   ),
	.do2   (vmmData ),
	.a2    ({ 1'b0, vmmAddr })
);

assign do = a[15:14] == 2'b00 ? romData : ramData;

endmodule
