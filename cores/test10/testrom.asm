ZXUNOREGADDR            equ 0fc3bh
ZXUNOREGDATA            equ 0fd3bh
MASTERCONF              equ 0
MASTERMAPPER            equ 1
FLASHSPI                equ 2
FLASHCS                 equ 3

; Selecciona un registro ZXUno de forma que los siguientes IN/OUTs a (C)
; se hagan en el registro deseado
select                  macro dir
                        ld bc,ZXUNOREGADDR
                        ld a,dir
                        out (c),a
                        inc b
                        endm

; Escribe "dato" en el registro ZXUno de direccion "dir"
wreg                    macro dir,dato
                        ld bc,ZXUNOREGADDR
                        ld a,dir
                        out (c),a
                        inc b
                        ld a,dato
                        out (c),a
                        endm

; Lee un byte desde el registro ZXUno cuya dirección es "dir" y lo almacena en "dest" (un registro de 8 bits)
rreg                    macro dir,dest
                        ld bc,ZXUNOREGADDR
                        ld a,dir
                        out (c),a
                        inc b
                        in dest,(c)
                        endm

;--------------------------------------------------------------------------

                        org 32768
Main                    di
                        ld sp,49151   ;stack fuera de la pagina de memoria que tocaremos

                        ; Elige uno de los dos, para probar
                        call CopiaPlus3
                        ;call CopiaOpenSE
                        wreg MASTERCONF,0   ;Fin del modo boot. La nueva ROM está en su sitio y activada
                        jp 0                ;Vamonos a ella.

CopiaPlus3              wreg MASTERMAPPER,8   ;primera página de RAM que se convertirá en ROM (la 8)
                        wreg FLASHCS,0        ;linea CS de la flash a nivel bajo. Necesario antes de emitir comandos SPI
                        wreg FLASHSPI,3       ;comando de lectura de la flash
                        ld a,03h   ;
                        out (c),a  ; Dirección donde se encuentra
                        ld a,00h   ; la ROM en la flash: 030000h
                        out (c),a  ;
                        ld a,00h   ;
                        out (c),a  ; A partir de aqui leemos secuencialmente

                        call CopiaBloque   ;copia 16K de la flash a la página 8

                        wreg MASTERMAPPER,9
                        select FLASHSPI

                        call CopiaBloque   ;copia 16K de la flash a la página 9

                        wreg MASTERMAPPER,10
                        select FLASHSPI

                        call CopiaBloque   ;etc...

                        wreg MASTERMAPPER,11
                        select FLASHSPI

                        call CopiaBloque

                        wreg FLASHCS,1    ;Deseleccionar flash
                        ret


CopiaOpenSE             wreg MASTERMAPPER,8   ;primera página de RAM que se convertirá en ROM
                        wreg FLASHCS,0        ;linea CS de la flash a nivel bajo
                        wreg FLASHSPI,3       ;comando de lectura de la flash
                        ld a,04h   ;
                        out (c),a  ; Dirección donde se encuentra
                        ld a,00h   ; la ROM en la flash: 040000h
                        out (c),a  ;
                        ld a,00h   ;
                        out (c),a  ; A partir de aqui leemos secuencialmente

                        call CopiaBloque

                        wreg MASTERMAPPER,9
                        select FLASHSPI

                        call CopiaBloque

                        wreg FLASHCS,1    ;Deseleccionar flash

                        ld bc,7ffdh
                        ld a,0h
                        out (c),a

                        ret

CopiaBloque             ld hl,49152
                        ld de,16384
BucCopia                in a,(c)        ;leemos de la flash...
                        ld (hl),a       ;...a memoria
                        inc hl
                        dec de
                        ld a,d
                        or e
                        jr nz,BucCopia
                        ret

                        end Main
