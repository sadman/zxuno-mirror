        include define.asm
        output  compress_tap.bin
    IF  address+binsize > $fd80
        org     $5ccb
com     ld      sp, $5ccb
        di
        db      $de, $c0, $37, $0e, $8f, $39, $96 ; OVER USR 7 ($5ccb)
ini     ld      de, $5aff
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
ini     ld      de, $5aff
        ld      hl, $5ccb+fin-com-1
    ENDIF
        call    deexo
        ld      b, $02
        dec     e
next    ld      d, $57
loop    ld      h, d
        ld      a, e
        djnz    conv2
        rrca
        rrca
        ld      c, a
        xor     d
        and     $07
        xor     d
        ld      h, a
        xor     d
        xor     c
conv2   ld      l, a
        rlca
        rrc     h
        rla
        rl      h
        ld      c, a
        xor     l
        and     $05
        xor     l
        rrca
        rrca
        xor     c
        and     $67
        xor     c
        ld      l, a
        sbc     hl, de
        jr      nc, skip
        add     hl, de
        ld      c, (hl)
        ld      a, (de)
        ld      (hl), a
        ld      a, c
        ld      (de), a
skip    inc     b
        dec     de
        bit     5, d
        jr      z, loop
        djnz    next
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
