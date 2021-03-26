ZXUNOADDR               equ 0fc3bh
DEVCONTROL              equ 0eh
DEVCTRL2                equ 0fh
TIMEXSCREEN             equ 0ffh
TIMEXMMU                equ 0fff4h

                        org 0000h

Start                   di
                        ld hl,CodigoParaRAM
                        ld de,23296
                        ld bc,LCodigoParaRAM
                        ldir
                        jp 23296

CodigoParaRAM           ;Esto se ejecutará en realidad en RAM
;                         ld bc,ZXUNOADDR
;                         ld a,DEVCONTROL
;                         out (c),a
;                         inc b
;                         ld a,01001000b  ;habilita MMU y deshabilita puerto 1FFDh
;                         out (c),a
;                         dec b
;                         ld a,DEVCTRL2
;                         out (c),a
;                         inc b
;                         xor a
;                         out (c),a       ;habilita modos Timex

                        ld a,128        ;selecciona EX-ROM for MMU
                        out (TIMEXSCREEN),a
                        ld a,1
                        ld bc,TIMEXMMU
                        out (c),a  ;pagina banco 0 de EXROM en area 0000-1FFF
                        ld hl,2000h
                        ld de,0
                        ld bc,8192
                        ldir
                        xor a
                        ld bc,TIMEXMMU
                        out (c),a  ;despagina banco 0 de EXROM
                        out (TIMEXSCREEN),a  ;resetea registro de modo de pantalla del Timex

                        ld bc,7FFDh
                        ld a,00110000b   ;pagina ROM 1 y bloquea cualquier otra operación de paginación
                        out (c),a
                        jp 0             ;salta a la ROM 1, que es la principal del Timex

LCodigoParaRAM          equ $-CodigoParaRAM

                        org 2000h
EXROMCode               incbin "ts2068-1.rom"   ; ROM extra para Timex (8 KB)

                        org 4000h
                        incbin "ts2068-0.rom"  ; ROM principal de Timex (16 KB)

