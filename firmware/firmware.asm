
        OUTPUT  firmware.rom

        di
        ld      hl, finlog-1
        ld      de, $58ff
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
        inc     e               ; limpiar los 2/3 inferiores
        ld      h, b
        ld      b, $10
        ld      (hl), l
        ldir
        inc     d
        inc     h
        ld      (hl), 7
        ld      b, 2
        ldir
binf    jr      binf

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

        block   $3000-$

; -----------------------------------------------------------------------------
; 6x8 character set (128 characters x 4 rotations)
; -----------------------------------------------------------------------------
chrset  incbin  fuente6x8.bin
