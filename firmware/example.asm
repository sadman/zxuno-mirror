        define  SPI_PORT        $eb
        define  OUT_PORT        $e7
        define  MMC_0           $fe ; D0 LOW = SLOT0 active
        define  IDLE_STATE      $40
        define  OP_COND         $41
        define  CMD8            $48
        define  SET_BLOCKLEN    $50
        define  READ_SINGLE     $51
        define  CMD41           $69
        define  CMD55           $77

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
        ld      bc, 16<<8 | SPI_PORT
        ld      hl, $81c0
zero    ld      (hl), 0
        inc     hl
        djnz    zero
waitk   ld      a, $fd
        in      a, ($fe)
        rrca
        jr      c, waitk
        ld      hl, 0
        ld      ix, $8000
        call    readat0
        ld      hl, $81c0
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
