                    org 65000

ZXUNOADDR           equ 0fc3bh
ZXUNODATA           equ 0fd3bh
RASTERLINE          equ 0ch
RASTERCTRL          equ 0dh
RASTERSTAT          equ 0dh

ULAPLUSADDR         equ 0bf3bh
ULAPLUSDATA         equ 0ff3bh

Main                di
                    ld a,253
                    ld i,a
                    im 2
                    jp Init

                    org 65023
                    dw NewRasterInt

Init                ld de,0  ;DE = line to interrupt
                    ld h,0   ;colour to put
                    ld l,0   ;colour to initialize on every frame

                    ld a,7
                    out (254),a

                    ld bc,ULAPLUSADDR
                    ld a,15
                    out (c),a
                    ld b,0ffh
                    xor a
                    out (c),a
                    ld b,0bfh
                    ld a,64
                    out (c),a
                    ld b,0ffh
                    ld a,1
                    out (c),a

                    ld bc,ZXUNOADDR
                    ld a,RASTERLINE
                    out (c),a
                    inc b
                    out (c),e
                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    ld a,d
                    or 6
                    out (c),a

                    ld bc,ULAPLUSADDR
                    ld a,15
                    out (c),a
                    ld b,0ffh

                    ei

Again               halt
                    jp Again

NewRasterInt        out (c),h
                    inc de
                    inc de
                    inc h
                    ld a,e
                    cp 248
                    jp z,ResetH
                    cp 38h
                    jp nz,NoResetDE
                    ld a,d
                    cp 1h
                    jp nz,NoResetDE
                    ld de,0
                    jp NoResetDE
ResetH              dec l
                    ld h,l
NoResetDE           ld bc,ZXUNOADDR
                    ld a,RASTERLINE
                    out (c),a
                    inc b
                    out (c),e
                    dec b
                    inc a
                    out (c),a
                    inc b
                    ld a,d
                    or 6
                    out (c),a

                    ld bc,ULAPLUSADDR
                    ld a,15
                    out (c),a
                    ld b,0ffh

RetInt              ei
                    reti

                    end Main
