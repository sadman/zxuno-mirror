;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module sdexert
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _font
	.globl _setup_chars
	.globl _elementos_estaticos
	.globl _elegir_opcion
	.globl _sd_select
	.globl _sd_reset
	.globl _sd_sendcommand
	.globl _sd_cmd0
	.globl _sd_cmd8
	.globl _sd_cmd55
	.globl _sd_cmd1
	.globl _sd_acmd41
	.globl _abs
	.globl _sgn
	.globl _frames
	.globl _pause
	.globl _pause0
	.globl _memset
	.globl _memcpy
	.globl _cls
	.globl _border
	.globl _puts
	.globl _locate
	.globl _u16tohex
	.globl _puthex8
	.globl _u8tohex
	.globl _wait_key
	.globl _inkey
	.globl _beep
	.globl _crc7
	.globl ___sdcc_enter_ix
	.globl _getcoreid
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_ULA	=	0x00fe
_ATTR	=	0x00ff
_KEMPSTONADDR	=	0x001f
_SEMIFILA1	=	0xf7fe
_SEMIFILA2	=	0xeffe
_SEMIFILA3	=	0xfbfe
_SEMIFILA4	=	0xdffe
_SEMIFILA5	=	0xfdfe
_SEMIFILA6	=	0xbffe
_SEMIFILA7	=	0xfefe
_SEMIFILA8	=	0x7ffe
_ZXUNOADDR	=	0xfc3b
_ZXUNODATA	=	0xfd3b
_DIVCS	=	0x00e7
_DIVSPI	=	0x00eb
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_font::
	.ds 768
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;sdexert.c:103: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;sdexert.c:107: border(IBLACK);
	xor	a, a
	push	af
	inc	sp
	call	_border
	inc	sp
;sdexert.c:108: cls(BRIGHT|PBLACK|IWHITE);
	ld	a,#0x47
	push	af
	inc	sp
	call	_cls
	inc	sp
;sdexert.c:110: setup_chars();
	call	_setup_chars
;sdexert.c:111: while(1)
00104$:
;sdexert.c:113: elementos_estaticos();
	call	_elementos_estaticos
;sdexert.c:114: salir = elegir_opcion();
	call	_elegir_opcion
	ld	a,l
;sdexert.c:115: if (salir)
	or	a, a
	jr	Z,00104$
;sdexert.c:118: border(*(BYTE *)(23624));
	ld	hl,#0x5c48
	ld	b,(hl)
	push	bc
	inc	sp
	call	_border
	inc	sp
;sdexert.c:119: cls(*(BYTE *)(23693));
	ld	hl,#0x5c8d
	ld	b,(hl)
	push	bc
	inc	sp
	call	_cls
	inc	sp
	ret
;sdexert.c:122: void setup_chars (void)
;	---------------------------------
; Function setup_chars
; ---------------------------------
_setup_chars::
;sdexert.c:126: memcpy (font, (BYTE *)15616, 768);
	ld	hl,#0x0300
	push	hl
	ld	h, #0x3d
	push	hl
	ld	hl,#_font
	push	hl
	call	_memcpy
	pop	af
	pop	af
	pop	af
;sdexert.c:127: font['-'*8+4-256] = 255;
	ld	hl,#(_font + 0x006c)
	ld	(hl),#0xff
;sdexert.c:128: for (i='|'*8;i<'|'*8+8;i++)
	ld	bc,#0x03e0
00102$:
;sdexert.c:129: font[i-256] = 16;
	ld	e, c
	ld	a,b
	add	a,#0xff
	ld	d,a
	ld	hl,#_font
	add	hl,de
	ld	(hl),#0x10
;sdexert.c:128: for (i='|'*8;i<'|'*8+8;i++)
	inc	bc
	ld	a,c
	sub	a, #0xe8
	ld	a,b
	sbc	a, #0x03
	jr	C,00102$
;sdexert.c:130: SETCHARS(font);
	ld	hl,#(_font - 0x0100)
	ld	(0x5c36), hl
	ret
;sdexert.c:133: void elementos_estaticos (void)
;	---------------------------------
; Function elementos_estaticos
; ---------------------------------
_elementos_estaticos::
;sdexert.c:135: locate (0,0);
	ld	hl,#0x0000
	push	hl
	call	_locate
;sdexert.c:136: puts ("\x6\x4\x46          SD EXERCISER          ");
	ld	hl, #___str_0
	ex	(sp),hl
	call	_puts
;sdexert.c:137: locate (1,0);
	ld	hl, #0x0001
	ex	(sp),hl
	call	_locate
;sdexert.c:138: puts ("--------------------------------");
	ld	hl, #___str_1
	ex	(sp),hl
	call	_puts
;sdexert.c:140: locate (2,0);
	ld	hl, #0x0002
	ex	(sp),hl
	call	_locate
;sdexert.c:141: puts ("A. \x4\x45Init sequence (80+ clocks)\r");
	ld	hl, #___str_2
	ex	(sp),hl
	call	_puts
;sdexert.c:142: puts ("B. CMD0.   \x4\x45GO_IDLE_STATE\r");
	ld	hl, #___str_3
	ex	(sp),hl
	call	_puts
;sdexert.c:143: puts ("C. CMD1.   \x4\x45\r");
	ld	hl, #___str_4
	ex	(sp),hl
	call	_puts
;sdexert.c:144: puts ("D. CMD8.   \x4\x45SEND_IF_COND\r");
	ld	hl, #___str_5
	ex	(sp),hl
	call	_puts
;sdexert.c:145: puts ("E. CMD16.  \x4\x45SET_BLOCKLEN\r");
	ld	hl, #___str_6
	ex	(sp),hl
	call	_puts
;sdexert.c:146: puts ("F. CMD55.  \x4\x45""APP_CMD\r");
	ld	hl, #___str_7
	ex	(sp),hl
	call	_puts
;sdexert.c:147: puts ("G. ACMD41. \x4\x45SD_SEND_OP_COND\r");
	ld	hl, #___str_8
	ex	(sp),hl
	call	_puts
;sdexert.c:149: locate (13,0);
	ld	hl, #0x000d
	ex	(sp),hl
	call	_locate
;sdexert.c:150: puts ("--------------------------------");
	ld	hl, #___str_1
	ex	(sp),hl
	call	_puts
;sdexert.c:152: locate (15,0);
	ld	hl, #0x000f
	ex	(sp),hl
	call	_locate
;sdexert.c:153: puts ("\x4\x46""Cmd     :");
	ld	hl, #___str_9
	ex	(sp),hl
	call	_puts
;sdexert.c:155: locate (17,0);
	ld	hl, #0x0011
	ex	(sp),hl
	call	_locate
;sdexert.c:156: puts ("\x4\x46Response:");
	ld	hl, #___str_10
	ex	(sp),hl
	call	_puts
	pop	af
	ret
___str_0:
	.db 0x06
	.db 0x04
	.ascii "F          SD EXERCISER          "
	.db 0x00
___str_1:
	.ascii "--------------------------------"
	.db 0x00
___str_2:
	.ascii "A. "
	.db 0x04
	.ascii "EInit sequence (80+ clocks)"
	.db 0x0d
	.db 0x00
___str_3:
	.ascii "B. CMD0.   "
	.db 0x04
	.ascii "EGO_IDLE_STATE"
	.db 0x0d
	.db 0x00
___str_4:
	.ascii "C. CMD1.   "
	.db 0x04
	.ascii "E"
	.db 0x0d
	.db 0x00
___str_5:
	.ascii "D. CMD8.   "
	.db 0x04
	.ascii "ESEND_IF_COND"
	.db 0x0d
	.db 0x00
___str_6:
	.ascii "E. CMD16.  "
	.db 0x04
	.ascii "ESET_BLOCKLEN"
	.db 0x0d
	.db 0x00
___str_7:
	.ascii "F. CMD55.  "
	.db 0x04
	.ascii "EAPP_CMD"
	.db 0x0d
	.db 0x00
___str_8:
	.ascii "G. ACMD41. "
	.db 0x04
	.ascii "ESD_SEND_OP_COND"
	.db 0x0d
	.db 0x00
___str_9:
	.db 0x04
	.ascii "FCmd     :"
	.db 0x00
___str_10:
	.db 0x04
	.ascii "FResponse:"
	.db 0x00
;sdexert.c:159: BYTE elegir_opcion (void)
;	---------------------------------
; Function elegir_opcion
; ---------------------------------
_elegir_opcion::
;sdexert.c:163: locate (23,0);
	ld	hl,#0x0017
	push	hl
	call	_locate
;sdexert.c:164: puts ("\x4\x44""ENTER YOUR CHOICE");
	ld	hl, #___str_11
	ex	(sp),hl
	call	_puts
	pop	af
;sdexert.c:165: key = pause0();
	call	_pause0
;sdexert.c:166: switch (key)
	ld	a, l
	cp	a,#0x41
	jr	Z,00102$
	cp	a,#0x42
	jr	Z,00104$
	cp	a,#0x43
	jr	Z,00106$
	cp	a,#0x44
	jr	Z,00108$
	cp	a,#0x46
	jr	Z,00110$
	cp	a,#0x47
	jr	Z,00112$
	cp	a,#0x61
	jr	Z,00102$
	cp	a,#0x62
	jr	Z,00104$
	cp	a,#0x63
	jr	Z,00106$
	cp	a,#0x64
	jr	Z,00108$
	cp	a,#0x66
	jr	Z,00110$
	sub	a, #0x67
	jr	Z,00112$
	jr	00113$
;sdexert.c:169: case 'A': sd_reset(); break;
00102$:
	call	_sd_reset
	jr	00113$
;sdexert.c:171: case 'B': sd_cmd0(); break;
00104$:
	call	_sd_cmd0
	jr	00113$
;sdexert.c:173: case 'C': sd_cmd1(); break;
00106$:
	call	_sd_cmd1
	jr	00113$
;sdexert.c:175: case 'D': sd_cmd8(); break;
00108$:
	call	_sd_cmd8
	jr	00113$
;sdexert.c:177: case 'F': sd_cmd55(); break;
00110$:
	call	_sd_cmd55
	jr	00113$
;sdexert.c:179: case 'G': sd_acmd41(); break;
00112$:
	call	_sd_acmd41
;sdexert.c:180: }
00113$:
;sdexert.c:181: return 0;
	ld	l,#0x00
	ret
___str_11:
	.db 0x04
	.ascii "DENTER YOUR CHOICE"
	.db 0x00
;sdexert.c:184: void sd_select (BYTE onoff)
;	---------------------------------
; Function sd_select
; ---------------------------------
_sd_select::
	call	___sdcc_enter_ix
;sdexert.c:186: DIVCS = 0xfe | !onoff;
	ld	a,4 (ix)
	sub	a,#0x01
	ld	a,#0x00
	rla
	or	a, #0xfe
	out	(_DIVCS),a
	pop	ix
	ret
;sdexert.c:189: void sd_reset (void)
;	---------------------------------
; Function sd_reset
; ---------------------------------
_sd_reset::
;sdexert.c:192: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:193: puts ("FFFFFFFFFFFFFFFFFFFF ");
	ld	hl, #___str_12
	ex	(sp),hl
	call	_puts
;sdexert.c:194: locate (17,10);
	ld	hl, #0x0a11
	ex	(sp),hl
	call	_locate
;sdexert.c:195: puts ("Not needed           ");
	ld	hl, #___str_13
	ex	(sp),hl
	call	_puts
	pop	af
;sdexert.c:196: sd_select(0);
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:197: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:198: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:199: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:200: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:201: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:202: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:203: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:204: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:205: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:206: DIVSPI = 0xff;
	ld	a,#0xff
	out	(_DIVSPI),a
	ret
___str_12:
	.ascii "FFFFFFFFFFFFFFFFFFFF "
	.db 0x00
___str_13:
	.ascii "Not needed           "
	.db 0x00
;sdexert.c:209: BYTE sd_sendcommand (BYTE *cmd)
;	---------------------------------
; Function sd_sendcommand
; ---------------------------------
_sd_sendcommand::
	call	___sdcc_enter_ix
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;sdexert.c:211: BYTE cnt = 0,ans = 0, tout, i;
	ld	-11 (ix),#0x00
;sdexert.c:213: cmd[5] = crc7 (cmd, 5);
	ld	a,4 (ix)
	add	a, #0x05
	ld	c,a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	b,a
	push	bc
	ld	a,#0x05
	push	af
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_crc7
	pop	af
	inc	sp
	ld	a,l
	pop	bc
	ld	(bc),a
;sdexert.c:214: for (i=0;i<6;i++)
	ld	c,#0x00
00112$:
;sdexert.c:216: puthex8 (cmd[i]);
	ld	a,4 (ix)
	add	a, c
	ld	e,a
	ld	a,5 (ix)
	adc	a, #0x00
	ld	d,a
	ld	a,(de)
	ld	b,a
	push	bc
	push	bc
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_14
	push	hl
	call	_puts
	pop	af
	pop	bc
;sdexert.c:214: for (i=0;i<6;i++)
	inc	c
	ld	a,c
	sub	a, #0x06
	jr	C,00112$
;sdexert.c:219: puts ("     ");
	ld	hl,#___str_15
	push	hl
	call	_puts
	pop	af
;sdexert.c:220: while (cnt<10)
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	-2 (ix),c
	ld	-1 (ix),b
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-6 (ix),c
	ld	-5 (ix),b
	ld	-8 (ix),c
	ld	-7 (ix),b
	ld	-10 (ix),c
	ld	-9 (ix),b
	ld	e,#0x00
00109$:
	ld	a,e
	sub	a, #0x0a
	jr	NC,00111$
;sdexert.c:222: DIVSPI = cmd[0];
	ld	a,(bc)
	out	(_DIVSPI),a
;sdexert.c:223: DIVSPI = cmd[1];
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	inc	hl
	ld	a,(hl)
	out	(_DIVSPI),a
;sdexert.c:224: DIVSPI = cmd[2];
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	inc	hl
	inc	hl
	ld	a,(hl)
	out	(_DIVSPI),a
;sdexert.c:225: DIVSPI = cmd[3];
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	out	(_DIVSPI),a
;sdexert.c:226: DIVSPI = cmd[4];
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	out	(_DIVSPI),a
;sdexert.c:227: DIVSPI = cmd[5];
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	out	(_DIVSPI),a
;sdexert.c:229: ans = DIVSPI;
	in	a,(_DIVSPI)
;sdexert.c:231: do
	ld	d,#0x00
00104$:
;sdexert.c:233: ans = DIVSPI;
	in	a,(_DIVSPI)
	ld	-11 (ix),a
;sdexert.c:234: tout++;
	inc	d
;sdexert.c:235: if (tout == 255)
	ld	a,d
	inc	a
	jr	NZ,00143$
	ld	a,#0x01
	jr	00144$
00143$:
	xor	a,a
00144$:
	or	a, a
	jr	NZ,00106$
;sdexert.c:237: } while (ans & 0x80);
	bit	7, -11 (ix)
	jr	NZ,00104$
00106$:
;sdexert.c:238: cnt++;
	inc	e
;sdexert.c:239: if (tout != 255)
	or	a, a
	jr	NZ,00109$
;sdexert.c:240: break;
00111$:
;sdexert.c:243: return ans;
	ld	l,-11 (ix)
	ld	sp, ix
	pop	ix
	ret
___str_14:
	.ascii " "
	.db 0x00
___str_15:
	.ascii "     "
	.db 0x00
;sdexert.c:246: void sd_cmd0 (void)
;	---------------------------------
; Function sd_cmd0
; ---------------------------------
_sd_cmd0::
;sdexert.c:251: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:252: sd_select(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:253: ans = sd_sendcommand ("\x40\x0\x0\x0\x0\x0");
	ld	hl,#___str_16
	push	hl
	call	_sd_sendcommand
	pop	af
	ld	b,l
;sdexert.c:254: sd_select(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
	pop	bc
;sdexert.c:255: DIVSPI = 0xFF; // spare 8 clocks
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:256: locate (17,10);
	push	bc
	ld	hl,#0x0a11
	push	hl
	call	_locate
	pop	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_17
	push	hl
	call	_puts
	pop	af
	ret
___str_16:
	.ascii "@"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
___str_17:
	.ascii "                   "
	.db 0x00
;sdexert.c:260: void sd_cmd8 (void)
;	---------------------------------
; Function sd_cmd8
; ---------------------------------
_sd_cmd8::
;sdexert.c:265: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:266: sd_select(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:267: ans = sd_sendcommand ("\x48\x0\x0\x1\xaa\x0");
	ld	hl,#___str_18
	push	hl
	call	_sd_sendcommand
	pop	af
	ld	b,l
;sdexert.c:268: locate (17,10);
	push	bc
	ld	hl,#0x0a11
	push	hl
	call	_locate
	pop	af
	pop	bc
;sdexert.c:269: puthex8 (ans); puts (" ");
	push	bc
	push	bc
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_19
	push	hl
	call	_puts
	pop	af
	pop	bc
;sdexert.c:270: if (ans == 0x01)
	djnz	00102$
;sdexert.c:272: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_19
	push	hl
	call	_puts
	pop	af
;sdexert.c:273: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_19
	push	hl
	call	_puts
	pop	af
;sdexert.c:274: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_19
	push	hl
	call	_puts
	pop	af
;sdexert.c:275: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_19
	push	hl
	call	_puts
	pop	af
	jr	00103$
00102$:
;sdexert.c:278: puts ("                   ");
	ld	hl,#___str_20
	push	hl
	call	_puts
	pop	af
00103$:
;sdexert.c:280: sd_select(0);
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:281: DIVSPI = 0xFF; // spare 8 clocks
	ld	a,#0xff
	out	(_DIVSPI),a
	ret
___str_18:
	.ascii "H"
	.db 0x00
	.db 0x00
	.db 0x01
	.db 0xaa
	.db 0x00
	.db 0x00
___str_19:
	.ascii " "
	.db 0x00
___str_20:
	.ascii "                   "
	.db 0x00
;sdexert.c:284: void sd_cmd55 (void)
;	---------------------------------
; Function sd_cmd55
; ---------------------------------
_sd_cmd55::
;sdexert.c:289: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:290: sd_select(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:291: ans = sd_sendcommand ("\x77\x0\x0\x0\x0\x0");
	ld	hl,#___str_21
	push	hl
	call	_sd_sendcommand
	pop	af
	ld	b,l
;sdexert.c:292: sd_select(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
	pop	bc
;sdexert.c:293: DIVSPI = 0xFF; // spare 8 clocks
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:294: locate (17,10);
	push	bc
	ld	hl,#0x0a11
	push	hl
	call	_locate
	pop	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_22
	push	hl
	call	_puts
	pop	af
	ret
___str_21:
	.ascii "w"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
___str_22:
	.ascii "                   "
	.db 0x00
;sdexert.c:298: void sd_cmd1 (void)
;	---------------------------------
; Function sd_cmd1
; ---------------------------------
_sd_cmd1::
;sdexert.c:303: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:304: sd_select(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:305: ans = sd_sendcommand ("\x41\x0\x0\x0\x0\x0");
	ld	hl,#___str_23
	push	hl
	call	_sd_sendcommand
	pop	af
	ld	b,l
;sdexert.c:306: sd_select(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
	pop	bc
;sdexert.c:307: DIVSPI = 0xFF; // spare 8 clocks
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:308: locate (17,10);
	push	bc
	ld	hl,#0x0a11
	push	hl
	call	_locate
	pop	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_24
	push	hl
	call	_puts
	pop	af
	ret
___str_23:
	.ascii "A"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
___str_24:
	.ascii "                   "
	.db 0x00
;sdexert.c:312: void sd_acmd41 (void)
;	---------------------------------
; Function sd_acmd41
; ---------------------------------
_sd_acmd41::
;sdexert.c:317: locate (15,10);
	ld	hl,#0x0a0f
	push	hl
	call	_locate
;sdexert.c:318: sd_select(1);
	ld	h,#0x01
	ex	(sp),hl
	inc	sp
	call	_sd_select
	inc	sp
;sdexert.c:319: ans = sd_sendcommand ("\x69\x40\x0\x0\x0\x0");
	ld	hl,#___str_25
	push	hl
	call	_sd_sendcommand
	pop	af
	ld	b,l
;sdexert.c:320: sd_select(0);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_sd_select
	inc	sp
	pop	bc
;sdexert.c:321: DIVSPI = 0xFF; // spare 8 clocks
	ld	a,#0xff
	out	(_DIVSPI),a
;sdexert.c:322: locate (17,10);
	push	bc
	ld	hl,#0x0a11
	push	hl
	call	_locate
	pop	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_26
	push	hl
	call	_puts
	pop	af
;sdexert.c:324: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_26
	push	hl
	call	_puts
	pop	af
;sdexert.c:325: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_26
	push	hl
	call	_puts
	pop	af
;sdexert.c:326: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_26
	push	hl
	call	_puts
	pop	af
;sdexert.c:327: puthex8 (DIVSPI); puts (" ");
	in	a,(_DIVSPI)
	push	af
	inc	sp
	call	_puthex8
	inc	sp
	ld	hl,#___str_26
	push	hl
	call	_puts
	pop	af
	ret
___str_25:
	.ascii "i@"
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
___str_26:
	.ascii " "
	.db 0x00
;sdexert.c:336: int abs (int n)
;	---------------------------------
; Function abs
; ---------------------------------
_abs::
	call	___sdcc_enter_ix
	dec	sp
;sdexert.c:338: return (n>=0)?n:-n;
	bit	7, 5 (ix)
	jr	NZ,00103$
	ld	c,4 (ix)
	ld	b,5 (ix)
	jr	00104$
00103$:
	xor	a, a
	sub	a, 4 (ix)
	ld	c,a
	ld	a, #0x00
	sbc	a, 5 (ix)
	ld	b,a
00104$:
	ld	l, c
	ld	h, b
	inc	sp
	pop	ix
	ret
;sdexert.c:341: signed char sgn (int n)
;	---------------------------------
; Function sgn
; ---------------------------------
_sgn::
	call	___sdcc_enter_ix
	dec	sp
;sdexert.c:343: return (n>=0)?1:-1;
	bit	7, 5 (ix)
	jr	NZ,00103$
	ld	l,#0x01
	jr	00104$
00103$:
	ld	l,#0xff
00104$:
	inc	sp
	pop	ix
	ret
;sdexert.c:346: long frames (void) __naked
;	---------------------------------
; Function frames
; ---------------------------------
_frames::
;sdexert.c:357: __endasm;
	ld	a,(#23672)
	ld	l,a
	ld	a,(#23673)
	ld	h,a
	ld	a,(#23674)
	ld	e,a
	ld	d,#0
	ret
;sdexert.c:360: void pause (BYTE frames)
;	---------------------------------
; Function pause
; ---------------------------------
_pause::
	call	___sdcc_enter_ix
;sdexert.c:364: for (i=0;i!=frames;i++)
	ld	c,#0x00
00103$:
	ld	a,4 (ix)
	sub	a, c
	jr	Z,00105$
;sdexert.c:366: WAIT_VRETRACE;
	halt	
;sdexert.c:364: for (i=0;i!=frames;i++)
	inc	c
	jr	00103$
00105$:
	pop	ix
	ret
;sdexert.c:370: BYTE pause0 (void)
;	---------------------------------
; Function pause0
; ---------------------------------
_pause0::
;sdexert.c:372: LASTKEY = 0;
	ld	hl,#0x5c08
	ld	(hl),#0x00
;sdexert.c:373: while(1)
00104$:
;sdexert.c:375: WAIT_VRETRACE;
	halt	
;sdexert.c:376: if (LASTKEY != 0)
	ld	hl,#0x5c08
	ld	l,(hl)
	ld	a,l
	or	a, a
	jr	Z,00104$
;sdexert.c:377: return LASTKEY;
	ret
;sdexert.c:381: void memset (BYTE *dir, BYTE val, WORD nby)
;	---------------------------------
; Function memset
; ---------------------------------
_memset::
	call	___sdcc_enter_ix
;sdexert.c:399: __endasm;
	push	bc
	push	de
	ld	l,4(ix)
	ld	h,5(ix)
	ld	a,6(ix)
	ld	c,7(ix)
	ld	b,8(ix)
	ld	d,h
	ld	e,l
	inc	de
	dec	bc
	ld	(hl),a
	ldir
	pop	de
	pop	bc
	pop	ix
	ret
;sdexert.c:402: void memcpy (BYTE *dst, BYTE *fue, WORD nby)
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy::
	call	___sdcc_enter_ix
;sdexert.c:416: __endasm;
	push	bc
	push	de
	ld	e,4(ix)
	ld	d,5(ix)
	ld	l,6(ix)
	ld	h,7(ix)
	ld	c,8(ix)
	ld	b,9(ix)
	ldir
	pop	de
	pop	bc
	pop	ix
	ret
;sdexert.c:419: void cls (BYTE attr)
;	---------------------------------
; Function cls
; ---------------------------------
_cls::
	call	___sdcc_enter_ix
;sdexert.c:434: memset((BYTE *)16384,0,6144);
	ld	hl,#0x1800
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	h, #0x40
	push	hl
	call	_memset
	pop	af
	pop	af
	inc	sp
;sdexert.c:435: memset((BYTE *)22528,attr,768);
	ld	hl,#0x0300
	push	hl
	ld	a,4 (ix)
	push	af
	inc	sp
	ld	h, #0x58
	push	hl
	call	_memset
	pop	af
	pop	af
	inc	sp
;sdexert.c:436: SETCOLOR(attr);
	ld	hl,#0x5b04
	ld	a,4 (ix)
	ld	(hl),a
;sdexert.c:437: *((WORD *)SPOSN)=0;
	ld	hl,#0x0000
	ld	(0x5b02), hl
	pop	ix
	ret
;sdexert.c:441: void border (BYTE b)
;	---------------------------------
; Function border
; ---------------------------------
_border::
	call	___sdcc_enter_ix
;sdexert.c:443: ULA=(b>>3)&0x7;
	ld	a,4 (ix)
	rrca
	rrca
	rrca
	and	a,#0x1f
	and	a, #0x07
	out	(_ULA),a
;sdexert.c:444: *((BYTE *)BORDR)=b;
	ld	hl,#0x5b05
	ld	a,4 (ix)
	ld	(hl),a
	pop	ix
	ret
;sdexert.c:447: void puts (BYTE *str)
;	---------------------------------
; Function puts
; ---------------------------------
_puts::
	call	___sdcc_enter_ix
	push	af
	dec	sp
;sdexert.c:449: volatile BYTE over=0;
	ld	-1 (ix),#0x00
;sdexert.c:450: volatile BYTE bold=0;
	ld	-2 (ix),#0x00
;sdexert.c:451: volatile BYTE backup_attrp = *(BYTE *)(ATTRP);
	ld	hl,#0x5b04
	ld	a,(hl)
	ld	-3 (ix),a
;sdexert.c:582: __endasm;
	push	bc
	push	de
	ld	l,4(ix)
	ld	h,5(ix)
	buc_print:
	ld	a,(hl)
	or	a
	jr	nz,no_fin_print
	jp	fin_print
	no_fin_print:
	cp	#22
	jr	nz,no_at
	inc	hl
	ld	a,(hl)
	ld	(#(23298 +1)),a
	inc	hl
	ld	a,(hl)
	ld	(#(23298)),a
	inc	hl
	jr	buc_print
	no_at:
	cp	#13
	jr	nz,no_cr
	xor	a
	ld	(#(23298)),a
	ld	a,(#(23298 +1))
	inc	a
	ld	(#(23298 +1)),a
	inc	hl
	jr	buc_print
	no_cr:
	cp	#4
	jr	nz,no_attr
	inc	hl
	ld	a,(hl)
	ld	(#23300),a
	inc	hl
	jr	buc_print
	no_attr:
	cp	#5
	jr	nz,no_pr_over
	ld	-1(ix),#0xff
	inc	hl
	jr	buc_print
	no_pr_over:
	cp	#6
	jr	nz,no_pr_bold
	ld	-2(ix),#0xff
	inc	hl
	jr	buc_print
	no_pr_bold:
	cp	#32
	jr	nc,imprimible
	ld	a,#32
	imprimible:
	push	hl
	ld	hl,(#(23298))
	push	hl
	push	af
	ld	de,#16384
	add	hl,de
	ld	a,h
	and	#7
	rrca
	rrca
	rrca
	or	l
	ld	l,a
	ld	a,#248
	and	h
	ld	h,a
	pop	af
	push	hl
	ld	de,(#23606)
	ld	l,a
	ld	h,#0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,de
	pop	de
	ld	b,#8
	print_car:
	ld	a,(hl)
	sra	a
	and	-2(ix)
	or	(hl)
	ld	c,a
	ld	a,(de)
	and	-1(ix)
	xor	c
	ld	(de),a
	inc	hl
	inc	d
	djnz	print_car
	pop	hl
	push	hl
	ld	de,#22528
	ld	b,h
	ld	h,#0
	add	hl,de
	xor	a
	or	b
	jr	z,fin_ca_attr
	ld	de,#32
	calc_dirat:
	add	hl,de
	djnz	calc_dirat
	fin_ca_attr:
	ld	a,(#23300)
	ld	(hl),a
	pop	hl
	inc	l
	bit	5,l
	jr	z,no_inc_fila
	res	5,l
	inc	h
	no_inc_fila:
	ld	(#(23298)),hl
	pop	hl
	inc	hl
	jp	buc_print
	fin_print:
	pop	de
	pop	bc
;sdexert.c:584: SETCOLOR(backup_attrp);
	ld	hl,#0x5b04
	ld	a,-3 (ix)
	ld	(hl),a
	ld	sp, ix
	pop	ix
	ret
;sdexert.c:587: void locate (BYTE row, BYTE col)
;	---------------------------------
; Function locate
; ---------------------------------
_locate::
	call	___sdcc_enter_ix
;sdexert.c:589: *((BYTE *)ROW)=row;
	ld	hl,#0x5b03
	ld	a,4 (ix)
	ld	(hl),a
;sdexert.c:590: *((BYTE *)COLUMN)=col;
	ld	l, #0x02
	ld	a,5 (ix)
	ld	(hl),a
	pop	ix
	ret
;sdexert.c:617: void u16tohex (WORD n, char *s)
;	---------------------------------
; Function u16tohex
; ---------------------------------
_u16tohex::
	call	___sdcc_enter_ix
;sdexert.c:619: u8tohex((n>>8)&0xFF,s);
	ld	b,5 (ix)
	ld	c,#0x00
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	call	_u8tohex
	pop	af
	inc	sp
;sdexert.c:620: u8tohex(n&0xFF,s+2);
	ld	c,6 (ix)
	ld	b,7 (ix)
	inc	bc
	inc	bc
	ld	d,4 (ix)
	ld	e,#0x00
	push	bc
	push	de
	inc	sp
	call	_u8tohex
	pop	af
	inc	sp
	pop	ix
	ret
;sdexert.c:623: void puthex8 (BYTE v)
;	---------------------------------
; Function puthex8
; ---------------------------------
_puthex8::
	call	___sdcc_enter_ix
	push	af
	dec	sp
;sdexert.c:626: u8tohex (v,s);
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e, c
	ld	d, b
	push	bc
	push	de
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_u8tohex
	pop	af
	inc	sp
	call	_puts
	ld	sp,ix
	pop	ix
	ret
;sdexert.c:630: void u8tohex (BYTE n, char *s)
;	---------------------------------
; Function u8tohex
; ---------------------------------
_u8tohex::
	call	___sdcc_enter_ix
;sdexert.c:635: resto=n&0xF;
	ld	a,4 (ix)
	and	a, #0x0f
	ld	e,a
;sdexert.c:636: s[1]=(resto>9)?resto+55:resto+48;
	ld	c,5 (ix)
	ld	b,6 (ix)
	inc	bc
	ld	a,#0x09
	sub	a, e
	jr	NC,00103$
	ld	a,e
	add	a, #0x37
	jr	00104$
00103$:
	ld	a,e
	add	a, #0x30
00104$:
	ld	(bc),a
;sdexert.c:637: resto=n>>4;
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0f
	ld	c,a
;sdexert.c:638: s[0]=(resto>9)?resto+55:resto+48;
	ld	e,5 (ix)
	ld	d,6 (ix)
	ld	a,#0x09
	sub	a, c
	jr	NC,00105$
	ld	a,c
	add	a, #0x37
	jr	00106$
00105$:
	ld	a,c
	add	a, #0x30
00106$:
	ld	(de),a
;sdexert.c:639: s[2]='\0';
	inc	de
	inc	de
	xor	a, a
	ld	(de),a
	pop	ix
	ret
;sdexert.c:642: void wait_key (void)
;	---------------------------------
; Function wait_key
; ---------------------------------
_wait_key::
;sdexert.c:644: while ((ULA&0x1f)==0x1f);
00101$:
	in	a,(_ULA)
	and	a, #0x1f
	sub	a, #0x1f
	jr	Z,00101$
	ret
;sdexert.c:647: BYTE inkey (BYTE semif, BYTE pos)
;	---------------------------------
; Function inkey
; ---------------------------------
_inkey::
	call	___sdcc_enter_ix
;sdexert.c:652: switch (semif)
	ld	a,4 (ix)
	sub	a, #0x01
	jr	C,00109$
	ld	a,#0x08
	sub	a, 4 (ix)
	jr	C,00109$
	ld	e,4 (ix)
	dec	e
	ld	d,#0x00
	ld	hl,#00127$
	add	hl,de
	add	hl,de
	add	hl,de
	jp	(hl)
00127$:
	jp	00101$
	jp	00102$
	jp	00103$
	jp	00104$
	jp	00105$
	jp	00106$
	jp	00107$
	jp	00108$
;sdexert.c:654: case 1: teclas=SEMIFILA1; break;
00101$:
	ld	a,#>(_SEMIFILA1)
	in	a,(#<(_SEMIFILA1))
	ld	c,a
	jr	00110$
;sdexert.c:655: case 2: teclas=SEMIFILA2; break;
00102$:
	ld	a,#>(_SEMIFILA2)
	in	a,(#<(_SEMIFILA2))
	ld	c,a
	jr	00110$
;sdexert.c:656: case 3: teclas=SEMIFILA3; break;
00103$:
	ld	a,#>(_SEMIFILA3)
	in	a,(#<(_SEMIFILA3))
	ld	c,a
	jr	00110$
;sdexert.c:657: case 4: teclas=SEMIFILA4; break;
00104$:
	ld	a,#>(_SEMIFILA4)
	in	a,(#<(_SEMIFILA4))
	ld	c,a
	jr	00110$
;sdexert.c:658: case 5: teclas=SEMIFILA5; break;
00105$:
	ld	a,#>(_SEMIFILA5)
	in	a,(#<(_SEMIFILA5))
	ld	c,a
	jr	00110$
;sdexert.c:659: case 6: teclas=SEMIFILA6; break;
00106$:
	ld	a,#>(_SEMIFILA6)
	in	a,(#<(_SEMIFILA6))
	ld	c,a
	jr	00110$
;sdexert.c:660: case 7: teclas=SEMIFILA7; break;
00107$:
	ld	a,#>(_SEMIFILA7)
	in	a,(#<(_SEMIFILA7))
	ld	c,a
	jr	00110$
;sdexert.c:661: case 8: teclas=SEMIFILA8; break;
00108$:
	ld	a,#>(_SEMIFILA8)
	in	a,(#<(_SEMIFILA8))
	ld	c,a
	jr	00110$
;sdexert.c:662: default: teclas=ULA; break;
00109$:
	in	a,(_ULA)
	ld	c,a
;sdexert.c:663: }
00110$:
;sdexert.c:664: posbit=1<<(pos-1);
	ld	b,5 (ix)
	dec	b
	push	af
	ld	e,#0x01
	pop	af
	inc	b
	jr	00129$
00128$:
	sla	e
00129$:
	djnz	00128$
;sdexert.c:665: return (teclas&posbit)?0:1;
	ld	a,c
	and	a,e
	jr	Z,00113$
	ld	l,#0x00
	jr	00114$
00113$:
	ld	l,#0x01
00114$:
	pop	ix
	ret
;sdexert.c:668: void beep (WORD durmili, BYTE freq) __critical
;	---------------------------------
; Function beep
; ---------------------------------
_beep::
	ld	a,i
	di
	push	af
	call	___sdcc_enter_ix
	dec	sp
;sdexert.c:672: cborde=(*(BYTE *)(BORDR));
	ld	hl,#0x5b05
	ld	a,(hl)
	ld	-1 (ix),a
;sdexert.c:704: __endasm;
	push	bc
	push	de
	ld	l,6(ix) ;se desplaza dos byte por ser "critical".
	ld	h,7(ix)
	ld	d,-1(ix)
	ld	b,8(ix)
	xor	a
	sub	b
	ld	b,a
	ld	c,a
	bucbeep:
	ld	a,d
	xor	#0x18
	ld	d,a
	out	(#254),a
	ld	b,c
	bucperiodobeep:
	djnz	bucperiodobeep
	dec	hl
	ld	a,h
	or	l
	jr	nz,bucbeep
	pop	de
	pop	bc
	inc	sp
	pop	ix
	pop	af
	ret	PO
	ei
	ret
;sdexert.c:707: BYTE crc7 (BYTE *pc, BYTE len)
;	---------------------------------
; Function crc7
; ---------------------------------
_crc7::
	call	___sdcc_enter_ix
;sdexert.c:741: __endasm;
	push	bc
	push	de
	ld	l,4(ix)
	ld	h,5(ix)
	ld	b,6(ix)
	ld	e,#0
	buc_next_byte:
	ld	a,(hl)
	push	bc
	ld	b,#8
	buc_next_bit:
	sla	e
	ld	d,a
	xor	e
	jp	p,not_xor_crc
	ld	a,#9
	xor	e
	ld	e,a
	not_xor_crc:
	ld	a,d
	sla	a
	djnz	buc_next_bit
	pop	bc
	inc	hl
	djnz	buc_next_byte
	ld	a,e
	sla	a
	or	#1
	ld	l,a
	pop	de
	pop	bc
	pop	ix
	ret
;sdexert.c:744: void __sdcc_enter_ix (void) __naked
;	---------------------------------
; Function __sdcc_enter_ix
; ---------------------------------
___sdcc_enter_ix::
;sdexert.c:752: __endasm;
	pop	hl ; return address
	push	ix ; save frame pointer
	ld	ix,#0
	add	ix,sp ; set ix to the stack frame
	jp	(hl) ; and return
;sdexert.c:755: void getcoreid(BYTE *s)
;	---------------------------------
; Function getcoreid
; ---------------------------------
_getcoreid::
	call	___sdcc_enter_ix
	dec	sp
;sdexert.c:760: s[0]='\0';
	ld	c,4 (ix)
	ld	b,5 (ix)
	xor	a, a
	ld	(bc),a
;sdexert.c:761: ZXUNOADDR = COREID;
	push	bc
	ld	a,#0xff
	ld	bc,#_ZXUNOADDR
	out	(c),a
	pop	bc
;sdexert.c:763: while (ZXUNODATA!=0 && cont<32) cont++;
	ld	e,#0x00
00102$:
	ld	a,#>(_ZXUNODATA)
	in	a,(#<(_ZXUNODATA))
	or	a, a
	jr	Z,00104$
	ld	a,e
	sub	a, #0x20
	jr	NC,00104$
	inc	e
	jr	00102$
00104$:
;sdexert.c:764: if (cont==32)
	ld	a,e
	sub	a, #0x20
	jr	Z,00116$
	jr	00123$
;sdexert.c:765: return;
	jr	00116$
;sdexert.c:767: do
00123$:
	ld	e,#0x00
00108$:
;sdexert.c:769: letra = ZXUNODATA;
	ld	a,#>(_ZXUNODATA)
	in	a,(#<(_ZXUNODATA))
	ld	-1 (ix),a
;sdexert.c:770: cont++;
	inc	e
;sdexert.c:772: while (letra==0 && cont<32);
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00110$
	ld	a,e
	sub	a, #0x20
	jr	C,00108$
00110$:
;sdexert.c:773: if (cont==32)
	ld	a,e
	sub	a, #0x20
	jr	Z,00116$
	jr	00112$
;sdexert.c:774: return;
	jr	00116$
00112$:
;sdexert.c:775: *(s++) = letra;
	ld	a,-1 (ix)
	ld	(bc),a
	inc	bc
	ld	4 (ix),c
	ld	5 (ix),b
;sdexert.c:776: do
	ld	c,4 (ix)
	ld	b,5 (ix)
00113$:
;sdexert.c:778: letra = ZXUNODATA;
	ld	a,#>(_ZXUNODATA)
	in	a,(#<(_ZXUNODATA))
;sdexert.c:779: *(s++) = letra;
	ld	-1 (ix), a
	ld	(bc),a
	inc	bc
;sdexert.c:781: while (letra!=0);
	ld	a,-1 (ix)
	or	a, a
	jr	NZ,00113$
00116$:
	inc	sp
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
