        output  firmware_strings.rom

        define  call_prnstr     rst     $08
        define  items   $8ffc
        define  codcnt  $8ffe

        di
        ld      hl, finlog-1
        ld      de, $9aff
        defb    $3e ;$3a
        jp      prnstr
        call    dzx7b           ; descomprimir
        inc     l
        inc     hl
        ld      b, $40          ; filtro RCS inverso
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
clean   ld      b, $13
        ldir
        ld      de, fincad-1    ; descomprimo cadenas
        ld      hl, finstr-1
        call    dzx7b
        ld      bc, $0909
        jp      descad

; ----------------------
; THE 'KEYBOARD' ROUTINE
; ----------------------
        call    keyscn                  ; routine KEY_SCAN
        ld      b, a                    ; save key in B
        ld      hl, (codcnt)            ; KEYCOD - last key pressed / KEYCNT - debounce counter
        xor     l                       ; compare to previous key.
        jr      z, keymat               ; forward if a match.
        xor     l                       ; reform original
        jr      z, nokeyb               ; forward if zero - no key.
        xor     a                       ; else clear accumulator.
        cp      l                       ; compare with last.
        jr      nz, reteiz              ; return if not zero.
nokeyb  ld      l, b                    ; set L to original keycode
        ld      h, 32                   ; set counter to thirty two.
        jr      stoexi                  ; forward to store values and exit returning zero
keymat  dec     h                       ; decrement the counter.
        ld      a, h                    ; fetch counter to A.
        cp      $1e                     ; compare to thirty.
        jr      z, retkea               ; forward if so to return key in A.
        xor     a                       ; clear accumulator.
        cp      h                       ; is counter zero?
        jr      nz, stoexi              ; forward if not to keep counting.
        ld      h, 4                    ; else set counter to four.
retkea  ld      a, l                    ; pick up previous key.
stoexi  ld      (codcnt),hl             ; update KEYCOD/KEYCNT
reteiz  ei
        ret                             ; return.
keyscn  ld      de, keytab-1&$ff
        ld      bc, $fefe
        ld      l, d
keylop  in      a, (c)
        cpl
        and     $1f
        ld      h, l
        jr      z, rowemp
nexkey  inc     l
        srl     a
        jr      nc, nexkey
        ex      af, af
        ld      a, l
        cp      $25                     ;symbol, change here
        jr      z, sympre
        cp      $01                     ;shift, change here
        jr      z, shipre
        inc     d
        dec     d
        ld      d, l
        jr      z, laszer
        xor     a
        ret
shipre  ld      e, 39+keytab&$ff
        defb    $c2                     ;JP NZ,xxxx
sympre  ld      e, 79+keytab&$ff
laszer  ex      af, af
        jr      nz, nexkey
rowemp  ld      a, h
        add     a, 5
        ld      l, a
        rlc     b
        jr      c, keylop
        xor     a
        ld      h, a
        add     a, d
        ret     z
        add     a, e
        ld      l, a
        ld      a, (hl)
        ret
; ---------------
; THE 'KEY TABLE'
; ---------------
keytab  defb    $00, $7a, $78, $63, $76 ;   SHIFT z x c v
        defb    $61, $73, $64, $66, $67 ;       a s d f g
        defb    $71, $77, $65, $72, $74 ;       q w e r t
        defb    $31, $32, $33, $34, $35 ;       1 2 3 4 5
        defb    $30, $39, $38, $37, $36 ;       0 9 8 7 6
        defb    $70, $6f, $69, $75, $79 ;       p o i u y
        defb    $0d, $6c, $6b, $6a, $68 ;   ENTER l k j h
        defb    $20, $00, $6d, $6e, $62 ; SPACE SYM m n b
        defb    $00, $5a, $58, $43, $56 ;   SHIFT Z X C V
        defb    $41, $53, $44, $46, $47 ;       A S D F G
        defb    $51, $57, $45, $52, $54 ;       Q W E R T
        defb    $0a, $02, $33, $08, $01 ; DELLINE CAPSLOCK 3 INVVIDEO LEFT
        defb    $05, $04, $03, $09, $07 ;     DEL  GRAPH  RIGHT  DOWN  UP
        defb    $50, $4f, $49, $55, $59 ;       P O I U Y
        defb    $0d, $4c, $4b, $4a, $48 ;   ENTER L K J H
        defb    $06, $00, $4d, $4e, $42 ; SPACE SYM M N B
        defb    $00, $3a, $60, $3f, $2f ;   SHIFT : £ ? /
        defb    $7e, $7c, $5c, $7b, $7d ;       ~ | \ { }
        defb    $51, $57, $45, $3c, $3e ;       Q W E < >
        defb    $21, $40, $23, $24, $25 ;       ! @ # $ %
        defb    $5f, $29, $28, $27, $26 ;       _ ) ( ' &
        defb    $22, $3b, $7f, $5d, $5b ;       " ; ç ] [
        defb    $0d, $3d, $2b, $2d, $5e ;   ENTER = + - ^
        defb    $20, $00, $2e, $2c, $2a ; SPACE SYM . , *
; end of key tables

descad  ld      ix, cad1        ; imprimir cadenas BOOT screen
        call_prnstr
        ld      bc, $020d
        call_prnstr
        inc     c
        call_prnstr
        ld      bc, $0010
        call_prnstr
        inc     c
        call_prnstr
        inc     c
        call_prnstr
        ld      bc, $0b13
        call_prnstr
        ld      bc, $0014
        call_prnstr
        ld      bc, $0017
        call_prnstr

        ld      hl, $2950
        ld      de, $9800
        ld      bc, $0022
        call    rdflsh
        ld      hl, $2980
        ld      de, $9000
        ld      bc, $0800
        call    rdflsh

        ei
waitk   ld      a, (codcnt)
        sub     6
        jr      nz, waitk

        di
        call    clrscr          ; borro pantalla
        ld      hl, $9800
nument  ld      a, (hl)         ; calculo en L el número de entradas
        inc     l
        inc     a
        jr      nz, nument
        ld      a, l
        cp      13
        jr      c, mentre
        ld      a, 13
mentre  ld      h, a
        ld      (items), hl
        add     a, -16
        cpl
        rrca
        ld      l, a
        ld      a, h
        add     a, 7
        ld      e, a

        ld      a, %01001111    ; fondo azul tinta blanca
        ld      h, $01          ; coordenada X
        ld      d, $1c          ; anchura de ventana
        push    hl
        call    window
        ld      ix, cad2
        pop     bc
        inc     b
        call_prnstr             ; ------------------
        inc     c
        call_prnstr             ; Please select
        inc     c
        call_prnstr             ; |----------------|
        inc     c
        ld      iy, $9800
nxtitm  ld      ix, cad4
        call_prnstr             ; |                |
        ld      a, (iy)
        rlca
        inc     a
        rlca
        ld      l, a
        ld      h, 9
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        push    hl
        pop     ix
        ld      b, 4
        call_prnstr
        ld      b, 2
        inc     c
        inc     iyl
        ld      a, (items+1)
        dec     a
        cp      iyl
        jr      nz, nxtitm
        ld      ix, cad3
        call_prnstr             ; |----------------|
        ld      ix, cad5
        inc     c
        call_prnstr             ; | U and D move s |
        inc     c
        call_prnstr             ; | ENTER to selec |
        inc     c
        call_prnstr             ; | ESC to boot us |
        inc     c
        call_prnstr             ; ------------------

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
        ld      (hl), a
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
l2950   defb    $02, $00, $01, $01, $ff, $02, $00, $01
        defb    $02, $00, $01, $02, $00, $01, $ff, $ff
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
        defm    'ZX Spectrum 48K ROM            ', 0
        defb    %01000100, %00000100, $00, $00, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum +2A English 4.1    ', 0
        defb    %01010010, %00100010, $04, $00, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 128K Spanish       ', 0

rdfls2  ret

; -----------------------------------------------------------------------------
; Compressed and RCS filtered logo
; -----------------------------------------------------------------------------
        incbin  logo256x192.rcs.zx7b
finlog

; -----------------------------------------------------------------------------
; Compressed messages
; -----------------------------------------------------------------------------
        incbin  strings.bin.zx7b
finstr

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

        block   $8000-$
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
cad5    defm    1, '    ', 12, ' and ', 13, ' to move selection     ', 1, 0
        defm    1, '   ENTER to select boot machine   ', 1, 0
        defm    1, '    ESC to boot using defaults    ', 1, 0
        defb    5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
        defb    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 6, 0
fincad