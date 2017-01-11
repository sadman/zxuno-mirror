//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module rom #
(
	parameter D    = 8,
	parameter A    = 14,
	parameter FILE = "rom8x16K.hex"
)
(
	input  wire        clock,
	output reg [D-1:0] do,
	input  wire[A-1:0] a
);

reg[D-1:0] d[(2**A)-1:0];
initial $readmemh(FILE, d, 0);
always @(posedge clock) do <= d[a];

endmodule
