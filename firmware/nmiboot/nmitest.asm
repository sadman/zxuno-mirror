
        define  spback  $fffe
        output  nmitest.rom
        ld      sp, $8000
        ld      de, $4001
        ld      hl, $4000
        ld      bc, $1b00
        ld      (hl), $55
        ldir
        ld      hl, L006B
        ld      de, $c000
        ld      bc, fin-LC000
        ldir
here    jr      here
        block   $0066-$
L0066   jp      LC000
L0069   retn
L006B

        org     $c000
LC000   ld      (spback), sp
        ld      sp, spback
        push    af
        pop     af
        ld      sp, (spback)
        jp      L0069
        defb    'hola'
fin

        block   $10000-$006b-$
