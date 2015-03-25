/*
 *    Conversor RS232 -> PS/2 del ZX-UNO by Quest
 *
 *    PS/2 DATA: Pin A3 
 *    PS/2 CLK: Pin A2
 *
 *    Conexión serie: 38400bps, 8, n, 1
 *
 */

#include <stdio.h>
#include <avr/io.h>
#include <inttypes.h>
#include <util/delay.h>
#include "keymaps.h"

#define LED_ON	PORTB |= (1<<5)		
#define LED_OFF	PORTB &= ~(1<<5)
#define LED_CONFIG	DDRB |= (1<<5) //Led en PB5 en Pro mini y similares


///////Pro Mini 
#define PS2_PORT	PORTC
#define PS2_DDR		DDRC
#define PS2_PIN		PINC

#define PS2_DAT		PC3
#define PS2_CLK		PC2

#ifndef F_CPU
#define F_CPU 	16000000UL
#endif
#define BAUD    38400
#define BAUD_PRESCALE (((F_CPU/ (BAUD * 16UL))) - 1)
#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))

#define HI 1
#define LO 0

void uartInit(void)
{
   	UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
        UCSR0C |= (1 << UCSZ00) | (1 << UCSZ01);

        UBRR0H = (BAUD_PRESCALE >> 8);
        UBRR0L = BAUD_PRESCALE;
}

unsigned char uartRx(void) 
{
  	loop_until_bit_is_set(UCSR0A, RXC0); 
   	return UDR0;
}

void uartTx (uint8_t v)
{
	loop_until_bit_is_set (UCSR0A, UDRE0);
	UDR0 = v;
}

void leds_debug(){
 	LED_ON;
	_delay_ms(60);
	LED_OFF;
	_delay_ms(30);
}

void ps2Mode(uint8_t pin, uint8_t mode) 
{
    if(mode) { //high
	PS2_DDR &= ~_BV(pin); //input (Truco DDR. Como input sin estado, se pone en modo Hi-Z)
    } else { //low
        PS2_DDR |= _BV(pin); //output (Truco DDR. Como output, se pone a 0v)
    }
}

void ps2Init() 
{
  //ponemos en alto ambas señales
	PS2_PORT &= ~_BV(PS2_DAT); //A 0
	PS2_PORT &= ~_BV(PS2_DAT); //A 0
	ps2Mode(PS2_DAT, HI);
	ps2Mode(PS2_CLK, HI);
}

uint8_t ps2Stat()
{
  if (!(PS2_PIN & (1<<PS2_CLK)))
    return 1;
  if (!(PS2_PIN & (1<<PS2_DAT)))
    return 1;
    
  return 0;
}

//En us, reloj y semireloj, para los flancos
//zxuno v2 test15: CK1 = 240, CK2 = 480. Uso normal: CK1 = 20, CK2 = 40 microsegundos
//(revertir a normal cuando el core ps/2 del ZX-UNO se mejore)
#define CK1 240 
#define CK2 480

//envio de datos ps/2 simulando reloj con delays.
void sendPS2(unsigned char code)
{
LED_ON;
        //Para continuar las líneas deben estar en alto
	if (ps2Stat())
		return;   
 
 	unsigned char parity = 1;
	unsigned char i = 0;
        
        //iniciamos transmisión
        ps2Mode(PS2_DAT, LO);
        _delay_us(CK1);
        
        ps2Mode(PS2_CLK, LO); //bit de comienzo
        _delay_us(CK2);
        ps2Mode(PS2_CLK, HI);
        _delay_us(CK1);
        //enviamos datos
        for (i = 0; i < 8; ++i) 
	{
	    if ((0b00000001 & code))
	      ps2Mode(PS2_DAT, HI);		
	    else
	      ps2Mode(PS2_DAT, LO);    		
	    
	    _delay_us(CK1);
            ps2Mode(PS2_CLK, LO);
            _delay_us(CK2);
            ps2Mode(PS2_CLK, HI);
            _delay_us(CK1);

        //paridad
            if ((0b00000001 & code) == 0b00000001) 
            {
                if (!parity)
                    parity = 1;
                else
                    parity = 0;
            }
    	    code = code >> 1;
	}

	// Enviamos bit de paridad
	if (parity)
	    ps2Mode(PS2_DAT, HI);		
	else
	    ps2Mode(PS2_DAT, LO);
        
	 _delay_us(CK1);
         ps2Mode(PS2_CLK, LO);
         _delay_us(CK2);
         ps2Mode(PS2_CLK, HI);
         _delay_us(CK1);
            
         //Bit de parada
         ps2Mode(PS2_DAT, HI);
         _delay_us(CK1);
         ps2Mode(PS2_CLK, LO);
         _delay_us(CK2);
         ps2Mode(PS2_CLK, HI);
         _delay_us(CK1);
         
         _delay_us(CK2*3); //fin
        
LED_OFF;
}

//codifica envio de caracteres ps/2 
void sendCodeMR(unsigned char key, uint8_t release) 
{
  uint8_t extn = 0;
 
  //checkeamos si es una tecla con scancode extendido (E0)
  switch(key) {
    case KEY_LEFT:
    case KEY_DOWN:
    case KEY_RIGHT:
    case KEY_UP:
    case KEY_HOME:
    case KEY_END:
    case KEY_PDN:
    case KEY_PUP:
       extn = 1; 
       break;
    default:
       extn = 0; 
       break;
  }
//secuencia  
  
  if (extn)
    sendPS2(0xE0);
  
  if (key && release) 
   sendPS2(0xF0);

 if (key)
  sendPS2(key);
  
//fin secuencia
}

int main() 
{
	unsigned char key;
	uint8_t data;
	char cad[3];

	CPU_PRESCALE(0);
	LED_CONFIG;
	LED_OFF;

	uartInit();
	ps2Init();
	while(1) {
		key = uartRx();  
		sprintf(cad,"%x ",key);
		uartTx(cad[0]); uartTx(cad[1]); uartTx(cad[2]);
		if (key>0x80) 
		  data=keymapVB[key-0x80];
                else
		  data=keymapVB[key];
		if (data>0) {
			if (key>0x80) 
			   sendCodeMR(data,1); //Release
			else
			   sendCodeMR(data,0); //Make
		}
		_delay_us(10); 
	}
}