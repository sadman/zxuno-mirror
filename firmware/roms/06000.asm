        output  06000.bin

        define  Issue2  $00
        define  Issue3  $20
        define  Tim48   $00
        define  Tim128  $01
        define  TimPen  $02
        define  NonContended $00
        define  Contended    $10
        define  DisableDiv   $00
        define  EnableDiv    $08
        define  DisableNMI   $00
        define  EnableNMI    $04

      macro Generic  slot, crc1, crc2, cadena, par1, par2, par3, par4, par5, par6
        defb    slot, par1, par2, par3, par4, par5, par6, $ff
        defb    crc1>>24&255, crc1>>16&255, crc1>>8&255, crc1&255, crc2>>24&255, crc2>>16&255, crc2>>8&255, crc2&255
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defm    cadena
        block   64-($ & 63), $20
      endm

      macro Cart    slot, crc, cadena
        Generic  slot, (crc<<16 | $ffff), $ffffffff, cadena, 1, $08, 1, $00, $20, Issue3 | Tim48  | Contended | DisableDiv | DisableNMI
      endm

      macro R32K    slot, crc, cadena
        Generic  slot, crc, $ffffffff, cadena, 2, $08, 4, 0, 0, Issue3 | Tim128  | Contended | DisableDiv | DisableNMI
      endm

      macro OPENSE  slot, crc, cadena
        Generic  slot, crc, $ffffffff, cadena, 2, $08, 4, 0, 0, Issue3 | Tim128  | Contended | EnableDiv | DisableNMI
      endm

      macro R64K    slot, crc1, crc2, cadena
        Generic  slot, crc1, crc2, cadena, 4, $08, 4, 0, 0, Issue3 | Tim128  | Contended | DisableDiv | DisableNMI
      endm

      macro R32KDIV slot, crc, cadena
        Generic  slot, crc, $ffffffff, cadena, 2, $08, 4, 0, 0, Issue3 | Tim128  | Contended | EnableDiv | EnableNMI
      endm

      macro R64KDIV slot, crc1, crc2, cadena
        Generic  slot, crc1, crc2, cadena, 4, $08, 4, 0, 0, Issue3 | Tim128  | Contended | EnableDiv | EnableNMI
      endm
      
l0030   Generic  0, $1bfeffff, $ffffffff, 'ZX Spectrum 48K', 1, 8, 4, 0, 0, Issue3 | Tim48  | Contended | EnableDiv | EnableNMI
        R32KDIV  1, $a2394d6a,            'ZX 128K +2 grey EN'
        R64K     3, $43bea3ff, $ec33dbeb, 'ZX +3e DivMMC'
        OPENSE   7, $bfd5c9e8,            'SE Basic IV 4.0 Anya'
        Cart     9, $1039,                'ZX Spectrum 48K Cargando Leches'
        Cart    10, $b818,                'Manic Miner (1983)'
        Cart    11, $15e7,                'Jet Set Willy (1984)'
        Cart    12, $e945,                'Lala Prologue (2010)'
        Cart    13, $dd26,                'Master Chess (1983)'
        Cart    14, $c054,                'Hungry Horace (1982)'
        Cart    15, $6754,                'Horace & the Spiders (1983)'
        Cart    16, $aafc,                'Planetoids (1982)'
        Cart    17, $7a69,                'Space Raiders (1982)'
        Cart    18, $4d5b,                'Misco Jones (2013)'

        block   $1000-$

;  00-3f: index to entries
;  40: active entry
;  41: fast boot    0: Disable, 1: Enable
;  42: Check CRC    0: Disable, 1: Enable
;  43: DivMMC       0: Disable, 1: Enable
;  44: NMI-DivMMC   0: Disable, 1: Enable
;  45: Issue        0: Issue 2, 1: Issue 3
l0040   defb    $00, $01, $02, $03, $04, $05, $06, $07
        defb    $08, $09, $0a, $0b, $0c, $0d, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
        defb    $00             ; active
        defb    $00             ; bitstream
        defb    $00             ; quiet
        defb    $01             ; checkcrc
        defb    $02             ; Issue
        defb    $03             ; Timing
        defb    $02             ; Contended
        defb    $02             ; DivMMC
        defb    $02             ; NMI-DivMMC
        defb    $00             ; layout
        defb    $00             ; joykey
        defb    $00             ; joydb9
        defb    $00             ; outvid
        defb    $00             ; scanli
        defb    $00             ; freque

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


