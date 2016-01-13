        include define.asm
        output  compress_tap.bin
        org     $5ccb
    IF address = $5b00
com     ld      de, $ff40
        di
        db      $de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
        ld      hl, $5ccb+21
        ld      bc, deexo-ini
        push    de
        ldir
        ret
ini     ld      de, $82ff
    ELSE
      IF address+binsize > $fd80
com     ld      sp, $5cde
      ELSE
com     ld      de, $82ff
      ENDIF
        di
        db      $de, $c0, $37, $0e, $8f, $39, $96 ; OVER USR 7 ($5ccb)
      IF address+binsize > $fd80
        ld      de, $82ff
      ENDIF
    ENDIF
        ld      hl, fin-1
        call    deexo
        ex      de, hl
        ld      bc, $3fff
loop    ld      a, b
        xor     c
        and     $f8
        xor     c
        ld      d, a
        xor     b
        xor     c
        rlca
        rlca
        ld      e, a
        inc     bc
        ldi
        inc     bc
        bit     7, h
        jr      z, loop
        ld      b, 3
        ldir
        ld      de, exosize
      IF address = $5b00
        ld      hl, compr
        call    $07f4
        di
        ld      de, $ff30
        ld      hl, compr+exosize-1
        call    deexo
        inc     de
        ex      de, hl
        ld      de, address
        ld      bc, binsize
        ldir
        jp      startpc
      ELSE
        ld      hl, startpc
        push    hl
        ld      hl, address-7
        call    $07f4
        di
        ld      de, address+binsize-1
        ld      hl, address+exosize-8
      ENDIF
deexo   include d.asm
compr   incbin  file.rcs.exo.opt
fin
