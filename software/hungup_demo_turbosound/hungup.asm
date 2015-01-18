ULAPLUSADDR     equ 0bf3bh
ULAPLUSDATA     equ 0ff3bh
INIT            equ 45533
PLAY            equ 45538
STOP            equ 45541

                org 32768
Main            di

                ld a,2
                out (255),a

                ld bc,ULAPLUSADDR
                ld hl,PALETTE
                ld d,0
BucPaleta       ld a,(hl)
                ld b,0bfh
                out (c),d
                ld b,0ffh
                out (c),a
                inc hl
                inc d
                ld a,d
                cp 64
                jr nz,BucPaleta
                
                ld b,0bfh
                out (c),d
                ld b,0ffh
                ld a,1
                out (c),a

                xor a
                out (254),a

                ld hl,ATTRS
                ld de,24576
                ld bc,6144
                ldir

                ld hl,BITMAP
                ld de,16384
                ld bc,6144
                ldir

                ld de,57229
                call INIT

                ei
BucPlay         xor a
                ld (23560),a
                halt
                ld a,(23560)
                and a
                jr nz,StopPlay
                call PLAY
                jr BucPlay

StopPlay        call STOP

                ld bc,ULAPLUSADDR
                out (c),d
                ld b,0ffh
                ld a,0
                out (c),a

                xor a
                out (255),a

                ret

BITMAP          equ $
ATTRS           equ $+6144
PALETTE         equ $+12288
                incbin "hungup_screen.scr"

                org 45533
                incbin "tsplayer_45533.bin"

                org 48617
                incbin "hungup_musicdata_48617.bin"

                end Main
