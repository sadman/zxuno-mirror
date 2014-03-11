        output  firmware_strings.rom

        define  call_prnstr     rst     $08

        define  cmbpnt  $8f00
        define  colcmb  $8fc6   ;solo lo: color de lista
        define  menuop  $8fc8   ;lo: menu superior    hi: submenu
        define  corwid  $8fca   ;lo: X attr coor      hi: attr width
        define  cmbcor  $8fcc   ;lo: Y coord          hi: X coord
        define  codcnt  $8fce   ;lo: codigo ascii     hi: repdel
        define  items   $8fd0   ;lo: totales          hi: en pantalla
        define  offsel  $8fd2   ;lo: offset visible   hi: seleccionado
        define  empstr  $8fd4
        define  tmpbuf  $9900

        ei
        ld      sp, $c000
        im      1
        jr      aqui
        jp      prnstr
aqui    ld      hl, finlog-1
        ld      de, $9aff
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
        jp      descad

; ----------------------
; THE 'KEYBOARD' ROUTINE
; ----------------------
        push    af
        ex      af, af'
        push    af
        push    bc
        push    de
        push    hl
        ld      de, keytab-1&$ff
        ld      bc, $fefe
        ld      l, d
keyscn  in      a, (c)
        cpl
        and     $1f
        ld      h, l
        jr      z, keysc5
keysc1  inc     l
        srl     a
        jr      nc, keysc1
        ex      af, af'
        ld      a, l
        cp      $25                     ;symbol, change here
        jr      z, keysc3
        cp      $01                     ;shift, change here
        jr      z, keysc2
        inc     d
        dec     d
        ld      d, l
        jr      z, keysc4
        xor     a
        jr      keysc6
keysc2  ld      e, 39+keytab&$ff
        defb    $c2                     ;JP NZ,xxxx
keysc3  ld      e, 79+keytab&$ff
keysc4  ex      af, af'
        jr      nz, keysc1
keysc5  ld      a, h
        add     a, 5
        ld      l, a
        rlc     b
        jr      c, keyscn
        xor     a
        ld      h, a
        add     a, d
        jr      z, keysc6
        add     a, e
        ld      l, a
        ld      a, (hl)
keysc6  ld      hl, (codcnt)
        jr      z, keysc8
        res     7, l
        cp      l
        jr      nz, keysc7
        dec     h
        jr      nz, keysc9
        ld      h, 3
        defb    $c2
keysc7  ld      h, 32
        or      $80
keysc8  ld      l, a
keysc9  ld      (codcnt), hl
        ei
        pop     hl
        pop     de
        pop     bc
        pop     af
        ex      af, af'
        pop     af
        ret                             ; return.
; ---------------
; THE 'KEY TABLE'
; ---------------
keytab  defb    $00, $7a, $78, $63, $76 ; Caps    z       x       c       v
        defb    $61, $73, $64, $66, $67 ; a       s       d       f       g
        defb    $71, $77, $65, $72, $74 ; q       w       e       r       t
        defb    $31, $32, $33, $34, $35 ; 1       2       3       4       5
        defb    $30, $39, $38, $37, $36 ; 0       9       8       7       6
        defb    $70, $6f, $69, $75, $79 ; p       o       i       u       y
        defb    $0d, $6c, $6b, $6a, $68 ; Enter   l       k       j       h
        defb    $20, $00, $6d, $6e, $62 ; Space   Symbol  m       n       b
        defb    $00, $5a, $58, $43, $56 ; Caps    Z       X       C       V
        defb    $41, $53, $44, $46, $47 ; A       S       D       F       G
        defb    $51, $57, $45, $52, $54 ; Q       W       E       R       T
        defb    $17, $19, $1a, $1b, $1e ; Edit    CapsLk  TruVid  InvVid  Left
        defb    $18, $16, $1f, $1c, $1d ; Del     Graph   Right   Up      Down
        defb    $50, $4f, $49, $55, $59 ; P       O       I       U       Y
        defb    $0d, $4c, $4b, $4a, $48 ; Enter   L       K       J       H
        defb    $0c, $00, $4d, $4e, $42 ; Break   Symbol  M       N       B
        defb    $00, $3a, $60, $3f, $2f ; Caps    :       `       ?       /
        defb    $7e, $7c, $5c, $7b, $7d ; ~       |       \       {       }
        defb    $51, $57, $45, $3c, $3e ; Q       W       E       <       >
        defb    $21, $40, $23, $24, $25 ; !       @       #       $       %
        defb    $5f, $29, $28, $27, $26 ; _       )       (       '       &
        defb    $22, $3b, $7f, $5d, $5b ; "       ;      (c)      ]       [
        defb    $0d, $3d, $2b, $2d, $5e ; Enter   =       +       -       ^
        defb    $20, $00, $2e, $2c, $2a ; Space   Symbol  .       ,       *

descad  call    dzx7b
        ld      bc, $0909
        ld      ix, cad1        ; imprimir cadenas BOOT screen
        call_prnstr             ; http://zxuno.speccy.org
        ld      bc, $020d
        call_prnstr             ; ZX-Uno BIOS v0.100
        call_prnstr             ; Copyright
        ld      bc, $0010       ; Copyright (c) 2014 ZX-Uno Team
        call_prnstr             ; Processor
        call_prnstr             ; Memory
        call_prnstr             ; Graphics
        ld      bc, $0b13
        call_prnstr             ; hi-res, ULAplus
        ld      b, a
        call_prnstr             ; Booting
        ld      c, $17
        call_prnstr             ; Press <Edit> to Setup
        ld      hl, $2950
        ld      de, $9800
        ld      bc, $0022
        call    rdflsh
        ld      hl, $2980
        ld      de, $9000
        ld      bc, $0800
        call    rdflsh
        xor     a
        out     ($fe), a

noesc   call    waitky
        cp      $0c
        jp      z, boot
        cp      $17
        jr      nz, noesc

; Setup menu
bios    out     ($fe), a
        ld      a, %01001111    ; fondo azul tinta blanca
        ld      hl, $0017
        ld      de, $2001
        call    window
        ld      a, %00111001    ; fondo blanco tinta azul
        ld      l, h
        ld      e, $17
        call    window
        ld      (menuop), hl
        call    clrscr          ; borro pantalla
        ld      ix, cad7
        call_prnstr             ; menu superior
        call_prnstr             ; borde superior
        ld      iy, $090a
bios2   ld      ix, cad8
        call_prnstr             ; |        |     |
        dec     iyh
        jr      nz, bios2
        call_prnstr             ; borde medio
bios3   ld      ix, cad8
        call_prnstr             ; |        |     |
        dec     iyl
        jr      nz, bios3
        ld      ix, cad9
        call_prnstr             ; borde inferior
        call_prnstr             ; info
bios4   ld      a, %00111001    ; fondo blanco tinta azul
        ld      hl, $0102
        ld      de, $1214
        call    window
        ld      a, %01001111    ; fondo azul tinta blanca
        dec     h
        ld      l, h
        ld      de, $2001
        call    window
        di
        ld      c, $14
        ld      hl, $405f
        ld      d, b
        ld      e, b
bios5   ld      b, 8
bios6   ld      sp, hl
        push    de
        push    de
        push    de
        push    de
        push    de
        inc     sp
        push    de
        dec     sp
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        push    de
        inc     h
        djnz    bios6
        ld      a, l
        add     a, $20
        ld      l, a
        jr      c, bios7
        ld      a, h
        sub     8
        ld      h, a
bios7   dec     c
        jr      nz, bios5
        ei
        ld      sp, $c000
        ld      ix, cad11
        ld      bc, $1a0b
        call_prnstr             ; borde medio
        ld      hl, (menuop)
        ld      de, $0401
        ld      a, %01111001    ; fondo blanco tinta azul
        dec     l
        jp      m, menu0
        jr      z, menu1
        dec     l
        jr      z, menu2
        dec     l
        jr      z, menu3
        dec     l
        jr      z, menu4
        dec     l
        jr      z, menu5

menu5   ld      h, 28
        call    window
        jp      tosel

menu4   ld      h, 20
        ld      d, 8
        call    window
        jp      tosel

menu3   ld      h, 16
        call    window
        jp      tosel

menu2   ld      h, 9
        ld      d, 7
        call    window
        jp      tosel

menu1   ld      h, 5
        call    window
        ld      a, %00111000    ; fondo blanco tinta negra
        ld      hl, $0102
        ld      d, $12
        call    window
        ld      ix, cad12
        ld      bc, $0202
        call_prnstr
        call_prnstr
        ld      bc, $1503
        call_prnstr
        ld      iy, $9800
        ld      ix, cmbpnt
        ld      de, tmpbuf
        ld      b, e
        ld      a, %00111001
        ld      (colcmb), a
menu11  ld      a, (iy)
        inc     iyl
        inc     a
        jr      z, menu14
        dec     a
        rlca
        rlca
        ld      l, a
        ld      h, 9
        add     hl, hl
        add     hl, hl
        add     hl, hl
        inc     l
        add     hl, hl
        ld      c, (hl)
        ld      a, l
        add     a, $1e
        ld      l, a
        ld      (ix+0), e
        ld      (ix+1), d
        inc     ixl
        inc     ixl
        ld      a, c
        ld      c, $17
        ldir
        ld      h, d
        ld      l, e
        inc     e
        ld      (hl), b
        dec     l
menu12  inc     c
        sub     10
        jr      nc, menu12
        add     a, 10+$30
        ld      (hl), a
        dec     l
        dec     c
        ld      a, $20
        jr      z, menu13
        ld      a, c
        add     a, $30
menu13  ld      (hl), a
        dec     l
        ld      (hl), $20
        jr      menu11
menu14  ld      (ix+1), $ff
        ld      hl, $1201
        ld      (corwid), hl
        ld      hl, $0204
        ld      d, $17
        ld      a, iyl
        dec     a
        cp      $12
        jr      c, menu15
        ld      a, $12
menu15  ld      e, a
        xor     a
menu16  call    combol
        ld      a, (codcnt)
        cp      $1e
        jr      z, menu17
        cp      $1f
        jr      nz, menu16
menu17  ld      hl, $0104
        ld      d, $12
        ld      a, (items+1)
        ld      e, a
        ld      a, %00111001
        call    window
        ld      a, (codcnt)
        jr      tosel1

menu0   inc     l
        inc     d
        ld      h, l
        call    window
        ld      a, %00111000    ; fondo blanco tinta negra
        ld      hl, $0102
        ld      d, $12
        call    window
        ld      l, 8
        call    window
        ld      ix, cad13
        ld      bc, $1b0c
        call    prnmul          ; Select Screen ...
        ld      ix, cad10
        ld      bc, $0202
        call    prnmul          ; Harward tests ...
        ld      de, $1201
        call    listas
        defb    $04
        defb    $05
        defb    $06
        defb    $0a
        defb    $0b
        defb    $ff
        defw    cad14
        defw    cad15
        defw    cad16
        defw    cad17
        defw    cad18
        ;jr      c,  se ha pulsado esc
        jr      nz, tosel1
; ejecuto esto si se ha pulsado enter

tosel   call    waitky
tosel1  ld      hl, (menuop)
        sub     $1e
        jr      nz, noiz
        dec     l
        jp      m, tosel
guarsa  ld      (menuop), hl
        jp      bios4
noiz    dec     a
        jr      nz, tosel
        inc     l
        ld      a, l
        cp      6
        jr      z, tosel
        jr      guarsa

; Boot list
boot    call    clrscr          ; borro pantalla
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
        rra
        ld      l, a
        ld      a, h
        add     a, 8
        ld      e, a

        ld      a, %01001111    ; fondo azul tinta blanca
        ld      h, $01          ; coordenada X
        ld      d, $1c          ; anchura de ventana
        push    hl
        call    window
        ld      ix, cad2
        pop     bc
        inc     b
        call_prnstr
        call_prnstr
        call_prnstr
        push    bc
        ld      iy, (items)
repblk  ld      ix, cad4
        call_prnstr             ; |                |
        dec     iyh
        jr      nz, repblk
        ld      ix, cad3
        call_prnstr             ; |----------------|
        ld      ix, cad5
        call    prnmul
        ld      iy, $9800
        ld      ix, cmbpnt
        ld      de, tmpbuf
        ld      b, e
nxtitm  ld      a, (iy)
        inc     iyl
        inc     a
        rlca
        rlca
        ld      l, a
        ld      h, 9
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ld      (ix+0), e
        ld      (ix+1), d
        inc     ixl
        inc     ixl
        ld      c, $21
        push    hl
tdecl   dec     l
        dec     c
        ld      a, (hl)
        cp      $20
        jr      z, tdecl
        pop     hl
        ld      a, l
        sub     $20
        ld      l, a
        jr      nz, ovetec
        dec     h
ovetec  ldir
        xor     a
        ld      (de), a
        inc     de
        ld      a, (items)
        sub     2
        sub     iyl
        jr      nc, nxtitm
        ld      (ix+0), cad6&$ff
        ld      (ix+1), cad6>>8
        ld      (ix+3), a
        ld      a, (items+1)
        ld      e, a
        ld      d, 32
        ld      hl, $1a02
        ld      (corwid), hl
        pop     hl
        ld      h, 4
        ld      a, %01001111
        ld      (colcmb), a
        ld      a, 1
tinval  call    combol
        jr      c, tinval

binf    jr      binf

; -------------------------------------
; Wait for a key
; Returns:
;    A: ascii code of the key
; -------------------------------------
waitky  ld      a, (codcnt)
        sub     $80
        jr      c, waitky       ; Espero la pulsación de una tecla
        ld      (codcnt), a
        ret

; -------------------------------------
; Show a combo list to select one element
; Parameters:
;(corwid)
; cmbpnt: list of pointers (last is $ffff)
;    A: preselected one
;   HL: X coord (H) and Y coord (L) of the first element
;   DE: window width (D) and window height (E)
; Returns:
;    A: item selected (-1 if break pressed)
; -------------------------------------
combol  push    de
        ex      af, af'
        ld      (cmbcor), hl
        ld      hl, cmbpnt+1
combo1  ld      a, (hl)
        inc     l
        inc     l
        inc     a
        jr      nz, combo1
        srl     l
        dec     l
        ld      c, l
        ld      h, e
        ld      b, d
        ld      (items), hl
        ld      hl, empstr
combo2  ld      (hl), $20
        inc     l
        djnz    combo2
        ld      (hl), a
        ex      af, af'
        ld      (offsel+1), a
        defb    $32
combo3  dec     a
        inc     b
        cp      e
        jr      nc, combo3
        ld      a, b
combo4  ld      (offsel), a
        ld      iy, (items)
        ld      iyl, iyh
        ld      bc, (cmbcor)
combo5  ld      ix, empstr
        call_prnstr
        dec     iyl
        jr      nz, combo5
        ld      a, (offsel)
        ld      bc, (cmbcor)
        add     a, a
        ld      h, cmbpnt>>8
        ld      l, a
combo6  ld      a, (hl)
        ld      ixl, a
        inc     l
        ld      a, (hl)
        inc     l
        ld      ixh, a
        push    hl
        call_prnstr
        pop     hl
        dec     iyh
        jr      nz, combo6
combo7  ld      de, (corwid)
        ld      hl, (cmbcor)
        ld      h, e
        ld      a, (items+1)
        ld      e, a
        ld      a, (colcmb)
        call    window
        ld      de, (corwid)
        ld      hl, (offsel)
        ld      a, (cmbcor)
        add     a, h
        sub     l
        ld      l, a
        ld      h, e
        ld      e, 1
        ld      a, %01000111
        call    window
        call    waitky
        ld      hl, (offsel)
        sub     $0d
        jr      c, combob
        jr      z, comboc
        ld      bc, (items)
        sub     $0f
        jr      nz, combo9
        dec     h
        jp      m, combo7
        ld      a, h
        cp      l
        ld      (offsel), hl
        jr      nc, combo7
        ld      a, l
        dec     a
combo8  jr      combo4
combo9  dec     a
        jr      nz, comboa
        inc     h
        ld      a, h
        cp      c
        jr      z, combo7
        sub     l
        cp      b
        ld      (offsel), hl
        jr      nz, combo7
        ld      a, l
        inc     a
        jr      combo8
comboa  ld      a, h
        ld      hl, (cmbcor)
combob  ccf
        pop     de
        ret
comboc  ld      a, h
        pop     de
        ret

; -------------------------------------
; Show a normal list only in attribute area width elements
; in not consecutive lines
; Parameters:
;    A: preselected one
;   PC: list of Y positions
;   DE: window width (D) and X position (E)
; Returns:
;    A: item selected
;    Carry on: if no Enter pressed
; -------------------------------------
listas  inc     a
        ld      iyl, a
        pop     hl
        push    hl
        xor     a
        defb    $32
lista1  inc     hl
        inc     a
        inc     (hl)
        jr      nz, lista1
        ld      ixl, a
        pop     hl
lista2  ld      iyh, iyl
        ld      ixh, ixl
        push    hl
        push    de
lista3  push    hl
        ld      l, (hl)
        ld      h, e
        ld      e, 1
        ld      a, %00111001    ; fondo blanco tinta azul
        dec     iyh
        jr      nz, lista4
        ld      a, %01000111
lista4  call    window
        pop     hl
        inc     hl
        dec     ixh
        jr      nz, lista3
        ld      a, iyl
        add     a, a
        ld      c, a
        add     hl, bc
        push    ix
        ld      a, (hl)
        ld      ixh, a
        dec     hl
        ld      a, (hl)
        ld      ixl, a
        ld      bc, $1b02
        call    prnmul
        call    waitky


        di
        ld      c, $9
        ld      hl, $405f
        ld      de, 0
lista5  ld      b, 8
list55  ld      sp, hl
        push    de
        push    de
        push    de
        push    de
        push    de
        inc     sp
        push    de
        inc     h
        djnz    list55
        ld      a, l
        add     a, $20
        ld      l, a
        jr      c, list56
        ld      a, h
        sub     8
        ld      h, a
list56  dec     c
        jr      nz, lista5
        ld      sp, $bffa
        ei
;; borrar aqui la pantalla de ayuda

        pop     ix
        pop     de
        pop     hl
        ld      a, (codcnt)
        cp      $1c
        jr      nz, lista7
        ld      a, iyl
        dec     a
        jr      z, lista2
lista6  ld      iyl, a
        jr      lista2
lista7  cp      $1d
        jr      nz, lista8
        ld      a, iyl
        cp      ixl
        jr      nc, lista2
        inc     a
        jr      lista6
lista8  push    ix
        pop     de
        add     hl, de
        add     hl, de
        add     hl, de
        inc     hl
        dec     iyl
        cp      $0d
        jr      nz, lista9
        ld      a, iyl
        jp      (hl)
lista9  scf
        jp      (hl)

; -------------------------------------
; Draw a window in the attribute area
; Parameters:
;    A: attribute color
;   HL: X coordinate (H) and Y coordinate (L)
;   DE: window width (D) and window height (E)
; -------------------------------------
window  push    hl
        push    de
        ld      c, h
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
        ld      a, l
        sub     d
        add     a, 32
        ld      l, a
        jr      nc, windo3
        inc     h
windo3  ex      af, af'
        dec     e
        jr      nz, windo1
        pop     de
        pop     hl
        ret

; ------------------------
; Clear the screen
; ------------------------
clrscr  ld      hl, $4000
        ld      de, $4001
        ld      bc, $17ff
        ld      (hl), l
        ldir
        ret

prnmul  call_prnstr
        add     a, (ix)
        jr      nz, prnmul
        inc     ix
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
l2950   defb    $02, $01, $00, $ff, $01, $00, $02, $01
        defb    $02, $01, $00, $02, $01, $00, $02, $01
        defb    $02, $01, $00, $02, $01, $00, $02, $01
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $00
        defb    $01

rdfls1  cp      $80
        jp      nz, rdfls2
        ld      hl, l2980
        ldir
        ret
; 32 entradas
;    00: RAM offset     
;    01: B= ROM SRAM size
;    02: slot offset
;    03: B= slot size
;    04: port 1ffd
;    05: port 7ffd
;    ...
;    10-1f: CRCs
;    20-3f: Name
l2980   defb    $0b, 4, $03, 1, $04, $30, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K ROM             '
        defb    $08, 4, $00, 4, $00, $00, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum +2A English 4.1     '
        defb    $0a, 2, 20, 2, $04, $00, $ff, $ff ;$04
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 128K Spanish        '

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

        block   $3126-$

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
        inc     c
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
        defm    'Copyright ', 127, ' 2014 ZX-Uno Team', 0
        defm    'Processor: Z80 3.5MHz', 0
        defm    'Memory:    512K Ok', 0
        defm    'Graphics:  normal, hi-color', 0
        defm    'hi-res, ULAplus', 0
        defm    'Booting:   Amstrad +3 ROM 4.0 English', 0
        defm    'Press <Edit> to Setup    <Break> Boot Menu', 0
cad2    defb    $12, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $13, 0
        defm    $10, '   Please select boot machine:    ', $10, 0
cad3    defb    $16, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $17, 0
cad4    defm    $10, '                                  ', $10, 0
cad5    defm    $10, '    ', $1c, ' and ', $1d, ' to move selection     ', $10, 0
        defm    $10, '   ENTER to select boot machine   ', $10, 0
        defm    $10, '    ESC to boot using defaults    ', $10, 0
        defb    $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $15, 0, 0
cad6    defb    'Enter Setup', 0
cad7    defb    ' Main  ROMs  Upgrade  Boot  Security  Exit', 0
        defb    $12, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $19, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $13, 0
cad8    defm    $10, '                         ', $10, '              ', $10, 0
        defm    $10, 0
cad9    defb    $14, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $18, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $15, 0
        defb    '     BIOS v0.100    ', $7f, '2014 ZX-Uno Team', 0
cad10   defb    'Hardware tests', 0
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, 0
        defb    $1b, ' Memory test', 0
        defb    $1b, ' Sound test', 0
        defb    $1b, ' Video test', 0
        defb    ' ', 0
        defb    'Options', 0
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, 0
        defb    'Quiet Boot    [Enabled]', 0
        defb    'SD Address    [DivMMC]', 0, 0
cad11   defb    $16, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $17, 0
cad12   defb    'Name               Slot', 0
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, 0
        defb    $11, $11, $11, $11, 0
cad13   defb    $1c, ' ', $1d, ' Sel.Screen', 0
        defb    $1e, ' ', $1f, ' Sel.Item', 0
        defb    'Enter Change', 0
        defb    'Graph Save&Exi', 0
        defb    'Break Exit', 0, 0
cad14   defb    'Run a diagnos-', 0
        defb    'tic test on', 0
        defb    'your system', 0
        defb    'memory', 0, 0
cad15   defb    'Performs a', 0
        defb    'sound test on', 0
        defb    'your system', 0, 0
cad16   defb    'Performs a', 0
        defb    'video test on', 0
        defb    'your system', 0, 0
cad17   defb    'Hide the whole', 0
        defb    'boot screen', 0
        defb    'when enabled', 0, 0
cad18   defb    'Toggle between', 0
        defb    'ports of ZXMMC', 0
        defb    'or DivMMC', 0, 0

fincad