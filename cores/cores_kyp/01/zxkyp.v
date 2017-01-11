//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module zxkyp
(
	input  wire      clock50,
	output wire[1:0] stdn,
	output wire[1:0] sync,
	output wire[8:0] rgb
);

wire[ 7:0] d;
wire[12:0] a;

clock Uclock
(
	.clock50(clock50),
	.clock70(clock70)
);
ula Uula
(
	.clock  (clock70),
	.sync   (sync   ),
	.rgb    (rgb    ),
	.d      (d      ),
	.a      (a      )
);
mem Umem
(
	.clock  (clock70),
	.d      (d      ),
	.a      (a      )
);

assign stdn = 2'b01;

endmodule
