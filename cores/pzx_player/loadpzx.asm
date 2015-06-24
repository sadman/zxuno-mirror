ZXUNOADDR        equ 0fc3bh
ZXUNODATA        equ 0fd3bh

SRAMDATA         equ 0fdh
SRAMADDRINC      equ 0fch
SRAMADDR         equ 0fbh

                 org 30000

Main             proc
                 di

                 ld bc,ZXUNOADDR
                 ld a,SRAMADDR
                 out (c),a
                 inc b
                 
                 xor a
                 out (c),a  ;
                 out (c),a  ; Direccion 0 de la SRAM
                 out (c),a  ;
                 dec b

                 ld hl,Bloque
                 ld de,LBloque
BucLDIR          ld a,SRAMDATA
                 out (c),a
                 inc b
                 ld a,(hl)
                 out (c),a
                 dec b

                 ld a,SRAMADDRINC
                 out (c),a
                 inc b
                 out (c),a
                 dec b

                 inc hl
                 dec de
                 ld a,d
                 or e
                 jr nz,BucLDIR
                 
                 ei
                 ret
                 endp

Bloque           equ $
                 incbin "ahh.bin"
LBloque          equ $-Bloque

                 end Main
