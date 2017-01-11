//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module ram
(
	input  wire       wr,
	input  wire[ 7:0] di,
	output wire[ 7:0] do,
	input  wire[18:0] a,
	//
	output wire       sramWr,
	inout  wire[ 7:0] sramData,
	output wire[18:0] sramAddr
);

assign sramWr   = wr;
assign sramData = !wr ? di : 8'bZ;
assign sramAddr = a;

assign do = sramData;

endmodule
