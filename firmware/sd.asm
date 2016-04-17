        define  SPI_PORT        $eb
        define  OUT_PORT        $e7
        define  MMC_0           $fe ; D0 LOW = SLOT0 active
        define  IDLE_STATE      $40
        define  OP_COND         $41
        define  SET_BLOCKLEN    $50
        define  READ_SINGLE     $51


reinit  call    mmcinit
        ret     nz
        ld      a, SET_BLOCKLEN
        call    cs_low
        out     (c), a
        xor     a
        out     (c), a
        inc     a
        out     (c), 0
        inc     a
        out     (c), a
        nop
        out     (c), 0
        call    lsen1
        call    cs_high
        jr      readata
readat0 ld      e, 0
readata ld      a, READ_SINGLE  ; Command code for multiple block read
        call    cs_low          ; set cs high
        out     (c), a
        nop
        out     (c), e
        nop
        out     (c), h
        nop
        out     (c), l
        nop
        out     (c), 0
        nop
        out     (c), 0
        call    waitr           ; waits for the MMC to reply != $FF
        dec     a
        jr      nz, reinit
        call    waittok
        ret     nz
        push    bc
        push    hl
        push    ix
        pop     hl              ; INI usa HL come puntatore
        ld      b, a
        inir
        inir
        pop     hl
        pop     bc
        ret

mmcinit push    bc
        push    hl
        ld      hl, $FF00 + IDLE_STATE
        call    cs_high         ; set cs high
        ld      b, 9            ; sends 80 clocks
l_init  out     (c), h
        djnz    l_init
        call    cs_low          ; set cs low
        out     (c), l          ; sends the command
        ld      hl, $9540       ; $40= 64
        call    send4z
        cp      $02             ; MMC should respond 01 to this command
        jr      nz, mmcfin      ; fail to reset
resetok call    cs_high         ; set cs high
        out     (c), h          ; 8 extra clock cycles
        call    cs_low          ; set cs low
        ld      a, OP_COND      ; Sends OP_COND command
        out     (c), a          ; sends the command
        ld      h, b
        call    send4z          ; then this byte is ignored.
        rrca                    ; D0 SET = initialization still in progress...
        jr      nc, ninitok
        call    cs_high         ; set cs high
loop3   djnz    loop3
        dec     h
        jr      nz, loop3
        jr      mmcfin
send4z  ld      b, 4
lsen0   out     (c), 0          ; then sends four "00" bytes (parameters = NULL)
        djnz    lsen0
lsen1   out     (c), h          ; then this byte is ignored.
waitr   push    bc
        ld      c, 50           ; retry counter
resp    in      a, (SPI_PORT)   ; reads a byte from MMC
        inc     a               ; $FF = no card data line activity
        jr      nz, resp_ok
        djnz    resp
        dec     c
        jr      nz, resp
resp_ok pop     bc
        ret
ninitok djnz    resetok         ; if no response, tries to send the entire block 254 more times
        dec     l
        jr      nz, resetok
        inc     l
mmcfin  pop     hl
        pop     bc
cs_high push    af
        ld      a, $ff
cs_hig1 out     (OUT_PORT), a
        pop     af
        ret
cs_low  push    af
        ld      a, MMC_0
        jr      cs_hig1
waittok push    bc
        ld      b, 10                         ; retry counter
waitl   call    waitr
        inc     a               ; waits for the MMC to reply $FE (DATA TOKEN)
        jr      z, exitw
        dec     a               ; but if not $FF, exits immediately (error code from MMC)
        jr      nz, exitw
        djnz    waitl
        inc     a               ; return A+2, NZ 
exitw   pop     bc
        ret
