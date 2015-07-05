/*
Compilar con:
sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 10000
--nostdlib --nostdinc --no-std-crt0 --code-loc 8192 readspi.c
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
__sfr __at (0x7f) FULLERADDR;

__sfr __banked __at (0xf7fe) SEMIFILA1;
__sfr __banked __at (0xeffe) SEMIFILA2;
__sfr __banked __at (0xfbfe) SEMIFILA3;
__sfr __banked __at (0xdffe) SEMIFILA4;
__sfr __banked __at (0xfdfe) SEMIFILA5;
__sfr __banked __at (0xbffe) SEMIFILA6;
__sfr __banked __at (0xfefe) SEMIFILA7;
__sfr __banked __at (0x7ffe) SEMIFILA8;

#define ATTRP 23693
#define ATTRT 23695
#define BORDR 23624
#define LASTK 23560

#define WAIT_VRETRACE __asm halt __endasm
#define WAIT_HRETRACE while(ATTR!=0xff)
#define SETCOLOR(x) *(BYTE *)(ATTRP)=(x)
#define LASTKEY *(BYTE *)(LASTK)
#define ATTRPERMANENT *((BYTE *)(ATTRP))
#define ATTRTEMPORARY *((BYTE *)(ATTRT))
#define BORDERCOLOR *((BYTE *)(BORDR))

#define MAKEWORD(d,h,l) { ((BYTE *)&(d))[0] = (l) ; ((BYTE *)&(d))[1] = (h); }

__sfr __banked __at (0xfc3b) ZXUNOADDR;
__sfr __banked __at (0xfd3b) ZXUNODATA;

#define MASTERCONF  0x00
#define FLASHSPI    0x02
#define FLASHCS     0x03
#define SCANCODE    0x04
#define KEYBSTAT    0x05
#define JOYCONF     0x06
#define EXTSPI      0x82
#define EXTCS       0x83
#define SRAMDATA    0xfd
#define SRAMADDRINC 0xfc
#define SRAMADDR    0xfb
#define COREID      0xff

/* Some ESXDOS system calls */
#define HOOK_BASE   128
#define MISC_BASE   (HOOK_BASE+8)
#define FSYS_BASE   (MISC_BASE+16)
#define M_GETSETDRV (MISC_BASE+1)
#define F_OPEN      (FSYS_BASE+2)
#define F_CLOSE     (FSYS_BASE+3)
#define F_READ      (FSYS_BASE+5)
#define F_WRITE     (FSYS_BASE+6)
#define F_SEEK      (FSYS_BASE+7)
#define F_GETPOS    (FSYS_BASE+8)

#define FMODE_READ	     0x1 // Read access
#define FMODE_WRITE      0x2 // Write access
#define FMODE_OPEN_EX    0x0 // Open if exists, else error
#define FMODE_OPEN_AL    0x8 // Open if exists, if not create
#define FMODE_CREATE_NEW 0x4 // Create if not exists, if exists error
#define FMODE_CREATE_AL  0xc // Create if not exists, else open and truncate

#define SEEK_START       0
#define SEEK_CUR         1
#define SEEK_BKCUR       2

#define BUFSIZE 1024
BYTE errno;
char buffer[BUFSIZE];

BYTE main (char *p);
void getcoreid(BYTE *s);
void usage (void);
BYTE commandlinemode (char *p);

void __sdcc_enter_ix (void) __naked;
void cls (BYTE);

void puts (BYTE *);
void u16tohex (WORD n, char *s);
void u8tohex (BYTE n, char *s);
void print8bhex (BYTE n);
void print16bhex (WORD n);

void memset (BYTE *, BYTE, WORD);
void memcpy (BYTE *, BYTE *, WORD);

BYTE open (char *filename, BYTE mode);
void close (BYTE handle);
WORD read (BYTE handle, BYTE *buffer, WORD nbytes);
WORD write (BYTE handle, BYTE *buffer, WORD nbytes);
void seek (BYTE handle, WORD hioff, WORD looff, BYTE from);

/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
BYTE getfilename (char *p, char *fname, WORD *kbytes);
void copyfromspi2file (BYTE handle, WORD kbytes);

void init (void) __naked
{
     __asm
     xor a
     ld (#_errno),a
     push hl
     call _main
     inc sp
     inc sp
     ld a,l
     or a
     ret z
     scf
     ret
     __endasm;
}

BYTE main (char *p)
{
  if (!p)
  {
     usage();
     return 0;
  }
  else
      return commandlinemode(p);
}

BYTE commandlinemode (char *p)
{
    char fname[32];
    BYTE handle,res;
    WORD kbytes;

    res = getfilename (p, fname, &kbytes);
    if (!res)
       return 1;

    handle = open (fname, FMODE_WRITE | FMODE_CREATE_AL);
    if (handle==0xff)
       return errno;

    copyfromspi2file (handle, kbytes);

    close (handle);
    return 0;
}

void usage (void)
{
        // 01234567890123456789012345678901
    puts (" READSPI file.bin\xd\xd"
          "Reads a SPI Flash and store into"
          "a file.\xd");
}

BYTE hexvalue (BYTE c)
{
    if (c>='0' && c<='9')
       return c-'0';
    else
       return c-55;
}

BYTE getfilename (char *p, char *fname, WORD *kbytes)
{
    while (*p!=':' && *p!=0xd && *p!=' ')
          *fname++ = *p++;
    *fname = '\0';
    if (*p!=' ')
       return 0;
    p++;
    *kbytes = (hexvalue(*p++))<<12;
    *kbytes |= (hexvalue(*p++))<<8;
    *kbytes |= (hexvalue(*p++))<<4;
    *kbytes |= hexvalue(*p++);
    return 1;
}

void enablespi (void)
{
    ZXUNOADDR = FLASHCS;
    ZXUNODATA = 0;
}

void disablespi (void)
{
    ZXUNOADDR = FLASHCS;
    ZXUNODATA = 1;
}

void writespi (BYTE n)
{
    ZXUNOADDR = FLASHSPI;
    ZXUNODATA = n;
}

BYTE readspi (void)
{
    ZXUNOADDR = FLASHSPI;
    return ZXUNODATA;
}

void copyfromspi2file (BYTE handle, WORD kbytes)
{
    WORD i,by;

    for (i=0;i<kbytes;i++)
    {
        enablespi();
        writespi(0x03);
        writespi((i>>6)&0xFF);
        writespi((i<<2)&0xFF);
        writespi(0x00);
        readspi();

        for (by=0;by<1024;by++)
            buffer[by] = ZXUNODATA;  // readspi rapidito

        disablespi();

        write (handle, buffer, 1024);
        if ((i&0x3f) == 0x3f)
        {
            __asm
                 ld a,#'*'
                 rst #16
                 ld a,#255
                 ld (#23692),a
            __endasm;
        }    
    }
}

/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------------- */
#pragma disable_warning 85
#pragma disable_warning 59
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

void puts (BYTE *str)
{
  __asm
  push bc
  push de
  ld a,(#ATTRT)
  push af
  ld a,(#ATTRP)
  ld (#ATTRT),a
  ld l,4(ix)
  ld h,5(ix)
buc_print:
  ld a,(hl)
  or a
  jp z,fin_print
  cp #4
  jr nz,no_attr
  inc hl
  ld a,(hl)
  ld (#ATTRT),a
  inc hl
  jr buc_print
no_attr:
  rst #16
  inc hl
  jp buc_print

fin_print:
  pop af
  ld (#ATTRT),a
  pop de
  pop bc
  __endasm;
}

// void u16tohex (WORD n, char *s)
// {
//   u8tohex((n>>8)&0xFF,s);
//   u8tohex(n&0xFF,s+2);
// }
// 
// void u8tohex (BYTE n, char *s)
// {
//   BYTE i=1;
//   BYTE resto;
// 
//   resto=n&0xF;
//   s[1]=(resto>9)?resto+55:resto+48;
//   resto=n>>4;
//   s[0]=(resto>9)?resto+55:resto+48;
//   s[2]='\0';
// }
//
// void print8bhex (BYTE n)
// {
//     char s[3];
// 
//     u8tohex(n,s);
//     puts(s);
// }
// 
// void print16bhex (WORD n)
// {
//     char s[5];
// 
//     u16tohex(n,s);
//     puts(s);
// }


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

BYTE open (char *filename, BYTE mode)
{
    __asm
    push bc
    push de
    xor a
    rst #8
    .db #M_GETSETDRV   ;Default drive in A
    ld l,4(ix)  ;Filename pointer
    ld h,5(ix)  ;in HL
    ld b,6(ix)  ;Open mode in B
    rst #8
    .db #F_OPEN
    jr nc,open_ok
    ld (#_errno),a
    ld a,#0xff
open_ok:
    ld l,a
    pop de
    pop bc
    __endasm;
}

void close (BYTE handle)
{
    __asm
    push bc
    push de
    ld a,4(ix)  ;Handle
    rst #8
    .db #F_CLOSE
    pop de
    pop bc
    __endasm;
}

WORD read (BYTE handle, BYTE *buffer, WORD nbytes)
{
    __asm
    push bc
    push de
    ld a,4(ix)  ;File handle in A
    ld l,5(ix)  ;Buffer address
    ld h,6(ix)  ;in HL
    ld c,7(ix)
    ld b,8(ix)  ;Buffer length in BC
    rst #8
    .db #F_READ
    jr nc,read_ok
    ld (#_errno),a
    ld bc,#65535
read_ok:
    ld h,b
    ld l,c
    pop de
    pop bc
    __endasm;
}

WORD write (BYTE handle, BYTE *buffer, WORD nbytes)
{
    __asm
    push bc
    push de
    ld a,4(ix)  ;File handle in A
    ld l,5(ix)  ;Buffer address
    ld h,6(ix)  ;in HL
    ld c,7(ix)
    ld b,8(ix)  ;Buffer length in BC
    rst #8
    .db #F_WRITE
    jr nc,write_ok
    ld (#_errno),a
    ld bc,#65535
write_ok:
    ld h,b
    ld l,c
    pop de
    pop bc
    __endasm;
}

void seek (BYTE handle, WORD hioff, WORD looff, BYTE from)
{
    __asm
    push bc
    push de
    ld a,4(ix)  ;File handle in A
    ld c,5(ix)  ;Hiword of offset in BC
    ld b,6(ix)
    ld e,7(ix)  ;Loword of offset in DE
    ld d,8(ix)
    ld l,9(ix)  ;From where: 0: start, 1:forward current pos, 2: backwards current pos
    rst #8
    .db #F_SEEK
    pop de
    pop bc
    __endasm;
}

void getcoreid(BYTE *s)
{
  BYTE cont;
  volatile BYTE letra;

  ZXUNOADDR = COREID;
  cont=0;

  do
  {
    letra = ZXUNODATA;
    *(s++) = letra;
    cont++;
  }
  while (letra!=0 && cont<32);
  *s='\0';
}
