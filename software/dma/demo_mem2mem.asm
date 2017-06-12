ZXUNOADDR       equ 0FC3Bh
ZXUNODATA       equ 0FD3Bh
DMACTRL         equ 0A0h
DMASRC          equ 0A1h
DMADST          equ 0A2h
DMALEN          equ 0A4h

                org 32768

Main            ld hl,22528
                ld de,0110000001010000b
                ld b,12
LoopLines       push bc
                ld b,32
LoopYellow      ld (hl),d
                inc hl
                djnz LoopYellow
                ld b,32
LoopWhite       ld (hl),e
                inc hl
                djnz LoopWhite
                pop bc
                djnz LoopLines

                ld hl,0  ; initial source address.
Loop            ld bc,ZXUNOADDR
                ld de,16384

                ld a,DMADST
                out (c),a
                inc b
                out (c),e
                out (c),d    ;DMADST = 16384
                dec b
                ld a,DMALEN
                out (c),a
                inc b
                xor a
                out (c),a    ;0 (LSB DMA transfer length)
                ld a,24
                out (c),a    ;24 (MSB DMA transfer length) : LEN = 24*256+0=6144 bytes
                dec b
                ld a,DMASRC
                out (c),a
                inc b
                out (c),l
                out (c),h   ;DMASRC = address in HL (ROM)
                dec b

                halt    ;sync with interrupt
                ld de,999  ;a small delay so the DMA transfer begins somewhere
Wait            dec de      ;within the visible screen range
                ld a,d
                or e
                jr nz,Wait

                ld a,DMACTRL
                out (c),a
                inc b

                ld a,2
                out (254),a

                ;-----------------------------------
                ld a,1   ; MEM to MEM, BURST
                out (c),a
                ;-----------------------------------
                ;DMA transfer time (us): (6144*4)/28 = 878 us = 14 scans

                ld a,7
                out (254),a
                dec b

                inc hl
                ld a,h
                cp 28h
                jr nz,Loop

                ret

                end Main

