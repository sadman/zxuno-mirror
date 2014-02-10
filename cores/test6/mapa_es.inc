// Teclas con scancode simple
`define KEY_ESC 		8'h76
`define KEY_F1 		8'h05
`define KEY_F2 		8'h06
`define KEY_F3 		8'h04
`define KEY_F4 		8'h0C
`define KEY_F5 		8'h03
`define KEY_F6 		8'h0B
`define KEY_F7 		8'h83
`define KEY_F8 		8'h0A
`define KEY_F9 		8'h01
`define KEY_F10 		8'h09
`define KEY_F11 		8'h78
`define KEY_F12 		8'h07

`define KEY_BL 		8'h0E
`define KEY_1 			8'h16
`define KEY_2 			8'h1E
`define KEY_3 			8'h26
`define KEY_4 			8'h25
`define KEY_5 			8'h2E
`define KEY_6 			8'h36
`define KEY_7 			8'h3D
`define KEY_8 			8'h3E
`define KEY_9 			8'h46
`define KEY_0 			8'h45
`define KEY_APOS 		8'h4E
`define KEY_AEXC 		8'h55
`define KEY_BKSP 		8'h66

`define KEY_TAB 		8'h0D
`define KEY_Q 			8'h15
`define KEY_W 			8'h1D
`define KEY_E 			8'h24
`define KEY_R 			8'h2D
`define KEY_T 			8'h2C
`define KEY_Y 			8'h35
`define KEY_U 			8'h3C
`define KEY_I 			8'h43
`define KEY_O 			8'h44
`define KEY_P 			8'h4D
`define KEY_CORCHA 	8'h54
`define KEY_CORCHC 	8'h5B
`define KEY_ENTER 	8'h5A

`define KEY_CPSLK 	8'h58
`define KEY_A 			8'h1C
`define KEY_S 			8'h1B
`define KEY_D 			8'h23
`define KEY_F 			8'h2B
`define KEY_G 			8'h34
`define KEY_H 			8'h33
`define KEY_J 			8'h3B
`define KEY_K 			8'h42
`define KEY_L 			8'h4B
`define KEY_NT 		8'h4C
`define KEY_LLAVA 	8'h52
`define KEY_LLAVC 	8'h5D

`define KEY_LSHIFT	8'h12
`define KEY_LT 		8'h61
`define KEY_Z 			8'h1A
`define KEY_X 			8'h22
`define KEY_C 			8'h21
`define KEY_V 			8'h2A
`define KEY_B 			8'h32
`define KEY_N 			8'h31
`define KEY_M 			8'h3A
`define KEY_COMA 		8'h41
`define KEY_PUNTO 	8'h49
`define KEY_MENOS 	8'h4A
`define KEY_RSHIFT	8'h59

`define KEY_CTRLI 	8'h14
`define KEY_ALTI 		8'h11
`define KEY_SPACE 	8'h29

`define KEY_KP0 		8'h70
`define KEY_KP1 		8'h69
`define KEY_KP2 		8'h72
`define KEY_KP3 		8'h7A
`define KEY_KP4 		8'h6B
`define KEY_KP5 		8'h73
`define KEY_KP6 		8'h74
`define KEY_KP7 		8'h6C
`define KEY_KP8 		8'h75
`define KEY_KP9 		8'h7D
`define KEY_KPPUNTO 	8'h71
`define KEY_KPMAS 	8'h79
`define KEY_KPMENOS 	8'h7B
`define KEY_KPASTER 	8'h7C

`define KEY_BLKNUM	8'h77
`define KEY_BLKSCR 	8'h7E

// Teclas con E0 + scancode
`define KEY_WAKEUP 	8'h5E
`define KEY_SLEEP 	8'h3F
`define KEY_POWER 	8'h37
`define KEY_INS 		8'h70
`define KEY_SUP 		8'h71
`define KEY_HOME 		8'h6C
`define KEY_END 		8'h69
`define KEY_PGU 		8'h7D
`define KEY_PGD 		8'h7A
`define KEY_UP 		8'h75
`define KEY_DOWN 		8'h72
`define KEY_LEFT 		8'h6B
`define KEY_RIGHT 	8'h74
`define KEY_CTRLD 	8'h14
`define KEY_ALTGR 	8'h11
`define KEY_KPENTER 	8'h5A
`define KEY_KPSLASH 	8'h4A
`define KEY_PRTSCR 	8'h7C

// Matriz del ZX Spectrum
`define SP_CS 			{3'b000,5'b11110}
`define SP_Z 			{3'b000,5'b11101}
`define SP_X 			{3'b000,5'b11011}
`define SP_C			{3'b000,5'b10111}
`define SP_V			{3'b000,5'b01111}

`define SP_A			{3'b001,5'b11110}
`define SP_S			{3'b001,5'b11101}
`define SP_D			{3'b001,5'b11011}
`define SP_F			{3'b001,5'b10111}
`define SP_G			{3'b001,5'b01111}

`define SP_Q			{3'b010,5'b11110}
`define SP_W			{3'b010,5'b11101}
`define SP_E			{3'b010,5'b11011}
`define SP_R			{3'b010,5'b10111}
`define SP_T			{3'b010,5'b01111}

`define SP_1			{3'b011,5'b11110}
`define SP_2			{3'b011,5'b11101}
`define SP_3			{3'b011,5'b11011}
`define SP_4			{3'b011,5'b10111}
`define SP_5			{3'b011,5'b01111}

`define SP_0			{3'b100,5'b11110}
`define SP_9			{3'b100,5'b11101}
`define SP_8			{3'b100,5'b11011}
`define SP_7			{3'b100,5'b10111}
`define SP_6			{3'b100,5'b01111}

`define SP_P			{3'b101,5'b11110}
`define SP_O			{3'b101,5'b11101}
`define SP_I			{3'b101,5'b11011}
`define SP_U			{3'b101,5'b10111}
`define SP_Y			{3'b101,5'b01111}

`define SP_ENT			{3'b110,5'b11110}
`define SP_L			{3'b110,5'b11101}
`define SP_K			{3'b110,5'b11011}
`define SP_J			{3'b110,5'b10111}
`define SP_H			{3'b110,5'b01111}

`define SP_SPC			{3'b111,5'b11110}
`define SP_SS			{3'b111,5'b11101}
`define SP_M			{3'b111,5'b11011}
`define SP_N			{3'b111,5'b10111}
`define SP_B			{3'b111,5'b01111}

`define SP_NOKEY		{3'b111,5'b11111}
`define NADA			{`SP_NOKEY,`SP_NOKEY}

integer relleno;
initial begin
	// Relleno inicial. Luego será sobreescrito...
	for (relleno=0;relleno<=131; relleno=relleno+1)
	begin
		mapa_noshift_noext[relleno]={`NADA};
		mapa_noshift_ext[relleno]={`NADA};
		mapa_shift_noext[relleno]={`NADA};
		mapa_shift_ext[relleno]={`NADA};
	end


	/* TRADUCCION DE TECLAS SIN SHIFT PULSADO */

	// Fila de teclas de funcion (13 teclas)
	mapa_noshift_noext[`KEY_ESC]	={`SP_CS,`SP_SPC};
	mapa_noshift_noext[`KEY_F2]	={`SP_CS,`SP_1};

	// Fila de números (14 teclas)
	mapa_noshift_noext[`KEY_BL]	={`SP_SS,`SP_D};
	mapa_noshift_noext[`KEY_1]		={`SP_1,`SP_NOKEY};
	mapa_noshift_noext[`KEY_2]		={`SP_2,`SP_NOKEY};
	mapa_noshift_noext[`KEY_3]		={`SP_3,`SP_NOKEY};
	mapa_noshift_noext[`KEY_4]		={`SP_4,`SP_NOKEY};
	mapa_noshift_noext[`KEY_5]		={`SP_5,`SP_NOKEY};
	mapa_noshift_noext[`KEY_6]		={`SP_6,`SP_NOKEY};
	mapa_noshift_noext[`KEY_7]		={`SP_7,`SP_NOKEY};
	mapa_noshift_noext[`KEY_8]		={`SP_8,`SP_NOKEY};
	mapa_noshift_noext[`KEY_9]		={`SP_9,`SP_NOKEY};
	mapa_noshift_noext[`KEY_0]		={`SP_0,`SP_NOKEY};
	mapa_noshift_noext[`KEY_APOS]	={`SP_SS,`SP_7};
	mapa_noshift_noext[`KEY_BKSP]	={`SP_CS,`SP_0};
	
	// Fila Q-P (14 teclas)
	mapa_noshift_noext[`KEY_TAB]	={`SP_CS,`SP_SS};
	mapa_noshift_noext[`KEY_Q]		={`SP_Q,`SP_NOKEY};
	mapa_noshift_noext[`KEY_W]		={`SP_W,`SP_NOKEY};
	mapa_noshift_noext[`KEY_E]		={`SP_E,`SP_NOKEY};
	mapa_noshift_noext[`KEY_R]		={`SP_R,`SP_NOKEY};
	mapa_noshift_noext[`KEY_T]		={`SP_T,`SP_NOKEY};
	mapa_noshift_noext[`KEY_Y]		={`SP_Y,`SP_NOKEY};
	mapa_noshift_noext[`KEY_U]		={`SP_U,`SP_NOKEY};
	mapa_noshift_noext[`KEY_I]		={`SP_I,`SP_NOKEY};
	mapa_noshift_noext[`KEY_O]		={`SP_O,`SP_NOKEY};
	mapa_noshift_noext[`KEY_P]		={`SP_P,`SP_NOKEY};
	mapa_noshift_noext[`KEY_CORCHA]={`SP_SS,`SP_H};
	mapa_noshift_noext[`KEY_CORCHC]={`SP_SS,`SP_K};
	mapa_noshift_noext[`KEY_ENTER]={`SP_ENT,`SP_NOKEY};

	// Fila A-L (13 teclas)
	mapa_noshift_noext[`KEY_CPSLK]={`SP_CS,`SP_2};
	mapa_noshift_noext[`KEY_A]		={`SP_A,`SP_NOKEY};
	mapa_noshift_noext[`KEY_S]		={`SP_S,`SP_NOKEY};
	mapa_noshift_noext[`KEY_D]		={`SP_D,`SP_NOKEY};
	mapa_noshift_noext[`KEY_F]		={`SP_F,`SP_NOKEY};
	mapa_noshift_noext[`KEY_G]		={`SP_G,`SP_NOKEY};
	mapa_noshift_noext[`KEY_H]		={`SP_H,`SP_NOKEY};
	mapa_noshift_noext[`KEY_J]		={`SP_J,`SP_NOKEY};
	mapa_noshift_noext[`KEY_K]		={`SP_K,`SP_NOKEY};
	mapa_noshift_noext[`KEY_L]		={`SP_L,`SP_NOKEY};
	mapa_noshift_noext[`KEY_LLAVA]={`SP_SS,`SP_F};
	mapa_noshift_noext[`KEY_LLAVC]={`SP_SS,`SP_P};
	
	// Fila Z-M (13 teclas)
	mapa_noshift_noext[`KEY_LT]	={`SP_SS,`SP_R};
	mapa_noshift_noext[`KEY_Z]		={`SP_Z,`SP_NOKEY};
	mapa_noshift_noext[`KEY_X]		={`SP_X,`SP_NOKEY};
	mapa_noshift_noext[`KEY_C]		={`SP_C,`SP_NOKEY};
	mapa_noshift_noext[`KEY_V]		={`SP_V,`SP_NOKEY};
	mapa_noshift_noext[`KEY_B]		={`SP_B,`SP_NOKEY};
	mapa_noshift_noext[`KEY_N]		={`SP_N,`SP_NOKEY};
	mapa_noshift_noext[`KEY_M]		={`SP_M,`SP_NOKEY};
	mapa_noshift_noext[`KEY_COMA]	={`SP_SS,`SP_N};
	mapa_noshift_noext[`KEY_PUNTO]={`SP_SS,`SP_M};
	mapa_noshift_noext[`KEY_MENOS]={`SP_SS,`SP_J};
	
	// Fila CTRL-SPACE (3 teclas)
	mapa_noshift_noext[`KEY_CTRLI]={`SP_CS,`SP_NOKEY};
	mapa_noshift_noext[`KEY_SPACE]={`SP_SPC,`SP_NOKEY};
	
	// Keypad (14 teclas)
	mapa_noshift_noext[`KEY_KP0]	={`SP_0,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP1]	={`SP_1,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP2]	={`SP_2,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP3]	={`SP_3,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP4]	={`SP_4,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP5]	={`SP_5,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP6]	={`SP_6,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP7]	={`SP_7,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP8]	={`SP_8,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KP9]	={`SP_9,`SP_NOKEY};
	mapa_noshift_noext[`KEY_KPPUNTO]	={`SP_SS,`SP_M};
	mapa_noshift_noext[`KEY_KPMAS]	={`SP_SS,`SP_K};
	mapa_noshift_noext[`KEY_KPMENOS]	={`SP_SS,`SP_J};
	mapa_noshift_noext[`KEY_KPASTER]	={`SP_SS,`SP_B};


	/* TRADUCCION DE TECLAS CON SHIFT PULSADO */

	// Fila de teclas de funcion (13 teclas)
	mapa_shift_noext[`KEY_ESC]		={`SP_CS,`SP_SPC};
	mapa_shift_noext[`KEY_F2]		={`SP_CS,`SP_1};

	// Fila de números (14 teclas)
	mapa_shift_noext[`KEY_1]		={`SP_1,`SP_SS};
	mapa_shift_noext[`KEY_2]		={`SP_P,`SP_SS};
	mapa_shift_noext[`KEY_3]		={`SP_3,`SP_SS};
	mapa_shift_noext[`KEY_4]		={`SP_4,`SP_SS};
	mapa_shift_noext[`KEY_5]		={`SP_5,`SP_SS};
	mapa_shift_noext[`KEY_6]		={`SP_6,`SP_SS};
	mapa_shift_noext[`KEY_7]		={`SP_V,`SP_SS};
	mapa_shift_noext[`KEY_8]		={`SP_8,`SP_SS};
	mapa_shift_noext[`KEY_9]		={`SP_9,`SP_SS};
	mapa_shift_noext[`KEY_0]		={`SP_L,`SP_SS};
	mapa_shift_noext[`KEY_APOS]	={`SP_C,`SP_SS};
	mapa_shift_noext[`KEY_BKSP]	={`SP_CS,`SP_0};
	
	// Fila Q-P (14 teclas)
	mapa_shift_noext[`KEY_TAB]		={`SP_CS,`SP_SS};
	mapa_shift_noext[`KEY_Q]		={`SP_Q,`SP_CS};
	mapa_shift_noext[`KEY_W]		={`SP_W,`SP_CS};
	mapa_shift_noext[`KEY_E]		={`SP_E,`SP_CS};
	mapa_shift_noext[`KEY_R]		={`SP_R,`SP_CS};
	mapa_shift_noext[`KEY_T]		={`SP_T,`SP_CS};
	mapa_shift_noext[`KEY_Y]		={`SP_Y,`SP_CS};
	mapa_shift_noext[`KEY_U]		={`SP_U,`SP_CS};
	mapa_shift_noext[`KEY_I]		={`SP_I,`SP_CS};
	mapa_shift_noext[`KEY_O]		={`SP_O,`SP_CS};
	mapa_shift_noext[`KEY_P]		={`SP_P,`SP_CS};
	mapa_shift_noext[`KEY_CORCHA]	={`SP_SS,`SP_H};
	mapa_shift_noext[`KEY_CORCHC]	={`SP_SS,`SP_B};
	mapa_shift_noext[`KEY_ENTER]	={`SP_ENT,`SP_NOKEY};

	// Fila A-L (13 teclas)
	mapa_shift_noext[`KEY_CPSLK]	={`SP_CS,`SP_2};
	mapa_shift_noext[`KEY_A]		={`SP_A,`SP_CS};
	mapa_shift_noext[`KEY_S]		={`SP_S,`SP_CS};
	mapa_shift_noext[`KEY_D]		={`SP_D,`SP_CS};
	mapa_shift_noext[`KEY_F]		={`SP_F,`SP_CS};
	mapa_shift_noext[`KEY_G]		={`SP_G,`SP_CS};
	mapa_shift_noext[`KEY_H]		={`SP_H,`SP_CS};
	mapa_shift_noext[`KEY_J]		={`SP_J,`SP_CS};
	mapa_shift_noext[`KEY_K]		={`SP_K,`SP_CS};
	mapa_shift_noext[`KEY_L]		={`SP_L,`SP_CS};
	mapa_shift_noext[`KEY_LLAVA]	={`SP_SS,`SP_F};
	mapa_shift_noext[`KEY_LLAVC]	={`SP_SS,`SP_G};
	
	// Fila Z-M (13 teclas)
	mapa_shift_noext[`KEY_LT]		={`SP_SS,`SP_T};
	mapa_shift_noext[`KEY_Z]		={`SP_Z,`SP_CS};
	mapa_shift_noext[`KEY_X]		={`SP_X,`SP_CS};
	mapa_shift_noext[`KEY_C]		={`SP_C,`SP_CS};
	mapa_shift_noext[`KEY_V]		={`SP_V,`SP_CS};
	mapa_shift_noext[`KEY_B]		={`SP_B,`SP_CS};
	mapa_shift_noext[`KEY_N]		={`SP_N,`SP_CS};
	mapa_shift_noext[`KEY_M]		={`SP_M,`SP_CS};
	mapa_shift_noext[`KEY_COMA]	={`SP_SS,`SP_O};
	mapa_shift_noext[`KEY_PUNTO]={`SP_SS,`SP_Z};
	mapa_shift_noext[`KEY_MENOS]={`SP_SS,`SP_0};
	
	// Fila CTRL-SPACE (3 teclas)
	mapa_shift_noext[`KEY_CTRLI]={`SP_CS,`SP_NOKEY};
	mapa_shift_noext[`KEY_SPACE]={`SP_SPC,`SP_NOKEY};
	
	// Keypad (14 teclas)
	mapa_shift_noext[`KEY_KP0]	={`SP_0,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP1]	={`SP_1,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP2]	={`SP_2,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP3]	={`SP_3,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP4]	={`SP_4,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP5]	={`SP_5,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP6]	={`SP_6,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP7]	={`SP_7,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP8]	={`SP_8,`SP_NOKEY};
	mapa_shift_noext[`KEY_KP9]	={`SP_9,`SP_NOKEY};
	mapa_shift_noext[`KEY_KPPUNTO]	={`SP_SS,`SP_M};
	mapa_shift_noext[`KEY_KPMAS]	={`SP_SS,`SP_K};
	mapa_shift_noext[`KEY_KPMENOS]	={`SP_SS,`SP_J};
	mapa_shift_noext[`KEY_KPASTER]	={`SP_SS,`SP_B};


	/* TRADUCCION DE TECLAS EXTENDIDAS SIN SHIFT PULSADO */

	mapa_noshift_ext[`KEY_UP]			={`SP_7,`SP_CS};
	mapa_noshift_ext[`KEY_DOWN]		={`SP_6,`SP_CS};
	mapa_noshift_ext[`KEY_LEFT]		={`SP_5,`SP_CS};
	mapa_noshift_ext[`KEY_RIGHT]		={`SP_8,`SP_CS};
	mapa_noshift_ext[`KEY_CTRLD]		={`SP_SS,`SP_NOKEY};
	mapa_noshift_ext[`KEY_KPENTER]	={`SP_ENT,`SP_NOKEY};
	mapa_noshift_ext[`KEY_KPSLASH]	={`SP_V,`SP_SS};

end

