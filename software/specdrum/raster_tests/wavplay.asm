                    org 2000h

include "esxdos.inc"
include "errors.inc"

ZXUNOADDR           equ 0fch
ZXUNODATA           equ 0fdh
ZXIBASEPORT         equ 3bh

MASTERCONF          equ 00h
SCANDBLCTRL         equ 0bh
RASTERLINE          equ 0ch
RASTERCTRL          equ 0dh
RASTERSTAT          equ 0dh

SPECDRUM            equ 0dfh

VECTORADDR          equ 20ffh
LBUFFER             equ 16384

Main                ld a,h
                    or l
                    jp nz,Init

                    ld hl,UsageStr
BucPrintMsg         ld a,(hl)
                    or a
                    ret z
                    rst 10h
                    inc hl
                    jr BucPrintMsg


                    org VECTORADDR
                    dw NewRasterInt


RecogerNFile        ;HL apunta a los argumentos (nombre del fichero)
                    ld de,BufferNFich
CheckCaracter       ld a,(hl)
                    or a
                    jr z,FinRecoger
                    cp " "
                    jr z,FinRecoger
                    cp ":"
                    jr z,FinRecoger
                    cp 13
                    jr z,FinRecoger
                    ldi
                    jr CheckCaracter
FinRecoger          xor a
                    ld (de),a
                    inc de   ;DE queda apuntando al buffer este que se necesita en OPEN, no sé pa qué.
                    ret

UsageStr
                    ;   01234567890123456789012345678901
                    db " .wavplay audiofile.wav",13,13
                    db "Plays an audio file using the",13
                    db "SpecDrum at 15.625 kHz",13,0

Init                call RecogerNFile  ;results DE = buffer for OPEN
                    xor a
                    rst 08h
                    db M_GETSETDRV  ;A = unidad actual
                    ld b,FA_READ    ;B = modo de apertura
                    ld hl,BufferNFich   ;HL = Puntero al nombre del fichero (ASCIIZ)
                    rst 08h
                    db F_OPEN
                    ret c   ;Volver si hay error
                    ld (FHandle),a

PrepareToPlay       di
                    ld a,20h
                    ld i,a
                    im 2

                    ld b,ZXUNOADDR
                    ld c,ZXIBASEPORT
                    ld a,MASTERCONF
                    out (c),a
                    inc b
                    in a,(c)
                    ld (MasterConf),a
                    and 10101111b ;ULA mode = 48K (311 scanlines)
                    or  00100000b ;no contention
                    out (c),a

                    dec b
                    ld a,SCANDBLCTRL
                    out (c),a
                    inc b
                    in a,(c)
                    ld (ScanDoubler),a
                    or 11000000b  ;maximum Z80 speed
                    out (c),a

                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    ld a,110b  ;raster int ON, vertical int OFF
                    out (c),a

                    ld hl,1    ;next raster
                    ld (RasterLine),hl

                    ld hl,BufferPlay  ;begin of circular play buffer
                    ld (SampleAddr),hl
                    ei

PlayLoop            ld bc,7ffeh   ;SPACE halfrow
                    in a,(c)
                    and 1
                    jp z,ExitPlay

StillInSecondHalf   halt
                    ld a,(SampleAddr+1)
                    cp HIGH(BufferPlay+LBUFFER/2)
                    jp nc,StillInSecondHalf

                    ;fill second half of buffer with audio data
                    ld hl,BufferPlay+LBUFFER/2
                    ld bc,LBUFFER/2
                    ld a,(FHandle)
                    di
                    rst 08h
                    db F_READ
                    ei
                    jp c,ExitPlay  ;si error, fin de lectura
                    ld a,b
                    or c
                    jp z,ExitPlay  ;si no hay más que leer, fin de lectura

StillInFirstHalf    halt
                    ld a,(SampleAddr+1)
                    cp HIGH(BufferPlay+LBUFFER/2)
                    jp c,StillInFirstHalf

                    ;fill first half of buffer with audio data
                    ld hl,BufferPlay
                    ld bc,LBUFFER/2
                    ld a,(FHandle)
                    di
                    rst 08h
                    db F_READ
                    ei
                    jp c,ExitPlay  ;si error, fin de lectura
                    ld a,b
                    or c
                    jp z,ExitPlay  ;si no hay más que leer, fin de lectura

                    jp PlayLoop

ExitPlay            ld a,(FHandle)
                    rst 08h
                    db F_CLOSE

                    di
                    ld b,ZXUNOADDR
                    ld c,ZXIBASEPORT
                    ld a,MASTERCONF
                    out (c),a
                    inc b
                    ld a,(MasterConf)
                    out (c),a

                    dec b
                    ld a,SCANDBLCTRL
                    out (c),a
                    inc b
                    ld a,(ScanDoubler)
                    out (c),a

                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    inc b
                    xor a
                    out (c),a
                    im 1

                    ei
                    or a   ;clear carry
                    ret

NewRasterInt        di
                    push af
                    push bc
                    push hl
                    ld bc,ZXUNOADDR*256+ZXIBASEPORT
                    ld a,RASTERLINE
                    ld hl,(RasterLine)
                    out (c),a
                    inc b
                    out (c),l  ;send MSB of next rasterline
                    dec b
                    ld a,RASTERCTRL
                    out (c),a
                    ld a,h
                    or 110b    ;keep ints going
                    inc b
                    out (c),a  ;send MSB plus ctrl
                    dec b
                    inc hl
                    bit 0,h
                    jp z,NotResetLine
                    ld a,56
                    cp l
                    jp nz,NotResetLine
                    ld hl,0
NotResetLine        ld (RasterLine),hl

                    ld hl,(SampleAddr)
                    ld a,(hl)
                    out (SPECDRUM),a
                    inc hl
                    ld a,h
                    cp HIGH(EndBufferPlay)
                    jp c,NotResetSampleBuff
                    ld hl,BufferPlay
NotResetSampleBuff  ld (SampleAddr),hl
                    pop hl
                    pop bc
                    pop af
                    ei
                    reti

MasterConf          db 0
ScanDoubler         db 0
FHandle             db 0
SampleAddr          dw 0
RasterLine          dw 0
BufferNFich         equ $   ;resto de la RAM para el nombre del fichero

;                    org 3000h
;BufferPlay          ds LBUFFER
;EndBufferPlay       equ $

BufferPlay           equ 32768
EndBufferPlay        equ BufferPlay+16384