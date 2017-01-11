//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module vmm
(
	input  wire       clock1,
	input  wire       wr,
	input  wire[ 7:0] di,
	input  wire[13:0] a1,
	input  wire       clock2,
	output reg [ 7:0] do,
	input  wire[13:0] a2
);

reg[7:0] d[16383:0];

always @ (posedge clock1) if(!wr) d[a1] <= di;
always @ (posedge clock2) do <= d[a2];

endmodule
