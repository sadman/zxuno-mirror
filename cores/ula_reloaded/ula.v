`timescale 1ns / 1ps
`default_nettype none

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:55 02/16/2014 
// Design Name: 
// Module Name:    ula 
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

module ula (
	 // Clocks
    input wire clk14,  // 14MHz master clock
    input wire wssclk, // 5MHz WSS clock
    input wire rst_n,  // reset para volver al modo normal

	 // CPU interface
	 input wire [15:0] a,
	 input wire mreq_n,
	 input wire iorq_n,
	 input wire rd_n,
	 input wire wr_n,
	 output wire cpuclk,
	 output reg int_n,
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
    output wire clkkbd,

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

    reg clk7 = 1'b0;
    always @(posedge clk14)
      clk7 <= ~clk7;

    assign clkdac = clk7;
    assign clkay = hc[0];
    assign clkkbd = hc[4];
    //assign cpuclk = hc[0];  // temporal. Deber�a ser con contenci�n

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

    parameter
      BHPIXEL =  0,
      EHPIXEL =  255,
      BBORDER =  256,
      EBORDER =  320,
      BHBLANK =  320,
      EHBLANK =  416,
      BHSYNC  =  344,
      EHSYNC  =  376,
      BBORDEL =  416,
      EBORDEL =  447,
      BVPIXEL =  0,
      EVPIXEL =  191,
      BBORDED =  192,
      EBORDED =  247,
      BVPERIOD = 248,
      EVPERIOD = 255,
      BVSYNC  =  248,
      EVSYNC  =  251,
      BBORDEU =  256,
      EBORDEU =  311;    

///////////////////////////////////////////////
// ULA datapath
///////////////////////////////////////////////

    // Control signals generated from the control unit
    // or the rest of modules
    reg BitmapDataLoad;
    reg AttrDataLoad;
    reg WriteToPortFE;
    reg SerializerLoad;
    reg TimexConfigLoad;
    reg AttrOutputLoad;
    reg PaletteRegLoad;
    reg ConfigRegLoad;
    reg PaletteLoad;
    reg BitmapAddr;
    reg AttrAddr;
    reg CALoad;
    reg VideoEnable;
    
    // BitmapData register
    reg [7:0] BitmapData = 8'h00;
    always @(posedge clk7) begin
      if (BitmapDataLoad)
         BitmapData <= vramdata;
    end
    
    // AttrData register
    reg [7:0] AttrData = 8'h00;
    always @(posedge clk7) begin
      if (AttrDataLoad)
         AttrData <= vramdata;
    end
    
    // Border register
    reg [2:0] Border = 3'b010;  // initial border colour is red
    always @(posedge clk7) begin
      if (WriteToPortFE)
         Border <= din[2:0];
    end
    
    // BitmapSerializer register
    reg [7:0] BitmapSerializer = 8'h00;
    wire SerialOutput = BitmapSerializer[7];
    always @(posedge clk7) begin
      if (SerializerLoad)
         BitmapSerializer <= BitmapData;
      else
         BitmapSerializer <= {BitmapSerializer[6:0],1'b0};
    end
    
    // BitmapSerializerHR register
    reg [15:0] BitmapSerializerHR = 8'h00;
    wire SerialOutputHR = BitmapSerializerHR[15];
    always @(posedge clk14) begin
      if (SerializerLoad) 
         BitmapSerializerHR <= {BitmapData,AttrData};
      else
         BitmapSerializerHR <= {BitmapSerializerHR[14:0],1'b0};
    end
    
    // Timex config register
    reg [5:0] TimexConfigReg = 6'h00;
    wire PG  = TimexConfigReg[0];
    wire HCL = TimexConfigReg[1];
    wire HR  = TimexConfigReg[2];
    wire [2:0] HRInk = TimexConfigReg[5:3];
    always @(posedge clk7) begin
      if (rst_n == 1'b0)
         TimexConfigReg <= 6'h00;
      else if (TimexConfigLoad)
         TimexConfigReg <= din[5:0];
    end
    
    // Combinational logic between AttrData and AttrOutput
    reg [7:0] InputToAttrOutput;
    always @* begin
      InputToAttrOutput = AttrData;
      case ({VideoEnable,HR})
         2'b00 : InputToAttrOutput = {2'b00,Border,3'b000};
         2'b01,
         2'b11 : InputToAttrOutput = {2'b01,~HRInk,HRInk};
         2'b10 : InputToAttrOutput = AttrData;
      endcase
    end
    
    // AttrOutput register
    reg [7:0] AttrOutput = 8'h00;
    wire [2:0] StdPaperColour = AttrOutput[5:3];
    wire [2:0] StdInkColour = AttrOutput[2:0];
    wire Bright = AttrOutput[6];
    wire Flash = AttrOutput[7];
    always @(posedge clk7) begin
      if (AttrOutputLoad)
         AttrOutput <= InputToAttrOutput;
    end
    
    // Combinational logic to generate pixel bit
    reg Pixel;
    always @* begin
      if (HR)
         Pixel = SerialOutputHR;
      else
         Pixel = SerialOutput;
    end
    
    // Flash!
    reg [4:0] FlashCounter = 5'h00;
    wire FlashFF = FlashCounter[4];
    wire PixelWFlash = Pixel ^ (Flash & FlashFF);
    always @(posedge clk7) begin
		if (vc==BVSYNC && hc==0)
			FlashCounter <= FlashCounter + 1;
	end
   
   // Standard ULA final 4-bit IGRB colour
   reg [3:0] StdPixelColour;
   always @* begin
      if (PixelWFlash)
         StdPixelColour = {Bright,StdInkColour};
      else
         StdPixelColour = {Bright,StdPaperColour};
   end
   
   // LUT-based translatator from IGRB to 9-bit GRB
   `define none 3'b000
   `define half 3'b101
   `define full 3'b111
   reg [8:0] Std9bitColour;
	always @* begin
     Std9bitColour = {`none,`none,`none};
 	  case (StdPixelColour)  // speccy colour to GGGRRRBBB colour. If you want to alter the standard palette, this is what you need to touch ;)
				0,8: Std9bitColour = {`none,`none,`none};
				1:   Std9bitColour = {`none,`none,`half};
				2:   Std9bitColour = {`none,`half,`none};
				3:   Std9bitColour = {`none,`half,`half};
				4:   Std9bitColour = {`half,`none,`none};
				5:   Std9bitColour = {`half,`none,`half};
				6:   Std9bitColour = {`half,`half,`none};
				7:   Std9bitColour = {`half,`half,`half};
				9:   Std9bitColour = {`none,`none,`full};
				10:  Std9bitColour = {`none,`full,`none};
				11:  Std9bitColour = {`none,`full,`full};
				12:  Std9bitColour = {`full,`none,`none};
				13:  Std9bitColour = {`full,`none,`full};
				14:  Std9bitColour = {`full,`full,`none};
				15:  Std9bitColour = {`full,`full,`full};
	  endcase
	end
   
   // PaletteReg register (ULAplus)
   reg [6:0] PaletteReg = 7'h00;
   always @(posedge clk7) begin
      if (PaletteRegLoad)
        PaletteReg <= din[6:0];
   end
   
   // ConfigReg register (ULAplus)
   reg ConfigReg = 1'b0;
   wire ULAplusEnabled = ConfigReg;
   always @(posedge clk7) begin
      if (rst_n == 1'b0)
         ConfigReg <= 1'b0;
      else if (ConfigRegLoad)
         ConfigReg <= din[0];
   end
   
   // Palette LUT
   wire [7:0] PaletteEntryToCPU;
   wire [7:0] ULAplusPaperColour;
   wire [7:0] ULAplusInkColour;
   lut palette (
      .clk(clk7),
      .load(PaletteLoad),
      .din(din),
      .a1({InputToAttrOutput[7:6],1'b1,InputToAttrOutput[5:3]}),
      .a2({InputToAttrOutput[7:6],1'b0,InputToAttrOutput[2:0]}),
      .a3(PaletteReg[5:0]),
      .do1(ULAplusPaperColour),
      .do2(ULAplusInkColour),
      .do3(PaletteEntryToCPU)
      );
      
   // AttrPlusOutput register
   reg [15:0] AttrPlusOutput = 16'h0000;
   always @(posedge clk7) begin
      if (AttrOutputLoad)
         AttrPlusOutput <= {ULAplusPaperColour,ULAplusInkColour};
   end
   
   // ULAplus final 8-bit GGGRRRBB colour
   reg [7:0] ULAplusPixelColour;
   always @* begin
      if (Pixel)
         ULAplusPixelColour = AttrPlusOutput[7:0];
      else
         ULAplusPixelColour = AttrPlusOutput[15:8];
   end
   
   // 332-GRB to 333-GRB (blue turns from B1 B0 into B1 B0 B1)
   wire [8:0] ULAplus9bitColour = {ULAplusPixelColour,ULAplusPixelColour[1]};
   
   // Final stage. Final colour is connected to PAL generator
   always @* begin
      if (ULAplusEnabled) begin
         gi = ULAplus9bitColour[8:6];
         ri = ULAplus9bitColour[5:3];
         bi = ULAplus9bitColour[2:0];
      end
      else begin
         gi = Std9bitColour[8:6];
         ri = Std9bitColour[5:3];
         bi = Std9bitColour[2:0];
      end
   end

   // Column address register (CA)
   reg [4:0] CA = 5'h00;
   always @(posedge clk7) begin
      if (CALoad)
         CA <= hc[7:3];
   end

   // VRAM Address generation
   always @* begin
     if (BitmapAddr) begin
        va = {PG,vc[7:6],vc[2:0],vc[5:3],CA};
     end
     else if (AttrAddr) begin
        if (HCL==1'b0)
           va = {PG,3'b110,vc[7:3],CA};
        else
           va = {1'b1,vc[7:6],vc[2:0],vc[5:3],CA};
     end
     else
        va = 14'hZZZZ;
   end

///////////////////////////////////////////////
// ULA control unit
///////////////////////////////////////////////

   // control data flow from VRAM to RGB output
   always @* begin
      BitmapDataLoad = 1'b0;
      AttrDataLoad = 1'b0;
      SerializerLoad = 1'b0;
      VideoEnable = 1'b0;
      AttrOutputLoad = 1'b0;
      BitmapAddr = 1'b0;
      AttrAddr = 1'b0;
      CALoad = 1'b0;
      if (hc[2:0]==3'd4) begin // hc=4,12,20,28,etc
         AttrOutputLoad = 1'b1;  // updated every 8 pixel clocks
      end
      if (hc[2:0]==3'd3) begin
         CALoad = 1'b1;
      end
      if (hc>=(BHPIXEL+8) && hc<=(EHPIXEL+8) && vc>=BVPIXEL && vc<=EVPIXEL) begin  // VidEN_n is low here: paper area
         VideoEnable = 1'b1;
         if (hc[2:0]==3'd4) begin
            SerializerLoad = 1'b1;  // updated every 8 pixel clocks, if we are in paper area
         end
         if (hc[3:0]==4'd8 || hc[3:0]==4'd12) begin
            BitmapAddr = 1'b1;
         end
         if (hc[3:0]==4'd9 || hc[3:0]==4'd13) begin
            BitmapAddr = 1'b1;
            BitmapDataLoad = 1'b1;
         end
         if (hc[3:0]==4'd10 || hc[3:0]==4'd14) begin
            AttrAddr = 1'b1;
         end
         if (hc[3:0]==4'd11 || hc[3:0]==4'd15) begin
            AttrAddr = 1'b1;
            AttrDataLoad = 1'b1;
         end
      end
   end

///////////////////////////////////////////////
// ULA interface with CPU
///////////////////////////////////////////////

   parameter
      TIMEXPORT =    8'hFF,
      ULAPLUSADDR = 16'hBF3B,
      ULAPLUSDATA = 16'hFF3B;      
         
   // Z80 writes values into registers
   // Port 0xFE
   always @(posedge clk7) begin
      if (iorq_n==1'b0 && wr_n==1'b0) begin
         if (a[0]==1'b0) begin
            {spk,mic} <= din[4:3];
         end
      end
   end
  
   // TIMEX and ULAplus ports
   always @* begin
      TimexConfigLoad = 1'b0;
      PaletteRegLoad = 1'b0;
      ConfigRegLoad = 1'b0;
      PaletteLoad = 1'b0;
      WriteToPortFE = 1'b0;
      if (iorq_n==1'b0 && wr_n==1'b0) begin
         if (a[0]==1'b0)
            WriteToPortFE = 1'b1;
         else if (a[7:0]==TIMEXPORT)
            TimexConfigLoad = 1'b1;
         else if (a==ULAPLUSADDR)
            PaletteRegLoad = 1'b1;
         else if (a==ULAPLUSDATA) begin
            if (PaletteReg[6]==1'b0)  // writting a new value into palette LUT
               PaletteLoad = 1'b1;
            else
               ConfigRegLoad = 1'b1;  // writting a new value into ULAplus config register
         end
      end
   end
   
   // Z80 gets values from registers (or floating bus)
   always @* begin
      dout = 8'hFF;
      if (iorq_n==1'b0 && rd_n==1'b0) begin
         if (a[0]==1'b0)
            dout = {1'b1,ear,1'b1,kbd};
         else if (a==ULAPLUSADDR)
            dout = {1'b0,PaletteReg};
         else if (a==ULAPLUSDATA && PaletteReg[6]==1'b0)
            dout = PaletteEntryToCPU;
         else if (a==ULAPLUSDATA && PaletteReg[6]==1'b1)
            dout = {7'b0000000,ConfigReg};
         else if (a[7:0]==TIMEXPORT && BitmapAddr)
            dout = BitmapData;
         else if (a[7:0]==TIMEXPORT && AttrAddr)  
            dout = AttrData;   // floating bus
         /*else if (a[7:0]==TIMEXPORT && VideoEnable)
            dout = vramdata;*/
      end
   end
         
   // INT generation
   always @* begin
      if (vc==BVSYNC && hc>=0 && hc<=63) // 32 T-states INT pulse width
         int_n = 1'b0;
      else
         int_n = 1'b1;
   end
   
   // CLK Contention control
/*
    High byte   |         | 
    in 40 - 7F? | Low bit | Contention pattern  
    ------------+---------+-------------------
         No     |  Reset  | N:1, C:3
         No     |   Set   | N:4
        Yes     |  Reset  | C:1, C:3
        Yes     |   Set   | C:1, C:1, C:1, C:1

The 'Contention pattern' column should be interpreted from left to right.
An "N:n" entry means that no delay is applied at this cycle, and the Z80 
continues uninterrupted for 'n' T states. A "C:n" entry means that the 
ULA halts the Z80; the delay is exactly the same as would occur for a 
contended memory access at this cycle (eg 6 T states at cycle 14335, 
5 at 14336, etc on the 48K machine). After this delay, the Z80 then 
continues for 'n' cycles.

*/
//
//   `define CPUBASECLK clk7
//
//   parameter
//		T1 = 0,
//		T2 = 1,
//		T3_MEM = 2,
//		T3_IO = 3,
//		T4_IO = 4;
//
//   `define CONTENDED_IOPORT_IN_USE (iorq_n==1'b0 && (a[0]==1'b0 || a==ULAPLUSADDR || a==ULAPLUSDATA))
//	`define NOT_CONTENDED_IOPORT_IN_USE (iorq_n==1'b0 && a[0]!=1'b0 && a!=ULAPLUSADDR && a!=ULAPLUSDATA)
//   
//   reg CLKWait;
//   reg RCLKCpu = 1'b0;
//   reg StopCLK;
//   always @* begin
//     CLKWait = 1'b0;
//     if (hc>=0 && hc<=255 && vc>=0 && vc<=191 && hc[3:0]>=4'd4 && hc[3:0]<=4'd14)
//       CLKWait = 1'b1;
//   end
//   
//   always @(posedge `CPUBASECLK) begin
//      if (StopCLK)
//         RCLKCpu <= 1'b1;
//      else
//         RCLKCpu <= ~RCLKCpu;
//   end
//   
//   reg [2:0] state = T1;
//   reg [2:0] next_state;
//   always @(posedge cpuclk)
//      state <= next_state;
//   
//   always @* begin      
//      case (state)
//         T1 : begin
//			       // there is an address in range 4000-7FFF present, no mreq/iorq signals asserted,
//					 // and there is risk of colission: This is T1. Contend!
//                if (a[15:14]==2'b01 && mreq_n==1'b1 && iorq_n==1'b1 && CLKWait) begin
//                   StopCLK = 1'b1;
//                   next_state = T1;
//                end
//			       // there is an address in range 4000-7FFF present, no mreq/iorq signals asserted,
//					 // and there is no risk of colission: This is T1. Don't contend!
//                else if (mreq_n==1'b1 && iorq_n==1'b1 && (!CLKWait && a[15:14]==2'b01 || a[15:14]!=2'b01)) begin
//                   StopCLK = 1'b0;
//						 next_state = T2;
//                end
//					 // MREQ is asserted. This must be T2, so we go to T3
//					 else if (mreq_n==1'b0) begin
//						StopCLK = 1'b0;
//						next_state = T3_MEM;
//				    end
//					 // there is an attempt to access an even I/O port and there is risk of colission:
//					 // This is T2. Contend!
//                else if (`CONTENDED_IOPORT_IN_USE && CLKWait) begin
//                   StopCLK = 1'b1;
//                   next_state = T2;
//                end
//					 // there is an attempt to access an odd I/O port, or it's an even I/O port but no
//					 // risk of contention: this is T2. Don't contend and go to T3
//					 else if ( (`CONTENDED_IOPORT_IN_USE && !CLKWait) || (`NOT_CONTENDED_IOPORT_IN_USE)) begin
//                  StopCLK = 1'b0;
//						next_state = T3_IO;
//					 end					 
//                else begin
//					    StopCLK = 1'b0;
//                   next_state = T1;
//                end
//              end
//         T2 : begin
//                if (`CONTENDED_IOPORT_IN_USE && CLKWait) begin
//                   StopCLK = 1'b1;
//                   next_state = T2;
//                end
//					 else if ( (`CONTENDED_IOPORT_IN_USE && !CLKWait) || (`NOT_CONTENDED_IOPORT_IN_USE)) begin
//                  StopCLK = 1'b0;
//						next_state = T3_IO;
//					 end
//                else if (!mreq_n) begin
//                  StopCLK = 1'b0;
//						next_state = T3_MEM;
//                end
//					 else begin
//						StopCLK = 1'b0;
//						next_state = T1;
//				    end
//              end
//         T3_MEM :
//              begin
//				    StopCLK = 1'b0;
//                next_state = T1;
//              end
//         T3_IO :
//              begin
//                StopCLK = 1'b0;
//					 next_state = T4_IO;
//              end
//         T4_IO :
//              begin
//                StopCLK = 1'b0;
//					 next_state = T1;
//              end
//		   default : 
//			     begin
//				    StopCLK = 1'b0;
//				    next_state = T1;
//				  end
//     endcase
//   end     
	//assign cpuclk = RCLKCpu;

///////////////////////////////////
// CPU CLOCK GENERATION (Altwasser method)
///////////////////////////////////

`define MASTERCPUCLK clk7

   reg CPUInternalClock = 0;
	reg ioreqtw3 = 0;
	reg mreqt23 = 0;

   wire iorequla = !iorq_n && (a[0]==0);
	wire iorequlaplus = !iorq_n && (a==ULAPLUSADDR || a==ULAPLUSDATA);
	wire ioreqall_n = !(iorequlaplus || iorequla);

	reg Border_n;
	always @(*) begin
		if (vc>=BVPIXEL && vc<=EVPIXEL && hc>=BHPIXEL && hc<=EHPIXEL)
			Border_n = 1;
		else
			Border_n = 0;
	end
	wire Nor1 = (~(a[14] | ~ioreqall_n)) | 
	            (~(~a[15] | ~ioreqall_n)) | 
					( hc[3:0]<4'd4 /*|| hc[3:0]==4'd15*/ ) | 
					(~Border_n | ~ioreqtw3 | ~cpuclk | ~mreqt23);
	wire Nor2 = ( hc[3:0]<4'd4 /*|| hc[3:0]==4'd15*/ ) | 
	            ~Border_n |
					~cpuclk |
					ioreqall_n |
					~ioreqtw3;
	wire CLKContention = ~Nor1 | ~Nor2;

	always @(posedge cpuclk) begin
      if (!CLKContention) begin
         ioreqtw3 <= ioreqall_n;
         mreqt23 <= mreq_n;
      end
	end

	always @(posedge `MASTERCPUCLK) begin
		if (!CLKContention)
			CPUInternalClock = ~CPUInternalClock;
	   else
		   CPUInternalClock = 1'b1;
   end

   assign cpuclk = CPUInternalClock;

endmodule
