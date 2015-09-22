      macro wreg  dir, dato
        rst     $30
        defb    dir, dato
      endm

        output  bootloader.rom
        define  zxuno_port      $fc3b
        define  master_conf     0
        define  master_mapper   1
        define  flash_spi       2
        define  flash_cs        3
        di
        ld      bc, zxuno_port + $100
        wreg    flash_cs, 1     ; desactivamos spi, enviando un 0
        ld      sp, $bfff-16
        xor     a               ; byte mas significativo de direccion
        wreg    master_mapper, 8  ; paginamos la ROM en $c000
        wreg    flash_cs, 0     ; activamos spi, enviando un 0
        wreg    flash_spi, 3    ; envio flash_spi un 3, orden de lectura
        out     (c), a          ; envia direccion 005000, a=00,e=50,a=00
        ld      de, $e961       ; tras el out (c), h de bffc se ejecuta
        push    de              ; un jp (hl) hl=0 para iniciar la nueva ROM
        ld      de, $ed50       ; en $bffc para evitar que el cambio de ROM
        push    de              ; colisione con la siguiente instruccion
        add     hl, sp
        out     (c), e
        out     (c), a
boot    ini
        inc     b
        cp      h               ; compruebo si la direccion es 0000 (final)
        jr      c, boot         ; repito si no lo es
        dec     b
        out     (c), h          ; a master_conf quiero enviar un 0 para pasar
        inc     b               ; a modo normal, pero el ultimo out lo ubico
        jp      $bffc-16

rst30   pop     hl
        outi
        ld      b, (zxuno_port >> 8)+2
        outi
        jp      (hl)

rst38   jp      $c003
        defb    'ZX-Uno bootloader v0.3 2015-09-22 05000->R8'
nmi66   jp      $c000
        retn

;        block   $4000-$