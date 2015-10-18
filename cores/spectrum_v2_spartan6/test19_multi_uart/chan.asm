; INSTRUCCIONES:
; 1. Ejecuta este programa.
; 2. Se habrá creado un nuevo canal, el canal "U",
;    y asociado a un stream, el #4, que se abre por nosotros
; 3. A partir de ahora, todo lo que se imprima al stream #4
;    se transmitirá por RS232.
;    Por ejemplo: PRINT #4;"Hola, mundo!"
; 4. Para leer, usa INKEY$#4. Por ejemplo, este programa saca por la
;    pantalla del Spectrum todo lo que escribas en un terminal serie:
;    100 PRINT INKEY$#4;: GO TO 100
; 5. NO CIERRES el stream #4. Si lo haces se bloquea el ordenador

PROG   equ 23635
CHANS  equ 23631
STRMS  equ 23568

     org 65000

; El grueso de este programa está sacado de aquí:
; http://www.worldofspectrum.org/faq/reference/48kreference.htm
Principal:
     LD HL,(PROG)  ; A new channel starts below PROG
     DEC HL        ;
     LD BC,0x0005  ; Make space
     CALL 0x1655   ;
     INC HL        ; HL points to 1st byte of new channel data
     LD A,LOW(TransmitirRS232)     ; LSB of output routine
     LD (HL),A     ;
     INC HL        ;
     PUSH HL       ; Save address of 2nd byte of new channel data
     LD A,HIGH(TransmitirRS232)     ; MSB of output routine
     LD (HL),A     ;
     INC HL        ;
     LD A,LOW(RecibirRS232)     ; LSB of input routine
     LD (HL),A     ;
     INC HL        ;
     LD A,HIGH(RecibirRS232)     ; MSB of input routine
     LD (HL),A     ;
     INC HL        ;
     LD A,'U'      ; Channel name 'U'
     LD (HL),A     ;
     POP HL        ; Get address of 2nd byte of output routine
     LD DE,(CHANS) ; Calculate the offset to the channel data
     AND A         ; and store it in DE
     SBC HL,DE     ;
     EX DE,HL      ;
     LD HL,STRMS   ;
     LD A,0x04     ; Stream to open, in this case #4.
     ADD A,0x03    ; Calculate the offset and store it in HL
     ADD A,A       ;
     LD B,0x00     ;
     LD C,A        ;
     ADD HL,BC     ;
     LD (HL),E     ; LSB of 2nd byte of new channel data
     INC HL        ;
     LD (HL),D     ; MSB of 2nd byte of new channel data
     RET

TransmitirRS232:
     push bc
     push af
     ld a,250   ;registro UARTDATA
     ld bc,64571
     out (c),a
     inc b
     pop af
     out (c),a  ;transmitir caracter en A
     dec b
     ld a,251
     out (c),a  ;registro UARTSTAT
     inc b
EsperaFinTransmision:
     in a,(c)
     sla a      ;bit TXBUSY a bit 7
     jp m,EsperaFinTransmision
     pop bc
     ret

RecibirRS232:
     push bc
     ld a,251         ;Registro UARTSTAT
     ld bc,64571
     out (c),a
     inc b
     in a,(c)         ;BIT 7 = DATO_DISPONIBLE.
     jp p,NoCaracter  ;Si no hay caracter, fin del asunto
     dec b
     ld a,250         ;Si lo hay, se lee
     out (c),a
     inc b
     in a,(c)
     pop bc
     scf              ;Carry a 1 para indicar que sí hay caracter
     ret
NoCaracter:
     xor a            ;CF=0, ZF=0, para indicar que no hay carácter
     pop bc
     ret

     end Principal
