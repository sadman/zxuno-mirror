        output  firmware_strings.rom

        define  call_prnstr     rst     $08

        define  cmbpnt  $8f00
        define  colcmb  $8fc6   ;lo: color de lista   hi: temporal
        define  menuop  $8fc8   ;lo: menu superior    hi: submenu
        define  corwid  $8fca   ;lo: X attr coor      hi: attr width
        define  cmbcor  $8fcc   ;lo: Y coord          hi: X coord
        define  codcnt  $8fce   ;lo: codigo ascii     hi: repdel
        define  items   $8fd0   ;lo: totales          hi: en pantalla
        define  offsel  $8fd2   ;lo: offset visible   hi: seleccionado
                       ; inputs  lo: cursor position  hi: max length
        define  empstr  $8fd4
        define  tmpbuf  $9900

        ei
        ld      sp, $c000
        im      1
        jr      start
        jp      prnstr

jmptbl  defw    main
        defw    roms
        defw    menu2
        defw    menu3
        defw    menu4
        defw    exit

start   call    dzx7bl          ; descomprimir
        inc     l 
        inc     hl
        ld      b, $40          ; filtro RCS inverso
start1  ld      a, b
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
        jr      z, start1
        ld      b, $13
        ldir
        jp      start2

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

start2  ld      de, fincad-1    ; descomprimo cadenas
        ld      hl, finstr-1
        call    dzx7b
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
        call    loadch
        xor     a
        out     ($fe), a
start3  djnz    start4
        dec     c
        jp      z, conti
start4  ld      a, (codcnt)
        sub     $80
        jr      c, start3
        ld      (codcnt), a
        cp      $0c
        jp      z, boot
        cp      $17
        jr      nz, start3

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
bios4   call    bios5
        jr      bios4
bios5   ld      a, %00111001    ; fondo blanco tinta azul
        ld      hl, $0102
        ld      de, $1614
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
bios6   ld      b, 8
bios7   ld      sp, hl
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
        djnz    bios7
        ld      a, l
        add     a, $20
        ld      l, a
        jr      c, bios8
        ld      a, h
        sub     8
        ld      h, a
bios8   dec     c
        jr      nz, bios6
        ei
        ld      sp, $bffe
        ld      ix, cad11
        ld      bc, $1908
        call    prnmul          ; borde medio
        ld      hl, (menuop)
        ld      d, h
        ld      h, a
        ld      a, l
        add     a, a
        add     a, jmptbl&$ff
        ld      l, a
        ld      c, (hl)
        inc     l
        ld      b, (hl)
        ld      l, h
        ld      h, d
        push    bc
        ld      de, $0401
        ld      a, %01111001    ; fondo blanco tinta azul
        ret

; after 1 second continue boot
conti   ld      a, 2
        out     ($fe), a
        di
        halt

main    inc     d
        ld      h, l
        call    window
        call    help
        ld      ix, cad10
        ld      bc, $0202
        call    prnmul          ; Harward tests ...
        ld      a, ($9821)      ; fast boot
        ld      ix, cad25
        dec     a
        jr      nz, main1
        ld      ixl, cad26 & $ff
main1   ld      bc, $0f0a
        call_prnstr
        ld      a, ($9822)      ; Read SD protocol
        ld      ixl, cad29 & $ff
        dec     a
        jr      nz, main2
        ld      ixl, cad30 & $ff
main2   call_prnstr
        ld      de, $1201
        ld      a, (menuop+1)
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
        jr      c, main6
        ld      (menuop+1), a
        cp      3
        ld      hl, $9822
        jr      c, main4
        jr      nz, main3
        dec     l
        call    popupw
        defw    cad23
        defw    cad24
        defw    $ffff
        ret
main3   call    popupw
        defw    cad27
        defw    cad28
        defw    $ffff
        ret
main4   inc     l
        call    popupw
        defw    cad22
        defw    $ffff
        ret
main6   cp      $0c
        call    z, notab
        cp      $16
        call    z, notar
        ld      hl, (menuop)
        cp      $1e
        jr      nz, notiz
        dec     l
        jp      p, main8
notiz   cp      $1f
        jr      nz, notde
        res     2, l
        dec     l
        jr      nz, main8
notde   ld      a, iyl
        dec     a
        ld      (menuop+1), a
        ret
main7   call    waitky
main8   ld      hl, (menuop)
        cp      $0c
        call    z, notab
        cp      $16
        call    z, notar
        sub     $1e
        jr      nz, mainb
        dec     l
        jp      m, main7
main9   ld      a, l
        ld      h, 0
        dec     a
        jr      nz, maina
        ld      a, ($9820)
        ld      h, a
maina   ld      (menuop), hl
        ret
mainb   dec     a
        jr      nz, main7
        inc     l
        ld      a, l
        cp      6
        jr      z, main7
        jr      main9

roms    push    hl
        ld      h, 5
        call    window
        ld      a, %00111000    ; fondo blanco tinta negra
        ld      hl, $0102
        ld      d, $12
        call    window
        ld      ix, cad12       ; Name Slot
        ld      bc, $0202
        call_prnstr
        call_prnstr
        ld      bc, $1503
        call_prnstr
        ld      bc, $1b0c
        call_prnstr
        call_prnstr
        ld      c, $11
        call_prnstr
        call_prnstr
        call_prnstr
        ld      c, $0e
        call_prnstr
        call_prnstr
        call_prnstr
        ld      iy, $9800
        ld      ix, cmbpnt
        ld      de, tmpbuf
        ld      b, e
        ld      a, %00111001
        ld      (colcmb), a
roms1   ld      a, (iy)
        inc     a
        jr      z, roms5
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
        ld      a, ($9820)
        cp      iyl
        ld      a, $1b
        jr      z, roms2
        ld      a, ' '
roms2   ld      (de), a
        inc     e
        inc     iyl
        ld      a, c
        ld      c, $17
        ldir
        ld      h, d
        ld      l, e
        inc     e
        ld      (hl), b
        dec     l
roms3   inc     c
        sub     10
        jr      nc, roms3
        add     a, 10+$30
        ld      (hl), a
        dec     l
        dec     c
        ld      a, $20
        jr      z, roms4
        ld      a, c
        add     a, $30
roms4   ld      (hl), a
        dec     l
        ld      (hl), $20
        jr      roms1
roms5   ld      (ix+1), $ff
        ld      hl, $1201
        ld      (corwid), hl
        ld      d, $17
        ld      a, iyl
        cp      $12
        jr      c, roms6
        ld      a, $12
roms6   ld      e, a
        pop     af
roms7   ld      hl, $0104
        call    combol
        ld      (menuop+1), a
        ld      a, (codcnt)
        sub     $0d
        jr      nc, roms85
notab   push    af
        ld      a, 1
        call    exitg
        pop     af
        ret
roms85  jr      z, roms9
        sub     $16-$0d
        jr      nz, roms8
notar   push    af
        call    exitg
        pop     af
        ret
roms8   sub     $1e-$16
        jp      z, romst
        dec     a
        jp      z, romst
        ld      a, (menuop+1)
        jr      roms7
roms9   ld      hl, tmpbuf
        ld      (hl), 1
romsa   call    popupw
        defw    cad31
        defw    cad32
        defw    cad33
        defw    cad34
        defw    cad35
        defw    $ffff
        ld      a, (codcnt)
        sub     $0e
        jr      nc, romsa
        inc     a
        jr      nz, romsf
        ld      a, (menuop+1)
        ld      b, (hl)
        inc     b
        djnz    romse
        or      a               ; move up
        jr      z, romsf
        ld      hl, $9820
        ld      b, (hl)
        cp      b
        jr      nz, romsb
        dec     (hl)
romsb   dec     a
        cp      b
        jr      nz, romsc
        inc     (hl)
romsc   ld      (menuop+1), a
romsd   ld      l, a
        ld      a, (hl)
        inc     l
        ld      b, (hl)
        ld      (hl), a
        dec     l
        ld      (hl), b
        jr      romsf
romse   djnz    romsg
        ld      ($9820), a      ; set active
romsf   ret
romsg   djnz    romsk
        ld      b, a            ; move down
        call    nument
        sub     2
        cp      b
romsh   jr      z, romsf
        ld      a, b
        ld      l, $20
        ld      b, (hl)
        cp      b
        jr      nz, romsi
        inc     (hl)
romsi   inc     a
        cp      b
        jr      nz, romsj
        dec     (hl)
romsj   ld      (menuop+1), a
        dec     a
        jr      romsd
romsk   djnz    romsp
        ld      l, a
        dec     h
        ld      a, (hl)
        inc     a
        rlca
        rlca
        ld      l, a
        ld      h, 9
        add     hl, hl
        add     hl, hl
        add     hl, hl
        add     hl, hl
        push    hl
        ld      de, empstr
        call    str2tmp
        ld      hl, $0309
        ld      de, $1a07
        ld      a, e            ;%00000111 fondo negro tinta blanca
        call    window
        dec     h
        dec     l
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        sub     l               ; fondo negro tinta blanca
        ld      iyl, c
        ld      hl, $030c
        ld      de, $1801
        call    window
        ld      bc, $0308
        call_prnstr
        call_prnstr
        call_prnstr
romsl   push    ix
        call_prnstr
        pop     ix
        dec     iyl
        jr      nz, romsl
        call_prnstr
        call_prnstr
        ld      bc, $040c
        ld      hl, $20ff
        call    inputs
        ld      hl, $1708
        ld      de, $0608
        ld      a, %00111001    ; fondo blanco tinta azul
        call    window
        ld      a, (codcnt)
        cp      $0c
        pop     hl
        jr      z, romsh
        ld      a, (items)
        or      a
        jr      z, romsh
        ld      c, a
        sub     32
        jr      z, romsn
        cpl
romsm   dec     l
        ld      (hl), 32
        dec     a
        jp      p, romsm
romsn   dec     l
        ex      de, hl
        ld      h, empstr>>8
        ld      a, empstr-1&$ff
        add     a, c
        ld      l, a
        lddr
        ret
romsp   dec     h
        ld      l, $20
        cp      (hl)
        jr      c, romsq
        ld      l, (hl)
        inc     l
        ld      b, (hl)
        inc     b
        jr      nz, romsr
        dec     l
        ret     z
        ld      l, $20
romsq   dec     (hl)
romsr   ld      l, a
romss   inc     l
        ld      a, (hl)
        dec     l
        ld      (hl), a
        inc     l
        or      a
        jp      p, romss
        add     a, l
        ld      hl, menuop+1
        cp      (hl)
        ret     nz
        dec     (hl)
        ret
romst   ld      hl, $0104
        ld      d, $12
        ld      a, (items+1)
        ld      e, a
        ld      a, %00111001
        call    window
        ld      a, (codcnt)
        jp      main8

menu2   ld      h, 9
        ld      d, 7
        call    window
        jp      main7

menu3   ld      h, 16
        call    window
        jp      main7

menu4   ld      h, 20
        ld      d, 8
        call    window
        jp      main7

exit    ld      h, 28
        call    window
        call    help
        ld      ix, cad37
        ld      bc, $0202
        call_prnstr
        call_prnstr
        call_prnstr
        call_prnstr
        ld      de, $1201
        ld      a, (menuop+1)
        call    listas
        defb    $02
        defb    $03
        defb    $04
        defb    $05
        defb    $ff
        defw    cad38
        defw    cad39
        defw    cad40
        defw    cad41
        jp      c, main6
        ld      (menuop+1), a
exitg   ld      (colcmb+1), a
        ld      hl, $0709
        ld      de, $1207
        ld      a, %00000111     ;%00000111 fondo negro tinta blanca
        call    window
        dec     h
        dec     l
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        ld      bc, $080b
        ld      ix, cad42
        call_prnstr
        call_prnstr
        call_prnstr
        call_prnstr
        ld      a, (colcmb+1)
        ld      b, a
        djnz    exit1
        ld      ix, cad44
exit1   djnz    exit2
        ld      ix, cad45
exit2   djnz    exit3
        ld      ix, cad46
exit3   ld      bc, $0808
        call_prnstr
        call_prnstr
        call_prnstr
        xor     a
        call    yesno
        ld      hl, $1708
        ld      de, $0208
        ld      a, %00111001    ; fondo blanco tinta azul
        call    window
        ld      a, (codcnt)
        cp      $0c
        ret     z
        dec     ixl
        ret     z
        ld      a, (colcmb+1)
        ld      b, a
        djnz    exit4
        jr      exit7
exit4   djnz    exit5
        jp      savech
exit5   djnz    exit6
        jp      loadch
exit6   call    savech
exit7   jp      conti

; Boot list
boot    call    clrscr          ; borro pantalla
        call    nument
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
        call    str2tmp
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
        call    combol
;        jr      c, atras

binf    jr      binf

; -------------------------------------
; Yes or not dialog
;    A: if 0 preselected Yes, if 1 preselected No
; Returns:
;    A: 0: yes, 1: no
; -------------------------------------
yesno   inc     a
yesno1  ld      ixl, a
yesno2  ld      hl, $0b0d
        ld      de, $0801
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        sub     d               ; %01000111 fondo negro tinta blanca
        ld      d, 3
        ld      b, ixl
        djnz    yesno3
        ld      h, $11
        dec     d
yesno3  call    window
        call    waitky
        add     a, $100-$1f
        jr      nz, yesno4
        add     a, ixl
        jr      z, yesno
yesno4  inc     a
        jr      nz, yesno5
        dec     a
        add     a, ixl
        jr      z, yesno1
yesno5  add     a, $1e-$0c
        cp      2
        jr      nc, yesno2
        ld      a, ixl
        ret

; -------------------------------------
; Transforms space finished string to a null terminated one
;   HL: end of origin string
;   DE: start of moved string
; -------------------------------------
str2tmp ld      c, $21
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
        ret

; -------------------------------------
; Read number of boot entries
; Returns:
;    A: number of boot entries
; -------------------------------------
nument  ld      hl, $9800
numen1  ld      a, (hl)         ; calculo en L el número de entradas
        inc     l
        inc     a
        jr      nz, numen1
        ld      a, l
        ret

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
; Input a string by the keyboard
; Parameters:
; empstr: input and output string
;     HL: max length (H) and cursor position (L)
;     BC: X coord (B) and Y coord (C)
; -------------------------------------
inputs  ld      (offsel), hl
input1  push    bc
        ld      ix, empstr
        call_prnstr
        push    ix
        pop     hl
        ld      a, l
        sub     empstr+1&$ff
        ld      (items), a
        ld      e, a
        add     a, b
        ld      b, a
        ld      a, (offsel)
        inc     a
        jr      nz, input2
        ld      a, e
        ld      (offsel), a
input2  ld      e, 32
        defb    $32
input3  ld      (hl), e
        inc     l
        ld      a, l
        sub     empstr+33&$ff
        jr      nz, input3
        ld      (hl), a
        dec     c
        call_prnstr
        pop     bc
input4  ld      a, (offsel)
        add     a, b
        ld      l, a
        and     %11111100
        ld      d, a
        xor     l
        ld      h, $80
        ld      e, a
        jr      z, input5
        dec     e
input5  xor     $fc
input6  rrc     h
        rrc     h
        inc     a
        jr      nz, input6
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
        ld      l, $08
input7  ld      a, (de)
        xor     h
        ld      (de), a
        inc     d
        dec     l
        jr      nz, input7
        ld      h, $80
input8  ld      a, (codcnt)
        sub     $80
        jr      nc, inputa
        dec     l
        jr      nz, input8
        dec     h
        jr      nz, input8
input9  jr      input4
inputa  ld      (codcnt), a
        cp      $0e
        ret     c
        ld      hl, (offsel)
        cp      $18
        jr      nz, inputb
        dec     l
        jp      m, input1
        ld      (offsel), hl
        ld      a, 33
        sub     l
        push    bc
        ld      c, a
        ld      b, 0
        ld      a, l
        add     a, empstr&$ff
        ld      l, a
        ld      h, empstr>>8
        ld      d, h
        ld      e, l
        inc     l
        ldir
        pop     bc
        jr      inpute
inputb  sub     $1e
        jr      nz, inputd
        dec     l
        jp      m, input1
inputc  jp      inputs
inputd  dec     a
        ld      a, (items)
        jr      nz, inputf
        cp      l
        jr      nz, inputg
inpute  jp      input1
inputf  cp      h
        jr      z, input9
        ld      a, l
        add     a, empstr&$ff
        ld      l, a
        ld      h, empstr>>8
        ld      a, (codcnt)
        inc     (hl)
        dec     (hl)
        jr      nz, inputh
        ld      (hl), a
        inc     l
        ld      (hl), 0
inputg  ld      hl, (offsel)
        inc     l
        jr      inputc
inputh  ex      af, af'
        ld      a, empstr+33&$ff
        sub     l
        push    bc
        ld      c, a
        ld      b, 0
        ld      l, empstr+32&$ff
        ld      de, empstr+33
        lddr
        inc     l
        ex      af, af'
        ld      (hl), a
        pop     bc
        jr      inputg

; -------------------------------------
; Show a combo list to select one element
; Parameters:
;(corwid)
; cmbpnt: list of pointers (last is $ffff)
;    A: preselected one
;   HL: X coord (H) and Y coord (L) of the first element
;   DE: window width (D) and window height (E)
; Returns:
;    A: item selected
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
        jr      c, comboa
        jr      z, comboa
        ld      bc, (items)
        sub     $1c-$0d
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
combo9  dec     a               ; $1d
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
        ld      a, (codcnt)
        cp      $0d
        jr      z, list10
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
        ld      sp, $bff8
        ei
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
lista9  scf
        jp      (hl)
list10  pop     de
        pop     hl
        pop     hl
        add     hl, de
        add     hl, de
        add     hl, de
        inc     hl
        ld      a, iyl
        dec     a
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


; -------------------------------------
; Draw a pop up list with options
; Parameters:
;   PC: list of pointers to options (last is $ffff)
;   HL: pointer to variable item
popupw  exx
        pop     hl
        ld      de, cmbpnt
        ldi
popup1  ldi
        ldi
        inc     (hl)
        jr      nz, popup1
        ldi
        push    hl
        srl     e
        ld      a, e
        dec     a
        ld      iyl, a
        add     a, -24
        cpl
        rra
        ld      l, a
        ld      h, $16
        ld      d, 1
        ld      a, %00000111    ; fondo negro tinta blanca
        call    window
        ld      a, e
        inc     e
        ld      h, e
        push    hl
        add     a, l
        ld      l, a
        ld      h, $0a
        ld      de, $0d01
        ld      a, %00000111    ; fondo negro tinta blanca
        call    window
        pop     hl
        ld      e, h
        dec     l
        ld      h, $09
        push    de
        push    hl
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        ld      ix, cad19
        ld      b, $0c
        ld      c, l
        call_prnstr
popup2  ld      ix, cad20
        call_prnstr
        dec     iyl
        jr      nz, popup2
        call_prnstr
        ld      hl, $0b0a
        ld      (corwid), hl
        ld      a, %01001111
        ld      (colcmb), a
        pop     hl
        pop     de
        inc     l
        ld      a, h
        add     a, 5
        ld      h, a
        dec     e
        dec     e
        exx
        ld      a, (hl)
        exx
        call    combol
        exx
        ld      (hl), a
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
; Save flash structures from $9800 to $29500 and from $9000 to $29800
; ------------------------
savech  ret

; ------------------------
; Load flash structures from $29500 to $9800 and from $29800 to $9000
; ------------------------
loadch  ld      hl, $2950
        ld      de, $9800
        ld      bc, $0024
        call    rdflsh
        ld      hl, $2980
        ld      de, $9000
        ld      bc, $0800
;        call    rdflsh
        
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
;  20: active entry
;  21: fast boot
;  22: SD protocol: 0: ZXMMC, 1: DivMMC
l2950   defb    $02, $01, $00, $ff, $01, $00, $02, $01
        defb    $02, $01, $00, $02, $01, $00, $02, $01
        defb    $02, $01, $00, $02, $01, $00, $02, $01
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $01
        defb    $00
        defb    $01
        defb    0   ; para que not implemented sea 0

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

dzx7bl  ld      hl, finlog-1
        ld      de, $9aff
        
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

        block   $310d-$

help    ld      a, %00111000    ; fondo blanco tinta negra
        ld      hl, $0102
        ld      d, $12
        call    window
        ld      l, 8
        call    window
        ld      ix, cad13
        ld      bc, $1b0c
        call_prnstr             ; Select Screen ...
        call_prnstr
        call_prnstr
        call_prnstr

; -----------------------------------------------------------------------------
; Print string routine
; Parameters:
;  BC: X coord (B) and Y coord (C)
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
        ld      b, 4
pos00   ld      a, (hl)
        ld      (de), a
        inc     l
        inc     d
        ld      a, (hl)
        ld      (de), a
        inc     l
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
        ld      a, $18
        or      l
        ld      l, a
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
        defb    'Quiet Boot', 0
        defb    'SD Address', 0, 0
cad11   defb    ' ', $10, 0
        defb    ' ', $10, 0
        defb    ' ', $10, 0
        defb    ' ', $16, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $17, 0
        defb    ' ', $10, 0
        defb    ' ', $10, 0
        defb    ' ', $10, 0, 0
cad12   defb    'Name               Slot', 0
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, 0
        defb    $11, $11, $11, $11, 0
cad13   defb    $1e, ' ', $1f, ' Sel.Screen', 0
        defb    $1c, ' ', $1d, ' Sel.Item', 0
        defb    'Enter Change', 0
        defb    'Graph Save&Exi', 0
        defb    'Break Exit', 0
        defb    'N   Add Entry', 0
        defb    'C   Check CRCs', 0
        defb    'R   Recovery', 0
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
cad19   defb    $12, $11, $11, $11, ' Options ', $11, $11, $11, $13, 0
cad20   defb    $10, '               ', $10, 0
cad21   defb    $14, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $15, 0
cad22   defb    'Not implem.', 0
cad23   defb    'Enabled', 0
cad24   defb    'Disabled', 0
cad25   defb    '[Enabled]', 0
cad26   defb    '[Disabled]', 0
cad27   defb    'ZXMMC', 0
cad28   defb    'DivMMC', 0
cad29   defb    '[ZXMMC]', 0
cad30   defb    '[DivMMC]', 0
cad31   defb    'Move Up', 0
cad32   defb    'Set Active', 0
cad33   defb    'Move Down', 0
cad34   defb    'Rename', 0
cad35   defb    'Delete', 0
cad36   defb    $12, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    ' Rename ', $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $13, 0
        defb    $10, ' ', $1e, ' ', $1f, ' Enter accept  Break cancel ', $10, 0
        defb    $16, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $17, 0
        defb    $10, '                                ', $10, 0
        defb    $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $15, 0
cad37   defb    'Save Changes & Exit', 0
        defb    'Discard Changes & Exit', 0
        defb    'Save Changes', 0
        defb    'Discard Changes', 0
cad38   defb    'Exit system', 0
        defb    'setup after', 0
        defb    'saving the', 0
        defb    'changes', 0, 0
cad39   defb    'Exit system', 0
        defb    'setup without', 0
        defb    'saving any', 0
        defb    'changes', 0, 0
cad40   defb    'Save Changes', 0
        defb    'done so far to', 0
        defb    'any of the', 0
        defb    'setup options', 0, 0
cad41   defb    'Discard Chan-', 0
        defb    'ges done so', 0
        defb    'far to any of', 0
        defb    'the setup', 0
        defb    'options', 0, 0
cad42   defb    $10, '                      ', $10, 0
        defb    $16, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $17, 0
        defb    $10, '      Yes     No      ', $10, 0
        defb    $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $15, 0
cad43   defb    $12, $11, $11, $11, ' Save and Exit ', $11, $11, $11, $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, '  Save conf. & Exit?  ', $10, 0
cad44   defb    $12, ' Exit Without Saving ', $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, ' Quit without saving? ', $10, 0
cad45   defb    $12, $11, ' Save Setup Values ', $11, $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, '  Save configuration? ', $10, 0
cad46   defb    $12, ' Load Previous Values ', $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, ' Load previous values?', $10, 0
        

fincad