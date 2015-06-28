                    org 28000
Main                di
                    ld bc,7ffdh
                    ld a,16+7
                    out (c),a
                    ld hl,Rom
                    ld de,49152+102
                    ld bc,LRom
                    ldir
                    ld bc,7ffdh
                    ld a,16
                    out (c),a
                    ei
                    ret

Rom                 jr RealNMI
                    nop
EndNMI              retn
RealNMI             push af
                    xor a
                    out (254),a
Espera              xor a
                    in a,(254)
                    and 31
                    cp 31
                    jr z,Espera
                    ld a,(23624)
                    sra a
                    sra a
                    sra a
                    and 7
                    out (254),a
                    pop af
                    jr EndNMI
LRom                equ $-Rom
                    end Main

