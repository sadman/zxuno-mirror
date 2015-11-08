; ace.inc
; Z80 ASM equates for the Jupiter Ace

; 2009, January - The Jupiter Ace Archive Team -> www.jupiter-ace.co.uk


#ifndef ACE_INC
#define ACE_INC

;------------
; Characters
;------------

CharSpace    .EQU  32
INVERSE      .EQU 128

;------------
; Memory Map
;------------

; ROM
ROMCHARSET  .EQU $1D7B ; Character Set in ROM

; Video
SCREENF     .EQU $2000 ; Screen start address, CPU priority
PADF        .EQU $2301 ; PAD or Tape buffer,   CPU priority
CHARSETF    .EQU $2800 ; Character Set Table,  CPU priority
SCREEN      .EQU $2400 ; Screen start address, Video circuit priority
PAD         .EQU $2701 ; PAD or Tape buffer,   Video circuit priority
CHARSET     .EQU $2C00 ; Character Set Table,  Video circuit priority

; RAM
SYSVARS     .EQU $3C00 ; System Variables
DICTIONARY  .EQU $3C40 ; Start of RAM user area

;------------------
; System Variables
;------------------

FP_WS       .EQU $3C00 ; 19 bytes, Floating Point arithmetic workspace
LISTWS      .EQU $3C13 ;  5 bytes, LIST & EDIT workspace
RAMTOP      .EQU $3C18 ;  2 bytes, RAM top address + 1
HLD         .EQU $3C1A ;  2 bytes, Point to last formatted char #
SCRPOS      .EQU $3C1C ;  2 bytes, Print position in video RAM
INSCRN      .EQU $3C1E ;  2 bytes, Logical line start at input buffer
CURSOR      .EQU $3C20 ;  2 bytes, Cursor position at input buffer
ENDBUF      .EQU $3C22 ;  2 bytes, Logical line end at input buffer
L_HALF      .EQU $3C24 ;  2 bytes, Start of input buffer
KEYCOD      .EQU $3C26 ;  1 byte,  Last key pressed
KEYCNT      .EQU $3C27 ;  1 byte,  Keyboard scan count
STATIN      .EQU $3C28 ;  1 byte,  Keyboard shift state
EXWRCH      .EQU $3C29 ;  2 bytes, Print vector (screen=0)
FRAMES      .EQU $3C2B ;  4 bytes, Tick count (50 or 60 Hz)
XCOORD      .EQU $3C2F ;  1 byte,  Last X coordinate used by PLOT
YCOORD      .EQU $3C30 ;  1 byte,  Last Y coordinate used by PLOT
CURRENT     .EQU $3C31 ;  4 bytes, Current Vocabulary Parameter Field
CONTEXT     .EQU $3C33 ;  4 bytes, Context Vocabulary Parameter field
VOCLNK      .EQU $3C35 ;  4 bytes, Vocabulary link of the newest vocabulary
STKBOT      .EQU $3C37 ;  4 bytes, Ptr to next dictionary position
DICT        .EQU $3C39 ;  4 bytes, Ptr to Lenght field of newest word
SPARE       .EQU $3C3B ;  4 bytes, Ptr to next pos after Top of Stack
ERR_NO      .EQU $3C3D ;  1 byte,  Error Code (no error = 255)
FLAGS       .EQU $3C3E ;  1 byte,  System Status
BASE        .EQU $3C3F ;  1 byte,  System Number Base

; System Status bits (FLAGS)
ST_INCOMPLETE   .EQU %00000100 ; Incomplete definition at the dictionary
ST_TO_INPUT     .EQU %00001000 ; Output is to feed input buffer
ST_INVIS        .EQU %00010000 ; INVIS mode
ST_COMPILE      .EQU %01000000 ; Compile mode

; Keyboard Shift state bits (STATIN)
KB_EDIT         .EQU %00000001  ; Edit Mode
KB_CAPS         .EQU %00000010  ; Caps Lock
KB_GRAPH        .EQU %00000100  ; Graphics Mode
KB_INVERSE      .EQU %00001000  ; Inverse Mode

;-----
; I/O
;-----

; Keyboard input addresses
KBD_VBNM_SP     .EQU $7FFE
KBD_HJKL_EN     .EQU $BFFE
KBD_YUIOP       .EQU $DFFE
KBD_67890       .EQU $EFFE
KBD_54321       .EQU $F7FE
KBD_TREWQ       .EQU $FBFE
KBD_GFDSA       .EQU $FDFE
KBD_CXZ_SY_SH   .EQU $FEFE
; Keyboard scan bit mask
KBD_MASK        .EQU %00011111

; Speaker
SPEAKER         .EQU $FE   ; Speaker address (any even address would do)
#define  PullSpeaker   IN  A,(SPEAKER)
#define  PushSpeaker  OUT (SPEAKER),A

; Tape Sockets
TAPE_SOCKET   .EQU $FE        ; Tape Socket address (any even address would do)
EAR_MASK      .EQU %00100000  ; IN from above address
MIC_MASK      .EQU %00001000  ; OUT to above address

;-------------------
; Z80 Reset Vectors
;-------------------

#define RST_START      RST $00           ; Cold Reset
#define RST_PRINT      RST $08           ; Print char from Accumulator
#define RST_DE_TO_STK  RST $10           ; Push DE to Data stack
#define RST_STK_TO_DE  RST $18           ; Pop DE from Data Stack
#define RST_ERROR(x)   RST $20\ .BYTE x  ; Abort with error x
#define RST_INIT2      RST $28           ; Initialize routine, Part 2
#define RST_INT        RST $38           ; Frame count Interrupt

;---------------
; Coding Macros
;---------------

#define Asm2Forth  CALL  $04B9   ; Start coding in FORTH
#define AsmEnd     JP    (IY)    ; End a FORTH word definition from ASM code

;--------------
; ROM routines
;--------------

PR_LOWER          .EQU $017E
PR_BUFFER         .EQU $0196
PR_BUFFER_0       .EQU $0198
EDIT_KEY          .EQU $01E6
TOOGLE_STATIN     .EQU $01FE
CURSOR_LEFT       .EQU $0204
CURSOR_RIGHT      .EQU $0211
DEL_CURSOR        .EQU $0225
DEL_CHAR          .EQU $022C
CURSOR_UP         .EQU $0247
PR_CURSOR         .EQU $0282
CURSOR_DOWN       .EQU $0295
FIND_0            .EQU $02B0
DEL_LINE          .EQU $02C3
KEY_ENTER         .EQU $02D0
SET_BUFFER        .EQU $02D8
SET_LOGICAL_LINE  .EQU $02ED
FIND_ENDBUF       .EQU $02F4
FIND_EOL          .EQU $0302
KEYBOARD          .EQU $0310
KEYBOARD_SCAN     .EQU $0336 ; Scan keyboard and return key in the Accumulator
SCROLL            .EQU $0421 ; **
UPDISP_SCROLL     .EQU $0421 ; **
SCROLL_BLANK      .EQU $042F
SCR_PTRS          .EQU $0443
INDEX_SYSVAR      .EQU $044D
;                 .EQU $048D ; ???
DO_FORTH          .EQU $04B9
;                 .EQU $04BF ; ???
CHECK_BREAK       .EQU $04E4
;                 .EQU $0536 ; ???
GET_BUFFER        .EQU $05DF
;                 .EQU $05E1 ; ???
;                 .EQU $068A ; ???
GET_DECIMAL       .EQU $0723
SHIFT_FP          .EQU $0732
NORMALIZE         .EQU $0740
GET_NUMBER        .EQU $074C
;                 .EQU $07DA ; ???
SPACE_FILL        .EQU $07FA ; Fill with Space char. DE=start, HL=end
SPACE_FILL2       .EQU $07FE ; Fill with Space char. HL=start, DE=count
UPPERCASE         .EQU $0807 ; Convert in the Accumulator to uppercase
STK_TO_BC         .EQU $084E ; Pop top of data stack to BC
PR_STRING         .EQU $0979 ; Print String. DE=Counted String Address
PR_STRING2        .EQU $097F ; Print String. DE=String Address, BC=String Lenght
CLS               .EQU $0A24 ; Clear Screen
PLOTSUB           .EQU $0B28
BEEP              .EQU $0BA9 ; BC=1000000/(8*freq) , DE=cycles
DELAY_HL          .EQU $0BC9 ; Delay = (3341*H+13*L-3302)/3250 ms
;                 .EQU $0C99
;                 .EQU $0F2E ; Blank Stack
MEMORY_CHECK      .EQU $0F8C
CHECK_FREE_MEMORY .EQU $0F8F
MAKE_ROOM         .EQU $0F9E
RECLAIM           .EQU $14DC
;                 .EQU $14F8 ; ???
;                 .EQU $1504 ; ???
;                 .EQU $1548 ; ???
;                 .EQU $1557 ; ???
;                 .EQU $1568 ; ???
;                 .EQU $1584 ; ???
;                 .EQU $1592 ; ???
;                 .EQU $159E ; ???
;                 .EQU $15A2 ; ???
;                 .EQU $15C0 ; Get Name Field Address
WORDSTART         .EQU $15E8
INDEXER           .EQU $15FB
FIND_RAM_WORD     .EQU $1620
;                 .EQU $1708 ; ???
INDENT            .EQU $17C1
;                 .EQU $17DA ; ???
;                 .EQU $17E1 ; ???
;                 .EQU $17E4 ; ???
PR_STRING_HL      .EQU $17FB ; Print String at (HL), last char +80h
PR_INLINE         .EQU $1808 ; Print inline string, last char +80h
PR_INTEGER        .EQU $180E ; Print Integer at HL
;                 .EQU $1815 ; Print ?
;                 .EQU $18A7 ; ???
;                 .EQU $18FC ; ???
;                 .EQU $1911 ; ???
;                 .EQU $1915 ; ???
PREP_FP           .EQU $1AF4
SHIFT_ADDEND      .EQU $1B22
BCD_NEGATE        .EQU $1B43
BCD_OP_ADD        .EQU $1B53
BCD_OP_MUL        .EQU $1B55

;---------------
#endif