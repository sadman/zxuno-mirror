//-------------------------------------------------------------------------------------------------
//
//-------------------------------------------------------------------------------------------------

module ula
(
	input  wire       clock,
	input  wire       iorq,
	output reg        int,
	input  wire       wr,
	input  wire[ 7:0] di,
	input  wire       a0,
	input  wire       vmmClock,
	input  wire[ 7:0] vmmData,
	output wire[12:0] vmmAddr,
	output wire[ 1:0] sync,
	output wire[ 8:0] rgb
);

always @ (posedge clock) if(!iorq && !wr && !a0) border = di[2:0];

reg[2:0] border;

reg[8:0] hCount;
reg[8:0] vCount;
reg[4:0] fCount;

reg[7:0] dataInp;
reg[7:0] dataOut;

reg[7:0] attrInp;
reg[7:0] attrOut;

reg videoEnable;

wire dataInpLoad = (hCount[3:0] ==  9 || hCount[3:0] == 13) && videoEnable;
wire attrInpLoad = (hCount[3:0] == 11 || hCount[3:0] == 15) && videoEnable;

wire dataOutLoad = hCount[2:0] == 4 && videoEnable;
wire attrOutLoad = hCount[2:0] == 4;

wire dataSelect = dataOut[7] ^ (fCount[4] & attrOut[7]);
wire[7:3] attrMux = videoEnable ? attrInp[7:3] : { 2'b00, border };

wire dataEnable = hCount < 256 && vCount < 192;
wire videoBlank = (hCount >= 320 && hCount <= 415) || (vCount >= 248 && vCount <= 255);

wire v = hCount >= 344 && hCount <= 375;
wire h = vCount >= 248 && vCount <= 251;
wire r = videoBlank ? 1'b0 : dataSelect ? attrOut[1] : attrOut[4];
wire g = videoBlank ? 1'b0 : dataSelect ? attrOut[2] : attrOut[5];
wire b = videoBlank ? 1'b0 : dataSelect ? attrOut[0] : attrOut[3];
wire i = videoBlank ? 1'b0 : attrOut[6];

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
	if(attrOutLoad) attrOut = { attrMux, attrInp[2:0] };

	if(hCount[3]) videoEnable = dataEnable;

	if(vCount == 248 && hCount >= 2 && hCount <= 65) int = 1'b0; else int = 1'b1;
end

assign vmmAddr[ 7:0] = { vCount[5:3], hCount[7:4], hCount[2] };
assign vmmAddr[12:8] = hCount[1] ? { 3'b110, vCount[7:6] } : { vCount[7:6], vCount[2:0] };

assign sync = { 1'b1, ~(v|h) };
assign rgb  = i ? { r,r,r, g,g,g, b,b,b } : { r,1'b0,r, g,1'b0,g, b,1'b0,b };

endmodule
