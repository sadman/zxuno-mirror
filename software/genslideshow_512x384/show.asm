                                org 48000
                                
                                ld a,(23388)
                                bit 4,a
                                jr z,No128
                                bit 5,a
                                jr nz,No128
                                and 7
                                cp 0
                                jr z,Ok128
                                cp 7
                                jr z,Ok128

No128                           ld a,16
                                ld (23388),a

Ok128                           di
                                ld bc,7ffdh
                                ld a,(23388)
                                and 0f8h
                                or 7
                                ld (23388),a
                                out (c),a
                                ld hl,32768
                                ld de,49152
                                ld bc,8192+6144
                                ldir
                                ld a,00111110b
                                out (255),a
                                xor a
                                ld (23560),a
                                ld bc,7ffdh
                                ei

BucleMuestra                    halt
                                ld a,(23560)
                                cp "s"
                                jr nz,NoSkipRetrace
                                xor a
                                ld (23560),a
                                jr BucleMuestra

NoSkipRetrace                   or a
                                jr nz,FinMuestra
                                ld a,(23388)
                                xor 08h
                                ld (23388),a
                                out (c),a
                                jr BucleMuestra

FinMuestra                      ld a,(23388)
                                and 00010111b
                                ld (23388),a
                                out (c),a

EsperaSoltar                    xor a
                                ld (23560),a
                                halt
                                ld a,(23560)
                                or a
                                jr nz,EsperaSoltar
                                
                                xor a
                                out (255),a

                                ret
