/*
 *    Conversor teclado ZX-spectrum 8x5 -> PS/2 del ZX-UNO by Quest
 *
 *    Combinaciones especiales: 
 *    - Reset maestro = SYMBOL+CAPS+9
 *    - NMI = SYMBOL+CAPS+1
 */

#include <avr/io.h>
#include <inttypes.h>
#include <util/delay.h>
#include "keymaps.h"

#define LED_ON	PORTB |= (1<<5)		
#define LED_OFF	PORTB &= ~(1<<5)
#define LED_CONFIG	DDRB |= (1<<5) //Led en PB5 en Pro mini y similares

#define ZXUNO_RESET KEY_9 //tecla para el reseteo junto a shift+symbol (9)
#define ZXUNO_NMI KEY_1 //tecla para NMI junto a shift+symbol (space) (1)

////////Pro Mini
#define PS2_PORT	PORTC
#define PS2_DDR		DDRC
#define PS2_PIN		PINC

#define PS2_DAT		PC4
#define PS2_CLK		PC5

#define HI 1
#define LO 0
#define _IN 1
#define _OUT 0

//Definicion de pines y puertos en arrays

///////////Pro Mini
//{PC1, PC0, PB4, PB3, PB2};
uint8_t pinsC[COLS] =  {1, 0, 4, 3, 2};
uint8_t bcdC[COLS] =   {3, 3, 2, 2, 2};

//{PD2, PD3, PD4, PD5, PD6, PD7, PB0, PB1};
uint8_t pinsR[ROWS] =  {2, 3, 4, 5, 6, 7, 0, 1};
uint8_t bcdR[ROWS] =   {4, 4, 4, 4, 4, 4, 2, 2};

//Caps Shift (Shift)
#define SHIFT_COL 4  
#define SHIFT_ROW 5  

//Symbol(control)
#define SYMBOL_COL 3   
#define SYMBOL_ROW 7   

//combinacion reset (9)
#define RESET_COL 3
#define RESET_ROW 3

//combinacion NMI (1)
#define NMI_COL 4
#define NMI_ROW 0

void leds_debug(){
 	LED_ON;
	_delay_ms(60);
	LED_OFF;
	_delay_ms(30);
}

void pinSet(pin, bcd, stat) //stat 1 = in, stat 0 = out
{
     switch(bcd){
	case 2:  if (stat) DDRB &= ~_BV(pin); else DDRB |= _BV(pin); break;
        case 3:  if (stat) DDRC &= ~_BV(pin); else DDRC |= _BV(pin); break;
	case 4:  if (stat) DDRD &= ~_BV(pin); else DDRD |= _BV(pin); break;	  
     }
} 

uint8_t pinStat(pin, bcd)
{
     switch(bcd){
	case 2:  if (!(PINB & (1<<pin))) return 1; else return 0; break;
        case 3:  if (!(PINC & (1<<pin))) return 1; else return 0; break;
	case 4:  if (!(PIND & (1<<pin))) return 1; else return 0; break;	  
     }
  return 0;
}

void pinPut(pin, bcd, stat) //stat 1 = HI, stat 0 = LO
{
     switch(bcd){
	case 2:  if (!stat) PORTB &= ~_BV(pin); else PORTB |= _BV(pin); break;
        case 3:  if (!stat) PORTC &= ~_BV(pin); else PORTC |= _BV(pin); break;
	case 4:  if (!stat) PORTD &= ~_BV(pin); else PORTD |= _BV(pin); break;	  
     }
} 

void ps2Mode(uint8_t pin, uint8_t mode) 
{
    if(mode) { //high
	PS2_DDR &= ~_BV(pin); //input (Truco DDR. Como input sin estado, se pone en modo Hi-Z)
        //PS2_PORT |= _BV(pin);  //high
    } else { //low
        PS2_DDR |= _BV(pin); //output (Truco DDR. Como output, se pone a 0v)
        //PS2_PORT &= ~_BV(pin);  //low
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
//zxuno v2 test15: CK1 = 240, CK2 = 480. Uso normal: CK1 = 20, CK2 = 24 
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
void sendCode(unsigned char key, uint8_t shiftd, uint8_t symbold) 
{
  uint8_t extn = 0;
  unsigned char key_mod = KEY_LSHIFT; //si es shift suelto = shift, si es para reset = alt.

  //checkeamos si es una tecla con scancode extendido (E0)
  switch(key) {
    case KEY_LEFT:
    case KEY_DOWN:
    case KEY_RIGHT:
    case KEY_UP:
    case KEY_RALT:
    //case KEY_RCTRL:
       extn = 1; 
       shiftd = 0; //no dejamos hacer shift con flechas de momento
       break;
    case ZXUNO_RESET:
        if (shiftd && symbold) {
          key = KEY_DELETE;    
          key_mod = KEY_LALT;     
        }
        break;
    case ZXUNO_NMI:
        if (shiftd && symbold) {
          key = KEY_F5;    
          key_mod = KEY_LALT;     
        }
        break;        
    default:
       extn = 0; 
       break;
  }
//secuencia  
  if (shiftd) 
    sendPS2(key_mod);
  
  if (symbold) 
    sendPS2(KEY_LCTRL);
  
  if (extn) 
    sendPS2(0xE0);
   
 if (key)
  sendPS2(key);
  
  if (extn)
    sendPS2(0xE0);
  
  if (key) 
   sendPS2(0xF0);

 if (key)
  sendPS2(key);
   
  if (symbold) {
    sendPS2(0xF0);
    sendPS2(KEY_LCTRL);
  }    
  
  if (shiftd) {
    sendPS2(0xF0);
    sendPS2(key_mod);
  }
  
//fin secuencia
}

void pressKey(uint8_t r, uint8_t c, uint8_t shiftd, uint8_t symbold)
{  
  if (shiftd || symbold)
  {
    uint8_t key;

    if (shiftd)
      key = mapShift[r][c];
    if (symbold)
      key = mapSymbol[r][c];

    if (key)
      sendCode(key,0,0);
    else
    {
      key = mapZX[r][c];
      if (key)
        sendCode(key,shiftd,symbold);
    }
  }
  else
  {
    uint8_t key = mapZX[r][c];
    if (key)
      sendCode(key,0,0);
  }
}

//preparamos matriz teclado.
void matrixInit()
{
   uint8_t c, r;
    
  LED_CONFIG;
  LED_OFF;

  for (c=0;c<COLS;c++)
  { 
    pinSet(pinsC[c],bcdC[c],_IN);
    pinPut(pinsC[c], bcdC[c], HI);
  }

  for (r=0;r<ROWS;r++)
    pinSet(pinsR[r],bcdR[r],_IN);
}

void matrixScan()
{
 
  uint8_t shiftd = 0;
  uint8_t symbold = 0;
  uint8_t prereset = 0;
  uint8_t prenmi = 0;
  uint8_t keyPressed = 0;
  uint8_t r, c;

//Combinaciones especiales
  //pulsacion shift
  pinSet(pinsR[SHIFT_ROW],bcdR[SHIFT_ROW],_OUT);  
 _delay_us(5);
   if(pinStat(pinsC[SHIFT_COL], bcdC[SHIFT_COL]))
    shiftd = 1;
  pinSet(pinsR[SHIFT_ROW],bcdR[SHIFT_ROW],_IN);
 _delay_us(5);

  //pulsacion symbol  
  pinSet(pinsR[SYMBOL_ROW],bcdR[SYMBOL_ROW],_OUT);  
 _delay_us(5);
  if(pinStat(pinsC[SYMBOL_COL], bcdC[SYMBOL_COL])) 
    symbold = 1;  
 _delay_us(5);
  pinSet(pinsR[SYMBOL_ROW],bcdR[SYMBOL_ROW],_IN);

  //ver si es reset
  if (shiftd && symbold && !keyPressed) {
    pinSet(pinsR[RESET_ROW],bcdR[RESET_ROW],_OUT);
 _delay_us(5);
    if(pinStat(pinsC[RESET_COL], bcdC[RESET_COL]))
      prereset = 1;  
    pinSet(pinsR[RESET_ROW],bcdR[RESET_ROW],_IN);

 _delay_us(5);
    
    pinSet(pinsR[NMI_ROW],bcdR[NMI_ROW],_OUT);
 _delay_us(5);
    if(pinStat(pinsC[NMI_COL], bcdC[NMI_COL]))
      prenmi = 1;  
    pinSet(pinsR[NMI_ROW],bcdR[NMI_ROW],_IN);
  

    if (prereset)
       sendCode(ZXUNO_RESET,shiftd,symbold); //zxuno reset
    else 
      if (prenmi)
         sendCode(ZXUNO_NMI,shiftd,symbold); //zxuno nmi 
       else  
         sendCode(0,shiftd,symbold); //extended mode  
  }

//Escaneo de filas
  for (r=0;r<ROWS;r++)
  {
    //activar fila
    pinSet(pinsR[r],bcdR[r],_OUT);
    pinPut(pinsR[r], bcdR[r], LO);
    _delay_us(5);
    for (c=0;c<COLS;c++)
    { 
        if((pinStat(pinsC[c], bcdC[c]))) 
        {
	   _delay_us(10); //debounce
	   if((pinStat(pinsC[c], bcdC[c]))) 
	   {	
	     keyPressed = 1;          
	     pressKey(r, c, shiftd, symbold);      
	   }
    	}
   }
    //desact. fila
    pinSet(pinsR[r],bcdR[r],_IN);
  }
 //fin escaneo de filas

  pinPut(pinsR[SHIFT_ROW], bcdR[SHIFT_ROW], LO);
  pinPut(pinsR[SYMBOL_ROW], bcdR[SYMBOL_ROW], LO);

  //if (keyPressed)
    _delay_ms(100);

}

int main() 
{
	matrixInit();
	ps2Init();
	while(1) {
	  matrixScan();
	}
}