/* 
 * Definiciones teclado con scancodes ps/2
 */

#define KEY_ESCAPE 0x76
#define KEY_DELETE 0x66

//Especiales, requieren E0
#define KEY_RIGHT   0x74
#define KEY_LEFT    0x6B
#define KEY_DOWN    0x72
#define KEY_UP      0x75
#define KEY_LCTRL   0x14
#define KEY_LALT    0x11
#define KEY_RCTRL   0x14
#define KEY_RALT    0x11

#define KEY_A       0x1C
#define KEY_B       0x32
#define KEY_C       0x21
#define KEY_D       0x23
#define KEY_E       0x24
#define KEY_F       0x2B
#define KEY_G       0x34
#define KEY_H       0x33
#define KEY_I       0x43
#define KEY_J       0x3B
#define KEY_K       0x42
#define KEY_L       0x4B
#define KEY_M       0x3A
#define KEY_N       0x31
#define KEY_O       0x44
#define KEY_P       0x4D
#define KEY_Q       0x15
#define KEY_R       0x2D
#define KEY_S       0x1B
#define KEY_T       0x2C
#define KEY_U       0x3C
#define KEY_V       0x2A
#define KEY_W       0x1D
#define KEY_X       0x22
#define KEY_Y       0x35
#define KEY_Z       0x1A
#define KEY_1       0x16
#define KEY_2       0x1E
#define KEY_3       0x26
#define KEY_4       0x25
#define KEY_5       0x2E
#define KEY_6       0x36
#define KEY_7       0x3D
#define KEY_8       0x3E
#define KEY_9       0x46
#define KEY_0       0x45

#define KEY_ENTER   0x5A
#define KEY_SPACE   0x29

#define KEY_F1      0x05
#define KEY_F2      0x06
#define KEY_F3      0x04
#define KEY_F4      0x0c
#define KEY_F5      0x03
#define KEY_F6      0x0B
#define KEY_F7      0x83
#define KEY_F8      0x0A
#define KEY_F9      0x01
#define KEY_F10     0x09
#define KEY_F11     0x78
#define KEY_F12     0x07

#define KEY_LSHIFT  0x12
#define KEY_RSHIFT  0x59

#define KEY_CAPS    0x58

#define KEY_TLD     0x0E
#define KEY_TAB     0x0D

#define ROWS 8
#define COLS 5

// mapa normal ZX 
const uint8_t mapZX[ROWS][COLS] = {
  {KEY_5,          KEY_4,          KEY_3,          KEY_2,          KEY_1}, 
  {KEY_T,          KEY_R,          KEY_E,          KEY_W,          KEY_Q}, 
  {KEY_G,          KEY_F,          KEY_D,          KEY_S,          KEY_A},
  {KEY_6,          KEY_7,          KEY_8,          KEY_9,          KEY_0}, 
  {KEY_Y,          KEY_U,          KEY_I,          KEY_O,          KEY_P},
  {KEY_V,          KEY_C,          KEY_X,          KEY_Z,          0	}, 
  {KEY_H,          KEY_J,          KEY_K,          KEY_L,          KEY_ENTER},
  {KEY_B,          KEY_N,          KEY_M,          0,              KEY_SPACE}
};

// mapa shift
const uint8_t mapShift[ROWS][COLS] = {
  {KEY_LEFT,       0,              0,              KEY_CAPS,       KEY_TLD}, 
  {0,              0,              0,              0,              0}, 
  {0,              0,              0,              0,              0},
  {KEY_DOWN,       KEY_UP,         KEY_RIGHT,      0,              KEY_DELETE},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              KEY_ESCAPE},
};
//mapa symbol
const uint8_t mapSymbol[ROWS][COLS] = {
  {0,              0,              0,              0,              0}, 
  {0,              0,              0,              0,              0}, 
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
  {0,              0,              0,              0,              0},
};

