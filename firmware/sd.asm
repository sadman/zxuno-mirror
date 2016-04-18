
reinit  pop     hl
        call    mmcinit
        ret     nz
        ld      a, SET_BLOCKLEN
        call    cs_low
        out     (c), a
        out     (c), 0
        out     (c), 0
        ld      a, 2
        out     (c), a
        call    send1z
        call    cs_high
        defb    $32
readat0 ld      e, 0
readata ld      a, READ_SINGLE  ; Command code for multiple block read
        call    cs_low          ; set cs high
        out     (c), a
        ld      a, (sdhc)
        dec     a
        push    hl
        jr      z, mul2
        out     (c), 0
        out     (c), e
        out     (c), h
        out     (c), l
        call    send0z
        jr      mul3
mul2    ld      a, e
        add     hl, hl
        adc     a, a
        out     (c), a
        out     (c), h
        out     (c), l
        call    send1z
mul3    and     a
        jr      nz, reinit
        push    bc
        call    waittok
        jr      nz, readsal
        push    ix
        pop     hl              ; INI usa HL come puntatore
        ld      b, a
        inir
        inir
readsal pop     bc
        pop     hl
        ret

mmcinit push    bc
        push    hl
        ld      hl, $FF00 + IDLE_STATE
        call    cs_high         ; set cs high
        ld      b, 9            ; sends 80 clocks
l_init  out     (c), h
        djnz    l_init
        call    cs_low          ; set cs low
        ld      h, $95
        call    send5
fail    dec     a               ; MMC should respond 01 to this command
        jr      nz, mmcfin      ; fail to reset
        ld      l, CMD8
        out     (c), l          ; sends the command
        out     (c), 0
        out     (c), 0
        inc     a
        out     (c), a
        ld      hl, $87aa
        out     (c), l
        call    send0z
        dec     a
        jr      nz, resetok
repite  ld      l, CMD55
        call    send5
        ld      hl, $40<<8 | CMD41
        out     (c), l
        out     (c), h
        call    send3z
        and     a
        jr      z, sigue
        djnz    repite
        jr      fail
resetok ld      l, OP_COND      ; Sends OP_COND command
        call    send5           ; then this byte is ignored.
        and     a
        jr      z, dela
        djnz    resetok         ; if no response, tries to send the entire block 254 more times
        jr      fail
sigue   ld      l, CMD58
        call    send5
        in      a, (c)
        sub     $c0
        jr      z, sig2
        ld      a, 1
sig2    ld      (sdhc), a
dela    call    cs_high         ; set cs high
loop3   djnz    loop3
        dec     h
        jr      nz, loop3
mmcfin  pop     hl
        pop     bc
cs_high push    af
        ld      a, $ff
cs_hig1 out     (OUT_PORT), a
        pop     af
        ret
send5   out     (c), l          ; sends the command
        out     (c), 0
send3z  out     (c), 0
        out     (c), 0
send1z  out     (c), 0
send0z  out     (c), h          ; then this byte is ignored.
waitr   push    bc
        ld      c, 50           ; retry counter
resp    in      a, (SPI_PORT)   ; reads a byte from MMC
        cp      $ff             ; $FF = no card data line activity
        jr      nz, resp_ok
        djnz    resp
        dec     c
        jr      nz, resp
resp_ok pop     bc
        ret
waittok ld      b, 10                         ; retry counter
waitl   call    waitr
        cp      $fe             ; waits for the MMC to reply $FE (DATA TOKEN)
        ret     z
        ret     nc
        djnz    waitl
cs_low  push    af
        ld      a, MMC_0
        jr      cs_hig1
