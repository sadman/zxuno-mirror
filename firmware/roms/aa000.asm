        output  aa000.bin

        define  Issue2  $00
        define  Issue3  $10
        define  Tim48   $00
        define  Tim128  $08
        define  NonContended $00
        define  Contended    $04
        define  DisableDiv   $00
        define  EnableDiv    $02
        define  DisableNMI   $00
        define  EnableNMI    $01

l0aa0   defb    $00, 1, $08, 4, $00, $00
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $40, $ba, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K Cargando Leches '
        defb    $01, 4, $08, 4, $00, $00
        defb    Issue3 | Tim128 | Contended    | EnableDiv  | EnableNMI,  $ff
        defb    $43, $be, $a3, $ff, $ec, $33, $db, $eb
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX +3e DivMMC                   '
        defb    $05, 2, $0a, 2, $04, $00
        defb    Issue3 | Tim48  | Contended    | EnableDiv  | DisableNMI, $ff
        defb    $bf, $d5, $c9, $e8, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'SE Basic IV 4.0 Anya            '
        defb    $07, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $1b, $fe, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K                 '

        defb    $08, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $b8, $18, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Manic Miner (1983)              '
        defb    $09, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $15, $e7, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Jet Set Willy (1984)            '
        defb    $0a, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $e9, $45, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Lala Prologue (2010)            '
        defb    $0b, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $7d, $63, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Deathchase (1983)               '
        defb    $0c, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $dd, $26, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Master Chess (1983)             '
        defb    $0d, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $49, $34, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Backgammon (1983)               '
        defb    $0e, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $c0, $54, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Hungry Horace (1982)            '
        defb    $0f, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $67, $54, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Horace & the Spiders (1983)     '
        defb    $10, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $aa, $fc, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Planetoids (1982)               '
        defb    $11, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $7a, $69, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Space Raiders (1982)            '
        defb    $12, 1, $0b, 1, $04, $30
        defb    Issue3 | Tim48  | Contended    | DisableDiv | DisableNMI, $ff
        defb    $4d, $5b, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Misco Jones (2013)              '

        block   $1000-$

;  00-3f: index to entries
;  40: active entry
;  41: fast boot    0: Disable, 1: Enable
;  42: Check CRC    0: Disable, 1: Enable
;  43: DivMMC       0: Disable, 1: Enable
;  44: NMI-DivMMC   0: Disable, 1: Enable
;  45: Issue        0: Issue 2, 1: Issue 3
l0ab0   defb    $02, $01, $00, $03, $04, $05, $06, $07
        defb    $08, $09, $0a, $0b, $0c, $0d, $0e, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $03             ; active
        defb    $00             ; quiet
        defb    $01             ; checkcrc
        defb    $02             ; Issue
        defb    $02             ; Timming
        defb    $02             ; Contended
        defb    $02             ; DivMMC
        defb    $02             ; NMI-DivMMC
        defb    0   ; para que not implemented sea 0

; 64 entradas
;    00: slot offset
;    01: B= slot size
;    02: RAM offset     
;    03: B= ROM SRAM size
;    04: port 1ffd
;    05: port 7ffd
;    ...
;    10-1f: CRCs
;    20-3f: Name

        block   $2000-$
