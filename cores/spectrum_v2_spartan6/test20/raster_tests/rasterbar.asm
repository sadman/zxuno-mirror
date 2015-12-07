                    org 8000h   ;32768

ZXUNOADDR           equ 0fch
ZXUNODATA           equ 0fdh
ULAPLUSADDR         equ 0bfh
ULAPLUSDATA         equ 0ffh

RASTERLINE          equ 0ch
RASTERCTRL          equ 0dh
RASTERSTAT          equ 0dh

VECTORADDR          equ 80ffh

RasterLineTable     ds 22   ;(color + next raster line) * 7 + color

Main                di
                    ld a,80h
                    ld i,a
                    im 2
                    jp Init

                    org VECTORADDR
                    dw NewVertInt

Init                xor a
                    out (254),a

                    ld bc,7ffdh
                    ld a,16+7        ;make shadow screen available on C000-FFFF
                    out (c),a
                    ld (23388),a     ;Backup

                    ld hl,Scr1
                    ld de,4000h
                    ld bc,1800h
                    ldir
                    ld hl,5800h
                    ld de,5801h
                    ld bc,767
                    ld (hl),00111000b   ;bitmap will use palette entries 15 (paper) and 0 (ink)
                    ldir

                    ;The same for the shadow screen
                    ld hl,Scr2
                    ld de,0C000h
                    ld bc,1800h
                    ldir
                    ld hl,0C000h+1800h
                    ld de,0C000h+1801h
                    ld bc,767
                    ld (hl),00111000b   ;bitmap will use palette entries 15 (paper) and 0 (ink)
                    ldir

                    ld c,03bh   ;ZXI ports
                    ld b,ULAPLUSADDR
                    ld a,15
                    out (c),a
                    ld b,ULAPLUSDATA
                    ld a,255    ;paper white
                    out (c),a
                    ld b,ULAPLUSADDR
                    ld a,0
                    out (c),a
                    ld b,ULAPLUSDATA
                    ld a,0      ;ink black
                    out (c),a
                    ld b,ULAPLUSADDR
                    ld a,64
                    out (c),a
                    ld b,ULAPLUSDATA
                    ld a,1      ;enable ULAPLUS
                    out (c),a

                    ei

InfiniteLoop        halt
                    jp InfiniteLoop

NewRasterIntSinPaper
                    ld a,(hl)
                    out (c),a   ;update palette entry 8 on ULAPLUS
                    inc hl
                    ld a,l
                    cp 22       ;if bar is complete drawn, go to vertical retrace int setup
                    jp z,PrepareVertIntSP
                    ld e,(hl)   ;update next scan for retrace interrupt
                    inc hl
                    ld d,(hl)
                    inc hl
                    ld b,ZXUNOADDR
                    ld a,RASTERLINE
                    out (c),a
                    inc b
                    out (c),e
                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    out (c),d
                    ld b,ULAPLUSDATA
                    ei
                    reti
PrepareVertIntSP    ld hl,NewVertInt
                    ld (VECTORADDR),hl
                    ei
                    reti

NewRasterIntConPaper
                    out (c),a   ;update palette entry 8 on ULAPLUS
                    exx
                    out (c),d
                    ld b,l
                    out (c),a
                    ld b,h
                    out (c),e
                    ld b,l
                    out (c),a
                    ld b,h
                    exx

                    inc hl
                    ld a,l
                    cp 22       ;if bar is complete drawn, go to vertical retrace int setup
                    jp z,PrepareVertIntCC
                    ld e,(hl)   ;update next scan for retrace interrupt
                    inc hl
                    ld d,(hl)
                    inc hl
                    ld b,ZXUNOADDR
                    ld a,RASTERLINE
                    out (c),a
                    inc b
                    out (c),e
                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    out (c),d
                    ld b,ULAPLUSADDR
                    ld a,8
                    out (c),a
                    ld b,ULAPLUSDATA
                    ld a,(hl)    ;Prepare color for next update
                    ei
                    reti

PrepareVertIntCC    ld a,(23388)
                    xor 8
                    ld (23388),a
                    ld bc,7ffdh
                    out (c),a        ;antigua (la que va desapareciendo)
                    ld c,03bh

                    ld hl,NewVertInt
                    ld (VECTORADDR),hl
                    ld b,ULAPLUSADDR
                    ld e,15
                    out (c),e
                    ld b,ULAPLUSDATA
                    ld a,255
                    out (c),a
                    ld b,ULAPLUSADDR
                    ld e,0
                    out (c),e
                    ld b,ULAPLUSDATA
                    ld a,0
                    out (c),a
                    ei
                    reti

BorderColors        db 00000001b,00000011b,00011011b,00011111b,00011111b,00011011b,00000011b,000000001b

SineValues          dw 287, 288, 288, 288, 288, 288, 289, 289, 290, 290, 291, 292, 293, 294, 295, 296
                    dw 297, 298, 299, 300, 302, 303, 305, 306, 308, 309, 311, 1, 3, 5, 7, 9, 11
                    dw 13, 15, 17, 19, 22, 24, 26, 29, 31, 34, 36, 39, 42, 44, 47, 50
                    dw 52, 55, 58, 61, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96
                    dw 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, 128, 130, 133, 136, 139, 141
                    dw 144, 147, 149, 152, 155, 157, 160, 162, 165, 167, 169, 172, 174, 176, 178, 180
                    dw 182, 184, 186, 188, 190, 192, 194, 195, 197, 198, 200, 201, 203, 204, 205, 206
                    dw 207, 208, 209, 210, 211, 212, 213, 213, 214, 214, 215, 215, 215, 215, 215, 216
                    dw 215, 215, 215, 215, 215, 214, 214, 213, 213, 212, 211, 210, 209, 208, 207, 206
                    dw 205, 204, 203, 201, 200, 198, 197, 195, 194, 192, 190, 188, 186, 184, 182, 180
                    dw 178, 176, 174, 172, 169, 167, 165, 162, 160, 157, 155, 152, 149, 147, 144, 141
                    dw 139, 136, 133, 130, 128, 125, 122, 119, 116, 113, 110, 107, 104, 101, 98, 95
                    dw 93, 90, 87, 84, 81, 78, 75, 72, 69, 66, 63, 61, 58, 55, 52, 50
                    dw 47, 44, 42, 39, 36, 34, 31, 29, 26, 24, 22, 19, 17, 15, 13, 11
                    dw 9, 7, 5, 3, 1, 311, 309, 308, 306, 305, 303, 302, 300, 299, 298, 297
                    dw 296, 295, 294, 293, 292, 291, 290, 290, 289, 289, 288, 288, 288, 288, 288


NewVertInt          ld a,(BarDirection)   ;0 up, 255 down
                    or a
                    jr z,NotUpdateScreen

                    ld a,(23388)
                    xor 8
                    ld (23388),a
                    ld bc,7ffdh
                    out (c),a       ;nueva (la que va apareciendo)

NotUpdateScreen     ld a,(CurrentSineValue)
                    ld l,a
                    ld h,0
                    add hl,hl
                    ld de,SineValues
                    add hl,de   ;HL = SineValues + CurrentSineValue*2 . points to a sine value word
                    ld e,(hl)
                    inc hl
                    ld d,(hl)  ;DE = SineValue read from table
                    push de    ;we will use later in this routine

                    inc a
                    ld (CurrentSineValue),a

                    ld hl,RasterLineTable  ;(color + next raster line) * 7 + color
                    ld c,0
                    ld b,7     ;The bar is composed of 8 lines. Each line is composed of 2 raster lines
CalcRasterLine        push de
                      ld e,c
                      inc c    ;Advance current border color
                      ld d,0
                      ld ix,BorderColors
                      add ix,de
                      ld a,(ix)
                      ld (hl),a
                      inc hl
                      pop de
                      inc de
                      inc de     ;two raster lines
                      push hl
                      ld hl,311
                      sbc hl,de  ;is DE > 311
                      jr nc,NotAbove311
                      ex de,hl
                      ld hl,0
                      or a
                      sbc hl,de
                      ex de,hl  ;DE = DE - 312
NotAbove311           pop hl
                      ld (hl),e
                      inc hl
                      ld a,d
                      or 2       ;D will be outputted to RASTERCTRL, so we activate bit 1 as well
                      ld (hl),a
                      inc hl
                    djnz CalcRasterLine

                    ld e,c
                    inc c    ;Advance current border color
                    ld d,0
                    ld ix,BorderColors
                    add ix,de
                    ld a,(ix)
                    ld (hl),a
                    inc hl

                    pop de    ;recover next raster line
                    ld c,3bh  ;ZXI ports
                    ld b,ZXUNOADDR
                    ld a,RASTERLINE
                    out (c),a
                    inc b
                    out (c),e
                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    ld a,d
                    or 2
                    out (c),a

                    or a
                    ld hl,287
                    sbc hl,de
                    jr nz,NoLinea287
                    ld hl,NewRasterIntConPaper
                    ld (NoLinea216+1),hl  ;patch address of routine for retrace int
                    ld a,255
                    ld (BarDirection),a
                    ld a,(23388)
                    xor 8    ;but don't update I/O port...
                    ld (23388),a

NoLinea287          or a
                    ld hl,216
                    sbc hl,de
                    jr nz,NoLinea216
                    ld hl,NewRasterIntSinPaper
                    ld (NoLinea216+1),hl  ;patch address of routine for retrace int
                    ld a,0
                    ld (BarDirection),a

NoLinea216          ld hl,0
                    ld (VECTORADDR),hl

                    ld hl,RasterLineTable
                    ld b,ULAPLUSADDR
                    ld a,8
                    out (c),a
                    ld b,ULAPLUSDATA   ;prepare for outputting palette value asap
                    exx
                    ld d,0fh
                    ld e,00h
                    ld h,ULAPLUSADDR
                    ld l,ULAPLUSDATA
                    ld b,h
                    ld c,03bh
                    exx
                    ld a,(hl)   ;Prepare color for next update
                    ei
                    ret

CurrentSineValue    db 0
BarDirection        db 255

Scr1                equ $
                    incbin "tiosfeos.bin"

Scr2                equ $
                    incbin "zelda.bin"

                    end Main
