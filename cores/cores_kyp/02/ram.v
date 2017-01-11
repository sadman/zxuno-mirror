//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module ram
(
	input  wire       clock1,
	input  wire       wr1,
	input  wire[ 7:0] di1,
	output reg [ 7:0] do1,
	input  wire[13:0] a1,
	//
	input  wire       clock2,
	input  wire       wr2,
	input  wire[ 7:0] di2,
	output reg [ 7:0] do2,
	input  wire[13:0] a2
);

reg[7:0] d[0:16383];

always @ (posedge clock1)
begin
	do1 <= d[a1];
	if(!wr1)
	begin
		do1   <= di1;
		d[a1] <= di1;
	end
end

always @ (posedge clock2)
begin
	do2 <= d[a2];
	if(!wr2)
	begin
		do2   <= di2;
		d[a2] <= di2;
	end
end

endmodule
