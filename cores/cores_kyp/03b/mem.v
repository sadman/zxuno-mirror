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
	input  wire       divRom,
	input  wire       divRam,
	input  wire[ 3:0] divPage,
	output wire       sramWr,
	inout  wire[ 7:0] sramData,
	output wire[18:0] sramAddr
);

wire[7:0] romData;
wire[7:0] divData;

wire vmmWr = wr || a[15:13] != 3'b010;

rom #(.D(8), .A(14), .FILE("48k.hex")) Urom
(
	.clock (clock   ),
	.do    (romData ),
	.a     (a[13:0] )
);
rom #(.D(8), .A(13), .FILE("esxdos mmc 086.hex")) Udivrom
(
	.clock (clock   ),
	.do    (divData ),
	.a     (a[12:0] )
);
vmm Uvmm
(
	.clock1(clock   ),
	.wr    (vmmWr   ),
	.di    (di      ),
	.a1    (a[12:0] ),
	.clock2(vmmClock),
	.do    (vmmData ),
	.a2    (vmmAddr )
);

assign do
	= divRom ? divData
	: divRam ? sramData
	: a[15:14] == 2'b00 ? romData
	: sramData;

assign sramAddr
	= divRam ? { 2'b01, a[13] ? divPage : 4'h3, a[12:0] }
	: { 3'b000, a };

assign sramWr   = wr || (divRam && !a[13]);
assign sramData = !wr ? di : 8'bZ;

endmodule
