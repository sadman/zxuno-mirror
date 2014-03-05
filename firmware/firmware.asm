
        OUTPUT  firmware.rom

        di
        ld      hl, finlog-1
        ld      de, $58ff
        call    dzx7b           ; descomprimir

        inc     l
        inc     hl
        ld      b, $40          ; filtro RCS inverso
        jr      loop
        jp      prnstr
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
        bit     3, b
        jr      z, loop

        inc     e               ; limpiar los 2/3 inferiores
        ld      h, b
        ld      b, $10
        ld      (hl), l
        ldir
        inc     d
        inc     h
        ld      (hl), $47
        ld      b, 2
        ldir

        ld      ix, cad1        ; imprimir cadenas BOOT screen
        ld      bc, $0909
        rst     $10
        ld      bc, $0d02
        rst     $10
        ld      bc, $0e02
        rst     $10
        ld      bc, $1000
        rst     $10
        ld      bc, $1100
        rst     $10
        ld      bc, $1200
        rst     $10
        ld      bc, $130b
        rst     $10
        ld      bc, $1400
        rst     $10
        ld      bc, $1700
        rst     $10

binf    jr      binf

cad1    defm    'http://zxuno.speccy.org', 0
cad2    defm    'ZX-Uno BIOS v0.100', 0
cad3    defm    'Copyright ', 127, ' 2014 ZX-Uno team', 0
cad4    defm    'Processor: Z80 3.5MHz', 0
cad5    defm    'Memory:    512K Ok', 0
cad6    defm    'Graphics:  normal, hi-color', 0
cad7    defm    'hi-res, ULAplus', 0
cad8    defm    'Booting:   Amstrad +3 ROM 4.0 English', 0
cad9    defm    'Press <F2> to Setup    <Esc> for Boot Menu', 0

; -----------------------------------------------------------------------------
; Compressed and RCS filtered logo
; -----------------------------------------------------------------------------
        incbin  logo256x64.rcs.zx7b
finlog

; -----------------------------------------------------------------------------
; ZX7 Backwards by Einar Saukas, Antonio Villena
; Parameters:
;   HL: source address (compressed data)
;   DE: destination address (decompressing)
; -----------------------------------------------------------------------------
dzx7b   ld      bc, $8000
        ld      a, b
copyby  inc     c
        ldd
mainlo  add     a, a
        call    z, getbit
        jr      nc, copyby
        push    de
        ld      d, c
        defb    $30
lenval  add     a, a
        call    z, getbit
        rl      c
        rl      b
        add     a, a
        call    z, getbit
        jr      nc, lenval
        inc     c
        jr      z, exitdz
        ld      e, (hl)
        dec     hl
        sll     e
        jr      nc, offend
        ld      d, $10
nexbit  add     a, a
        call    z, getbit
        rl      d
        jr      nc, nexbit
        inc     d
        srl     d
offend  rr      e
        ex      (sp), hl
        ex      de, hl
        adc     hl, de
        lddr
exitdz  pop     hl
        jr      nc, mainlo
getbit  ld      a, (hl)
        dec     hl
        adc     a, a
        ret

        block   $2f2e-$

; -----------------------------------------------------------------------------
; Print string routine
; Parameters:
;   B: Y coord
;   C: X coord
;  IX: null terminated string
; -----------------------------------------------------------------------------
prnstr  ld      a, c
        and     %11111100
        ld      d, a
        xor     c
        ld      e, a
        jr      z, prnch1
        dec     e
prnch1  xor     $fc
        ld      l, a
        ld      h, prnstr>>8
        ld      l, (hl)
        push    hl
        ld      a, d
        rrca
        ld      d, a
        rrca
        add     a, d
        add     a, e
        ld      e, a
        ld      a, b
        and     %00011000
        or      %01000000
        ld      d, a
        ld      a, b
        and     %00000111
        rrca
        rrca
        rrca
        add     a, e
        ld      e, a
        ret
pos0    ld      a, (ix)
        inc     ix
        add     a, a
        ret     z
        ld      l, a
        ld      h, 3
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ld      bc, $0408
pos00   ldi
        dec     e
        inc     d
        ldi
        dec     e
        inc     d
        djnz    pos00
        ld      hl, $f800
        add     hl, de
        ex      de, hl
pos1    ld      a, (ix)
        inc     ix
        add     a, a
        ret     z
        ld      l, a
        ld      h, 3
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        set     3, l
        set     4, l
        ld      bc, $04fc
pos10   ld      a, (de)
        xor     (hl)
        and     c
        xor     (hl)
        ld      (de), a
        inc     e
        ld      a, (hl)
        and     c
        ld      (de), a
        inc     d
        inc     l
        ld      a, (hl)
        and     c
        ld      (de), a
        dec     e
        ld      a, (de)
        xor     (hl)
        and     c
        xor     (hl)
        ld      (de), a
        inc     d
        inc     l
        djnz    pos10
        ld      hl, $f801
        add     hl, de
        ex      de, hl
pos2    ld      a, (ix)
        inc     ix
        add     a, a
        ret     z
        ld      l, a
        ld      h, 3
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        set     4, l
        ld      bc, $04f0
pos20   ld      a, (de)
        xor     (hl)
        and     c
        xor     (hl)
        ld      (de), a
        inc     e
        ld      a, (hl)
        and     c
        ld      (de), a
        inc     d
        inc     l
        ld      a, (hl)
        and     c
        ld      (de), a
        dec     e
        ld      a, (de)
        xor     (hl)
        and     c
        xor     (hl)
        ld      (de), a
        inc     d
        inc     l
        djnz    pos20
        ld      hl, $f801
        add     hl, de
        ex      de, hl
pos3    ld      a, (ix)
        inc     ix
        add     a, a
        ret     z
        ld      l, a
        ld      h, 3
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        set     3, l
        ld      b, 4
pos30   ld      a, (de)
        xor     (hl)
        ld      (de), a
        inc     d
        inc     l
        ld      a, (de)
        xor     (hl)
        ld      (de), a
        inc     d
        inc     l
        djnz    pos30
        ld      hl, $f801
        add     hl, de
        ex      de, hl
        jp      pos0

        defb    pos0 & $ff
        defb    pos1 & $ff
        defb    pos2 & $ff
        defb    pos3 & $ff

; -----------------------------------------------------------------------------
; 6x8 character set (128 characters x 4 rotations)
; -----------------------------------------------------------------------------
chrset  incbin  fuente6x8.bin
