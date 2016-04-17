        define  SPI_PORT        $eb
        output  example.bin
        org     $5ccb
        defb    0, 0, 0, 0
        defb    $de, $c0, $37, $0e, $8f, $39, $ac ;OVER USR 7 ($5cd6)

init    ld      hl, msg
        ld      b, 8
prmsg   ld      a, (hl)
        inc     hl
        rst     $10
        djnz    prmsg
waitk   ld      a, $fd
        in      a, ($fe)
        rrca
        jr      c, waitk
        ld      c, SPI_PORT
        ld      hl, 0
        ld      ix, $8000
        call    readat0
        ld      hl, $8000
repe    ld      a, (hl)
        rrca
        rrca
        rrca
        rrca
        call    rdigit
        rst     $10
        ld      a, (hl)
        call    rdigit
        rst     $10
        ld      a, ' '
        rst     $10
        inc     hl
        ld      a, l
        and     7
        jr      nz, line
        ld      a, 13
        rst     $10
line    bit     4, l
        jr      z, repe
waitnk  ld      a, $fd
        in      a, ($fe)
        rrca
        jr      nc, waitnk
        jr      init

rdigit  and     $0f
        or      $30
        cp      $3a
        ret     c
        add     a, 7
        ret

msg     defb    'Press A', 13

        include sd.asm
