
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

        jr      clean
        jp      rdflsh
clean   inc     e               ; limpiar los 2/3 inferiores
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
        ld      bc, $020d
        rst     $10
        inc     c
        rst     $10
        ld      bc, $0010
        rst     $10
        inc     c
        rst     $10
        inc     c
        rst     $10
        ld      bc, $0b13
        rst     $10
        ld      bc, $0014
        rst     $10
        ld      bc, $0017
        rst     $10

        ld      hl, $2950
        ld      de, $8800
        ld      bc, $0022
        rst     $28
        ld      hl, $2980
        ld      de, $8000
        ld      bc, $0800
        rst     $28
        ld      bc, $fefe
        in      a, (c)
        rrca
        jr      c, noesc
        ld      b, $7f
        in      a, (c)
        rrca
        jr      c, noesc

        call    clrscr
        ld      a, %01001111    ; fondo azul tinta blanca
        ld      hl, $0103       ; coordenadas X e Y
        ld      de, $1c0c       ; anchura y altura de ventana
        call    window
        ld      ix, cad2
        ld      bc, $0203
        rst     $10             ; ------------------
        inc     c
        rst     $10             ; Please select
        inc     c
        rst     $10             ; |----------------|
        inc     c
        push    ix
        push    ix
        rst     $10             ; |                |
        inc     c
        pop     ix
        rst     $10             ; |                |
        inc     c
        pop     ix
        rst     $10             ; |                |
        inc     c
        rst     $10             ; | Enter Setup
        ld      ix, cad3
        inc     c
        rst     $10             ; |----------------|
        ld      ix, cad5
        inc     c
        rst     $10             ; | U and D move s |
        inc     c
        rst     $10             ; | ENTER to selec |
        inc     c
        rst     $10             ; | ESC to boot us |
        inc     c
        rst     $10             ; ------------------

noesc   


binf    jr      binf


; -------------------------------------
; Draw a window in the attribute area
; Parameters:
;    A: attribute color
;   HL: X coordinate (H) and Y coordinate (L)
;   DE: window with (D) and window height (E)
; -------------------------------------
window  ld      c, h
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ld      h, $16
        add     hl, hl
        add     hl, hl
        ld      b, 0
        add     hl, bc
windo1  ld      b, d
windo2  ld      (hl), a
        inc     l
        djnz    windo2
        ex      af, af'
        ld      a, 32
        sub     d
        add     a, l
        ld      l, a
        jr      nc, windo3
        inc     h
windo3  ex      af, af'
        dec     e
        jr      nz, windo1
        ret

; ------------------------
; Clear the screen
; ------------------------
clrscr  ld      hl, $4000
        ld      de, $4001
        ld      bc, $1b00
        ld      (hl), l
        ldir
        ret

; ------------------------
; Read from SPI flash
; Parameters:
;   HL: source address without last 4 bits
;   DE: destination address
;   BC: number of bytes to read
; ------------------------
rdflsh  ld      a, h
        cp      $29
        jp      nz, rdfls2
        ld      a, l
        cp      $50
        jr      nz, rdfls1
        ld      hl, l2950
        ldir
        ret
;  00-1f: index to entries
;  20: fast boot
;  21: active entry
l2950   defb    $02, $00, $01, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $00
        defb    $01

rdfls1  cp      $80
        jp      nz, rdfls2
        ld      hl, l2980
        ldir
        ret
; 32 entradas
;    00: AAAAABBB A= RAM offset    B= ROM SRAM size (000=8)  ff==empty entry
;    01: AAAAABBB A= slot offset   B= slot size     (000=8)
;    02: port 1ffd
;    03: port 7ffd
;    ...
;    10-1f: CRCs
;    20-3f: Name
l2980   defb    %01011001, %00011001, $04, $30, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K ROM             '
        defb    %01000100, %00000100, $00, $00, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum +2A English 4.1     '
        defb    %01010010, %00100010, $04, $00, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 128K Spanish        '

rdfls2  ret

; ------------------------
; Messages
; ------------------------
cad1    defm    'http://zxuno.speccy.org', 0
        defm    'ZX-Uno BIOS v0.100', 0
        defm    'Copyright ', 127, ' 2014 Equipo ZX-Uno', 0
        defm    'Processor: Z80 3.5MHz', 0
        defm    'Memory:    512K Ok', 0
        defm    'Graphics:  normal, hi-color', 0
        defm    'hi-res, ULAplus', 0
        defm    'Booting:   Amstrad +3 ROM 4.0 English', 0
        defm    'Press <F2> to Setup    <Esc> for Boot Menu', 0
cad2    defb    3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        defb    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 0
        defm    1, '   Please select boot machine:    ', 1, 0
cad3    defb    7, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        defb    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 8, 0
cad4    defm    1, '                                  ', 1, 0
        defm    1, ' Enter Setup                      ', 1, 0
cad5    defm    1, '    ', 12, ' and ', 13, ' to move selection     ', 1, 0
        defm    1, '   ENTER to select boot machine   ', 1, 0
        defm    1, '    ESC to boot using defaults    ', 1, 0
        defb    5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        defb    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 6, 0

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

        block   $2f27-$

; -----------------------------------------------------------------------------
; Print string routine
; Parameters:
;   B: X coord
;   C: Y coord
;  IX: null terminated string
; -----------------------------------------------------------------------------
prnstr  push    bc
        ld      a, b
        and     %11111100
        ld      d, a
        xor     b
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
        ld      a, c
        and     %00011000
        or      %01000000
        ld      d, a
        ld      a, c
        and     %00000111
        rrca
        rrca
        rrca
        add     a, e
        ld      e, a
        defb    $3e             ; salta la siguiente instruccion
posf    pop     bc
        ret

pos0    ld      a, (ix)
        inc     ix
        add     a, a
        jr      z, posf
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
        jr      z, posf
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
tposf   jr      z, posf
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
        jr      z, tposf
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
