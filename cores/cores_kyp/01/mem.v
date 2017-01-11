//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module mem
(
	input  wire       clock,
	output wire[ 7:0] d,
	input  wire[12:0] a
);

rom #
(
	.D(8),
	.A(13),
	.FILE("fairlight.hex ") // fairlight.hex // abu simbel 01.hex
)
Urom
(
	.clock(clock),
	.do   (d    ),
	.a    (a    )
);

endmodule
