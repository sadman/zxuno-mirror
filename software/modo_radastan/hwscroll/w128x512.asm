;Example of warp-around scroll with a virtual screen of 128x512 pixels
;You can use any other bitmap provided that:
;- it is 128 x 512 pixels
;- it uses 4bpp (16 colours) paletized mode
;- it is flipped vertically just before saveing it
;- it is saved as a BMP file (which flips the image again so at the end it is in its correct position)
;- File length should be 32886 bytes, including BMP headers and palette

; To be assembled with PASMO --tapbas

RADASOFFSET    equ 41h
ZXUNOADDR      equ 0fch
ZXUNODATA      equ 0fdh
ZXIBASEADDR    equ 3bh

StartPoint     org 30000
Main           di

               ;Convert BMP palette to ULAplus palette entry
               ld hl,Pantalla+36h  ;BMP palette offset. Format is BGRA
               ld bc,0bf3bh
               ld e,0
BucPaleta      out (c),e
               ld b,0ffh
               ld a,(hl)   ; blue
               sra a
               sra a
               sra a
               sra a
               sra a
               sra a
               and 3
               ld d,a
               inc hl
               ld a,(hl)   ; green
               and 11100000b
               or d
               ld d,a
               inc hl
               ld a,(hl)   ; red
               sra a
               sra a
               sra a
               and 00011100b
               or d
               out (c),a
               inc hl
               inc hl      ; skip the alpha byte
               ld b,0bfh
               inc e
               ld a,e
               cp 16
               jr nz,BucPaleta

               ;set Radastan mode
               ld b,0fch
               ld a,64
               out (c),a
               ld b,0fdh
               ld a,3
               out (c),a

               ld a,3  ; <-- change accordingly with the palette you loaded
               out (254),a

               ;dummy interrupt handler
               ld a,82h
               ld i,a
               im 2

               ;transfer upper half of screen to make room at $8000 to put the rest of the code there
               ld hl,Pantalla+118 ;offset to actual start of bitmap
               ld de,16384
               ld bc,8192
               ldir

               ld hl,CodeAt8000
               ld de,8000h
               ld bc,LCode8000
               ldir
               jp 8000h

CodeAt8000     ld sp,0c000h
               ld hl,Pantalla+118+8192  ;about to transfer the remaining part of the screen
               ld de,24576
               ld bc,8192
               ldir
               ;now I have all RAM from $8000 to $BFFF for my code
               ld hl,NuevaIM2-CodeAt8000+8000h
               ld (82FFh),hl  ;set IM 2 vector

               ld hl,16384 ;screen offset.
               ld de,49152 ;backbuffer offset.

               ei
LoopScroll     halt

               ;interchange scans from/to screen to/from backbuffer
               ld b,64
LoopTransfer   ld c,(hl)
               ld a,(de)
               ld (hl),a
               ld a,c
               ld (de),a
               inc hl
               inc de
               djnz LoopTransfer

               ;adjust HL and DE
               ld a,h
               and 00111111b
               or  01000000b
               ld h,a
               ld a,d
               and 00111111b
               or  11000000b
               ld d,a

               ;move current view (hardware scroll)
               ld bc,ZXUNOADDR*256+ZXIBASEADDR
               ld a,RADASOFFSET
               out (c),a
               inc b
               out (c),l
               ld a,h
               and 00111111b  ;RADAS offset begins at 0, not at 16384
               out (c),a

               jr LoopScroll

NuevaIM2       rept 8
               nop
               endm
               ei
               ret

LCode8000      equ $-CodeAt8000

               org 32650
Pantalla       equ $
               incbin "foto128x512_inv.bmp"  ; <-- put here the BMP you want to use

               end Main
