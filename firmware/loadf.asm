        output  loadf.bin
      macro wreg  dir, dato
        call    rst20
        defb    dir, dato
      endm
        define  zxuno_port      $fc3b
        define  flash_spi       2
        define  flash_cs        3
        org     $8000-22
        ld      de, fin-1
        di
        defb    $de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
        ld      hl, fin-l8000+$5ccb+21
        ld      bc, fin-l8000
        lddr
        jp      l8000
l8000   xor     a
        ld      hl, rom
        ld      bc, zxuno_port+$100
        exx
        ld      de, $02c0
        ld      bc, zxuno_port+$100
savec1  wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 6    ; envío write enable
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, $20  ; envío sector erase
        out     (c), d
        out     (c), e
        out     (c), a
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
savec2  call    waitst
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 6    ; envío write enable
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 2    ; page program
        out     (c), d
        out     (c), e
        out     (c), a
        ld      a, $20
        exx
savec3  inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        inc     b
        outi
        dec     a
        jr      nz, savec3
        exx
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        inc     e
        jr      z, savec4
        ld      a, e
        and     $0f
        jr      nz, savec2
        call    waitst
        jr      savec1
savec4  ld      a, 2
        out     ($fe), a
        halt
rst20   pop     hl
        outi
        ld      b, (zxuno_port >> 8)+2
        outi
        jp      (hl)
waitst  wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 5    ; envío read status
        in      a, (c)
waits1  in      a, (c)
        and     1
        jr      nz, waits1
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        ret
rom     incbin  firmware.rom
fin