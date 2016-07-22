        define  SPI_PORT        $eb
        define  OUT_PORT        $e7
        define  MMC_0           $fe
        define  CMD0            $40
        define  CMD1            $41
        define  CMD8            $48
        define  SET_BLOCKLEN    $50
        define  READ_SINGLE     $51
        define  CMD41           $69
        define  CMD55           $77
        define  CMD58           $7a

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
        ld      b, 32
        ld      hl, $81c0
zero    ld      (hl), 0
        inc     hl
        djnz    zero
waitk   ld      a, $fd
        in      a, ($fe)
        rrca
        jr      c, waitk
        call    mmcinit
        ld      iy, $5c3a

        ld      hl, 0
;        ld      de, 0
        ld      ix, $8000
        call    readat0

        ld      a, ($8000)           ; read first type
        cp      $eb
        jr      nz, conmbr
        ld      hl, $8000
        jr      repe
conmbr  ld      hl, ($81c6)     ; read LBA address of 1st partition
        ld      ix, $81d0
        call    readat0
        ld      hl, $81c0
repe    ld      a, (hl)
        call    rbyte
        bit     5, l
        jr      z, repe
waitnk  ld      a, $fd
        in      a, ($fe)
        rrca
        jr      nc, waitnk
        jr      init
rbyte   push    af
        rrca
        rrca
        rrca
        rrca
        call    rdigit
        rst     $10
        pop     af
        call    rdigit
        rst     $10
        ld      a, ' '
        rst     $10
        inc     hl
        ld      a, l
        and     7
        ret     nz
        ld      a, 13
        rst     $10
        ret
rdigit  and     $0f
        or      $30
        cp      $3a
        ret     c
        add     a, 7
        ret
        include sd.asm
msg     defb    'Press A', 13
sdhc    defb    0
