                output  ROMSUPGR

                include zxuno.inc

              macro wreg  dir, dato
                call    rst28
                defb    dir, dato
              endm

                org     $2000           ; comienzo de la ejecución de los comandos ESXDOS

Main            ld      bc, zxuno_port
                out     (c), 0
                inc     b
                in      f, (c)
                jp      p, Nonlock
                call    Print
                dz      'ROM not rooted'
                ret
Nonlock         ld      a, scandbl_ctrl
                dec     b
                out     (c), a
                inc     b
                in      a, (c)
                and     $3f
                ld      (normal+1), a
                or      $c0
                out     (c), a
                call    init
                ld      bc, zxuno_port
                ld      a, scandbl_ctrl
                out     (c), a
                inc     b
normal          ld      a, 0
                out     (c), a
                ret
init            xor     a
                rst     $08
                db      M_GETSETDRV     ; A = unidad actual
                jr      nc, SDCard
                call    Print
                dz      'SD card not inserted'
                ret
SDCard          ld      b, FA_READ      ; B = modo de apertura
                ld      hl, FileName    ; HL = Puntero al nombre del fichero (ASCIIZ)
                rst     $08
                db      F_OPEN
                ld      (handle+1), a
                jr      nc, FileFound
                call    Print
                dz      'File ROMS.ZX1 not found'
                ret
FileFound       call    Print
                db      'Upgrading ROMS.ZX1 from SD', 13
                dz      '[', 6, ' ]', 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
                ld      ixl, 64
                ld      de, $8000
                ld      hl, $0060
                ld      a, $20
                call    rdflsh
                ld      de, $0060
                exx
                ld      hl, $8000
                ld      bc, $1041
handle          ld      a, 0
                rst     $08
                db      F_READ
                jr      c, tError
                ld      a, $20
                ld      hl, $8000
                exx
                call    wrflsh
                ld      e, $c0
                exx
Bucle           ld      a, ixl
                dec     a
                and     $03
                jr      nz, punto
                ld      a, 'o'
                exx
                push    de
                rst     $10
                pop     de
                exx
punto           ld      hl, $8000
                ld      bc, $4000
                ld      a, (handle+1)
                rst     $08
                db      F_READ
                jr      nc, ReadOK
tError          call    Print
                dz      'Read Error'
                ret
ReadOK          ld      a, $40
                ld      hl, $8000
                exx
                call    wrflsh
                inc     de
                ld      a, ixl
                cp      46
                jr      nz, o45roms
                ld      de, $34c0
o45roms         exx
                dec     ixl
                jr      nz, Bucle
                ld      a, (handle+1)
                rst     $08
                db      F_CLOSE
                call    Print
                dz      13, 'Upgrade complete', 13
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

; ------------------------
; Write to SPI flash
; Parameters:
;    A: number of pages (256 bytes) to write
;   DE: target address without last byte
;  HL': source address from memory
; ------------------------
wrflsh          ex      af, af'
                xor     a
wrfls1          wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, 6    ; envío write enable
                wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
                wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, $20  ; envío sector erase
                out     (c), d
                out     (c), e
                out     (c), a
                wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
wrfls2          call    waits5
                wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, 6    ; envío write enable
                wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
                wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, 2    ; page program
                out     (c), d
                out     (c), e
                out     (c), a
                ld      a, $20
                exx
                ld      bc, zxuno_port+$100
wrfls3          inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                inc     b
                outi
                dec     a
                jr      nz, wrfls3
                exx
                wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
                ex      af, af'
                dec     a
                jr      z, waits5
                ex      af, af'
                inc     e
                ld      a, e
                and     $0f
                jr      nz, wrfls2
                ld      hl, wrfls1
                push    hl
waits5          wreg    flash_cs, 0     ; activamos spi, enviando un 0
                wreg    flash_spi, 5    ; envío read status
                in      a, (c)
waits6          in      a, (c)
                and     1
                jr      nz, waits6
                wreg    flash_cs, 1     ; desactivamos spi, enviando un 1
                ret
        
rst28           ld      bc, zxuno_port + $100
                pop     hl
                outi
                ld      b, (zxuno_port >> 8)+2
                outi
                jp      (hl)

FileName        dz      'ROMS.ZX1'
