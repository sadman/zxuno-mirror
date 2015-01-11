        output  2b500.bin
;  00-1f: index to entries
;  20: active entry
;  21: fast boot    0: Disable, 1: Enable
;  22: Check CRC    0: Disable, 1: Enable
;  23: DivMMC       0: Disable, 1: Enable
;  24: NMI-DivMMC   0: Disable, 1: Enable
;  25: Issue        0: Issue 2, 1: Issue 3
l02b5   defb    $02, $01, $00, $03, $04, $05, $06, $07
        defb    $08, $09, $0a, $0b, $0c, $0d, $0e, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $03             ; active
        defb    $00             ; quiet
        defb    $01             ; checkcrc
        defb    $00             ; DivMMC
        defb    $01             ; NMI-DivMMC
        defb    $01             ; Issue
        defb    0   ; para que not implemented sea 0

; 32 entradas
;    00: slot offset
;    01: B= slot size
;    02: RAM offset     
;    03: B= ROM SRAM size
;    04: port 1ffd
;    05: port 7ffd
;    ...
;    10-1f: CRCs
;    20-3f: Name

        block   $300-$

l02b8   defb    $00, 1, $08, 4, $00, $00, $ff, $ff
        defb    $40, $ba, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K Cargando Leches '
        defb    $01, 4, $08, 4, $00, $00, $ff, $ff
        defb    $43, $be, $a3, $ff, $ec, $33, $db, $eb
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX +3e DivMMC                   '
        defb    $05, 2, $0a, 2, $04, $00, $ff, $ff ;$04
        defb    $bf, $d5, $c9, $e8, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'SE Basic IV 4.0 Anya            '
        defb    $07, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $1b, $fe, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'ZX Spectrum 48K                 '

        defb    $08, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $b8, $18, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Manic Miner (1983)              '
        defb    $09, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $15, $e7, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Jet Set Willy (1984)            '
        defb    $0a, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $e9, $45, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Lala Prologue (2010)            '
        defb    $0b, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $7d, $63, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Deathchase (1983)               '
        defb    $0c, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $dd, $26, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Master Chess (1983)             '
        defb    $0d, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $49, $34, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Backgammon (1983)               '
        defb    $0e, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $c0, $54, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Hungry Horace (1982)            '
        defb    $0f, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $67, $54, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Horace & the Spiders (1983)     '
        defb    $10, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $aa, $fc, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Planetoids (1982)               '
        defb    $11, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $7a, $69, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Space Raiders (1982)            '
        defb    $12, 1, $0b, 1, $04, $30, $ff, $ff
        defb    $4d, $5b, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    'Misco Jones (2013)              '
        
        block   $b00-$
