                output  ROMSDN

                include zxuno.inc

              macro wreg  dir, dato
                call    rst28
                defb    dir, dato
              endm

                org     $2000

Main            xor     a
                rst     $08
                db      M_GETSETDRV     ; A = unidad actual
                jr      nc, SDCard
                call    Print
                dz      'SD card not inserted'
                ret
SDCard          ld      b, FA_WRITE | FA_OPEN_AL ; B = modo de apertura
                ld      hl, FileName    ; HL = Puntero al nombre del fichero (ASCIIZ)
                rst     $08
                db      F_OPEN
                jr      nc, FileFound
                call    Print
                dz      'Can\'t open ROMS.ZX1'
                ret
FileFound       push    af
                ld      ixl, 64
                ld      de, $8000
                ld      hl, $0060
                ld      a, $11
                call    rdflsh
                ld      hl, $8000
                ld      bc, $1041
                pop     af
                push    af
                rst     $08
                db      F_WRITE
                ld      de, $00c0
                jr      c, tError
Bucle           ld      hl, $8000
                ld      a, ixl
                cp      46
                jr      nz, o45roms
                ld      de, $34c0
o45roms         ld      a, $40
                call    rdflsh
                ld      hl, $8000
                ld      bc, $4000
                pop     af
                push    af
                rst     $08
                db      F_WRITE
                jr      nc, ReadOK
tError          call    Print
                dz      'Write Error'
                pop     af
                ret
ReadOK          dec     ixl
                jr      nz, Bucle
                rst     $08
                db      F_CLOSE
                ret

Print           pop     hl
                db      $3e
Print1          rst     $10
                ld      a, (hl)
                inc     hl
                or      a
                jr      nz, Print1
                jp      (hl)

; ------------------------
; Read from SPI flash
; Parameters:
;   DE: destination address
;   HL: source address without last byte
;    A: number of pages (256 bytes) to read
; ------------------------
rdflsh          ex      af, af'
                xor     a
                push    hl
                wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, 3    ; envio flash_spi un 3, orden de lectura
                pop     hl
                push    hl
                out     (c), h
                out     (c), l
                out     (c), a
                ex      af, af'
                ex      de, hl
                in      f, (c)
rdfls1          ld      e, $20
rdfls2          ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                ini
                inc     b
                dec     e
                jr      nz, rdfls2
                dec     a
                jr      nz, rdfls1
                wreg    flash_cs, 1
                pop     hl
                ret
        
rst28           ld      bc, zxuno_port + $100
                pop     hl
                outi
                ld      b, (zxuno_port >> 8)+2
                outi
                jp      (hl)

FileName        dz      'ROMS.ZX1'
