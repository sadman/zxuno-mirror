//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module zxkyp
(
	input  wire       clock50,
	//
	output wire[ 1:0] stdn,
	output wire[ 1:0] sync,
	output wire[ 8:0] rgb,
	//
	input  wire       ear,
	output wire[ 1:0] audio,
	//
	inout  wire[ 1:0] ps2,
	//
	output wire       sramWr,
	inout  wire[ 7:0] sramData,
	output wire[18:0] sramAddr
);

wire[ 7:0] cpuData;
wire[ 7:0] ulaData;
wire[ 7:0] memData;
wire[ 7:0] vmmData;
wire[12:0] vmmAddr;
reg [ 7:0] di;
wire[15:0] a;

reg [5:0] io7FFD;
wire[2:0] ramPage = io7FFD[2:0];
wire      vmmPage = io7FFD[3];
wire      romPage = io7FFD[4];

clock Uclock
(
	.clock50 (clock50 ),
	.clock70 (clock70 )
);
multiboot Umultiboot
(
    .clock   (clock70 ),
    .reset   (boot    )
);
t80w Ucpu
(
	.clock   (cpuClock),
	.reset   (reset   ),
	.busak   (        ),
	.busrq   (1'b1    ),
	.wa1t    (1'b1    ),
	.halt    (        ),
	.rfsh    (        ),
	.mreq    (mreq    ),
	.iorq    (iorq    ),
	.nmi     (nmi     ),
	.int     (int     ),
	.wr      (wr      ),
	.rd      (rd      ),
	.m1      (        ),
	.do      (cpuData ),
	.di      (di      ),
	.a       (a       )
);
ula Uula
(
	.cpuClock(cpuClock),
	.reset   (reset   ),
	.boot    (boot    ),
	.mreq    (mreq    ),
	.iorq    (iorq    ),
	.nmi     (nmi     ), 
	.int     (int     ),
	.wr      (wr      ),
	.rd      (rd      ),
	.di      (cpuData ),
	.do      (ulaData ),
	.a       (a       ),
	.ear     (ear     ),
	.mic     (mic     ),
	.speaker (speaker ),
	.ps2     (ps2     ), 
	.ramPage0(ramPage[0]),
	.vmmClock(clock70 ),
	.vmmData (vmmData ),
	.vmmAddr (vmmAddr ),
	.sync    (sync    ),
	.rgb     (rgb     )
);
mem Umem
(
	.clock   (cpuClock),
	.wr      (mreq|wr ),
	.do      (memData ),
	.di      (cpuData ),
	.a       (a       ),
	.vmmClock(clock70 ),
	.vmmData (vmmData ),
	.vmmAddr (vmmAddr ),
	.romPage (romPage ),
	.ramPage (ramPage ),
	.vmmPage (vmmPage ),
	.sramWr  (sramWr  ),
	.sramData(sramData),
	.sramAddr(sramAddr)
);
mixer Umixer
(
	.clock   (clock70 ),
	.reset   (reset   ),
	.speaker (speaker ),
	.ear     (ear     ),
	.mic     (mic     ),
	.l       (audio[0]),
	.r       (audio[1])
);

always @ (posedge cpuClock)
	if(!reset) io7FFD = 5'd0;
	else if(!iorq && !wr && !a[15] && !a[1] && !io7FFD[5]) io7FFD = cpuData[5:0];

always @ * di
	= !mreq ? memData
	: ulaData;

assign stdn = 2'b01;

endmodule
