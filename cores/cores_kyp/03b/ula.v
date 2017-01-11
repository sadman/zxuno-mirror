//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module ula
(
	output wire       cpuClock,
	output wire       reset,
	output wire       boot,
	input  wire       mreq,
	input  wire       iorq,
	output wire       nmi,
	output reg        int,
	input  wire       wr,
	input  wire       rd,
	input  wire[ 7:0] di,
	output wire[ 7:0] do,
	input  wire[15:0] a,
	//
	input  wire       ear,
	output reg        mic,
	output reg        speaker,
	inout  wire[ 1:0] ps2,
	//
	input  wire       vmmClock,
	input  wire[ 7:0] vmmData,
	output wire[12:0] vmmAddr,
	output wire[ 1:0] sync,
	output wire[ 8:0] rgb
);

reg  cancelContention = 1'b1;
wire causeContention;
wire mayContend;
wire iorequla;
wire cpuEnable;

wire      received;
wire[7:0] scancode;
wire[4:0] keys;

reg[2:0] border;

reg[8:0] hCount = 9'b0;
reg[8:0] vCount = 9'b0;
reg[4:0] fCount = 5'b0;

reg[7:0] dataInp;
reg[7:0] dataOut;

reg[7:0] attrInp;
reg[7:0] attrOut;
reg  videoEnable;

wire dataInpLoad;
wire attrInpLoad;

wire dataOutLoad;
wire attrOutLoad;

wire dataSelect;
wire[7:0] attrMux;

wire dataEnable;
wire videoBlank;

wire v;
wire h;
wire r;
wire g;
wire b;
wire i;

ps2 Ups2
(
	.clockPs2 (vmmClock), // 7 MHz
	.clock    (ps2[0]  ),
	.data     (ps2[1]  ),
	.received (received),
	.scancode (scancode)
);
keyboard Ukeyboard
(
	.received (received),
	.scancode (scancode),
	.boot     (boot    ),
	.reset    (reset   ),
	.nmi      (nmi     ),
	.cols     (keys    ),
	.rows     (a[15:8] )
);
BUFGCE_1 Ubufgce1
(
	.I        (hCount[0]),
	.O        (cpuClock ),
	.CE       (cpuEnable)
);

assign iorqula = iorq|a[0];
assign mayContend = !(hCount[3:0] > 4'd3 && dataEnable);
assign causeContention = !(a[15:14] == 2'b01 || !iorqula);
always @ (posedge cpuClock) cancelContention = !mreq || !iorqula;
assign cpuEnable = mayContend|causeContention|cancelContention;

always @ (posedge cpuClock)
	if(!iorq && !wr && !a[0])
	begin
		border  = di[2:0];
		mic     = di[3];
		speaker = di[4];
	end

assign do
	= !iorq && !rd && !a[0] ? { 1'b1, !ear, 1'b1, keys }
	: !iorq && !rd && (dataInpLoad || attrInpLoad) ? vmmData
	: 8'hFF;

always @ (posedge vmmClock)
begin
	if(hCount < 447)
		hCount = hCount+9'b1; 
	else
	begin
		hCount = 9'b0;

		if(vCount < 311)
			vCount = vCount+9'b1;
		else
		begin
			vCount = 9'b0;
			fCount = fCount+5'b1;
		end
	end

	if(dataInpLoad) dataInp = vmmData;
	if(attrInpLoad) attrInp = vmmData;

	if(dataOutLoad) dataOut = dataInp; else dataOut = { dataOut[6:0], 1'b0 };
	if(attrOutLoad) attrOut = attrMux;

	if(hCount[3]) videoEnable = dataEnable;

	if(vCount == 248 && hCount >= 2 && hCount <= 65) int = 1'b0; else int = 1'b1;
end

assign dataInpLoad = (hCount[3:0] ==  9 || hCount[3:0] == 13) && videoEnable;
assign attrInpLoad = (hCount[3:0] == 11 || hCount[3:0] == 15) && videoEnable;

assign dataOutLoad = hCount[2:0] == 4 && videoEnable;
assign attrOutLoad = hCount[2:0] == 4;

assign dataSelect =  dataOut[7] ^ (fCount[4] & attrOut[7]);
assign attrMux = videoEnable ? attrInp : { 2'b00, border, 3'b000 };

assign dataEnable = hCount < 256 && vCount < 192;
assign videoBlank = (hCount >= 320 && hCount <= 415) || (vCount >= 248 && vCount <= 255);

assign vmmAddr[ 7:0] = { vCount[5:3], hCount[7:4], hCount[2] };
assign vmmAddr[12:8] = hCount[1] ? { 3'b110, vCount[7:6] } : { vCount[7:6], vCount[2:0] };

assign v = !(hCount >= 344 && hCount <= 375);
assign h = !(vCount >= 248 && vCount <= 251);
assign r = videoBlank ? 1'b0 : dataSelect ? attrOut[1] : attrOut[4];
assign g = videoBlank ? 1'b0 : dataSelect ? attrOut[2] : attrOut[5];
assign b = videoBlank ? 1'b0 : dataSelect ? attrOut[0] : attrOut[3];
assign i = videoBlank ? 1'b0 : attrOut[6];

assign sync = { 1'b1, v&h };
assign rgb  = i ? { r,r,r, g,g,g, b,b,b } : { r,1'b0,r, g,1'b0,g, b,1'b0,b };

endmodule
