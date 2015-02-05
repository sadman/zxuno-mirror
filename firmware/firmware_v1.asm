        output  firmware_strings.rom
        define  debug   0

      macro wreg  dir, dato
        rst     $30
        defb    dir, dato
      endm

        define  call_prnstr     rst     $20
        define  zxuno_port      $fc3b
        define  master_conf     0
        define  master_mapper   1
        define  flash_spi       2
        define  flash_cs        3
        define  scan_code       4

        define  cmbpnt  $8f00
        define  colcmb  $8fc6   ;lo: color de lista   hi: temporal
        define  menuop  $8fc8   ;lo: menu superior    hi: submenu
        define  corwid  $8fca   ;lo: X attr coor      hi: attr width
        define  cmbcor  $8fcc   ;lo: Y coord          hi: X coord
        define  codcnt  $8fce   ;lo: codigo ascii     hi: repdel
        define  items   $8fd0   ;lo: totales          hi: en pantalla
        define  offsel  $8fd2   ;lo: offset visible   hi: seleccionado
                      ; inputs   lo: cursor position  hi: max length
                      ; otro     lo: pagina actual    hi: mascara paginas
        define  empstr  $8fd4
        define  config  $9000
        define  indexe  $9500
        define  active  $9520
        define  quietb  $9521
        define  checkc  $9522
        define  divmap  $9523
        define  nmidiv  $9524
        define  keyiss  $9525
        define  tmpbuf  $a000
        define  stack   $ab00
        define  alto    $ae00-crctab+

        ld      sp, stack
        ld      a, scan_code
        ld      bc, zxuno_port
        out     (c), a
        inc     b
        in      f, (c)
        push    af
        ld      hl, conti
        ld      de, $b400-chrend+conti
        ld      bc, chrend-conti
        ldir
        call    loadch
        ei
        jp      start

rst20   push    bc
        jp      alto prnstr

jmptbl  defw    main
        defw    roms
        defw    upgrad
        defw    menu3
        defw    menu4
        defw    exit

rst30   pop     hl
        outi
        ld      b, (zxuno_port >> 8)+2
        outi
        jp      (hl)

; ----------------------
; THE 'KEYBOARD' ROUTINE
; ----------------------
rst38   push    af
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

start   im      1
        ld      de, fincad-1    ; descomprimo cadenas
        ld      hl, finstr-1
        call    dzx7b
        ld      hl, $b000
        ld      de, $b400
start1  ld      b, $04
start2  ld      a, (hl)
        rrca
        rrca
        ld      (de), a
        inc     de
        cpi
        jp      pe, start2
        jr      nc, start1
        ld      a, (quietb)
        out     ($fe), a
        dec     a
        jr      z, start4
        ld      hl, finlog-1
        ld      de, $7aff
        call    dzx7b           ; descomprimir
        inc     l
        inc     hl
        ld      b, $40          ; filtro RCS inverso
start3  ld      a, b
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
        jr      z, start3
        ld      b, $13
        ldir
        ld      bc, $0909
        ld      ix, cad1        ; imprimir cadenas BOOT screen
        call_prnstr             ; http://zxuno.speccy.org
        ld      bc, $020d
        call_prnstr             ; ZX-Uno BIOS v0.220
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
start4  ld      d, a
        pop     af
        jr      nz, start5
        ld      d, a
start5  djnz    start6
        dec     de
        ld      a, d
        or      e
        jp      z, alto conti
start6  ld      a, (codcnt)
        sub     $80
        jr      c, start5
        ld      (codcnt), a
        cp      $0c
        jp      z, boot
        cp      $17
        jr      nz, start5

;++++++++++++++++++++++++++++++++++
;++++++++    Enter Setup   ++++++++
;++++++++++++++++++++++++++++++++++
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
bios1   ld      ix, cad8
        call_prnstr             ; |        |     |
        dec     iyh
        jr      nz, bios1
        call_prnstr             ; borde medio
bios2   ld      ix, cad8
        call_prnstr             ; |        |     |
        dec     iyl
        jr      nz, bios2
        ld      ix, cad9
        call_prnstr             ; borde inferior
        call_prnstr             ; info
bios3   ld      a, $07
        out     ($fe), a
        call    bios4
        jr      bios3
bios4   ld      a, %00111001    ; fondo blanco tinta azul
        ld      hl, $0102
        ld      de, $1814
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
        ld      sp, stack-2
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

;****  Main Menu  ****
;*********************
main    inc     d
        ld      h, l
        call    help
        ld      ix, cad10
        ld      bc, $0202
        call    prnmul          ; Harward tests ...
        ld      iy, quietb
        ld      bc, $0f0a
main1   ld      a, (iy)
        ld      ix, cad24
        dec     a
        jr      nz, main2
        ld      ixl, cad25 & $ff
main2   call_prnstr
        inc     iyl
        ld      a, keyiss&$ff
        cp      iyl
        jr      nz, main1
        ld      a, (iy)
        ld      ixl, cad26 & $ff
        dec     a
        jr      nz, main3
        ld      ixl, cad27 & $ff
main3   call_prnstr
        ld      de, $1201
        call    listas
        defb    $04
        defb    $05
        defb    $06
        defb    $0a
        defb    $0b
        defb    $0c
        defb    $0d
        defb    $0e
        defb    $ff
        defw    cad14
        defw    cad15
        defw    cad16
        defw    cad17
        defw    cad56
        defw    cad18
        defw    cad19
        defw    cad20
        jr      c, main6
        ld      (menuop+1), a
        cp      3
        ld      h, divmap >> 8
        jr      c, main5
        add     a, $1e
        ld      l, a
        cp      keyiss&$ff
        jr      z, main4
        call    popupw
        defw    cad28
        defw    cad29
        defw    $ffff
        ret
main4   call    popupw
        defw    cad30
        defw    cad31
        defw    $ffff
        ret
main5   ld      l, $25
        call    popupw
        defw    cad23
        defw    $ffff
        ret
main6   cp      $0c
        call    z, roms8
        cp      $16
        call    z, romsa
        ld      hl, (menuop)
        cp      $1e
        jr      nz, main7
        dec     l
        jp      p, maina
main7   cp      $1f
        jr      nz, main8
        res     2, l
        dec     l
        jr      nz, maina
main8   ld      a, iyl
        dec     a
        ld      (menuop+1), a
        ret
main9   call    waitky
maina   ld      hl, (menuop)
        cp      $0c
        call    z, roms8
        cp      $16
        call    z, romsa
        sub     $1e
        jr      nz, maind
        dec     l
        jp      m, main9
mainb   ld      a, l
        ld      h, 0
        dec     a
        jr      nz, mainc
        ld      a, (active)
        ld      h, a
mainc   ld      (menuop), hl
        ret
maind   dec     a
        jr      nz, main9
        inc     l
        ld      a, l
        cp      6
        jr      z, main9
        jr      mainb

;****  Roms Menu  ****
;*********************
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
        ld      iy, indexe
        ld      ix, cmbpnt
        ld      de, tmpbuf
        ld      b, e
        ld      a, %00111001
        ld      (colcmb), a
roms1   ld      l, (iy)
        inc     l
        jr      z, roms5
        dec     l
        add     hl, hl
        add     hl, hl
        ld      h, 9
        add     hl, hl
        inc     h
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ld      c, (hl)
        set     5, l
        ld      (ix+0), e
        ld      (ix+1), d
        inc     ixl
        inc     ixl
        ld      a, (active)
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
        jr      nc, roms9
roms8   push    af
        ld      a, 1
        call    exitg
        pop     af
        ret
roms9   jp      z, roms15
        sub     $16-$0d
        jr      nz, romsb
romsa   push    af
        call    exitg
        pop     af
        ret
romsb   sub     $1e-$16
        jp      z, roms27
        dec     a
        jp      z, roms27
        sub     $6e-$1f         ; n= New Entry
        jp      nz, roms14
        call    loadta
        jp      nc, roms12
        ld      hl, %00001010
romsc   ld      (offsel), hl
        ld      bc, $7ffd
        out     (c), h
        call    romcyb
        push    bc
        ld      ix, tmpbuf+$40
        call_prnstr
        inc     (ix-8)
        ld      ix, $c000
        ld      de, $4000
        call    lbytes
        pop     bc
        jp      nc, roms12
        ld      b, $17
        ld      ix, cad53
        call_prnstr
        ld      hl, (offsel)
        inc     h
        rr      l
        jr      nc, romsd
        inc     h
romsd   dec     iyh
        jr      nz, romsc
        ei
        call    romcyb
        ld      ix, cad54
        call_prnstr
        ld      hl, %0100011101000111 ; fondo negro tinta blanca
        ld      ($5800+11*32+18), hl
        ld      hl, $0200
        dec     c
        ld      b, $18
        call    inputv
        ld      a, (codcnt)
        rrca
        ret     nc
        ld      hl, items
        ld      a, l
        dec     (hl)
        ld      l, empstr & $ff
        ret     m
        jr      z, romsf
;        add     a, (hl)
;        ld      b, a
;        sub     (hl)
romse   add     a, 10
;        djnz    romse
        inc     l
romsf   add     a, (hl)
        cp      20
        ret     nc
        push    af
        adc     a, c
;        add     a, 12
        rlca
        rlca
        rlca
        ld      l, a
        ld      h, 0
        add     hl, hl
        add     hl, hl
        add     hl, hl
        ex      de, hl
        exx
        call    nument
        dec     l
        ld      e, l
        ld      a, -1
romst   inc     a
        ld      b, e
        ld      l, 0
romsu   cp      (hl)
        jr      z, romst
        inc     l
        djnz    romsu
        ld      (hl), a
        add     a, a
        add     a, a
        ld      l, a
        ld      h, 9
        add     hl, hl
        inc     h
        add     hl, hl
        add     hl, hl
        add     hl, hl
        pop     af
        ld      (hl), a
        inc     l
        ex      de, hl
        ld      hl, tmpbuf
        ld      a, (hl)
        ld      iyh, a
        ld      c, $3f
        ldir
        ld      hl, %00001010
roms10  ld      (offsel), hl
        ld      bc, $7ffd
        out     (c), h
        ld      bc, zxuno_port+$100
        ld      a, $40
        ld      hl, $c000
        exx
        call    wrflsh
        inc     de
        exx
        ld      hl, (offsel)
        inc     h
        rr      l
        jr      nc, roms11
        inc     h
roms11  dec     iyh
        jr      nz, roms10
        ret
roms12  call    romcyb
        ld      ix, cad50
roms13  call_prnstr
        ei
        call    romcyb
        ld      ix, cad51
        call_prnstr
        jp      waitky
roms14  sub     $72-$6e         ; r= Recovery
        jr      nz, roms149
        ld      hl, $0309
        ld      de, $1b08
        ld      a, %00000111    ; fondo negro tinta blanca
        call    window
        dec     h
        dec     l
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        sub     l               ; fondo negro tinta blanca
        ld      iyl, 4
        ld      hl, $030c
        ld      de, $1801
        ld      ix, cad63
        call    window
        ld      bc, $0208
        call    prnmul
        ld      bc, $040c
        ld      hl, $20ff
        call    inputv

        ld      bc, $040e
        ld      hl, $02ff
        call    inputv

  di
  halt
        ret

roms149 ld      a, (menuop+1)
        jp      roms7
roms15  ld      hl, tmpbuf
        ld      (hl), 1
roms16  call    popupw
        defw    cad32
        defw    cad33
        defw    cad34
        defw    cad35
        defw    cad36
        defw    $ffff
        ld      a, (codcnt)
        sub     $0e
        jr      nc, roms16
        inc     a
        ret     nz
        ld      a, (menuop+1)
        ld      b, (hl)
        inc     b
        djnz    roms1a
        or      a               ; move up
        ret     z
        ld      hl, active
        ld      b, (hl)
        cp      b
        jr      nz, roms17
        dec     (hl)
roms17  dec     a
        cp      b
        jr      nz, roms18
        inc     (hl)
roms18  ld      (menuop+1), a
roms19  ld      l, a
        ld      a, (hl)
        inc     l
        ld      b, (hl)
        ld      (hl), a
        dec     l
        ld      (hl), b
        ret
roms1a  djnz    roms1b
        ld      (active), a     ; set active
        ret
roms1b  djnz    roms1f
        ld      b, a            ; move down
        call    nument
        sub     2
        cp      b
roms1c  ret     z
        ld      a, b
        ld      l, $20
        ld      b, (hl)
        cp      b
        jr      nz, roms1d
        inc     (hl)
roms1d  inc     a
        cp      b
        jr      nz, roms1e
        dec     (hl)
roms1e  ld      (menuop+1), a
        dec     a
        jr      roms19
roms1f  djnz    roms23
        ld      l, a            ; rename
        ld      h, indexe >> 8
        ld      a, (hl)
        inc     a
        rlca
        rlca
        ld      l, a
        ld      h, 9
        add     hl, hl
        inc     h
        add     hl, hl
        add     hl, hl
        add     hl, hl
        push    hl
        ld      de, empstr
        call    str2tmp
        ld      hl, $0309
        ld      de, $1b07
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
        ld      bc, $0208
        call_prnstr
        call_prnstr
        call_prnstr
roms20  push    ix
        call_prnstr
        pop     ix
        dec     iyl
        jr      nz, roms20
        call_prnstr
        call_prnstr
        ld      bc, $040c
        ld      hl, $20ff
        call    inputs
        ld      hl, $1708
        ld      de, $0708
        ld      a, %00111001    ; fondo blanco tinta azul
        call    window
        ld      a, (codcnt)
        cp      $0c
        pop     hl
        jr      z, roms1c
        ld      a, (items)
        or      a
        jr      z, roms1c
        ld      c, a
        sub     32
        jr      z, roms22
        cpl
roms21  dec     hl
        ld      (hl), 32
        dec     a
        jp      p, roms21
roms22  dec     l
        ex      de, hl
        ld      h, empstr>>8
        ld      a, empstr-1&$ff
        add     a, c
        ld      l, a
        lddr
        ret
roms23  ld      hl, active      ; delete
        cp      (hl)
        jr      c, roms24
        ld      l, (hl)
        inc     l
        ld      b, (hl)
        inc     b
        jr      nz, roms25
        dec     l
        ret     z
        ld      l, $20
roms24  dec     (hl)
roms25  ld      l, a
roms26  inc     l
        ld      a, (hl)
        dec     l
        ld      (hl), a
        inc     l
        or      a
        jp      p, roms26
        add     a, l
        ld      hl, menuop+1
        cp      (hl)
        ret     nz
        dec     (hl)
        ret
roms27  ld      hl, $0104
        ld      d, $12
        ld      a, (items+1)
        ld      e, a
        ld      a, %00111001
        call    window
        ld      a, (codcnt)
        jp      maina

;*** Upgrade Menu ***
;*********************
upgrad  ld      h, 9
        ld      d, 7
        call    help
        ld      ix, cad57
        ld      bc, $0202
        call_prnstr             ; Upgrade machine
        call_prnstr             ; Upgrade BIOS
        ld      de, $1201
        call    listas
        defb    $02
        defb    $03
        defb    $ff
        defw    cad58
        defw    cad59
        jp      c, main6
        ld      (menuop+1), a
        ld      ix, upgra1
        call    delhel
upgra1  ld      sp, stack-2
        call    loadta
        jp      nc, roms12
        ld      hl, (menuop+1)
        rr      l
        jr      c, upgra5
        cp      $3c
        jp      nz, roms12
        ld      de, tmpbuf+$40
        ld      hl, cad60
        ld      bc, cad61-cad60
        ldir
        call    romcyb
        ld      ix, tmpbuf+$40
        call_prnstr
upgra2  ld      a, tmpbuf+$54 & $ff
        sub     iyh
        ld      l, a
        ld      h, tmpbuf>>8
        ld      (hl), 'o'
        call    shaon
        ld      ix, $4000
        ld      de, $4000
        call    lbytes
        push    af
        ld      a, 21
        sub     iyh
        call    alto copyme
        call    shaoff
        pop     af
        jp      nc, roms12
        dec     iyl
        call    romcyb
        ld      ix, tmpbuf+$40
        call_prnstr
        dec     iyh
        jr      nz, upgra2
        ld      iyh, 12
        call    shaon
        exx
upgra3  ld      a, 21
        sub     iyh
        call    alto saveme
        ld      a, $40
        ld      hl, $4000
        exx
        call    wrflsh
        inc     de
        exx
        dec     iyh
        jr      nz, upgra3
        call    shaoff
        call    romcyb
        ld      ix, cad61
upgra4  jp      roms13
upgra5  cp      $31
        jp      nz, roms12
        ld      a, (tmpbuf+1)
        cp      $ca
        jp      nz, roms12
        call    romcyb
        ld      ix, tmpbuf+$40
        call_prnstr
        ld      ix, $c000
        ld      de, $4000
        call    lbytes
        jp      nc, roms12
        ld      bc, $170a
        ld      ix, cad53
        call_prnstr
        call    check
        ld      hl, (tmpbuf+7)
        sbc     hl, de
        jp      nz, roms12
        ld      a, $40
        ld      hl, $c000
        ld      bc, zxuno_port+$100
        exx
        ld      de, $02c0
        call    wrflsh
        call    romcyb
        ld      ix, cad62
        jr      upgra4

;****  Boot Menu  ****
;*********************
menu3   ld      h, 16
        call    window
        jp      main9

;*** Security Menu ***
;*********************
menu4   ld      h, 20
        ld      d, 8
        call    window
        jp      main9

;****  Exit Menu  ****
;*********************
exit    ld      h, 28
        call    help
        ld      ix, cad37
        ld      bc, $0202
        call_prnstr
        call_prnstr
        call_prnstr
        call_prnstr
        ld      de, $1201
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
        call    bloq1
        ld      ix, cad42
        call_prnstr
        call_prnstr
        call_prnstr
        call_prnstr
        ld      a, (colcmb+1)
        ld      b, a
        djnz    exit1
        ld      ix, cad46
exit1   djnz    exit2
        ld      ix, cad47
exit2   djnz    exit3
        ld      ix, cad48
exit3   ld      bc, $0808
        call_prnstr
        call_prnstr
        call_prnstr
        xor     a
        call    yesno
        dec     a
        ret     z
        ld      a, (codcnt)
        cp      $0c
        ret     z
        ld      a, (colcmb+1)
        ld      b, a
        djnz    exit4
        call    loadch
        jp      alto conti
exit4   djnz    exit5
        jp      savech
exit5   djnz    exit6
        jp      loadch
exit6   call    savech
        jp      alto conti

;++++++++++++++++++++++++++++++++++
;++++++++     Boot list    ++++++++
;++++++++++++++++++++++++++++++++++
boot    call    clrscr          ; borro pantalla
        call    nument
        cp      13
        jr      c, boot1
        ld      a, 13
boot1   ld      h, a
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
boot2   ld      ix, cad4
        call_prnstr             ; |                |
        dec     iyh
        jr      nz, boot2
        ld      ix, cad3
        call_prnstr             ; |----------------|
        ld      ix, cad5 
        call_prnstr
        call_prnstr
        call_prnstr
        call_prnstr
        ld      iy, indexe
        ld      ix, cmbpnt
        ld      de, tmpbuf
        ld      b, e
boot3   ld      l, (iy)
        inc     iyl
        inc     l
        add     hl, hl
        add     hl, hl
        ld      h, 9
        add     hl, hl
        inc     h
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
        jr      nc, boot3
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
        ld      a, (active)
boot4   call    combol
        ld      b, a
        ld      a, (codcnt)
        cp      $0d
        ld      a, b
        jr      c, boot5
        jr      nz, boot4
        ld      a, (items)
        dec     a
        cp      b
        ld      a, $17
        jp      z, bios
        ld      a, b
        ld      (active), a
boot5   jp      alto conti


; -------------------------------------
; Prits a blank line in the actual line
; -------------------------------------
romcyb  ld      a, iyl
romcy1  sub     5
        jr      nc, romcy1
        add     a, 5+9
        ld      c, a
        inc     iyl
        ld      b, 8
        ld      ix, cad42
        call_prnstr
        inc     b
        dec     c
        ret

; -------------------------------------
; Generates a determined box with shadow
; -------------------------------------
bloq1   ld      hl, $0709
        ld      de, $1207
        ld      a, %00000111     ;%00000111 fondo negro tinta blanca
        call    window
        dec     h
        dec     l
        ld      a, %01001111    ; fondo azul tinta blanca
        call    window
        ld      bc, $080b
        ret

; -------------------------------------
;  Carry: 0 -> from 4000 to C000, shadow on , pre  page
;         1 -> from C000 to 4000, shadow off, post page
; -------------------------------------
shaoff  scf
shao1   ld      bc, $4000
        ld      d, b
        ld      e, c
        ld      hl, $c000
        jr      c, shao2
        ex      de, hl
shao2   ldir
        ret     nc
        ld      a, $07
        defb    $d2
shaon   ld      a, $0f
        ld      bc, $7ffd
        out     (c), a
        jr      nc, shao1
        ret

; -------------------------------------
; Shows the window of Load from Tape
; -------------------------------------
loadta  ld      ix, cad49
        call    prnhel
        call    bloq1
        dec     c
        dec     c
        ld      iyl, 5
loadt1  ld      ix, cad42
        call_prnstr
        dec     iyl
        jr      nz, loadt1
        ld      ixl, cad43 & $ff
        call_prnstr
        ld      ixl, cad44 & $ff
        ld      c, b
        call_prnstr
        call    romcyb
        ld      ixl, cad45 & $ff
        call_prnstr
        ld      ix, tmpbuf
        ld      de, $003f
        call    lbytes
        ld      bc, $1109
        ret     nc
        ld      hl, tmpbuf+$2c
        ld      a, (hl)
        push    af
        ld      (hl), 0
        ld      ixl, $1f
        call_prnstr
        pop     af
        ld      (tmpbuf+$2c), a
        ld      de, tmpbuf+$40
        ld      hl, cad52
        ld      bc, cad53-cad52
        ldir
loadt2  ld      a, (tmpbuf)
        ld      iyh, a
        sub     $d0
        ld      (tmpbuf+$4b), a
        ret

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
str2t1  dec     hl
        dec     c
        ld      a, (hl)
        cp      $20
        jr      z, str2t1
        pop     hl
        ld      a, l
        sub     $20
        ld      l, a
        jr      nc, str2t2
        dec     h
str2t2  ldir
        xor     a
        ld      (de), a
        inc     de
        ret

; -------------------------------------
; Read number of boot entries
; Returns:
;    A: number of boot entries
; -------------------------------------
nument  ld      hl, indexe
numen1  ld      a, (hl)         ; calculo en L el número de entradas
        inc     l
        inc     a
        jr      nz, numen1
        ld      a, l
        ret

; -------------------------------------
; Input a string by the keyboard
; Parameters:
; empstr: input and output string
;     HL: max length (H) and cursor position (L)
;     BC: X coord (B) and Y coord (C)
; -------------------------------------
inputv  xor     a
        ld      (empstr), a
inputs  ld      (offsel), hl
input1  push    bc
        ld      ix, empstr
        call_prnstr
        push    ix
        pop     hl
        ld      a, l
        sub     empstr+1&$ff
        ld      (items), a
        ld      r, a
        ld      e, a
        add     a, b
        ld      b, a
        ld      a, (offsel)
        inc     a
        jr      nz, input2
        ld      a, e
        ld      (offsel), a
input2  ld      de, (offsel)
        ld      e, ' '
        defb    $32
input3  ld      (hl), e
        inc     l
        ld      a, l
        sub     empstr+2&$ff
        sub     d
        jr      nz, input3
        ld      (hl), a
        dec     c
        call_prnstr
        pop     bc
input4  ld      a, r
        cpl
        ld      r, a
        call    cursor
        ld      h, $80
input5  ld      a, (codcnt)
        sub     $80
        jr      nc, input7
        dec     l
        jr      nz, input5
        dec     h
        jr      nz, input5
input6  jr      input4
input7  ld      (codcnt), a
        cp      $0e
        jr      nc, input8
        ld      a, r
        ret     p
cursor  ld      a, (offsel)
        add     a, b
        ld      l, a
        and     %11111100
        ld      d, a
        xor     l
        ld      h, $80
        ld      e, a
        jr      z, curso1
        dec     e
curso1  xor     $fc
curso2  rrc     h
        rrc     h
        inc     a
        jr      nz, curso2
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
curso3  ld      a, (de)
        xor     h
        ld      (de), a
        inc     d
        dec     l
        jr      nz, curso3
        ret
input8  ld      hl, (offsel)
        cp      $18
        jr      nz, input9
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
        jr      inputc
input9  sub     $1e
        jr      nz, inputb
        dec     l
        jp      m, input1
inputa  jp      inputs
inputb  dec     a
        ld      a, (items)
        jr      nz, inputd
        cp      l
        jr      nz, inpute
inputc  jp      input1
inputd  cp      h
        jr      z, input6
        ld      a, l
        add     a, empstr&$ff
        ld      l, a
        ld      h, empstr>>8
        ld      a, (codcnt)
        inc     (hl)
        dec     (hl)
        jr      nz, inputf
        ld      (hl), a
        inc     l
        ld      (hl), 0
inpute  ld      hl, (offsel)
        inc     l
        jr      inputa
inputf  ex      af, af'
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
        jr      inpute

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
combol  push    hl
        push    de
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
        pop     hl
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
listas  ld      a, (menuop+1)
        inc     a
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
        call    prnhel
        call    waitky
        ld      a, (codcnt)
        cp      $0d
        jr      z, listaa
        ld      ix, lista5
; -------------------------------------
; Deletes the upper right area (help)
; -------------------------------------
delhel  di
        ld      c, $9
        ld      hl, $405f
        ld      de, 0
delhe1  ld      b, 8
delhe2  ld      sp, hl
        push    de
        push    de
        push    de
        push    de
        push    de
        inc     sp
        push    de
        inc     h
        djnz    delhe2
        ld      a, l
        add     a, $20
        ld      l, a
        jr      c, delhe3
        ld      a, h
        sub     8
        ld      h, a
delhe3  dec     c
        jr      nz, delhe1
        ei
        jp      (ix)
lista5  ld      sp, stack-8
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
        jp      nc, lista2
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
listaa  pop     de
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
; -------------------------------------
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
        ld      ix, cad21
        ld      b, $0c
        ld      c, l
        call_prnstr
popup2  ld      ix, cad22
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

; ------------------------
; Clear the screen
; ------------------------
clrscr  ld      hl, $4000
        ld      de, $4001
        ld      bc, $17ff
        ld      (hl), l
        ldir
        ret

; -------------------------------
; Prints some lines, end with 0,0
; -------------------------------
prnhel  ld      bc, $1b02
prnmul  call_prnstr
        add     a, (ix)
        jr      nz, prnmul
        inc     ix
        ret

; ------------------------
; Save flash structures from $9500 to $2b500 and from $9800 to $2b800
; ------------------------
      IF  debug
wrflsh
savech  ret
      ELSE
savech  ld      bc, zxuno_port+$100
        ld      a, $10
        ld      hl, config
        exx
        ld      de, $02b0

; ------------------------
; Write to SPI flash
; Parameters:
;    A: number of pages (256 bytes) to write
;   DE: target address without last byte
;  BC': zxuno_port+$100 (constant)
;  HL': source address from memory
; ------------------------
wrflsh  ex      af, af'
        xor     a
        ld      bc, zxuno_port+$100
wrfls1  wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 6    ; envío write enable
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, $20  ; envío sector erase
        out     (c), d
        out     (c), e
        out     (c), a
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
wrfls2  call    waits5
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
wrfls3  inc     b
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
        jr      nz, wrfls3
        exx
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        ex      af, af'
        dec     a
        jr      z, waits5
        ex      af, af'
        inc     e
        ld      a, e
        and     $0f
        jr      nz, wrfls2
        ld      hl, wrfls1
        push    hl
waits5  wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 5    ; envío read status
        in      a, (c)
waits6  in      a, (c)
        and     1
        jr      nz, waits6
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
        ret
      ENDIF

; ------------------------
; Load flash structures from $29000 to $9000
; ------------------------
loadch  ld      bc, zxuno_port+$100
        wreg    flash_cs, 1
        ld      de, config
        ld      hl, $02b0
        ld      a, $10
        jp      alto rdflsh

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

lbytes  di                      ; disable interrupts
        ld      a, $0f          ; make the border white and mic off.
        out     ($fe), a        ; output to port.
        push    ix
        pop     hl              ; pongo la direccion de comienzo en hl
        ld      c, 2
        exx                     ; salvo de, en caso de volver al cargador estandar y para hacer luego el checksum
        ld      c, a
ultr0   defb    $2a             ; en (1220) bit bajo de l=1 alto de h=0
ultr1   jr      nz, ultr3       ; return if at any time space is pressed.
ultr2   ld      b, 0
        call    lsampl          ; leo la duracion de un pulso (positivo o negativo)
        jr      nc, ultr1       ; si el pulso es muy largo retorno a bucle
        ld      a, b
        cp      40              ; si el contador esta entre 24 y 40
        jr      nc, ultr4       ; y se reciben 8 pulsos (me falta inicializar hl a 00ff)
        cp      24
        rl      l
        jr      nz, ultr4
ultr3   exx
lbreak  ret     nz              ; return if at any time space is pressed.
lstart  call    ldedg1          ; routine ld-edge-1
        jr      nc, lbreak      ; back to ld-break with time out and no edge present on tape
        xor     a               ; set up 8-bit outer loop counter for approx 0.45 second delay
ldwait  add     hl, hl
        djnz    ldwait          ; self loop to ld-wait (for 256 times)
        dec     a               ; decrease outer loop counter.
        jr      nz, ldwait      ; back to ld-wait, if not zero, with zero in b.
        call    ldedg2          ; routine ld-edge-2
        jr      nc, lbreak      ; back to ld-break if no edges at all.
leader  ld      b, $9c          ; two edges must be spaced apart.
        call    ldedg2          ; routine ld-edge-2
        jr      nc, lbreak      ; back to ld-break if time-out
        ld      a, $c6          ; two edges must be spaced apart.
        cp      b               ; compare
        jr      nc, lstart      ; back to ld-start if too close together for a lead-in.
        inc     h               ; proceed to test 256 edged sample.
        jr      nz, leader      ; back to ld-leader while more to do.
ldsync  ld      b, $c9          ; two edges must be spaced apart.
        call    ldedg1          ; routine ld-edge-1
        jr      nc, lbreak      ; back to ld-break with time-out.
        ld      a, b            ; fetch augmented timing value from b.
        cp      $d4             ; compare 
        jr      nc, ldsync      ; back to ld-sync if gap too big, that is, a normal lead-in edge gap
        call    ldedg1          ; routine ld-edge-1
        ret     nc              ; return with time-out.
        ld      a, c            ; fetch long-term mask from c
        xor     $03             ; and make blue/yellow.
        ld      c, a            ; store the new long-term byte.
        jr      marker          ; forward to ld-marker 
ldloop  ex      af, af'         ; restore entry flags and type in a.
        jr      nz, ldflag      ; forward to ld-flag if awaiting initial flag, to be discarded
        ld      (ix), l         ; place loaded byte at memory location.
        inc     ix              ; increment byte pointer.
        dec     de              ; decrement length.
        defb    $c2
ldflag  inc     l               ; compare type in a with first byte in l.
        ret     nz              ; return if no match e.g. code vs. data.
marker  ex      af, af'         ; store the flags.
        ld      l, $01          ; initialize as %00000001
l8bits  ld      b, $b2          ; timing.
        call    ldedg2          ; routine ld-edge-2 increments b relative to gap between 2 edges
        ret     nc              ; return with time-out.
        ld      a, $cb          ; the comparison byte.
        cp      b               ; compare to incremented value of b.
        rl      l               ; rotate the carry bit into l.
        jr      nc, l8bits      ; jump back to ld-8-bits
        ld      a, h            ; fetch the running parity byte.
        xor     l               ; include the new byte.
        ld      h, a            ; and store back in parity register.
        ld      a, d            ; check length of
        or      e               ; expected bytes.
        jr      nz, ldloop      ; back to ld-loop while there are more.
        ld      a, h            ; fetch parity byte.
        cp      1               ; set carry if zero.
        ret                     ; return
ultr4   cp      16              ; si el contador esta entre 10 y 16 es el tono guia
        rr      h               ; de las ultracargas, si los ultimos 8 pulsos
        cp      10              ; son de tono guia h debe valer ff
        jr      nc, ultr2
        inc     h
        inc     h
        jr      nz, ultr0       ; si detecto sincronismo sin 8 pulsos de tono guia retorno a bucle
        call    lsampl          ; leo pulso negativo de sincronismo
        ld      l, $01          ; hl vale 0001, marker para leer 16 bits en hl (checksum y byte flag)
        call    get16           ; leo 16 bits, ahora temporizo cada 2 pulsos
        ld      a, l
        inc     l               ; lo comparo con el que me encuentro en la ultracarga
        ret     nz              ; salgo si no coinciden
        xor     h               ; xoreo el checksum con en byte flag, resultado en a
        exx                     ; guardo checksum por duplicado en h' y l'
        push    hl              ; pongo direccion de comienzo en pila
        ld      c, a
        ld      a, $d8          ; a' tiene que valer esto para entrar en raudo
        ex      af, af'
        exx
        ld      h, $01          ; leo 8 bits en hl
        call    get16
        push    hl
        pop     ix
        pop     de              ; recupero en de la direccion de comienzo del bloque
        rr      c               ; pongo en flag z el signo del pulso
        ld      bc, $effe       ; este valor es el que necesita b para entrar en raudo
        jp      nc, ult55
        ld      h, $3e
ultr5   in      f, (c)
        jp      pe, ultr5
        call    l3ec3           ; salto a raudo segun el signo del pulso en flag z
        jr      ultr7
ult55   ld      h, $3c
ultr6   in      f, (c)
        jp      po, ultr6
        call    l3d03           ; salto a raudo
ultr7   exx                     ; ya se ha acabado la ultracarga (raudo)
        ld      b, e
        ld      e, c
        ld      c, d
        sbc     a, a
        inc     b
        dec     b
        jr      z, ultr8
        inc     c
ultr8   xor     (hl)
        inc     hl
        djnz    ultr8
        dec     c
        jp      nz, ultr8
        push    hl              ; ha ido bien
        xor     e
        pop     ix              ; ix debe apuntar al siguiente byte despues del bloque
        ret     nz              ; si no coincide el checksum salgo con carry desactivado
        scf
        ret
ldedg2  call    ldedg1          ; call routine ld-edge-1 below.
        ret     nc              ; return if space pressed or time-out.
ldedg1  ld      a, $16          ; a delay value of twenty two.
ldelay  dec     a               ; decrement counter
        jr      nz, ldelay      ; loop back to ld-delay 22 times.
        and     a               ; clear carry.
lsampl  inc     b               ; increment the time-out counter.
        ret     z               ; return with failure when $ff passed.
        ld      a, $7f          ; prepare to read keyboard and ear port
        in      a, ($fe)        ; row $7ffe. bit 6 is ear, bit 0 is space key.
        rra                     ; test outer key the space. (bit 6 moves to 5)
        ret     nc              ; return if space pressed.  >>>
        xor     c               ; compare with initial long-term state.
        and     $20             ; isolate bit 5
        jr      z, lsampl       ; back to ld-sample if no edge.
        ld      a, c            ; fetch comparison value.
        xor     $27             ; switch the bits
        ld      c, a            ; and put back in c for long-term.
        out     ($fe), a        ; send to port to effect the change of colour. 
        scf                     ; set carry flag signaling edge found within time allowed
        ret                     ; return.
get16   ld      b, 0
        call    lsampl
        call    lsampl
        ld      a, b
        cp      12
        adc     hl, hl
        jr      nc, get16
        ret

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


; after 1 second continue boot
      IF  debug
saveme
copyme
conti   ld      a, 2
        out     ($fe), a
        di
        halt

rdflsh  ld      a, h
        cp      $02
        ret     nz
        ld      a, l
        cp      $b0
        ret     nz
        ld      bc, l02b8-l02b5
        ld      hl, l02b5
        ld      d, $95
        ldir
        ld      de, $9800
        ld      bc, l0300-l02b8
        ldir
        ret
;  00-1f: index to entries
;  20: active entry
;  21: fast boot    0: Disable, 1: Enable
;  22: Check CRC    0: Disable, 1: Enable
;  23: DivMMC       0: Disable, 1: Enable
;  24: NMI-DivMMC   0: Disable, 1: Enable
;  25: Issue        0: Issue 2, 1: Issue 3
l02b5   defb    $02, $01, $00, $03, $02, $01, $00, $03
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $03             ; active
        defb    $00             ; quiet
        defb    $01             ; checkcrc
        defb    $00             ; DivMMC
        defb    $01             ; NMI-DivMMC
        defb    $01             ; Issue
        defb    0   ; para que not implemented sea 0

; 32 entradas
;    00: slot offset
;    01: slot size
;    02: RAM offset     
;    03: ROM SRAM size
;    04: port 1ffd
;    05: port 7ffd
;    ...
;    10-1f: CRCs
;    20-3f: Name
l02b8   defb    $00, 1, $08, 1, $00, $00, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K Cargando Leches '
        defb    $01, 4, $08, 4, $00, $00, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX +3e DivMMC                   '
        defb    $05, 2, $0a, 2, $04, $00, $ff, $ff ;$04
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'SE Basic IV 4.0 Anya            '
        defb    $07, 1, $08, 1, $00, $00, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K                 '
l0300
      ELSE

;++++++++++++++++++++++++++++++++++
;++++++++    Start ROM     ++++++++
;++++++++++++++++++++++++++++++++++
conti   di
        ld      a, %00101000    ; leo 3 bits
        ld      hl, keyiss
conti1  rr      (hl)
        adc     a, a
        dec     l
        jr      nc, conti1
        add     a, a
        xor     %00001100       ; invierto I2KB y DISNMI
        ld      (alto conti9+1), a
        ld      bc, zxuno_port+$100
        wreg    master_conf, 1
        and     $02
        jr      z, conti3
        wreg    master_mapper, 12
        ld      hl, $0295
        ld      de, $c000
        ld      a, $20
        call    alto rdflsh
        ld      a, 16
conti2  ld      de, $c000 | master_mapper
        dec     b
        out     (c), e
        inc     b
        push    bc
        out     (c), a
        ld      bc, $3fff
        ld      hl, $c000
        ld      (hl), l
        ldir
        pop     bc
        inc     a
        cp      24
        jr      nz, conti2
conti3  ld      hl, active
        ld      l, (hl)
        ld      l, (hl)
        add     hl, hl
        add     hl, hl
        ld      h, 9
        add     hl, hl
        inc     h
        add     hl, hl
        add     hl, hl
        add     hl, hl
        push    hl
        pop     ix
conti4  ld      a, (ix+1)
        ld      iyl, a
        ld      a, (ix)
        add     a, 12
        rlca
        rlca
        rlca
        ld      l, a
        ld      h, 0
        add     hl, hl
        add     hl, hl
        add     hl, hl
conti5  ld      a, master_mapper
        dec     b
        out     (c), a
        inc     b
        ld      a, (ix+2)
        inc     (ix+2)
        out     (c), a
        ld      de, $c000
        ld      a, $40
        call    alto rdflsh
        ld      a, (checkc)
        dec     a
        jr      nz, conti8
        push    hl
        call    alto check
        push    ix
        ld      a, iyl
        add     a, a
        add     a, ixl
        ld      ixl, a
        ld      l, (ix+$06)
        ld      h, (ix+$07)
        sbc     hl, de
        jr      z, conti7
        add     hl, de
        push    de
        ld      de, cad55+33
        call    alto wtohex
        pop     hl
        ld      e, cad55+19&$ff
        call    alto wtohex
        ld      ix, cad55
        ld      bc, $0016
        call    alto prnstr-1
        call    alto prnstr-1
        ld      c, $fe
conti6  in      a, (c)
        or      $e0
        inc     a
        jr      z, conti6
conti7  ld      bc, zxuno_port+$100
        pop     ix
        pop     hl
conti8  ld      de, $0040
        add     hl, de
        dec     (ix+3)
        jr      z, conti9
        dec     iyl
        jr      z, conti4
        jr      conti5
conti9  ld      a, 0
        dec     b
        out     (c), d
        inc     b
        out     (c), a
        ld      bc, $1ffd
        ld      a, (ix+4)
        out     (c), a
        ld      b, $7f
        ld      a, (ix+5)
        out     (c), a
        rst     0

; -------------------------------------
; Put page A in mode 1 and copies from 4000 to C000
;      A: page number
; -------------------------------------
copyme  ld      bc, zxuno_port+$100
        wreg    master_conf, 1
        ld      de, $c000 | master_mapper
        dec     b
        out     (c), e
        inc     b
        out     (c), a
        dec     e
        push    bc
        ld      bc, $4000
        ld      h, b
        ld      l, c
        ldir
        call    alto check
        pop     bc
        wreg    master_conf, 0
        ld      a, iyh
        add     a, a
        add     a, 5
        ld      l, a
        ld      h, tmpbuf>>8
        ld      c, (hl)
        inc     l
        ld      b, (hl)
        ex      de, hl
        sbc     hl, bc
        ret     z
        pop     de
        add     hl, hl
        ex      (sp), hl
        push    de
        ret

; -------------------------------------
; Put page A in mode 1 and copies from C000 to 4000
;      A: page number
; -------------------------------------
saveme  ld      bc, zxuno_port+$100
        wreg    master_conf, 1
        ld      hl, $c000 | master_mapper
        dec     b
        out     (c), l
        inc     b
        out     (c), a
        dec     l
        push    bc
        ld      bc, $4000
        ld      d, b
        ld      e, c
        ldir
        pop     bc
        wreg    master_conf, 0
        ret

; ------------------------
; Print Hexadecimal number
; Parameters:
;   DE: destination address
;   HL: 4 digit number
; ------------------------
wtohex  ld      b, 4
wtohe1  ld      a, $3
        add     hl, hl
        adc     a, a
        add     hl, hl
        adc     a, a
        add     hl, hl
        adc     a, a
        add     hl, hl
        adc     a, a
        cp      $3a
        jr      c, wtohe2
        add     a, 7
wtohe2  ld      (de), a
        inc     e
        djnz    wtohe1
        ret

; ------------------------
; Read from SPI flash
; Parameters:
;   DE: destination address
;   HL: source address without last byte
;    A: number of pages (256 bytes) to read
; ------------------------
rdflsh  ex      af, af'
        xor     a
        push    hl
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 3    ; envio flash_spi un 3, orden de lectura
        pop     hl
        push    hl
        out     (c), h
        out     (c), l
        out     (c), a
        ex      af, af'
        ex      de, hl
        in      f, (c)
rdfls1  ld      e, $20
rdfls2  ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        ini
        inc     b
        dec     e
        jr      nz, rdfls2
        dec     a
        jr      nz, rdfls1
        wreg    flash_cs, 1
        pop     hl
        ret
      ENDIF

check   ld      c, alto crctab>>8
        ld      hl, $bfff       ;4c2b > d432
        defb    $11
check1  xor     (hl)            ;6*4+4*7+10= 62 ciclos/byte
        ld      e, a
        ex      de, hl
        ld      a, h
        ld      h, c
        xor     (hl)
        inc     h
        ld      h, (hl)
        ex      de, hl
        inc     l
        jp      nz, alto check1
        inc     h
        jr      nz, check1
        ld      e, a
        ret

help    call    window
        ld      a, %00111000    ; fondo blanco tinta negra
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
        push    bc

; -----------------------------------------------------------------------------
; Print string routine
; Parameters:
;  BC: X coord (B) and Y coord (C)
;  IX: null terminated string
; -----------------------------------------------------------------------------
prnstr  ld      a, b
        and     %11111100
        ld      d, a
        xor     b
        ld      e, a
        jr      z, prnch1
        dec     e
prnch1  xor     $fc
        ld      l, a
        ld      h, alto prnstr>>8
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
        ld      h, $2c
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
        ld      h, $2f
        add     hl, hl
        add     hl, hl
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
        ld      h, $2e
        add     hl, hl
        add     hl, hl
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
        ld      h, $2d
        add     hl, hl
        add     hl, hl
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
        jp      alto pos0

        defb    pos0-crctab & $ff
        defb    pos1-crctab & $ff
        defb    pos2-crctab & $ff
        defb    pos3-crctab & $ff

; ----------
; CRC Table
; ----------
crctab  incbin  crctable.bin
        defs    $80

; -----------------------------------------------------------------------------
; 6x8 character set (128 characters x 1 rotation)
; -----------------------------------------------------------------------------
        incbin  fuente6x8.bin
chrend

        block   $3bbf-$

l3bbf   inc     h               ;4
        jr      nc, l3bcd       ;7/12     46/48
        xor     b               ;4
        xor     $9c             ;7
        ld      (de), a         ;7
        inc     de              ;6
        ld      a, $dc          ;7
        ex      af, af'         ;4
        in      l, (c)          ;12
        jp      (hl)            ;4
l3bcd   xor     b               ;4
        add     a, a            ;4
        ret     c               ;5
        add     a, a            ;4
        ex      af, af'         ;4
        out     ($fe), a        ;11
        in      l, (c)          ;12
        jp      (hl)            ;4

        block   $3bff-$         ; X bytes

l3bff   in      l, (c)
        jp      (hl)

        block   $3c0d-$         ; 11 bytes

        defb    $ec, $ec, $01   ; 0d
        defb    $ec, $ec, $02   ; 10
        defb    $ec, $ec, $03   ; 13
        defb    $ec, $ec, $04   ; 16
        defb    $ec, $ec, $05   ; 19
        defb    $ec, $ec, $06   ; 1c
        defb    $ec, $ec, $07   ; 1f
        defb    $ec, $ec, $08   ; 22
        defb    $ec, $ec, $09   ; 25
        defb    $ed, $ed, $0a   ; 28
        defb    $ed, $ed, $0b   ; 2b
        defb    $ed, $ed, $0c   ; 2e
        defb    $ed, $ed, $0d   ; 31
        defb    $ed, $ed, $0e   ; 34
        defb    $ed, $ed, $7f   ; 37
        defb    $ed, $ed, $7f   ; 3a
        defb    $ed, $ed, $7f   ; 3d
        defb    $ed, $ed, $7f   ; 40
        defb    $ed, $ee, $7f   ; 43 --
        defb    $ee, $ee, $7f   ; 46 --
        defb    $ee, $ee, $7f   ; 49
        defb    $ee, $ee, $7f   ; 4c
        defb    $ee, $ee, $7f   ; 4f
        defb    $ee, $ee, $7f   ; 52
        defb    $ee, $ee, $0f   ; 55
        defb    $ee, $ee, $10   ; 58
        defb    $ee, $ee, $11   ; 5b
        defb    $ee, $ef, $12   ; 5e
        defb    $ee, $ef, $13   ; 61
        defb    $ef, $ef, $14   ; 64
        defb    $ef, $ef, $15   ; 67
        defb    $ef, $ef, $16   ; 6a
        defb    $ef, $ef, $17   ; 6d
        defb    $ef, $ef, $18   ; 70
        defb    $ef, $ef, $19   ; 73
        defb    $ef, $ef, $1a   ; 76
        defb    $ef, $1b, $1c   ; 79
        defb    $ef, $1d, $1e   ; 7c
        defb    $ef             ; 7f
        defb    $ec, $ec, $1f   ; 80
        defb    $ec, $ec, $20   ; 83
        defb    $ec, $ec, $21   ; 86
        defb    $ec, $ec, $22   ; 89
        defb    $ec, $ec, $23   ; 8c
        defb    $ed, $ed, $7e   ; 8f
        defb    $ed, $ed, $7d   ; 92
        defb    $ed, $ed, $7f   ; 95
        defb    $ed, $ed, $7f   ; 98
        defb    $ed, $ee, $7f   ; 9b --
        defb    $ee, $ee, $7f   ; 9e
        defb    $ee, $ee, $7f   ; a1
        defb    $ee, $ee, $7d   ; a4
        defb    $ee, $ee, $7e   ; a7
        defb    $ee, $ef, $24   ; aa
        defb    $ef, $ef, $25   ; ad
        defb    $ef, $ef, $26   ; b0
        defb    $ef, $ef, $27   ; b3
        defb    $ef, $ef, $28   ; b6
        defb    $ef, $29, $2a   ; b9
        defb    $2b, $2c, $2d   ; bc
l3cbf   in      l, (c)
        jp      (hl)

        block   $3cff-$         ; 61 bytes

l3cff   ld      a, r            ;9        49 (41 sin borde)
        ld      l, a            ;4
        ld      b, (hl)         ;7
l3d03   ld      a, ixl          ;8
        ld      r, a            ;9
        ld      a, b            ;4
        ex      af, af'         ;4
        dec     h               ;4
        in      l, (c)          ;12
        jp      (hl)            ;4

        block   $3dbf-$         ; 178 bytes

l3dbf   in      l, (c)
        jp      (hl)

        block   $3df5-$         ; 51 bytes

l3df5   xor     b
        add     a, a
        ret     c
        add     a, a
        ex      af, af'
        out     ($fe), a
        in      l, (c)
        jp      (hl)
l3dff   inc     h
        jr      nc, l3df5
        xor     b
        xor     $9c
        ld      (de), a
        inc     de
        ld      a, $dc
        ex      af, af'
        in      l, (c)
        jp      (hl)
        defb    $ec, $ec, $01   ; 0d
        defb    $ec, $ec, $02   ; 10
        defb    $ec, $ec, $03   ; 13
        defb    $ec, $ec, $04   ; 16
        defb    $ec, $ec, $05   ; 19
        defb    $ec, $ec, $06   ; 1c
        defb    $ec, $ec, $07   ; 1f
        defb    $ec, $ec, $08   ; 22
        defb    $ec, $ec, $09   ; 25
        defb    $ed, $ed, $0a   ; 28
        defb    $ed, $ed, $0b   ; 2b
        defb    $ed, $ed, $0c   ; 2e
        defb    $ed, $ed, $0d   ; 31
        defb    $ed, $ed, $0e   ; 34
        defb    $ed, $ed, $7f   ; 37
        defb    $ed, $ed, $7f   ; 3a
        defb    $ed, $ed, $7f   ; 3d
        defb    $ed, $ed, $7f   ; 40
        defb    $ed, $ee, $7f   ; 43 --
        defb    $ee, $ee, $7f   ; 46 --
        defb    $ee, $ee, $7f   ; 49
        defb    $ee, $ee, $7f   ; 4c
        defb    $ee, $ee, $7f   ; 4f
        defb    $ee, $ee, $7f   ; 52
        defb    $ee, $ee, $0f   ; 55
        defb    $ee, $ee, $10   ; 58
        defb    $ee, $ee, $11   ; 5b
        defb    $ee, $ef, $12   ; 5e
        defb    $ee, $ef, $13   ; 61
        defb    $ef, $ef, $14   ; 64
        defb    $ef, $ef, $15   ; 67
        defb    $ef, $ef, $16   ; 6a
        defb    $ef, $ef, $17   ; 6d
        defb    $ef, $ef, $18   ; 70
        defb    $ef, $ef, $19   ; 73
        defb    $ef, $ef, $1a   ; 76
        defb    $ef, $1b, $1c   ; 79
        defb    $ef, $1d, $1e   ; 7c
        defb    $ef             ; 7f
        defb    $ec, $ec, $1f   ; 80
        defb    $ec, $ec, $20   ; 83
        defb    $ec, $ec, $21   ; 86
        defb    $ec, $ec, $22   ; 89
        defb    $ec, $ec, $23   ; 8c
        defb    $ed, $ed, $7e   ; 8f
        defb    $ed, $ed, $7d   ; 92
        defb    $ed, $ed, $7f   ; 95
        defb    $ed, $ed, $7f   ; 98
        defb    $ed, $ee, $7f   ; 9b --
        defb    $ee, $ee, $7f   ; 9e
        defb    $ee, $ee, $7f   ; a1
        defb    $ee, $ee, $7d   ; a4
        defb    $ee, $ee, $7e   ; a7
        defb    $ee, $ef, $24   ; aa
        defb    $ef, $ef, $25   ; ad
        defb    $ef, $ef, $26   ; b0
        defb    $ef, $ef, $27   ; b3
        defb    $ef, $ef, $28   ; b6
        defb    $ef, $29, $2a   ; b9
        defb    $2b, $2c, $2d   ; bc
l3ebf   ld      a, r
        ld      l, a
        ld      b, (hl)
l3ec3   ld      a, ixl
        ld      r, a
        ld      a, b
        ex      af, af'
        dec     h
        in      l, (c)
        jp      (hl)

        block   $3eff-$         ; 50 bytes

l3eff   in      l,(c)
        jp      (hl)


;++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++
;++++++++++++               +++++++++++++
;++++++++++++    MESSAGES   +++++++++++++
;++++++++++++               +++++++++++++
;++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++
        block   $8000-$
cad1    defm    'http://zxuno.speccy.org', 0
        defm    'ZX-Uno BIOS v0.220', 0
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
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $15, 0
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
        defb    '     BIOS v0.220    ', $7f, '2014 ZX-Uno Team', 0
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
        defb    'Check CRC', 0
        defb    'DivMMC', 0
        defb    'NMI-DivMMC', 0
        defb    'Keyboard', 0, 0
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
        defb    'N   New Entry', 0
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
cad18   defb    'Enable RAM and', 0
        defb    'ROM on DivMMC ', 0
        defb    'interface.', 0
        defb    'Ports are', 0
        defb    'available', 0, 0
cad19   defb    'Disable for', 0
        defb    'better compa-', 0
        defb    'tibility with', 0
        defb    'SE Basic IV', 0, 0
cad20   defb    'Behaviour of', 0
        defb    'bit 6 on port', 0
        defb    '$FE depends', 0
        defb    'on hardware', 0
        defb    'issue', 0, 0
cad21   defb    $12, $11, $11, $11, ' Options ', $11, $11, $11, $13, 0
cad22   defb    $10, '               ', $10, 0
        defb    $14, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $15, 0
cad23   defb    'Not implem.', 0
cad24   defb    '[Disabled]', 0
cad25   defb    '[Enabled]', 0
cad26   defb    '[Issue 2]', 0
cad27   defb    '[Issue 3]', 0
cad28   defb    'Disabled', 0
cad29   defb    'Enabled', 0
cad30   defb    'Issue 2', 0
cad31   defb    'Issue 3', 0
cad32   defb    'Move Up', 0
cad33   defb    'Set Active', 0
cad34   defb    'Move Down', 0
cad35   defb    'Rename', 0
cad36   defb    'Delete', 0
        defb    ' ', $12, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    ' Rename ', $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $13, 0
        defb    ' ', $10, ' ', $1e, ' ', $1f, '  Enter accept  Break cancel ', $10, 0
        defb    ' ', $16, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $17, 0
        defb    ' ', $10, '                                 ', $10, 0
        defb    ' ', $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $15, 0
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
cad43   defb    $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $15, 0
        defb    $12, $11, $11, $11, ' Save and Exit ', $11, $11, $11, $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, '  Save conf. & Exit?  ', $10, 0
cad44   defb    $12, $11, $11, $11, ' Load from tape ', $11, $11, $11, $13, 0
cad45   defb    'Header:', 0
cad46   defb    $12, ' Exit Without Saving ', $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, ' Quit without saving? ', $10, 0
cad47   defb    $12, $11, ' Save Setup Values ', $11, $11, $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, '  Save configuration? ', $10, 0
cad48   defb    $12, ' Load Previous Values ', $13, 0
        defb    $10, '                      ', $10, 0
        defb    $10, ' Load previous values?', $10, 0
cad49   defb    'Press play on', 0
        defb    'tape & follow', 0
        defb    'the progress', 0
        defb    'Break to', 0
        defb    'cancel', 0, 0
cad50   defb    'Loading Error', 0
cad51   defb    'Any key to return', 0
cad52   defb    'Block 1 of 1:', 0
cad53   defb    'Done', 0
cad54   defb    'Slot position:', 0
cad55   defb    'Invalid CRC in ROM 0000. Must be 0000', 0
        defb    'Press any key to continue                 ', 0
cad56   defb    'Check CRC in', 0
        defb    'all ROMs. Slow', 0
        defb    'but safer', 0, 0
cad57   defb    'Upgrade machine', 0
        defb    'Upgrade BIOS', 0
cad58   defb    'Upgrade entire', 0
        defb    'machine, BIOS', 0
        defb    'included', 0, 0
cad59   defb    'Upgrade only', 0
        defb    'the BIOS', 0
        defb    'firmware', 0, 0
cad60   defb    'Status:[            ]', 0
cad61   defb    'Machine upgraded', 0
cad62   defb    'BIOS upgraded', 0
cad63   defb    ' ', $12, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    ' Recovery ', $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $11, $13, 0
        defb    ' ', $10, ' ', $1e, ' ', $1f, '  Enter accept  Break cancel ', $10, 0
        defb    ' ', $16, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $17, 0
        defb    ' ', $10, 'Name                             ', $10, 0
        defb    ' ', $10, '                                 ', $10, 0
        defb    ' ', $10, 'Slot Size Bank Size  1FFD  7FFD  ', $10, 0
        defb    ' ', $10, '                                 ', $10, 0
        defb    ' ', $14, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $11, $11
        defb    $11, $11, $11, $11, $11, $11, $11, $15, 0, 0

fincad

; todo
; * generar tablas CRC por código
; * descomprimir en lugar de copiar codigo alto
