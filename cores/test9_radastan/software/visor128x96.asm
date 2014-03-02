;Visor de pantallas simples modo 128x96
;Para generar una pantalla compatible con este modo:
; - Convertir una imagen RGB a 128x96, 16 colores paletizados
; - Grabarla como BMP sin compresi�n
; - Integrarla como archivo binario a este programa

               org 32768
Main           di

               ;Convertir la paleta del BMP a paleta de ULAplus
               ld hl,Pantalla+36h  ;offset de la paleta en los BMP. El formato de la paleta es BGRA
               ld bc,0bf3bh
               ld e,0
BucPaleta      out (c),e
               ld b,0ffh
               ld a,(hl)   ; azul
               sra a
               sra a
               sra a
               sra a
               sra a
               sra a
               and 3
               ld d,a
               inc hl
               ld a,(hl)   ; verde
               and 11100000b
               or d
               ld d,a
               inc hl
               ld a,(hl)   ; rojo
               sra a
               sra a
               sra a
               and 00011100b
               or d
               out (c),a
               inc hl
               inc hl      ; nos saltamos el byte de "alpha"
               ld b,0bfh
               inc e
               ld a,e
               cp 16
               jr nz,BucPaleta

               ld a,64
               out (c),a
               ld b,0ffh
               ld a,3
               out (c),a

               ld hl,Pantalla+76h+95*64   ;offset a la �ltima l�nea del BMP (la primera en pantalla)
               ld de,16384                ;offset al comienzo de pantalla
               ld b,96
BucPintaScans  push bc
               ld bc,64
               ldir
               ld bc,-128
               add hl,bc
               pop bc
               djnz BucPintaScans

               ei

               ld bc,0
               call 7997 ;PAUSE 0

               ld bc,0bf3bh
               ld a,64
               out (c),a
               ld b,0ffh
               xor a
               out (c),a

               ret


Pantalla       equ $
               incbin "familyguy.bmp"  ; <-- pon aqui el fichero BMP que quieras ver. Debe tener 6262 bytes de longitud

               end Main
