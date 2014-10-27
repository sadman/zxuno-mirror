; API de ESXDOS.
include "esxdos.inc"
include "errors.inc"

;Para ensamblar con PASMO como archivo binario (no TAP)

ZXUNOADDR           equ 0fc3bh
ZXUNODATA           equ 0fd3bh

                    org 2000h  ;comienzo de la ejecución de los comandos ESXDOS.

Main                proc
                    ld a,h
                    or l
                    jr z,PrintAndExit
                    call RecogerParam
                    call ParseParam
                    jr nc,NoError
                    cp 255
                    ret z
                    ret c

NoError             ld bc,ZXUNOADDR
                    xor a
                    out (c),a
                    inc b
                    ld a,(ConfValue)
                    out (c),a
PrintAndExit        call PrintCurrentMode
                    or a
                    ret
                    endp
;------------------------------------------------------

PrintCurrentMode    proc
                    ld bc,ZXUNOADDR
                    ld a,0   ;MASTERCONF
                    out (c),a
                    inc b
                    in a,(c)
                    ld (ConfValue),a  ;Current config value

                    ld hl,CurrConfString1
                    call PrintString
                    ld hl,Timm48KStr
                    ld a,(ConfValue)
                    bit 4,a
                    jr z,NoChTimm
                    ld hl,Timm128KStr
NoChTimm            call PrintString

                    ld hl,CurrConfString2
                    call PrintString
                    ld hl,ContEnabledStr
                    ld a,(ConfValue)
                    bit 5,a
                    jr z,NoChCont
                    ld hl,ContDisabledStr
NoChCont            call PrintString

                    ld hl,CurrConfString3
                    call PrintString
                    ld a,(ConfValue)
                    cpl
                    and 08h  ;
                    sra a    ; A = "2" or "3"
                    sra a    ; depending upon the
                    sra a    ; bit at 3
                    or 32h   ;
                    rst 10h
                    ld a,13
                    rst 10h
                    ret

                    endp
;------------------------------------------------------

RecogerParam        proc   ;HL apunta a los argumentos
                    ld de,BufferParam
CheckCaracter       ld a,(hl)
                    or a
                    jr z,FinRecoger
                    cp ":"
                    jr z,FinRecoger
                    cp 13
                    jr z,FinRecoger
                    ldi
                    jr CheckCaracter
FinRecoger          ld a," "
                    ld (de),a
                    inc de
                    xor a
                    ld (de),a
                    ret
                    endp
;------------------------------------------------------

ParseParam          proc
                    ld bc,ZXUNOADDR
                    ld a,0   ;MASTERCONF
                    out (c),a
                    inc b
                    in a,(c)
                    ld (ConfValue),a  ;Current config value

                    ld hl,BufferParam
OtroChar            ld a,(hl)
                    inc hl
                    or a
                    ret z
                    cp " "
                    jp z,OtroChar
                    cp "-"
                    jp nz,ErrorInvalidArg

                    ld a,(hl)
                    inc hl
                    cp "t"
                    jp z,ParseTimming
                    cp "c"
                    jp z,ParseContention
                    cp "k"
                    jp z,ParseKeyboard
                    cp "h"
                    jp z,ParseHelp
                    jp ErrorInvalidArg

ParseTimming        ld a,(hl)
                    inc hl
                    cp "4"
                    jp z,Parse48K
                    cp "1"
                    jp z,Parse128K
                    jp ErrorInvalidArg
Parse48K            ld a,(hl)
                    inc hl
                    cp "8"
                    jp nz,ErrorInvalidArg
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    and 0efh  ;clear bit 4
                    ld (ConfValue),a
                    jp OtroChar
Parse128K           ld a,(hl)
                    inc hl
                    cp "2"
                    jp nz,ErrorInvalidArg
                    ld a,(hl)
                    inc hl
                    cp "8"
                    jp nz,ErrorInvalidArg
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    or 10h  ;set bit 4
                    ld (ConfValue),a
                    jp OtroChar

ParseContention     ld a,(hl)
                    inc hl
                    cp "y"
                    jp nz,PutDisableCont
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    and 0dfh
                    ld (ConfValue),a
                    jp OtroChar
PutDisableCont      cp "n"
                    jp nz,ErrorInvalidArg
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    or 20h
                    ld (ConfValue),a
                    jp OtroChar

ParseKeyboard       ld a,(hl)
                    inc hl
                    cp "3"
                    jp nz,PutIssue2
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    and 0f7h
                    ld (ConfValue),a
                    jp OtroChar
PutIssue2           cp "2"
                    jp nz,ErrorInvalidArg
                    ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld a,(ConfValue)
                    or 08h
                    ld (ConfValue),a
                    jp OtroChar

ParseHelp           ld a,(hl)
                    inc hl
                    cp " "
                    jp nz,ErrorInvalidArg
                    ld hl,Uso
                    call PrintString
                    ld a,255
                    scf
                    ret

ErrorInvalidArg     ld a,2
                    scf
                    ret
                    endp
;------------------------------------------------------

PrintString         proc
BucPrintMsg         ld a,(hl)
                    or a
                    ret z
                    rst 10h
                    inc hl
                    jr BucPrintMsg
                    endp
;------------------------------------------------------
;------------------------------------------------------

                    ;   01234567890123456789012345678901
Uso                 db "zxunocfg [-h] [-tA] [-cB] [-kC]",13,13
                    db "Configure/print ZX-UNO options:",13
                    db " No switches: print config.",13
                    db " -h : shows this help",13
                    db " -tA: choose ULA timmings",13
                    db "      A=48:   48K timmings",13
                    db "      A=128: 128K timmings",13
                    db " -cB: en/dis contention",13
                    db "      B=y: enable it",13
                    db "      B=n: disable it",13
                    db " -kC: choose keyboard mode",13
                    db "      C=2: issue 2 keyboard",13
                    db "      C=3: issue 3 keyboard",13,13
                    db "Example: zxunocfg -t48 -cn -k3",13
                    db "  (provides Pentagon 128 compati",13
                    db "   ble mode)",13
                    db 0

                    ;   01234567890123456789012345678901
CurrConfString1     db "ZX-Uno current configuration:",13
                    db "    Timming: ",0
Timm48KStr          db "48K",13,0
Timm128KStr         db "128K",13,0
CurrConfString2     db " Contention: ",0
ContEnabledStr      db "ENABLED",13,0
ContDisabledStr     db "DISABLED",13,0
CurrConfString3     db "   Keyboard: ISSUE ",0


ConfValue           db 0

BufferParam         equ $   ;resto de la RAM para el nombre del fichero