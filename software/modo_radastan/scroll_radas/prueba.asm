ULAPLUSADDR      equ 48955
ULAPLUSDATA      equ 65339

                 org 32768
                 
Main             proc
                 ld hl,1366   ;una dirección cualquiera de la ROM
                 ld d,0

BucPonPaleta     ld bc,ULAPLUSADDR
                 out (c),d
                 ld bc,ULAPLUSDATA
                 ld a,(hl)
                 out (c),a
                 inc hl
                 inc d
                 ld a,d
                 cp 64
                 jr nz,BucPonPaleta

                 ld bc,ULAPLUSADDR
                 out (c),d
                 ld bc,ULAPLUSDATA
                 ld a,3   ;Modo radastaniano
                 out (c),a

                 ld hl,0
                 ld de,16384
                 ld bc,6144
                 ldir

Forever          halt
                 call ScrollHor2
                 jp Forever
                 endp

ScrollHor1       proc
                 ld hl,16384+63
                 ld de,63
                 ld b,96
BucScroll1linea  rept 63
                   rld
                   dec hl
                 endm
                 rld
                 and 0fh
                 ld c,a
                 add hl,de
                 ld a,(hl)
                 and 0f0h
                 or c
                 ld (hl),a
                 inc hl
                 add hl,de

                 dec b
                 jp nz,BucScroll1linea
                 ret
                 endp

ScrollHor2       proc
                 ld hl,16385
                 ld de,16384
                 ld b,96

BucScroll2linea  push bc
                 ld a,(de)

                 rept 63
                   ldi
                 endm

                 ld (de),a

                 inc hl
                 inc de
                 pop bc
                 dec b
                 jp nz,BucScroll2linea
                 ret
                 endp

                 end 32768
