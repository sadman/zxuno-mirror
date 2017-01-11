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

wire[ 7:0] cpuData;
wire[ 7:0] memData;
wire[ 7:0] vmmData;
wire[12:0] vmmAddr;
reg [ 7:0] di;
wire[15:0] a;

wire memWr = mreq|wr;

clock Uclock
(
	.clock50 (clock50),
	.clock70 (clock70),
	.clock35 (clock35)
);
t80w Ucpu
(
	.clock   (clock35),
	.reset   (reset  ),
	.busak   (       ),
	.busrq   (1'b1   ),
	.wa1t    (1'b1   ),
	.halt    (       ),
	.rfsh    (       ),
	.mreq    (mreq   ),
	.iorq    (iorq   ),
	.nmi     (1'b1   ),
	.int     (int    ),
	.wr      (wr     ),
	.rd      (       ),
	.m1      (       ),
	.do      (cpuData),
	.di      (di     ),
	.a       (a      )
);
ula Uula
(
	.clock   (clock35),
	.iorq    (iorq   ),
	.int     (int    ),
	.wr      (wr     ),
	.di      (cpuData),
	.a0      (a[0]   ),
	.vmmClock(clock70),
	.vmmData (vmmData),
	.vmmAddr (vmmAddr),
	.sync    (sync   ),
	.rgb     (rgb    )
);
mem Umem
(
	.clock   (clock35),
	.wr      (memWr  ),
	.do      (memData),
	.di      (cpuData),
	.a       (a      ),
	.vmmClock(clock70),
	.vmmData (vmmData),
	.vmmAddr (vmmAddr)
);

reg[31:0] sr = 0;
assign reset = sr[0];
always @ (posedge clock35) sr = { 1'b1, sr[31:1] };

always @ * di
	= !mreq ? memData
	: 8'hFF;

assign stdn = 2'b01;

endmodule
