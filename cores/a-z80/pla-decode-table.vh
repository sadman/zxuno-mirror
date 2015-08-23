if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[2] == 1'b0) pla[  0] = 1'b1; else pla[  0] = 1'b0;		// ldx/cpx/inx/outx brk
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[  1] = 1'b1; else pla[  1] = 1'b0;		// exx
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[  2] = 1'b1; else pla[  2] = 1'b0;		// ex de,hl
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[  3] = 1'b1; else pla[  3] = 1'b0;		// IX/IY prefix
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[  4] = 1'b1; else pla[  4] = 1'b0;		// ld x,a/a,x
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[  5] = 1'b1; else pla[  5] = 1'b0;		// ld sp,hl
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[  6] = 1'b1; else pla[  6] = 1'b0;		// jp hl
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[  7] = 1'b1; else pla[  7] = 1'b0;		// ld rr,nn
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[  8] = 1'b1; else pla[  8] = 1'b0;		// ld (rr),a/a,(rr)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[  9] = 1'b1; else pla[  9] = 1'b0;		// inc/dec rr
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 10] = 1'b1; else pla[ 10] = 1'b0;		// ex (sp),hl
if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 11] = 1'b1; else pla[ 11] = 1'b0;		// cpi/cpir/cpd/cpdr
if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 12] = 1'b1; else pla[ 12] = 1'b0;		// ldi/ldir/ldd/lddr
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 13] = 1'b1; else pla[ 13] = 1'b0;		// ld direction
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 14] = 1'b1; else pla[ 14] = 1'b0;		// dec rr
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 15] = 1'b1; else pla[ 15] = 1'b0;		// rrd/rld
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 16] = 1'b1; else pla[ 16] = 1'b0;		// push rr
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 17] = 1'b1; else pla[ 17] = 1'b0;		// ld r,n
if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 20] = 1'b1; else pla[ 20] = 1'b0;		// outx/otxr
if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 21] = 1'b1; else pla[ 21] = 1'b0;		// inx/inxr
if (prefix[6] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 22] = 1'b1; else pla[ 22] = 1'b0;		// CB prefix w/o IX/IY
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[3] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 23] = 1'b1; else pla[ 23] = 1'b0;		// push/pop
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 24] = 1'b1; else pla[ 24] = 1'b0;		// call nn
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 25] = 1'b1; else pla[ 25] = 1'b0;		// rlca/rla/rrca/rra
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 26] = 1'b1; else pla[ 26] = 1'b0;		// djnz e
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0) pla[ 27] = 1'b1; else pla[ 27] = 1'b0;		// in/out r,(c)
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 28] = 1'b1; else pla[ 28] = 1'b0;		// out (n),a
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 29] = 1'b1; else pla[ 29] = 1'b0;		// jp nn
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 30] = 1'b1; else pla[ 30] = 1'b0;		// ld hl,(nn)/(nn),hl
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 31] = 1'b1; else pla[ 31] = 1'b0;		// ld rr,(nn)/(nn),rr
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 33] = 1'b1; else pla[ 33] = 1'b0;		// ld direction
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 34] = 1'b1; else pla[ 34] = 1'b0;		// out (c),r
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 35] = 1'b1; else pla[ 35] = 1'b0;		// ret
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 37] = 1'b1; else pla[ 37] = 1'b0;		// out (n),a/a,(n)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 38] = 1'b1; else pla[ 38] = 1'b0;		// ld (nn),a/a,(nn)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 39] = 1'b1; else pla[ 39] = 1'b0;		// ex af,af'
if (prefix[5] == 1'b1 && prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 40] = 1'b1; else pla[ 40] = 1'b0;		// ld (ix+d),n
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 42] = 1'b1; else pla[ 42] = 1'b0;		// call cc,nn
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 43] = 1'b1; else pla[ 43] = 1'b0;		// jp cc,nn
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 44] = 1'b1; else pla[ 44] = 1'b0;		// CB prefix
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 45] = 1'b1; else pla[ 45] = 1'b0;		// ret cc
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 46] = 1'b1; else pla[ 46] = 1'b0;		// reti/retn
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 47] = 1'b1; else pla[ 47] = 1'b0;		// jr e
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 48] = 1'b1; else pla[ 48] = 1'b0;		// jr ss,e
if (prefix[5] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 49] = 1'b1; else pla[ 49] = 1'b0;		// CB prefix with IX/IY
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 50] = 1'b1; else pla[ 50] = 1'b0;		// ld (hl),n
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 51] = 1'b1; else pla[ 51] = 1'b0;		// ED prefix
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 52] = 1'b1; else pla[ 52] = 1'b0;		// add/sub/and/or/xor/cp (hl)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b0) pla[ 53] = 1'b1; else pla[ 53] = 1'b0;		// inc/dec (hl)
if (prefix[5] == 1'b1 && prefix[1] == 1'b1) pla[ 54] = 1'b1; else pla[ 54] = 1'b0;		// Every CB with IX/IY
if (prefix[1] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 55] = 1'b1; else pla[ 55] = 1'b0;		// Every CB op (hl)
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 56] = 1'b1; else pla[ 56] = 1'b0;		// rst p
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 57] = 1'b1; else pla[ 57] = 1'b0;		// ld i,a/r,a
if (prefix[4] == 1'b1 && prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 58] = 1'b1; else pla[ 58] = 1'b0;		// ld r,(hl)
if (prefix[4] == 1'b1 && prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0) pla[ 59] = 1'b1; else pla[ 59] = 1'b0;		// ld (hl),r
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1) pla[ 61] = 1'b1; else pla[ 61] = 1'b0;		// ld r,r'
if (prefix[1] == 1'b1) pla[ 62] = 1'b1; else pla[ 62] = 1'b0;		// For all CB opcodes
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 64] = 1'b1; else pla[ 64] = 1'b0;		// add/sub/and/or/xor/cmp a,imm
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0) pla[ 65] = 1'b1; else pla[ 65] = 1'b0;		// add/sub/and/or/xor/cmp a,r
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b0) pla[ 66] = 1'b1; else pla[ 66] = 1'b0;		// inc/dec r
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 67] = 1'b1; else pla[ 67] = 1'b0;		// in
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 68] = 1'b1; else pla[ 68] = 1'b0;		// adc/sbc hl,rr
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 69] = 1'b1; else pla[ 69] = 1'b0;		// add hl,rr
if (prefix[1] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0) pla[ 70] = 1'b1; else pla[ 70] = 1'b0;		// rlc r
if (prefix[1] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1) pla[ 72] = 1'b1; else pla[ 72] = 1'b0;		// bit b,r
if (prefix[1] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0) pla[ 73] = 1'b1; else pla[ 73] = 1'b0;		// res b,r
if (prefix[1] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1) pla[ 74] = 1'b1; else pla[ 74] = 1'b0;		// set b,r
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b1) pla[ 75] = 1'b1; else pla[ 75] = 1'b0;		// dec r
if (prefix[3] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b1) pla[ 76] = 1'b1; else pla[ 76] = 1'b0;		// 111 (CP)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 77] = 1'b1; else pla[ 77] = 1'b0;		// daa
if (prefix[3] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b0) pla[ 78] = 1'b1; else pla[ 78] = 1'b0;		// 010 (SUB)
if (prefix[3] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[3] == 1'b1) pla[ 79] = 1'b1; else pla[ 79] = 1'b0;		// 011 (SBC)
if (prefix[3] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b1) pla[ 80] = 1'b1; else pla[ 80] = 1'b0;		// 001 (ADC)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 81] = 1'b1; else pla[ 81] = 1'b0;		// cpl
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b0 && opcode[0] == 1'b0) pla[ 82] = 1'b1; else pla[ 82] = 1'b0;		// neg
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 83] = 1'b1; else pla[ 83] = 1'b0;		// ld a,i/a,r
if (prefix[3] == 1'b1 && opcode[5] == 1'b0 && opcode[4] == 1'b0 && opcode[3] == 1'b0) pla[ 84] = 1'b1; else pla[ 84] = 1'b0;		// 000 (ADD)
if (prefix[3] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b0) pla[ 85] = 1'b1; else pla[ 85] = 1'b0;		// 100 (AND)
if (prefix[3] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0) pla[ 86] = 1'b1; else pla[ 86] = 1'b0;		// 110 (OR)
if (prefix[3] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b0 && opcode[3] == 1'b1) pla[ 88] = 1'b1; else pla[ 88] = 1'b0;		// 101 (XOR)
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 89] = 1'b1; else pla[ 89] = 1'b0;		// ccf
if (prefix[0] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1) pla[ 91] = 1'b1; else pla[ 91] = 1'b0;		// inx/outx/inxr/otxr
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b0 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 92] = 1'b1; else pla[ 92] = 1'b0;		// scf
if (prefix[2] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[3] == 1'b0 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 95] = 1'b1; else pla[ 95] = 1'b0;		// halt
if (prefix[0] == 1'b1 && opcode[7] == 1'b0 && opcode[6] == 1'b1 && opcode[2] == 1'b1 && opcode[1] == 1'b1 && opcode[0] == 1'b0) pla[ 96] = 1'b1; else pla[ 96] = 1'b0;		// im n
if (prefix[2] == 1'b1 && opcode[7] == 1'b1 && opcode[6] == 1'b1 && opcode[5] == 1'b1 && opcode[4] == 1'b1 && opcode[2] == 1'b0 && opcode[1] == 1'b1 && opcode[0] == 1'b1) pla[ 97] = 1'b1; else pla[ 97] = 1'b0;		// di/ei
if (opcode[0] == 1'b1) pla[ 99] = 1'b1; else pla[ 99] = 1'b0;		// opcode[0]
if (opcode[1] == 1'b1) pla[100] = 1'b1; else pla[100] = 1'b0;		// opcode[1]
if (opcode[2] == 1'b1) pla[101] = 1'b1; else pla[101] = 1'b0;		// opcode[2]
if (opcode[3] == 1'b1) pla[102] = 1'b1; else pla[102] = 1'b0;		// opcode[3]
if (opcode[4] == 1'b1) pla[103] = 1'b1; else pla[103] = 1'b0;		// opcode[4]
if (opcode[5] == 1'b1) pla[104] = 1'b1; else pla[104] = 1'b0;		// opcode[5]
