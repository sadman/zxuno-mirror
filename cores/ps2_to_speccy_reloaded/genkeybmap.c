#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

/*
    8      5    3   3    5      8
AAAAAAAA DDDDD MMM MRN JJJJJ XXXXXXXX

AAAAAAAA = semifilas del teclado a modificar
DDDDD    = dato (AND con lo que haya) de esa semifila
MMM      = la tecla es un modificador
MRN      = Master reset, Reset de usuario, NMI
JJJJJ    = estado del joystick al pulsar tecla. Posiciones UDLRX
XXXXX..X = Reservado para uso futuro

Ej: en la dirección de memoria correspondiente al código de la tecla ESC,
que correspondería a la pulsación simultánea de CAPS SHIFT+SPACE, pondríamos:
10000001 00001 000 000 00000 00000000
Esto es: se activan A8 y A15, y D0.

256 codigos + E0 = 512 codigos
SHIFT, CTRL, ALT = 8 combinaciones

512*8=4096 direcciones x 32 bits = 16384 bytes
*/

/* Warning: Binary constants. Compìle with GCC >= 4.3 */

// You shouldn't have to touch these defs unless your Spectrum has a different keyboard
// layout (because, for example, you are using a different ROM

//                   AAAAAAAADDDDDMMMMRNJJJJJXXXXXXXX
#define SP_1       0b00001000000010000000000000000000
#define SP_2       0b00001000000100000000000000000000
#define SP_3       0b00001000001000000000000000000000
#define SP_4       0b00001000010000000000000000000000
#define SP_5       0b00001000100000000000000000000000

#define SP_0       0b00010000000010000000000000000000
#define SP_9       0b00010000000100000000000000000000
#define SP_8       0b00010000001000000000000000000000
#define SP_7       0b00010000010000000000000000000000
#define SP_6       0b00010000100000000000000000000000

#define SP_Q       0b00000100000010000000000000000000
#define SP_W       0b00000100000100000000000000000000
#define SP_E       0b00000100001000000000000000000000
#define SP_R       0b00000100010000000000000000000000
#define SP_T       0b00000100100000000000000000000000

#define SP_P       0b00100000000010000000000000000000
#define SP_O       0b00100000000100000000000000000000
#define SP_I       0b00100000001000000000000000000000
#define SP_U       0b00100000010000000000000000000000
#define SP_Y       0b00100000100000000000000000000000

#define SP_A       0b00000010000010000000000000000000
#define SP_S       0b00000010000100000000000000000000
#define SP_D       0b00000010001000000000000000000000
#define SP_F       0b00000010010000000000000000000000
#define SP_G       0b00000010100000000000000000000000

#define SP_ENTER   0b01000000000010000000000000000000
#define SP_L       0b01000000000100000000000000000000
#define SP_K       0b01000000001000000000000000000000
#define SP_J       0b01000000010000000000000000000000
#define SP_H       0b01000000100000000000000000000000

#define SP_CAPS    0b00000001000010000000000000000000
#define SP_Z       0b00000001000100000000000000000000
#define SP_X       0b00000001001000000000000000000000
#define SP_C       0b00000001010000000000000000000000
#define SP_V       0b00000001100000000000000000000000

#define SP_SPACE   0b10000000000010000000000000000000
#define SP_SYMBOL  0b10000000000100000000000000000000
#define SP_M       0b10000000001000000000000000000000
#define SP_N       0b10000000010000000000000000000000
#define SP_B       0b10000000100000000000000000000000

#define SP_BANG    SP_SYMBOL | SP_1
#define SP_AT      SP_SYMBOL | SP_2
#define SP_HASH    SP_SYMBOL | SP_3
#define SP_DOLLAR  SP_SYMBOL | SP_4
#define SP_PERCEN  SP_SYMBOL | SP_5
#define SP_AMP     SP_SYMBOL | SP_6
#define SP_APOSTRO SP_SYMBOL | SP_7
#define SP_PAROPEN SP_SYMBOL | SP_8
#define SP_PARCLOS SP_SYMBOL | SP_9
#define SP_UNDERSC SP_SYMBOL | SP_0
#define SP_LESS    SP_SYMBOL | SP_R
#define SP_GREATER SP_SYMBOL | SP_T
#define SP_BRAOPEN SP_SYMBOL | SP_Y
#define SP_BRACLOS SP_SYMBOL | SP_U
#define SP_SEMICOL SP_SYMBOL | SP_O
#define SP_QUOTE   SP_SYMBOL | SP_P
#define SP_TILDE   SP_SYMBOL | SP_A
#define SP_PIPE    SP_SYMBOL | SP_S
#define SP_BACKSLA SP_SYMBOL | SP_D
#define SP_CUROPEN SP_SYMBOL | SP_F
#define SP_CURCLOS SP_SYMBOL | SP_G
#define SP_CARET   SP_SYMBOL | SP_H
#define SP_MINUS   SP_SYMBOL | SP_J
#define SP_PLUS    SP_SYMBOL | SP_K
#define SP_EQUAL   SP_SYMBOL | SP_L
#define SP_COLON   SP_SYMBOL | SP_Z
#define SP_POUND   SP_SYMBOL | SP_X
#define SP_QUEST   SP_SYMBOL | SP_C
#define SP_SLASH   SP_SYMBOL | SP_V
#define SP_STAR    SP_SYMBOL | SP_B
#define SP_COMMA   SP_SYMBOL | SP_N
#define SP_DOT     SP_SYMBOL | SP_M

#define SP_EXTEND  SP_CAPS | SP_SYMBOL
#define SP_EDIT    SP_CAPS | SP_1
#define SP_CPSLOCK SP_CAPS | SP_2
#define SP_TRUE    SP_CAPS | SP_3
#define SP_INVERSE SP_CAPS | SP_4
#define SP_LEFT    SP_CAPS | SP_5
#define SP_DOWN    SP_CAPS | SP_6
#define SP_UP      SP_CAPS | SP_7
#define SP_RIGHT   SP_CAPS | SP_8
#define SP_GRAPH   SP_CAPS | SP_9
#define SP_DELETE  SP_CAPS | SP_0
#define SP_BREAK   SP_CAPS | SP_SPACE
#define SP_TEST    SP_Q | SP_A | SP_Z | SP_P | SP_L | SP_M

// END of Spectrum keys definitions

// Definitions for additional signals generated by the keyboard core
#define MODIFIER1  0b00000000000001000000000000000000
#define MODIFIER2  0b00000000000000100000000000000000
#define MODIFIER3  0b00000000000000010000000000000000

#define MRESET     0b00000000000000001000000000000000
#define URESET     0b00000000000000000100000000000000
#define NMI        0b00000000000000000010000000000000

#define JOYUP      0b00000000000000000001000000000000
#define JOYDOWN    0b00000000000000000000100000000000
#define JOYLEFT    0b00000000000000000000010000000000
#define JOYRIGHT   0b00000000000000000000001000000000
#define JOYFIRE    0b00000000000000000000000100000000

#define USER1      0b00000000000000000000000010000000
#define USER2      0b00000000000000000000000001000000
#define USER3      0b00000000000000000000000000100000
#define USER4      0b00000000000000000000000000010000
#define USER5      0b00000000000000000000000000001000
#define USER6      0b00000000000000000000000000000100
#define USER7      0b00000000000000000000000000000010
#define USER8      0b00000000000000000000000000000001
// End of additional signals

// A key can be pressed with up to three key modifiers
// which generates 8 combinations for each key
#define EXT        0b000100000000
#define MD1        0b001000000000
#define MD2        0b010000000000
#define MD3        0b100000000000

// Scan code 2 list. First, non localized keys
#define PC_A       0x1C
#define PC_B       0x32
#define PC_C       0x21
#define PC_D       0x23
#define PC_E       0x24
#define PC_F       0x2B
#define PC_G       0x34
#define PC_H       0x33
#define PC_I       0x43
#define PC_J       0x3B
#define PC_K       0x42
#define PC_L       0x4B
#define PC_M       0x3A
#define PC_N       0x31
#define PC_O       0x44
#define PC_P       0x4D
#define PC_Q       0x15
#define PC_R       0x2D
#define PC_S       0x1B
#define PC_T       0x2C
#define PC_U       0x3C
#define PC_V       0x2A
#define PC_W       0x1D
#define PC_X       0x22
#define PC_Y       0x35
#define PC_Z       0x1A

#define PC_0       0x45
#define PC_1       0x16
#define PC_2       0x1E
#define PC_3       0x26
#define PC_4       0x25
#define PC_5       0x2E
#define PC_6       0x36
#define PC_7       0x3D
#define PC_8       0x3E
#define PC_9       0x46

#define PC_F1      0x05
#define PC_F2      0x06
#define PC_F3      0x04
#define PC_F4      0x0C
#define PC_F5      0x03
#define PC_F6      0x0B
#define PC_F7      0x83
#define PC_F8      0x0A
#define PC_F9      0x01
#define PC_F10     0x09
#define PC_F11     0x78
#define PC_F12     0x07

#define PC_ESC     0x76
#define PC_SPACE   0x29
#define PC_LCTRL   0x14
#define PC_RCTRL   0x14 | EXT
#define PC_LSHIFT  0x12
#define PC_RSHIFT  0x59
#define PC_LALT    0x11
#define PC_RALT    0x11 | EXT
#define PC_LWIN    0x1F | EXT
#define PC_RWIN    0x27 | EXT
#define PC_APPS    0x2F | EXT

#define PC_TAB     0x0D
#define PC_CPSLOCK 0x58
#define PC_SCRLOCK 0x7E

#define PC_INSERT  0x70 | EXT
#define PC_DELETE  0x71 | EXT
#define PC_HOME    0x6C | EXT
#define PC_END     0x69 | EXT
#define PC_PGUP    0x7D | EXT
#define PC_PGDOWN  0x7A | EXT
#define PC_BKSPACE 0x66
#define PC_ENTER   0x5A
#define PC_UP      0x75 | EXT
#define PC_DOWN    0x72 | EXT
#define PC_LEFT    0x6B | EXT
#define PC_RIGHT   0x74 | EXT

#define PC_NUMLOCK  0x77
#define PC_KP_DIVIS 0x4A | EXT
#define PC_KP_MULT  0x7C
#define PC_KP_MINUS 0x7B
#define PC_KP_PLUS  0x79
#define PC_KP_ENTER 0x5A | EXT
#define PC_KP_DOT   0x71
#define PC_KP_0     0x70
#define PC_KP_1     0x69
#define PC_KP_2     0x72
#define PC_KP_3     0x7A
#define PC_KP_4     0x6B
#define PC_KP_5     0x73
#define PC_KP_6     0x74
#define PC_KP_7     0x6C
#define PC_KP_8     0x75
#define PC_KP_9     0x7D

// Localized keyboards start to differenciate from here

// Localized keyboard ES (Spain)
#define PC_BACKSLA 0x0E
#define PC_APOSTRO 0x4E
#define PC_OPNBANG 0x55
#define PC_GRAVEAC 0x54
#define PC_PLUS    0x5B
#define PC_EGNE    0x4C
#define PC_ACUTEAC 0x52
#define PC_CEDILLA 0x5D
#define PC_LESS    0x61
#define PC_COMMA   0x41
#define PC_DOT     0x49
#define PC_MINUS   0x4A

#define MAP(pc,sp) rom[(pc)] = (sp)
#define CLEANMAP {                                                            \
                    int i;                                                    \
                    for (i=0;i<(sizeof(rom)/sizeof(rom[0]));i++)              \
                      rom[i] = 0;                                             \
                 }
#define SAVEMAP(name) {                                                       \
                         FILE *f;                                             \
                         int i;                                               \
                         f=fopen(name,"w");                                   \
                         for(i=0;i<(sizeof(rom)/sizeof(rom[0]));i++)          \
                           fprintf(f,"%.8X\n",rom[i]);                        \
                         fclose(f);                                           \
                      }
#define SAVEMAP16(name) {                                                       \
                           FILE *f;                                             \
                           int i;                                               \
                           f=fopen(name,"w");                                   \
                           for(i=0;i<(sizeof(rom)/sizeof(rom[0]));i++)          \
                             fprintf(f,"%.4X\n",(rom[i]>>16)&0xFFFF);           \
                           fclose(f);                                           \
                        }

int main()
{
    uint32_t rom[4096];

    CLEANMAP;
    MAP(PC_LSHIFT,MODIFIER1);  // MD1 is SHIFT
    MAP(PC_RSHIFT,MODIFIER1);

    MAP(PC_LCTRL,MODIFIER2);   // MD2 is CTRL
    MAP(PC_RCTRL,MODIFIER2);

    MAP(PC_LALT,MODIFIER3|JOYFIRE);    // MD3 is ALT. Also is FIRE for keyboard joystick
    MAP(PC_RALT,MODIFIER3|JOYFIRE);

    // Basic mapping: each key from PC is mapped to a key in the Spectrum
    MAP(PC_1,SP_1);
    MAP(PC_2,SP_2);
    MAP(PC_3,SP_3);
    MAP(PC_4,SP_4);
    MAP(PC_5,SP_5);
    MAP(PC_6,SP_6);
    MAP(PC_7,SP_7);
    MAP(PC_8,SP_8);
    MAP(PC_9,SP_9);
    MAP(PC_0,SP_0);

    MAP(PC_Q,SP_Q);
    MAP(PC_W,SP_W);
    MAP(PC_E,SP_E);
    MAP(PC_R,SP_R);
    MAP(PC_T,SP_T);
    MAP(PC_Y,SP_Y);
    MAP(PC_U,SP_U);
    MAP(PC_I,SP_I);
    MAP(PC_O,SP_O);
    MAP(PC_P,SP_P);
    MAP(PC_A,SP_A);
    MAP(PC_S,SP_S);
    MAP(PC_D,SP_D);
    MAP(PC_F,SP_F);
    MAP(PC_G,SP_G);
    MAP(PC_H,SP_H);
    MAP(PC_J,SP_J);
    MAP(PC_K,SP_K);
    MAP(PC_L,SP_L);
    MAP(PC_Z,SP_Z);
    MAP(PC_X,SP_X);
    MAP(PC_C,SP_C);
    MAP(PC_V,SP_V);
    MAP(PC_B,SP_B);
    MAP(PC_N,SP_N);
    MAP(PC_M,SP_M);

    MAP(PC_LCTRL,SP_CAPS);
    MAP(PC_RCTRL,SP_SYMBOL);
    MAP(PC_SPACE,SP_SPACE);
    MAP(PC_ENTER,SP_ENTER);

    //Complex mapping. This is for the spanish keyboard although many
    //combos can be used with any other PC keyboard
    MAP(PC_ESC,SP_BREAK);
    MAP(PC_CPSLOCK,SP_CPSLOCK);
    MAP(PC_TAB,SP_EXTEND);
    MAP(PC_BKSPACE,SP_DELETE);
    MAP(PC_UP,SP_UP);
    MAP(PC_DOWN,SP_DOWN);
    MAP(PC_LEFT,SP_LEFT);
    MAP(PC_RIGHT,SP_RIGHT);
    MAP(PC_F2,SP_EDIT);

    MAP(PC_F5|MD2|MD3,NMI);            // Ctrl-Alt-F5 for NMI
    MAP(PC_DELETE|MD2|MD3,URESET);     //
    MAP(PC_KP_DOT|MD2|MD3,URESET);     // Ctrl-Alt-Del for user reset
    MAP(PC_BKSPACE|MD2|MD3,MRESET);    // Ctrl-Alt-BkSpace for master reset

    //keypad
    MAP(PC_KP_DIVIS,SP_SLASH);
    MAP(PC_KP_MULT,SP_STAR);
    MAP(PC_KP_MINUS,SP_MINUS);
    MAP(PC_KP_PLUS,SP_PLUS);

    // a 8-way keyboard joystick on the keypad
    MAP(PC_KP_7,JOYUP|JOYLEFT);
    MAP(PC_KP_8,JOYUP);
    MAP(PC_KP_9,JOYUP|JOYRIGHT);
    MAP(PC_KP_4,JOYLEFT);
    MAP(PC_KP_5,JOYDOWN);
    MAP(PC_KP_6,JOYRIGHT);
    MAP(PC_KP_1,JOYDOWN|JOYLEFT);
    MAP(PC_KP_2,JOYDOWN);
    MAP(PC_KP_3,JOYDOWN|JOYRIGHT);

    //Some shift+key mappings for the ES keyboard
    MAP(MD1|PC_1,SP_BANG);
    MAP(MD1|PC_2,SP_QUOTE);
    MAP(MD1|PC_3,SP_HASH);
    MAP(MD1|PC_4,SP_DOLLAR);
    MAP(MD1|PC_5,SP_PERCEN);
    MAP(MD1|PC_6,SP_AMP);
    MAP(MD1|PC_7,SP_SLASH);
    MAP(MD1|PC_8,SP_PAROPEN);
    MAP(MD1|PC_9,SP_PARCLOS);
    MAP(MD1|PC_0,SP_EQUAL);
    MAP(PC_APOSTRO,SP_APOSTRO);
    MAP(MD1|PC_APOSTRO,SP_QUEST);
    MAP(PC_GRAVEAC,SP_POUND);
    MAP(MD1|PC_GRAVEAC,SP_CARET);
    MAP(PC_PLUS,SP_PLUS);
    MAP(MD1|PC_PLUS,SP_STAR);
    MAP(PC_ACUTEAC,SP_CUROPEN);
    MAP(MD1|PC_ACUTEAC,SP_CUROPEN);
    MAP(PC_ACUTEAC,SP_CUROPEN);
    MAP(MD1|PC_ACUTEAC,SP_CUROPEN);
    MAP(PC_CEDILLA,SP_QUOTE);
    MAP(PC_COMMA,SP_COMMA);
    MAP(MD1|PC_COMMA,SP_SEMICOL);
    MAP(PC_DOT,SP_DOT);
    MAP(MD1|PC_DOT,SP_COLON);
    MAP(PC_MINUS,SP_MINUS);
    MAP(MD1|PC_MINUS,SP_UNDERSC);
    MAP(PC_BACKSLA,SP_BACKSLA);
    MAP(MD1|PC_BACKSLA,SP_BACKSLA);
    MAP(PC_EGNE,SP_TILDE);
    MAP(PC_LESS,SP_LESS);
    MAP(MD1|PC_LESS,SP_GREATER);

    // End of mapping. Save .HEX file for Verilog
    SAVEMAP16("keyb_es_hex.txt");
    //SAVEMAP("keyb_es_hex.txt");
}
