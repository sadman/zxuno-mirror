//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module t80w
(
	input        reset,
	input        clock,
	input        wa1t,
	input        int,
	input        nmi,
	input        busrq,
	output       m1,
	output       mreq,
	output       iorq,
	output       rd,
	output       wr,
	output       rfsh,
	output       halt,
	output       busak,
	input [ 7:0] di,
	output[ 7:0] do,
	output[15:0] a
 );

wire [7:0] d;

T80a cpu
(
	.RESET_n (reset),
	.CLK_n   (clock),
	.WAIT_n  (wa1t ),
	.INT_n   (int  ),
	.NMI_n   (nmi  ),
	.BUSRQ_n (busrq),
	.M1_n    (m1   ),
	.MREQ_n  (mreq ),
	.IORQ_n  (iorq ),
	.RD_n    (rd   ),
	.WR_n    (wr   ),
	.RFSH_n  (rfsh ),
	.HALT_n  (halt ),
	.BUSAK_n (busak),
	.A       (a    ),
	.D       (d    ),

	.SavePC      (        ),
	.SaveINT     (        ),
	.RestorePC   (16'h0000),
	.RestoreINT  (8'h00   ),
	.RestorePC_n (1'b1    )
);

assign do = d;
assign d = ((!mreq || !iorq) && !rd) ? di : ((!mreq || !iorq) && !wr)? 8'hZZ : 8'hFF;

endmodule
