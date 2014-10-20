`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:        Dept. Architecture and Computing Technology. University of Seville
// Engineer:       Miguel Angel Rodriguez Jodar. rodriguj@atc.us.es
// 
// Create Date:    19:13:39 4-Apr-2012 
// Design Name:    ZX Spectrum
// Module Name:    PS2 keyboard interface for ZX Spectrum.
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 1.00 - File Created
// Additional Comments: GPL License policies apply to the contents of this file.
//
//////////////////////////////////////////////////////////////////////////////////
module ps2kbd (
    input clk,
	 input reset,
	 input clkps2,
	 input dataps2,
	 output ledextended,
	 output ledreleased,
	 output ledmayus,
	 output [7:0] scancode,
	 input [7:0] semifila,
	 output [4:0] columna
    );

	reg rload = 0;
	reg [1:0] estado = 0;

	wire [7:0] tecla;
	wire recibida;
	
	reg [7:0] rscancode=8'h00;
	assign scancode = rscancode;

	reg extended = 0;
	reg released = 0;
	reg mayus = 0;
	assign ledextended = extended;
	assign ledreleased = released;
	assign ledmayus = mayus;

	ps2_keyboard ps2_get_scancode (
		.clk(clk),
		.reset(reset),
		.ps2_clk(clkps2),
		.ps2_data(dataps2),
		.interrupt(recibida),
		.rx_scan_code(tecla)
	);

	matrix scancode_to_zx_keyboard (
		.clk(clk),
		.keyreceived(rload),
		.scancode(tecla),
		.mayus(mayus),
		.extended(extended),
		.released(released),
		.semifila(semifila),
		.columna(columna)
	);

	always @(posedge clk)
	begin
		case (estado)
			0:	if (recibida) // if a new key has just been received at the PS2 port...
					begin
						if (tecla==8'h12 || tecla==8'h59) begin  // if it's one of the two shift keys,
							mayus <= 1;                           // signal it.
						end
						else if (tecla==8'hE0) begin // if this is the beginning of an extended key
							extended <= 1;            // signal it...
							released <= 0;                 // (this is not a released key)
							estado <= 1;              // ...and wait for the next code
						end
						else if (tecla==8'hF0) begin // if this is the beginning of a released key
							extended <= 0;            // then it's not an extended key
							released <= 1;            // signal it...
							estado <= 2;              // ... and wait for the next code
						end
						else if (tecla!=8'hE0 && tecla!=8'hF0 && tecla!=8'h12 && tecla!=8'h59) begin  // if this is a "normal" key
							rscancode <= tecla;                                                      // store its scancode
							extended <= 0;                         //
							released <= 0;                         // signal it as "normal": not released, not extended
							rload <= 1; //no estaba                // a new key has arrived. Signal that to the matrix module
							estado <= 0; //3;                      // and go for another key (the next clock will have "recibida" = 0, so
						end                                       // it will go to the "else" part of this "if" statement, to deassert "rload")
					end
				else
					rload <= 0;  // if a new key has not been received, just turn off the "new key arrived" signal
					
			1:	if (recibida) // if a new extended key has just been received at the PS2 port...
					begin
						if (tecla==8'hF0) begin  // if this is the beginning of a released extended key...
							released <= 1;        // ... signal it, and
							estado <= 2;          // ... wait for the actual scancode of the released key
						end
						else if (tecla!=8'hE0 && tecla!=8'hF0 && tecla!=8'h12 && tecla!=8'h59) begin  // if this is the actual scancode of a new pressed extended key...
							rscancode <= tecla;                                                           // store it...
							rload <= 1; //no estaba                                                    // assert "rload"...
							estado <= 0; //3;                                                          // and go for another key... 
						end
					end
				else
					rload <= 0;
					
			2:	if (recibida) // if a new released key has just been received at the PS2 port...
					begin
						if (tecla==8'h12 || tecla==8'h59) begin  // if it is one of the shift keys
							mayus <= 0;                           // deassert "mayus" to signal that shift is no longer pressed
							estado <= 0;
						end
						else if (tecla!=8'hE0 && tecla!=8'hF0 && tecla!=8'h12 && tecla!=8'h59) begin  // if this is any other key...
							rscancode <= tecla;                                                           // store it...
							rload <= 1;                                                                // assert "rload"
							estado <= 0;                                                               // and go for another key
						end
					end
				else
					rload <= 0;					
		endcase
	end 
endmodule

module matrix (
   input clk,
	input keyreceived,
	input [7:0] scancode,
	input mayus,
	input extended,
	input released,
	input [7:0] semifila,
	output [4:0] columna
	);
	
	reg [4:0] thematrix[0:7];	// memory representing 40 keys
	initial begin					// initially, all keys are released (0=pressed)
		thematrix[0] = 5'b11111;
		thematrix[1] = 5'b11111;
		thematrix[2] = 5'b11111;
		thematrix[3] = 5'b11111;
		thematrix[4] = 5'b11111;
		thematrix[5] = 5'b11111;
		thematrix[6] = 5'b11111;
		thematrix[7] = 5'b11111;
	end
	
	// output bits to ULA are composed with data from the eight half-rows, depending upon which
	// bits were resetted at CPU address bus bits 8-15 (row selection)
	assign columna = ((!semifila[0])? thematrix[0] : 5'b11111) &
						  ((!semifila[1])? thematrix[1] : 5'b11111) &
						  ((!semifila[2])? thematrix[2] : 5'b11111) &
						  ((!semifila[3])? thematrix[3] : 5'b11111) &
						  ((!semifila[4])? thematrix[4] : 5'b11111) &
						  ((!semifila[5])? thematrix[5] : 5'b11111) &
						  ((!semifila[6])? thematrix[6] : 5'b11111) &
						  ((!semifila[7])? thematrix[7] : 5'b11111);
		
	// ROM's containing the ZX Spectrum equivalent key(s) for each PS2 key. For Spectrum shifted keys
   //	(such as = * + ! CURSOR-LEFT, DELETE, EDIT, etc), a memory location contains two values: one of
	// them is either CAPS SHIFT or SYMBOL SHIFT. The other one is the key that would have to be pressed along
	// with the shift key on the ZX Spectrum keyboard.
	// These ROM's are filled in the file "mapa_es.inc". This file contains the mapping for a spanish keyboard.
	// There is a ROM for normal PS2 keys, another one for PS2 shifted keys, another one for extended, non shifted
	// keys, and the last one is for extended shifted keys.
	// Cada posicion tiene: CODSEMIFILA1(3) , VALORSEMIFILA1(5) , CODSEMIFILA1(3) , VALORSEMIFILA1(5)
	// These ROM's will be infered as BLOCK RAM because the address will be registered
	reg [15:0] mapa_noshift_noext[0:131];
	reg [15:0] mapa_shift_noext[0:131];
	reg [15:0] mapa_noshift_ext[0:131];
	reg [15:0] mapa_shift_ext[0:131];

`include "mapa_es.inc"
		
	reg [2:0] row_key1_nosh_noex;
	reg [2:0] row_key2_nosh_noex;
	reg [2:0] row_key1_sh_noex;
	reg [2:0] row_key2_sh_noex;
	reg [2:0] row_key1_nosh_ex;
	reg [2:0] row_key2_nosh_ex;
	reg [2:0] row_key1_sh_ex;
	reg [2:0] row_key2_sh_ex;
	
	reg [4:0] col_key1_nosh_noex;
	reg [4:0] col_key2_nosh_noex;
	reg [4:0] col_key1_sh_noex;
	reg [4:0] col_key2_sh_noex;
	reg [4:0] col_key1_nosh_ex;
	reg [4:0] col_key2_nosh_ex;
	reg [4:0] col_key1_sh_ex;
	reg [4:0] col_key2_sh_ex;
	
	reg [7:0] addrmap; // to make the addr registered, so XST will infer block RAM.
	reg [4:0] matrixstate = 0;
	
	always @(posedge clk) begin
		case (matrixstate)
			0 : begin
					if (keyreceived) begin	// wait until a key is received.
						matrixstate <= 1;
						addrmap <= scancode;
					end
				 end
			1 : begin   // paralell read the same in the four possible combinations
					{row_key1_nosh_noex,
					 col_key1_nosh_noex,
					 row_key2_nosh_noex,
					 col_key2_nosh_noex} <= mapa_noshift_noext[addrmap];
					{row_key1_sh_noex,
					 col_key1_sh_noex,
					 row_key2_sh_noex,
					 col_key2_sh_noex} <= mapa_shift_noext[addrmap];
					{row_key1_nosh_ex,
					 col_key1_nosh_ex,
					 row_key2_nosh_ex,
					 col_key2_nosh_ex} <= mapa_noshift_ext[addrmap];
					{row_key1_sh_ex,
					 col_key1_sh_ex,
					 row_key2_sh_ex,
					 col_key2_sh_ex} <= mapa_shift_ext[addrmap];
					matrixstate <= 3;
				 end
			3 : begin  // apply matrix updates according to the actual combination pressed or released
					case ( {mayus,extended,released} )
						3'b000 : matrixstate <= 4;  //non shifted, non extended, key pressed
						3'b001 : matrixstate <= 6;  //non shifted, non extended, key released
						3'b010 : matrixstate <= 10; //non shifted, extended...
						3'b011 : matrixstate <= 12; //
						3'b100 : matrixstate <= 16; //shifted, non extended...
						3'b101 : matrixstate <= 18; //
						3'b110 : matrixstate <= 20; //shifted, extended...
						3'b111 : matrixstate <= 22; //
						default : matrixstate <= 0;
					endcase
				 end
			4 : begin // non shifted, non extended, key pressed, update key1 status
					thematrix[row_key1_nosh_noex] <= thematrix[row_key1_nosh_noex] & col_key1_nosh_noex;
					matrixstate <= 5;
				 end
			5 : begin // update key2 status
					thematrix[row_key2_nosh_noex] <= thematrix[row_key2_nosh_noex] & col_key2_nosh_noex;
					matrixstate <= 0; // go for another key
				 end

			6 : begin // non shifted, non extended, key released...
					thematrix[row_key1_nosh_noex] <= thematrix[row_key1_nosh_noex] | ~col_key1_nosh_noex;
					matrixstate <= 7;
				 end
			7 : begin 
					thematrix[row_key2_nosh_noex] <= thematrix[row_key2_nosh_noex] | ~col_key2_nosh_noex;
					matrixstate <= 8;
				 end
			8 : begin // when a non shifted key releases, it released shifted version too...
					thematrix[row_key1_sh_noex] <= thematrix[row_key1_sh_noex] | ~col_key1_sh_noex;
					matrixstate <= 9;
				 end
			9 : begin 
					thematrix[row_key2_sh_noex] <= thematrix[row_key2_sh_noex] | ~col_key2_sh_noex;
					matrixstate <= 0;
				 end

			10: begin // non shifted, extended, key pressed...
					thematrix[row_key1_nosh_ex] <= thematrix[row_key1_nosh_ex] & col_key1_nosh_ex;
					matrixstate <= 11;
				 end
			11: begin
					thematrix[row_key2_nosh_ex] <= thematrix[row_key2_nosh_ex] & col_key2_nosh_ex;
					matrixstate <= 0; // go for another key
				 end
				 
			12: begin // non shifted, extended, key released...
					thematrix[row_key1_nosh_ex] <= thematrix[row_key1_nosh_ex] | ~col_key1_nosh_ex;
					matrixstate <= 13;
				 end
			13: begin 
					thematrix[row_key2_nosh_ex] <= thematrix[row_key2_nosh_ex] | ~col_key2_nosh_ex;
					matrixstate <= 14;
				 end
			14: begin // when a non shifted key releases, it released shifted version too...
					thematrix[row_key1_sh_ex] <= thematrix[row_key1_sh_ex] | ~col_key1_sh_ex;
					matrixstate <= 15;
				 end
			15: begin 
					thematrix[row_key2_sh_ex] <= thematrix[row_key2_sh_ex] | ~col_key2_sh_ex;
					matrixstate <= 0;
				 end
					
			16: begin // shifted, non extended, key pressed, update key1 status
					thematrix[row_key1_sh_noex] <= thematrix[row_key1_sh_noex] & col_key1_sh_noex;
					matrixstate <= 17;
				 end
			17: begin // update key2 status
					thematrix[row_key2_sh_noex] <= thematrix[row_key2_sh_noex] & col_key2_sh_noex;
					matrixstate <= 0; // go for another key
				 end

			18: begin // shifted, non extended, key released...
					thematrix[row_key1_sh_noex] <= thematrix[row_key1_sh_noex] | ~col_key1_sh_noex;
					matrixstate <= 19;
				 end
			19: begin 
					thematrix[row_key2_sh_noex] <= thematrix[row_key2_sh_noex] | ~col_key2_sh_noex;
					matrixstate <= 0;
				 end
			
			20: begin // shifted, extended, key pressed, update key1 status
					thematrix[row_key1_sh_ex] <= thematrix[row_key1_sh_ex] & col_key1_sh_ex;
					matrixstate <= 21;
				 end
			21: begin // update key2 status
					thematrix[row_key2_sh_ex] <= thematrix[row_key2_sh_ex] & col_key2_sh_ex;
					matrixstate <= 0; // go for another key
				 end

			22: begin // shifted, extended, key released...
					thematrix[row_key1_sh_ex] <= thematrix[row_key1_sh_ex] | ~col_key1_sh_ex;
					matrixstate <= 23;
				 end
			23: begin 
					thematrix[row_key2_sh_ex] <= thematrix[row_key2_sh_ex] | ~col_key2_sh_ex;
					matrixstate <= 0;
				 end
		endcase
	end
endmodule

																					