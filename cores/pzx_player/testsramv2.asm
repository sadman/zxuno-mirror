ZXUNOADDR        equ 0fc3bh
ZXUNODATA        equ 0fd3bh

SRAMDATA         equ 0fdh
SRAMADDRINC      equ 0fch
SRAMADDR         equ 0fbh

                 org 32768

Main             proc
                 di

                 ld e,0  ;pagina de 64K de SRAM
                 ld d,7fh
                 ld bc,ZXUNOADDR
BucRellena       ld a,SRAMADDR
                 out (c),a
                 inc b

                 out (c),e  ;
                 xor a
                 out (c),a  ; Dirección de SRAM: E-00
                 out (c),a  ;

                 dec b
                 ld a,SRAMDATA
                 out (c),a
                 inc b
                 out (c),d   ;Escribe
                 dec b

                 inc e
                 ld a,e
                 cp 32
                 jr nz,BucRellena

                 ld e,0  ;pagina de 64K de SRAM
BucIncrementa    ld a,SRAMADDR
                 out (c),a
                 inc b

                 out (c),e  ;
                 xor a
                 out (c),a  ; Dirección de SRAM: E-00
                 out (c),a  ;

                 dec b
                 ld a,SRAMDATA
                 out (c),a
                 inc b
                 in a,(c)
                 inc a
                 out (c),a  ; Incrementa dato
                 dec b

                 inc e
                 ld a,e
                 cp 32
                 jr nz,BucIncrementa

                 ld a,1
                 out (254),a

                 ld a,SRAMADDR
                 out (c),a
                 inc b

                 xor a
                 out (c),a
                 out (c),a  ; Direccion 000000
                 out (c),a
                 
                 dec b
                 ld a,SRAMDATA
                 out (c),a
                 inc b

                 ld de,2048
                 in a,(c)
                 cp 128
                 jr z,Fin

                 sra d
                 rr e
                 cp 129
                 jr z,Fin

                 sra d
                 rr e

Fin              ld b,d
                 ld c,e

                 ei
                 ret
                 endp

                 end
