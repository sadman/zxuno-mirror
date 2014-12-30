TECLA                   equ 0
ESTADO                  equ 1
LED                     equ 2
SOLTADA                 equ 0
EXTENDIDA               equ 1

                        org 0
                        di
                        
                        ld d,0

Sinfin                  ld bc,LED
                        out (c),d

                        ld hl,0
Espera                  dec hl
                        ld a,h
                        or l
                        jp nz,Espera

                        ld a,d
                        xor 1
                        ld d,a
                        jp Sinfin

                        

;                         ld sp,256
;
;                         xor a
;                         out (LED),a
;
; Bucle                   in a,(ESTADO)
;                         cpl
;                         and 1
;                         out (LED),a
;                         jp Bucle

                        end
