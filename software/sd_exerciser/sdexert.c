/*
Compilar con:
sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node X
--alow-unsafe-reads --nostdlib --nostdinc --no-std-crt0 --out-fmt-s19
--port-mode=z80 --code-loc 32768 --data-loc 0 --stack-loc 65535 ficherofuente.c
*/


/*
  80 o más clocks con SS=1, MOSI=0xFF
  ans = CMD0
  ans = CMD8
  if (ans == 5)
    sdhc = 0
  else if (ans == 1)
    sdhc = 1
    
  ans = CMD55
  if (ans == 5)
    legacy = 1
    ans = CMD1
  else if (ans == 1)
    legacy = 0
    ans = ACMD41
    
  if (sdhc == 0)
    CMD16 (512 bytes)
*/

typedef unsigned char BYTE;
typedef unsigned short WORD;

enum {IBLACK=0, IBLUE, IRED, IMAG, IGREEN, ICYAN, IYELLOW, IWHITE};
enum {PBLACK=0, PBLUE=8, PRED=16, PMAG=24, PGREEN=32, PCYAN=40, PYELLOW=48, PWHITE=56};
#define BRIGHT 64
#define FLASH 128

__sfr __at (0xfe) ULA;
__sfr __at (0xff) ATTR;
__sfr __at (0x1f) KEMPSTONADDR;

__sfr __banked __at (0xf7fe) SEMIFILA1;
__sfr __banked __at (0xeffe) SEMIFILA2;
__sfr __banked __at (0xfbfe) SEMIFILA3;
__sfr __banked __at (0xdffe) SEMIFILA4;
__sfr __banked __at (0xfdfe) SEMIFILA5;
__sfr __banked __at (0xbffe) SEMIFILA6;
__sfr __banked __at (0xfefe) SEMIFILA7;
__sfr __banked __at (0x7ffe) SEMIFILA8;

#define COORDS 23296
#define SPOSN 23298
#define ATTRP 23300
#define BORDR 23301
#define CHARS 23606
#define LASTK 23560

#define COLUMN (SPOSN)
#define ROW (SPOSN+1)

#define WAIT_VRETRACE __asm halt __endasm
#define WAIT_HRETRACE while(ATTR!=0xff)
#define SETCOLOR(x) *(BYTE *)(ATTRP)=(x)
#define LASTKEY *(BYTE *)(LASTK)
#define SETCHARS(x) *(BYTE **)(CHARS)=((x)-256)

__sfr __banked __at (0xfc3b) ZXUNOADDR;
__sfr __banked __at (0xfd3b) ZXUNODATA;
#define COREID 255

void __sdcc_enter_ix (void) __naked;
void cls (BYTE);
void border (BYTE);
void locate (BYTE, BYTE);

void puts (BYTE *);
void putdec (WORD);
void puthex8 (BYTE v);
void u16todec (WORD, char *);
void u16tohex (WORD, char *);
void u8tohex (BYTE, char *);

void memset (BYTE *, BYTE, WORD);
void memcpy (BYTE *, BYTE *, WORD);

int abs (int);
signed char sgn (int);

long frames (void) __naked;
void pause (BYTE);
BYTE pause0 (void);

void wait_key (void);
BYTE inkey (BYTE, BYTE);

void beep (WORD, BYTE) __critical;
void getcoreid(BYTE *s);
BYTE crc7 (BYTE *pc, BYTE len);

__sfr __at (0xe7) DIVCS;
__sfr __at (0xeb) DIVSPI;

BYTE sd_sendcommand (BYTE *cmd);
void sd_select (BYTE onoff);
void sd_reset (void);
void sd_cmd0 (void);
void sd_cmd1 (void);
void sd_cmd8 (void);
void sd_cmd55 (void);
void sd_acmd41 (void);
void elementos_estaticos (void);
void setup_chars (void);
BYTE elegir_opcion (void);

/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */

BYTE font[768];

/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */

void main (void)
{
  BYTE salir;

  border(IBLACK);
  cls(BRIGHT|PBLACK|IWHITE);

  setup_chars();
  while(1)
  {
    elementos_estaticos();
    salir = elegir_opcion();
    if (salir)
       break;
  }
  border(*(BYTE *)(23624));
  cls(*(BYTE *)(23693));
}

void setup_chars (void)
{
  WORD i;

  memcpy (font, (BYTE *)15616, 768);
  font['-'*8+4-256] = 255;
  for (i='|'*8;i<'|'*8+8;i++)
      font[i-256] = 16;
  SETCHARS(font);
}

void elementos_estaticos (void)
{
  locate (0,0);
  puts ("\x6\x4\x46          SD EXERCISER          ");
  locate (1,0);
  puts ("--------------------------------");

  locate (2,0);
  puts ("A. \x4\x45Init sequence (80+ clocks)\r");
  puts ("B. CMD0.   \x4\x45GO_IDLE_STATE\r");
  puts ("C. CMD1.   \x4\x45\r");
  puts ("D. CMD8.   \x4\x45SEND_IF_COND\r");
  puts ("E. CMD16.  \x4\x45SET_BLOCKLEN\r");
  puts ("F. CMD55.  \x4\x45""APP_CMD\r");
  puts ("G. ACMD41. \x4\x45SD_SEND_OP_COND\r");

  locate (13,0);
  puts ("--------------------------------");

  locate (15,0);
  puts ("\x4\x46""Cmd     :");

  locate (17,0);
  puts ("\x4\x46Response:");
}

BYTE elegir_opcion (void)
{
  BYTE key;

  locate (23,0);
  puts ("\x4\x44""ENTER YOUR CHOICE");
  key = pause0();
  switch (key)
  {
    case 'a':
    case 'A': sd_reset(); break;
    case 'b':
    case 'B': sd_cmd0(); break;
    case 'c':
    case 'C': sd_cmd1(); break;
    case 'd':
    case 'D': sd_cmd8(); break;
    case 'f':
    case 'F': sd_cmd55(); break;
    case 'g':
    case 'G': sd_acmd41(); break;
  }
  return 0;
}

void sd_select (BYTE onoff)
{
  DIVCS = 0xfe | !onoff;
}

void sd_reset (void)
{
  // 80+ clocks, CS not asserted
  locate (15,10);
  puts ("FFFFFFFFFFFFFFFFFFFF ");
  locate (17,10);
  puts ("Not needed           ");
  sd_select(0);
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
}

BYTE sd_sendcommand (BYTE *cmd)
{
  BYTE cnt = 0,ans = 0, tout, i;

  cmd[5] = crc7 (cmd, 5);
  while (cnt<10)
  {
    DIVSPI = cmd[0];
    DIVSPI = cmd[1];
    DIVSPI = cmd[2];
    DIVSPI = cmd[3];
    DIVSPI = cmd[4];
    DIVSPI = cmd[5];

    ans = DIVSPI;
    tout = 0;
    do
    {
      ans = DIVSPI;
      tout++;
      if (tout == 255)
         break;
    } while (ans & 0x80);
    cnt++;
    if (tout != 255)
       break;
  }

  return ans;
}

void sd_cmd0 (void)
{
  BYTE ans;

  // 40 00 00 00 00 95 - Response: 01
  sd_select(1);
  ans = sd_sendcommand ("\x40\x0\x0\x0\x0\x0");
  sd_select(0);
  DIVSPI = 0xFF; // spare 8 clocks
  locate (15,10);
  for (i=0;i<6;i++)
  {
    puthex8 (cmd[i]);
    puts (" ");
  }
  puts ("     ");
  locate (17,10);
  puthex8 (ans); puts ("                   ");
}

void sd_cmd8 (void)
{
  BYTE ans;

  // 00 00 01 AA - Response: 01 00 00 01 AA
  sd_select(1);
  ans = sd_sendcommand ("\x48\x0\x0\x1\xaa\x0");
  locate (15,10);
  for (i=0;i<6;i++)
  {
    puthex8 (cmd[i]);
    puts (" ");
  }
  puts ("     ");
  locate (17,10);
  puthex8 (ans); puts (" ");
  if (ans == 0x01)
  {
    puthex8 (DIVSPI); puts (" ");
    puthex8 (DIVSPI); puts (" ");
    puthex8 (DIVSPI); puts (" ");
    puthex8 (DIVSPI); puts (" ");
  }
  else
    puts ("                   ");

  sd_select(0);
  DIVSPI = 0xFF; // spare 8 clocks
}

void sd_cmd55 (void)
{
  BYTE ans;

  // 77 00 00 00 00 00 - Response: 01
  sd_select(1);
  ans = sd_sendcommand ("\x77\x0\x0\x0\x0\x0");
  sd_select(0);
  DIVSPI = 0xFF; // spare 8 clocks
  locate (15,10);
  for (i=0;i<6;i++)
  {
    puthex8 (cmd[i]);
    puts (" ");
  }
  puts ("     ");
  locate (17,10);
  puthex8 (ans); puts ("                   ");
}

void sd_cmd1 (void)
{
  BYTE ans;

  // 41 00 00 00 00 00 - Response: ??
  sd_select(1);
  ans = sd_sendcommand ("\x41\x0\x0\x0\x0\x0");
  sd_select(0);
  DIVSPI = 0xFF; // spare 8 clocks
  locate (15,10);
  for (i=0;i<6;i++)
  {
    puthex8 (cmd[i]);
    puts (" ");
  }
  puts ("     ");
  locate (17,10);
  puthex8 (ans); puts ("                   ");
}

void sd_acmd41 (void)
{
  BYTE ans;

  // 69 40 00 00 00 00 - Response: 00
  sd_select(1);
  ans = sd_sendcommand ("\x69\x40\x0\x0\x0\x0");
  sd_select(0);
  DIVSPI = 0xFF; // spare 8 clocks
  locate (15,10);
  for (i=0;i<6;i++)
  {
    puthex8 (cmd[i]);
    puts (" ");
  }
  puts ("     ");
  locate (17,10);
  puthex8 (ans); puts (" ");
  puthex8 (DIVSPI); puts (" ");
  puthex8 (DIVSPI); puts (" ");
  puthex8 (DIVSPI); puts (" ");
  puthex8 (DIVSPI); puts (" ");
}

BYTE sd_init (BYTE *rev20, BYTE *legacy)
{
  BYTE ans, tout;

  sd_select(0);
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;
  DIVSPI = 0xff;

  sd_select(1);
  tout = 0;
  do  // CMD0
  {
    ans = sd_sendcommand ("\x40\x0\x0\x0\x0\x0");
    tout++;
  } while (tout<10 && ans != 0x01);
  if (ans != 0x01)
  {
    sd_select(0);
    return ans;
  }
  DIVSPI = 0xFF;

  tout = 0;
  do  // CMD8
  {
    ans = sd_sendcommand ("\x48\x0\x0\x1\xaa\x0");
    tout++;
  } while (tout<10 && ans != 0x01 && ans != 0x05);
  if (ans == 0x01)
  {
    ans = DIVSPI;
    ans = DIVSPI;
    ans = DIVSPI;
    ans = DIVSPI;
    *rev20 = 1;
    sd_select(0);
    DIVSPI = 0xFF;
  }
  else if (ans == 0x05)
  {
    *rev20 = 0;
    sd_select(0);
    DIVSPI = 0xFF;
  }
  else
  {
    sd_select(0);
    return ans;
  }

  tout = 0;
  do  // CMD55
  {
    ans = sd_sendcommand ("\x77\x0\x0\x0\x0\x0");
    tout++;
  } while (tout<10 && ans != 0x01 && ans != 0x05);
  if (ans != 0x01 && ans != 0x05)
  {
    sd_select(0);
    return ans;
  }
  DIVSPI = 0xFF;
  
  if (ans == 0x05)
     *legacy = 1;
  else
      *legacy = 0;







/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
#pragma disable_warning 85
int abs (int n)
{
  return (n>=0)?n:-n;
}

signed char sgn (int n)
{
  return (n>=0)?1:-1;
}

long frames (void) __naked
{
  __asm
  ld a,(#23672)
  ld l,a
  ld a,(#23673)
  ld h,a
  ld a,(#23674)
  ld e,a
  ld d,#0
  ret
  __endasm;
}

void pause (BYTE frames)
{
  BYTE i;

  for (i=0;i!=frames;i++)
  {
    WAIT_VRETRACE;
  }
}

BYTE pause0 (void)
{
  LASTKEY = 0;
  while(1)
  {
    WAIT_VRETRACE;
    if (LASTKEY != 0)
       return LASTKEY;
  }
}

void memset (BYTE *dir, BYTE val, WORD nby)
{
  __asm
  push bc
  push de
  ld l,4(ix)
  ld h,5(ix)
  ld a,6(ix)
  ld c,7(ix)
  ld b,8(ix)
  ld d,h
  ld e,l
  inc de
  dec bc
  ld (hl),a
  ldir
  pop de
  pop bc
  __endasm;
}

void memcpy (BYTE *dst, BYTE *fue, WORD nby)
{
  __asm
  push bc
  push de
  ld e,4(ix)
  ld d,5(ix)
  ld l,6(ix)
  ld h,7(ix)
  ld c,8(ix)
  ld b,9(ix)
  ldir
  pop de
  pop bc
  __endasm;
}

void cls (BYTE attr)
{
#ifdef USEROM
  __asm
  push bc
  push de
  ld a,4(ix)
  ld (#ATTRP),a
  call #0x0d6b
  ld a,#0xfe
  call #0x1601
  pop de
  pop bc
  __endasm;
#else
  memset((BYTE *)16384,0,6144);
  memset((BYTE *)22528,attr,768);
  SETCOLOR(attr);
  *((WORD *)SPOSN)=0;
#endif
}

void border (BYTE b)
{
  ULA=(b>>3)&0x7;
  *((BYTE *)BORDR)=b;
}

void puts (BYTE *str)
{
  volatile BYTE over=0;
  volatile BYTE bold=0;
  volatile BYTE backup_attrp = *(BYTE *)(ATTRP);

  __asm
  push bc
  push de
  ld l,4(ix)
  ld h,5(ix)
buc_print:
  ld a,(hl)
  or a
  jr nz,no_fin_print
  jp fin_print
no_fin_print:
  cp #22
  jr nz,no_at
  inc hl
  ld a,(hl)
  ld (#ROW),a
  inc hl
  ld a,(hl)
  ld (#COLUMN),a
  inc hl
  jr buc_print
no_at:
  cp #13
  jr nz,no_cr
  xor a
  ld (#COLUMN),a
  ld a,(#ROW)
  inc a
  ld (#ROW),a
  inc hl
  jr buc_print
no_cr:
  cp #4
  jr nz,no_attr
  inc hl
  ld a,(hl)
  ld (#ATTRP),a
  inc hl
  jr buc_print
no_attr:
  cp #5
  jr nz,no_pr_over
  ld -1(ix),#0xff
  inc hl
  jr buc_print
no_pr_over:
  cp #6
  jr nz,no_pr_bold
  ld -2(ix),#0xff
  inc hl
  jr buc_print
no_pr_bold:
  cp #32
  jr nc,imprimible
  ld a,#32
imprimible:
  push hl
  ld hl,(#COLUMN)
  push hl
  push af
  ld de,#16384
  add hl,de
  ld a,h
  and #7
  rrca
  rrca
  rrca
  or l
  ld l,a
  ld a,#248
  and h
  ld h,a
  pop af
  push hl
  ld de,(#CHARS)
  ld l,a
  ld h,#0
  add hl,hl
  add hl,hl
  add hl,hl
  add hl,de
  pop de

  ld b,#8
print_car:
  ld a,(hl)
  sra a
  and -2(ix)
  or (hl)
  ld c,a
  ld a,(de)
  and -1(ix)
  xor c
  ld (de),a
  inc hl
  inc d
  djnz print_car

  pop hl
  push hl
  ld de,#22528
  ld b,h
  ld h,#0
  add hl,de
  xor a
  or b
  jr z,fin_ca_attr
  ld de,#32
calc_dirat:
  add hl,de
  djnz calc_dirat
fin_ca_attr:
  ld a,(#ATTRP)
  ld (hl),a
  pop hl
  inc l
  bit 5,l
  jr z,no_inc_fila
  res 5,l
  inc h
no_inc_fila:
  ld (#COLUMN),hl
  pop hl
  inc hl
  jp buc_print

fin_print:
  pop de
  pop bc
  __endasm;

  SETCOLOR(backup_attrp);
}

void locate (BYTE row, BYTE col)
{
  *((BYTE *)ROW)=row;
  *((BYTE *)COLUMN)=col;
}

// void putdec (WORD n)
// {
//   BYTE num[6];
//
//   u16todec (n,num);
//   puts (num);
// }
//
// void u16todec (WORD n, char *s)
// {
//   BYTE i=4;
//   WORD divisor=10, resto;
//
//   memset(s,' ',5);
//   do
//   {
//     resto=n%divisor;
//     n/=divisor;
//     s[i--]=resto+'0';
//   }
//   while (n);
//   s[5]='\0';
// }

void u16tohex (WORD n, char *s)
{
  u8tohex((n>>8)&0xFF,s);
  u8tohex(n&0xFF,s+2);
}

void puthex8 (BYTE v)
{
  char s[3];
  u8tohex (v,s);
  puts (s);
}

void u8tohex (BYTE n, char *s)
{
  BYTE i=1;
  BYTE resto;

  resto=n&0xF;
  s[1]=(resto>9)?resto+55:resto+48;
  resto=n>>4;
  s[0]=(resto>9)?resto+55:resto+48;
  s[2]='\0';
}

void wait_key (void)
{
  while ((ULA&0x1f)==0x1f);
}

BYTE inkey (BYTE semif, BYTE pos)
{
  BYTE teclas;
  BYTE posbit;

  switch (semif)
  {
    case 1: teclas=SEMIFILA1; break;
    case 2: teclas=SEMIFILA2; break;
    case 3: teclas=SEMIFILA3; break;
    case 4: teclas=SEMIFILA4; break;
    case 5: teclas=SEMIFILA5; break;
    case 6: teclas=SEMIFILA6; break;
    case 7: teclas=SEMIFILA7; break;
    case 8: teclas=SEMIFILA8; break;
    default: teclas=ULA; break;
  }
  posbit=1<<(pos-1);
  return (teclas&posbit)?0:1;
}

void beep (WORD durmili, BYTE freq) __critical
{
  volatile BYTE cborde;

  cborde=(*(BYTE *)(BORDR));
  __asm
  push bc
  push de

  ld l,6(ix)  ;se desplaza dos byte por ser "critical".
  ld h,7(ix)
  ld d,-1(ix)

  ld b,8(ix)
  xor a
  sub b
  ld b,a
  ld c,a

bucbeep:
  ld a,d
  xor #0x18
  ld d,a
  out (#254),a

  ld b,c
bucperiodobeep:
  djnz bucperiodobeep

  dec hl
  ld a,h
  or l
  jr nz,bucbeep

  pop de
  pop bc
  __endasm;
}

BYTE crc7 (BYTE *pc, BYTE len)
{
  __asm
  push bc
  push de
  ld l,4(ix)
  ld h,5(ix)
  ld b,6(ix)
  ld e,#0
buc_next_byte:
  ld a,(hl)
  push bc
  ld b,#8
buc_next_bit:
  sla e
  ld d,a
  xor e
  jp p,not_xor_crc
  ld a,#9
  xor e
  ld e,a
not_xor_crc:
  ld a,d
  sla a
  djnz buc_next_bit
  pop bc
  inc hl
  djnz buc_next_byte
  ld a,e
  sla a
  or #1
  ld l,a
  pop de
  pop bc
  __endasm;
}

void __sdcc_enter_ix (void) __naked
{
    __asm
    pop	hl	; return address
    push ix	; save frame pointer
    ld ix,#0
    add	ix,sp	; set ix to the stack frame
    jp (hl)	; and return
    __endasm;
}

void getcoreid(BYTE *s)
{
  BYTE cont;
  volatile BYTE letra;

  s[0]='\0';
  ZXUNOADDR = COREID;
  cont=0;
  while (ZXUNODATA!=0 && cont<32) cont++;
  if (cont==32)
     return;
  cont=0;
  do
  {
    letra = ZXUNODATA;
    cont++;
  }
  while (letra==0 && cont<32);
  if (cont==32)
     return;
  *(s++) = letra;
  do
  {
    letra = ZXUNODATA;
    *(s++) = letra;
  }
  while (letra!=0);
}
