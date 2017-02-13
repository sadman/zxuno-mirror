                    org 8000h

ZXUNOADDR           equ 0fch
ZXUNODATA           equ 0fdh
ZXIBASEPORT         equ 3bh

MASTERCONF          equ 00h
SCANDBLCTRL         equ 0bh
RASTERLINE          equ 0ch
RASTERCTRL          equ 0dh
RASTERSTAT          equ 0dh

SPECDRUM            equ 0dfh

VECTORADDR          equ 80ffh

Main                di
                    exx
                    push hl
                    exx
                    ld a,80h
                    ld i,a
                    im 2
                    jp Init

                    org VECTORADDR
                    dw NewRasterInt

Init                ld b,ZXUNOADDR
                    ld c,ZXIBASEPORT
                    ld a,MASTERCONF
                    out (c),a
                    inc b
                    in a,(c)
                    ld (MasterConf),a
                    and 10101111b ;ULA mode = 48K (311 scanlines)
                    or  00100000b ;no contention
                    out (c),a

                    dec b
                    ld a,SCANDBLCTRL
                    out (c),a
                    inc b
                    in a,(c)
                    ld (ScanDoubler),a
                    or 11000000b  ;maximum Z80 speed
                    out (c),a

                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    ld a,110b  ;raster int ON, vertical int OFF
                    out (c),a

                    exx
                    ld hl,1    ;next raster
                    ld b,ZXUNOADDR
                    ld c,ZXIBASEPORT
                    ld d,RASTERLINE
                    ld e,RASTERCTRL
                    exx
                    ld hl,Sample
                    ei

Forever             ld bc,7ffeh   ;SPACE halfrow
                    in e,(c)
                    bit 0,e
                    jp nz,Forever

                    di
                    ld b,ZXUNOADDR
                    ld c,ZXIBASEPORT
                    ld a,MASTERCONF
                    out (c),a
                    inc b
                    ld a,(MasterConf)
                    out (c),a

                    dec b
                    ld a,SCANDBLCTRL
                    out (c),a
                    inc b
                    ld a,(ScanDoubler)
                    out (c),a

                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    xor a
                    out (c),a
                    im 1
                    exx
                    pop hl
                    exx
                    ei
                    ret

NewRasterInt        di
                    exx   ;C=ZXIPORT, D=RASTERLINE, E=RASTERCTRL, B=ZXUNOADDR, HL=line no.
                    out (c),d  ;rasterline
                    inc b
                    out (c),l  ;send MSB of next rasterline
                    dec b
                    out (c),e  ;rasterctrl
                    ld a,h
                    or 110b    ;keep ints going
                    inc b
                    out (c),a  ;send MSB plus ctrl
                    dec b
                    inc hl
                    bit 0,h
                    jp z,NotReset
                    ld a,56
                    cp l
                    jp nz,NotReset
                    ld hl,0
NotReset            exx
                    ld a,(hl)
                    add a,80h
                    out (SPECDRUM),a
                    inc hl
                    ld a,h
                    or 0c0h
                    ld h,a
                    ei
                    reti
                    
MasterConf          db 0
ScanDoubler         db 0                    

                    org 0c000h
Sample              equ $
                    incbin "piano_c4.raw"

                    end Main
