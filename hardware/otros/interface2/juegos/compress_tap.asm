        include define.asm
        output  compress_tap.bin
    IF  address+binsize > $fd80
        org     $5ccb
com     ld      sp, $5cde
        di
        db      $de, $c0, $37, $0e, $8f, $39, $96 ; OVER USR 7 ($5ccb)
ini     ld      de, $8300
        ld      hl, fin-1
    ELSE
        org     $5b87
com     ld      de, ini
        di
        db      $de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
        ld      hl, $5ccb+21
        ld      bc, compr-ini
        push    de
        ldir
        ret
ini     ld      de, $8300
        ld      hl, $5ccb+fin-com-1
    ENDIF
        call    deexo
        ex      de, hl
        ld      bc, $4000
loop    inc     hl
        ld      a, b
        xor     c
        and     $f8
        xor     c
        ld      d, a
        xor     b
        xor     c
        rlca
        rlca
        ld      e, a
        ld      a, (hl)
        ld      (de), a
        inc     bc
        bit     7, h
        jr      z, loop
        ld      b, 3
        ldir
        ld      hl, startpc
        push    hl
        ld      de, exosize
        ld      hl, address-4
        call    $07f4
        di
        ld      de, address+binsize-1
        ld      hl, address+exosize-5
deexo   include d.asm
compr   incbin  file.rcs.exo.opt
fin
