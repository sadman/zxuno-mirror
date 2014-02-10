`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:14 10/18/2012 
// Design Name: 
// Module Name:    dummy_ula 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`define WANT_AYCHIP
`define WANT_ULAPLUS

`define PREV_HCYCLE(a) ((a+447)%448)
`define PREV_VCYCLE(a) ((a+311)%312)

`define BHPIXEL 0
`define EHPIXEL 255
`define BBORDER 256
`define EBORDER 320
`define BHBLANK 320
`define EHBLANK 416
`define BHSYNC  344
`define EHSYNC  376
`define BBORDEL 416
`define EBORDEL 447

`define BVPIXEL  0
`define EVPIXEL  191
`define BBORDED  192
`define EBORDED  247
`define BVPERIOD 248
`define EVPERIOD 255
`define BVSYNC   248
`define EVSYNC   251
`define BBORDEU  256
`define EBORDEU  311

module ula (
	 // Clocks
    input wire clk28,  // 28MHz master clock
    input wire wssclk, // 5MHz WSS clock
    input wire rst_n,  // reset para volver al modo normal

	 // CPU interface
	 input wire [15:0] a,
	 input wire mreq_n,
	 input wire iorq_n,
	 input wire rd_n,
	 input wire wr_n,
	 output wire cpuclk,
	 output wire int_n,
	 input wire [7:0] din,
    output reg [7:0] dout,

    // VRAM interface
	 output reg [13:0] va,  // 16KB videoram
    input wire [7:0] vramdata,
	 
    // I/O ports
	 input wire ear,
	 input wire [4:0] kbd,
    output reg mic,
    output reg spk,
    output wire clkay,
    output wire clkdac,

    // Video
	 output wire [2:0] r,
	 output wire [2:0] g,
	 output wire [2:0] b,
	 output wire csync,
    output wire y_n	 
    );

	 // RGB inputs to sync module
	 reg [2:0] ri;
	 reg [2:0] gi;
	 reg [2:0] bi;

    // Counters from sync module
	 wire [8:0] hc;
	 wire [8:0] vc;

    // Sequencer counter for FSM
	`define SEQ0 2
	`define SEQ1 3
	`define SEQ2 0
	`define SEQ3 1
	 reg [1:0] seq = 2'b00;
	 always @(posedge clk28)
		seq <= seq + 1;

	 wire clk7  = seq[1];
    assign clkdac = seq[1];
    assign clkay = hc[0];

	 pal_sync_generator_progressive syncs (
    .clk(clk7),
	 .wssclk(wssclk),
	 .ri(ri),
	 .gi(gi),
	 .bi(bi),
	 .hcnt(hc),
	 .vcnt(vc),
    .ro(r),
    .go(g),
    .bo(b),
    .csync(csync)
    );

///////////////////////////////////
// PALETTE RAM
///////////////////////////////////
	wire updating_palette;  // =1 if there's an I/O bus cycle affecting palette registers. Prevents border palette to be updated with AOLATCH
	wire palettewe;         // =1 to write a palette register
	wire [5:0] palette_addr; // address bus for palette RAM
	wire [7:0] paldout;     // output data bus for palette RAM
	wire [7:0] paldin;      // input data bus for palette RAM
	reg [7:0] ulaplus_register = 8'h00;
	 
	// instantiation of a 64 byte RAM 
	ram64bytes the_palette (
    .clk(clk28),
    .a(palette_addr),
    .din(paldin),
    .dout(paldout),
    .we(palettewe)
    );

	reg ulaplusenabled = 1'b0;  // bit M0 of mode register.
	reg attr8x1 = 1'b0;         // bit M1 of mode register
	reg mode256x256 = 1'b0;     // bit M2 of mode register

///////////////////////////////////
// CONTROL SIGNAL GENERATOR
///////////////////////////////////
	
	// /INT
	reg rint_n = 1;
	assign int_n = (rint_n)? 1'b1 : 1'b0;
	
	always @(posedge clk7) begin
		if (vc == `BVSYNC && hc == 0)
			rint_n <= 0;
		else if (vc == `BVSYNC && hc == 64)
			rint_n <= 1;
	end
		
	//Y_N (for SPECTRA)
   assign y_n = ((vc>=`BVSYNC && vc<=`EVSYNC) || (hc>=`BHSYNC && hc<=`EHSYNC))? 1 : 0;
		
	// /VIDEN
	reg viden_n;
	always @(*) begin
		if (vc>=`BVPIXEL && vc<=`EVPIXEL && hc>=(`BHPIXEL+8) && hc<=(`EHPIXEL+8))
			viden_n = 0;
		else
			viden_n = 1;
	end
	
	// /VIDEN_DLY (1 cycle before)
	reg viden_dly_n;
	always @(*) begin
		if (vc>=`BVPIXEL && vc<=`EVPIXEL && hc>=(`BHPIXEL+7) && hc<=(`EHPIXEL+7))
			viden_dly_n = 0;
		else
			viden_dly_n = 1;
	end

	// /AOLATCH (1 cycle before)
	reg aolatch_n;
	always @(*) begin
		if (hc[2:0]==4 && seq==`SEQ3)
			aolatch_n = 0;
		else
			aolatch_n = 1;
	end
	
	// SLOAD (1 cycle before)
	reg sload;
	always @(*) begin
		if (!viden_n && hc[2:0]==4 && seq==`SEQ3)
			sload = 1;
		else
			sload = 0;
	end
	
	// /DATALATCH
	reg datalatch_n;
	always @(*) begin
		if (!viden_n && (hc[3:0]==9 || hc[3:0]==13) && (seq==`SEQ0 /*|| seq==`SEQ1*/))
			datalatch_n = 0;
		else
			datalatch_n = 1;
	end
			
	// ATTRLATCH
	reg attrlatch_n;
	always @(*) begin
		if (!viden_n && (hc[3:0]==11 || hc[3:0]==15) && (seq==`SEQ0 /*|| seq==`SEQ1*/))
			attrlatch_n = 0;
		else
			attrlatch_n = 1;
	end
	
	// /PAPERLATCH
	reg paperlatch_n;
	always @(*) begin
		if (seq==`SEQ2/* || seq==`SEQ3*/) begin
			if (viden_n) begin
				if (hc[2:0]==4 && !updating_palette)  // border palette color is updated only when nobody else is using the palette
					paperlatch_n = 0;
				else
					paperlatch_n = 1;
			end
			else begin
				if (hc[3:0]==11 || hc[3:0]==15 )  // activated just after an attribute has been read from VRAM
					paperlatch_n = 0;
				else
					paperlatch_n = 1;
			end
		end
		else
			paperlatch_n = 1;
	end

	// /INKLATCH
	reg inklatch_n;
	always @(*) begin
		if (seq==`SEQ0 /*|| seq==`SEQ3*/) begin
			if (!viden_n && (hc[3:0]==12 || hc[3:0]==0 ))  // activated just after PAPERLATCH
				inklatch_n = 0;
			else
				inklatch_n = 1;
		end
		else
			inklatch_n = 1;
	end

	// VIDEO_READ_IN_PROGRESS (VidC3)
	reg video_read_in_progress;
	always @(*) begin
		if (!viden_dly_n && ( ((hc[3:0]==7 && seq==`SEQ3) || hc[3:0]>=8) && hc[3:0]<=15))
			video_read_in_progress = 1;
		else
			video_read_in_progress = 0;
	end

///////////////////////////////////
// VRAM VIDEO READ MANAGEMENT
///////////////////////////////////
	reg [4:0] ca = 5'b00000;
   always @(posedge clk28) begin
		if (hc[3:0]==7 || hc[3:0]==11)
			ca <= hc[7:3];
	end
	
	reg vrampage = 1'b0;  // to have two video pages (at 4000h and 6000h)
	wire [13:0] bitmapaddr = {vrampage,vc[7:6],vc[2:0],vc[5:3],ca};
	wire [13:0] attraddr = {vrampage,3'b110,vc[7:5],vc[4:3],ca};
	wire [13:0] attrtimexaddr = {1'b1,vc[7:6],vc[2:0],vc[5:3],ca};

	always @(*) begin
		if (!video_read_in_progress /*|| hc[3:0]==11 || hc[3:0]==15*/) begin //last part added to widen Z window
			va = 14'hZZZZ;
		end
		else if (hc[3:0]==8 || hc[3:0]==12) begin
			va = bitmapaddr;
		end
		else if (hc[3:0]==9 || hc[3:0]==10 || hc[3:0]==13 || hc[3:0]==14) begin
			va = (attr8x1)? attrtimexaddr : attraddr;
		end
		else begin
			va = 14'hZZZZ;
		end
	end
	
///////////////////////////////////
// STANDARD ULA PIXEL/ATTR GENERATION
///////////////////////////////////
	reg [7:0] datalatch = 8'h00;
	reg [7:0] attrlatch1 = 8'h00;
	reg [7:0] sreg = 8'h00;
	reg [7:0] attrlatch2 = 8'h00;
	reg [2:0] border = 3'd2;
	wire pixel = sreg[7];
	reg [5:0] flashcnt = 6'b000000;

	// get 8 pixels (bitmap data) from VRAM
   always @(posedge clk28) begin
		if (!datalatch_n)
			datalatch <= vramdata;
	end
	
   // get an attribute value from VRAM
	always @(posedge clk28) begin
		if (!attrlatch_n)
			attrlatch1 <= vramdata;
	end
	
   // transfer bitmap and attribute to output latches
	always @(posedge clk28) begin
		if (!aolatch_n) begin
			if (!viden_n)
				attrlatch2 <= attrlatch1;  // transfer pixel attributes or...
			else
				attrlatch2 <= {2'b00,border,border}; // ... border attributes
		end
	end
	
   // shift register to output pixels
	always @(posedge clk28) begin
		if (sload)
			sreg <= datalatch;
		else if (seq==`SEQ3)
			sreg <= {sreg[6:0],1'b0};
	end
	
   // flash flip-flop
	always @(posedge clk28) begin
		if (vc==`BVSYNC && hc==0 && seq==`SEQ0)
			flashcnt <= flashcnt + 1;
	end
	
   // generate IRGB value from pixel value, flash state and attribute value
	reg [3:0] pixelcolor;
	always @(*) begin
		if (pixel^(flashcnt[4] & attrlatch2[7]))
			pixelcolor = {attrlatch2[6],attrlatch2[2:0]};
		else
			pixelcolor = {attrlatch2[6],attrlatch2[5:3]};
	end
	
///////////////////////////////////
// ULA+ PIXEL/ATTR GENERATION
///////////////////////////////////
	reg [7:0] paperplus1 = 8'h00;
	reg [7:0] inkplus1 = 8'h00;
	reg [7:0] paperplus2 = 8'h00;
	reg [7:0] inkplus2 = 8'h00;
	reg [7:0] borderplus = 8'h00;
	reg [7:0] ulapluspixelcolor;
		
   // generate palette RAM address value based upon what we're doing with the palette RAM
	assign palette_addr = (updating_palette)? ulaplus_register[5:0] :
                         (!paperlatch_n && 
                          hc[2:0]!=4)?       {attrlatch1[7:6],1'b1,attrlatch1[5:3]} :
	                      (!inklatch_n)?      {attrlatch1[7:6],1'b0,attrlatch1[2:0]} :
								                     {3'b001,border};                    
								 
   // load interal latches from palette RAM depending upon what we're reading from it
	always @(negedge clk28) begin
		if (!paperlatch_n && hc[2:0]==4 && !updating_palette)
			borderplus <= paldout;
		else if (!paperlatch_n)
			paperplus1 <= paldout;
		else if (!inklatch_n)
			inkplus1 <= paldout;
	end
	
   // transfer ink and paper colours to output latches
	always @(posedge clk28) begin
		if (!aolatch_n) begin
			if (!viden_n) begin
				paperplus2 <= paperplus1;
				inkplus2 <= inkplus1;
			end
			else begin
				paperplus2 <= borderplus;
				inkplus2 <= borderplus;
			end
		end
	end
	
   // generate RRRGGGBB value based upon pixel value
	always @(*) begin
		if (pixel)
			ulapluspixelcolor = inkplus2;
		else
			ulapluspixelcolor = paperplus2;
	end

///////////////////////////////////
// RGB GENERATOR
///////////////////////////////////
`define none 3'b000
`define half 3'b101
`define full 3'b111

	always @(*) begin
		if (!ulaplusenabled) begin
			case (pixelcolor)  // speccy colour to RRRGGGBBB colour. If you want to alter the standard palette, this is what you need to touch ;)
				0,8: {gi,ri,bi} = {`none,`none,`none};
				1:   {gi,ri,bi} = {`none,`none,`half};
				2:   {gi,ri,bi} = {`none,`half,`none};
				3:   {gi,ri,bi} = {`none,`half,`half};
				4:   {gi,ri,bi} = {`half,`none,`none};
				5:   {gi,ri,bi} = {`half,`none,`half};
				6:   {gi,ri,bi} = {`half,`half,`none};
				7:   {gi,ri,bi} = {`half,`half,`half};
				9:   {gi,ri,bi} = {`none,`none,`full};
				10:  {gi,ri,bi} = {`none,`full,`none};
				11:  {gi,ri,bi} = {`none,`full,`full};
				12:  {gi,ri,bi} = {`full,`none,`none};
				13:  {gi,ri,bi} = {`full,`none,`full};
				14:  {gi,ri,bi} = {`full,`full,`none};
				15:  {gi,ri,bi} = {`full,`full,`full};
			endcase
		end
		else begin
			{gi,ri,bi} = {ulapluspixelcolor[7:2],ulapluspixelcolor[1:0],ulapluspixelcolor[1]};
		end
	end

///////////////////////////////////
// CPU CLOCK GENERATION (Altwasser method)
///////////////////////////////////
`define PORT_FF3B (a==16'hFF3B)
`define PORT_BF3B (a==16'hBF3B)
`define PORT_TIMEX (a[7:0]==8'hFF)
`define PORT_ATTR (a[7:0]==8'hFF)
`define PORT_ULA (a[0]==1'b0)

`define MASTERCPUCLK hc[0]
//`define MASTERCPUCLK clk7
//`define MASTERCPUCLK clk14

   reg CPUInternalClock = 0;
	reg ioreqtw3 = 0;
	reg mreqt23 = 0;
	
   wire iorequla = !iorq_n && `PORT_ULA;
`ifdef WANT_ULAPLUS
	wire iorequlaplus = !iorq_n && (`PORT_FF3B || `PORT_BF3B);
`else
   wire iorequlaplus = 1'b0;
`endif   
   
	wire ioreqall_n = !(iorequlaplus || iorequla);
	
	reg Border_n;
	always @(*) begin
		if (vc>=`BVPIXEL && vc<=`EVPIXEL && hc>=`BHPIXEL && hc<=`EHPIXEL)
			Border_n = 1;
		else
			Border_n = 0;
	end
	wire Nor1 = (~(a[14] | ~ioreqall_n)) | 
	            (~(~a[15] | ~ioreqall_n)) | 
					(~(hc[2] | hc[3])) | 
					(~Border_n | ~ioreqtw3 | CPUInternalClock | ~mreqt23);
	wire Nor2 = (~(hc[2] | hc[3])) | 
	            ~Border_n |
					CPUInternalClock |
					ioreqall_n |
					~ioreqtw3;
	wire CLKContention = ~Nor1 | ~Nor2;

	always @(posedge `MASTERCPUCLK) begin
      if (!CLKContention) begin
         ioreqtw3 <= ioreqall_n;
         mreqt23 <= mreq_n;
      end
	end

	always @(negedge clk28)
      CPUInternalClock = ~(CLKContention | `MASTERCPUCLK);

   assign cpuclk = ~CPUInternalClock;

///////////////////////////////////
// I/O PORTS
///////////////////////////////////
   // Z80 writes new values to ULA registers
	always @(posedge clk28) begin
      if (!rst_n) begin
         mode256x256 <= 1'b0;
         ulaplusenabled <= 1'b0;
         attr8x1 <= 1'b0;
      end
      else if (!ioreqtw3) begin
         if (!iorq_n && `PORT_FF3B && !wr_n) begin
            if (ulaplus_register==8'h40)
               {mode256x256,ulaplusenabled} <= din[1:0];  // ULAplus mode register
		   end
		   else if (!iorq_n && `PORT_BF3B && !wr_n)
            ulaplus_register <= din;     // ULAplus register and mode address (write only register)
         else if (!iorq_n && `PORT_TIMEX && !wr_n)
            attr8x1 <= din[1]; // Timex HiColour
		   else if (!iorq_n && `PORT_ULA && !wr_n) begin
            {spk,mic,border} <= din[4:0];  // port $FE
         end
      end
	end
	
	assign paldin = din;   // palette data bus input is permanently connected to data bus
	assign updating_palette = (!iorq_n && (`PORT_FF3B || `PORT_BF3B) && (!rd_n || !wr_n))? 1'b1: 1'b0;  // signal whether we're dealing with palette
	assign palettewe = (!iorq_n && 
                       !ioreqtw3 &&
							  `PORT_FF3B &&
							  !wr_n && 
							  ulaplus_register[7:6]==2'b00 )? 1'b1 : 1'b0;  // palette RAM WE signal is asserted only when it's required
	
   // Z80 gets values from ULA registers
	always @(*) begin
      dout = 8'hFF;  // valor por defecto
      if (!ioreqtw3) begin
         if (!iorq_n && `PORT_ULA && !rd_n)
            dout = {1'b1,ear,1'b1,kbd};  // port $FE.
         else if (!iorq_n && `PORT_FF3B && !rd_n)  // only port $FF3B is read/write
            dout = (ulaplus_register[7:6]==2'b00)? paldout :   // palette RAM data output bus if we want to read a palette entry
                    (ulaplus_register==8'h40)? {5'b00000,attr8x1,mode256x256,ulaplusenabled} :  // ULAplus mode register if we want to read entry $40
                    8'hFF;      //... or nothing
         else if (!iorq_n && `PORT_ATTR && !rd_n && !viden_n)
            dout = attrlatch1;  // port $FF reads current attribute just latched from memory
      end
	end  
endmodule
