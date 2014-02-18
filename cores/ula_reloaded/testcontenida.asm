                org 0
                di
                ld sp,32768
                ld hl,Codigo
                ld de,16384
                ld bc,LCodigo
                ldir
Otra:           call 16384
                jp Otra

Codigo:         in a,(255)
                cp 255
                jr nz,Codigo
                out (254),a
                ld bc,40feh
                out (c),a
                ret
LCodigo         equ $-Codigo

                end
