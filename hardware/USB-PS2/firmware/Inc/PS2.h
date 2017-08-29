/**
 ******************************************************************************
 * File Name          : main.c
 * Description        : Main program body
 ******************************************************************************
 * This notice applies to any and all portions of this file
 * that are not between comment pairs USER CODE BEGIN and
 * USER CODE END. Other portions of this file, whether
 * inserted by the user or by software development tools
 * are owned by their respective copyright owners.
 *
 * Copyright (c) 2017 STMicroelectronics International N.V.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted, provided that the following conditions are met:
 *
 * 1. Redistribution of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of STMicroelectronics nor the names of other
 *    contributors to this software may be used to endorse or promote products
 *    derived from this software without specific written permission.
 * 4. This software, including modifications and/or derivative works of this
 *    software, must execute solely and exclusively on microcontroller or
 *    microprocessor devices manufactured by or for STMicroelectronics.
 * 5. Redistribution and use of this software other than as permitted under
 *    this license is void and will automatically terminate your rights under
 *    this license.
 *
 * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
 * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT
 * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 ******************************************************************************
 ******************************************************************************
 *
 *
 * *** USER CODE LICENSE ***
 *
 * Project description: Firmware for USB Keyboard stm32 module for ZX-Uno v4.2
 *
 * MIT Licensed 2017 by Juan Jose luna Espinosa
 * (https://github.com/yomboprime/usb_zxuno)
 *
 * PS/2 Protocol and bit banged output code derived from JOY2PS2, by Spark2k06,
 * which in turn is derived from original code by Quest.
 * License is Creative Commons by SA
 * (https://github.com/spark2k06/zxuno/tree/master/joy2ps2) *
 *
 *
 * Copyright 2017 Juan Jose Luna Espinosa
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * *****************************************************************************
 *
 */

#ifndef __PS2__
#define __PS2__

// TODO anyadir teclas: RCTRL, RSHIFT, LGUI, RGUI


/*
 * Key definitions
 */

#define PS2_KEY_UP      1 // E0
#define PS2_KEY_DOWN    2 // E0
#define PS2_KEY_LEFT    3 // E0
#define PS2_KEY_RIGHT   4 // E0
#define PS2_KEY_INS	    5 // E0
#define PS2_KEY_HOME    6 // E0
#define PS2_KEY_PUP     7 // E0
#define PS2_KEY_DEL     8 // E0
#define PS2_KEY_END     9 // E0
#define PS2_KEY_PDN     10 // E0
//
#define PS2_KEY_A       11
#define PS2_KEY_B       12
#define PS2_KEY_C       13
#define PS2_KEY_D       14
#define PS2_KEY_E       15
#define PS2_KEY_F       16
#define PS2_KEY_G       17
#define PS2_KEY_H       18
#define PS2_KEY_I       19
#define PS2_KEY_J       20
#define PS2_KEY_K       21
#define PS2_KEY_L       22
#define PS2_KEY_M       23
#define PS2_KEY_N       24
#define PS2_KEY_O       25
#define PS2_KEY_P       26
#define PS2_KEY_Q       27
#define PS2_KEY_R       28
#define PS2_KEY_S       29
#define PS2_KEY_T       30
#define PS2_KEY_U       31
#define PS2_KEY_V       32
#define PS2_KEY_W       33
#define PS2_KEY_X       34
#define PS2_KEY_Y       35
#define PS2_KEY_Z       36
#define PS2_KEY_1       37
#define PS2_KEY_2       38
#define PS2_KEY_3       39
#define PS2_KEY_4       40
#define PS2_KEY_5       41
#define PS2_KEY_6       42
#define PS2_KEY_7       43
#define PS2_KEY_8       44
#define PS2_KEY_9       45
#define PS2_KEY_0       46
//
#define PS2_KEY_F1      47
#define PS2_KEY_F2      48
#define PS2_KEY_F3      49
#define PS2_KEY_F4      50
#define PS2_KEY_F5      51
#define PS2_KEY_F6      52
#define PS2_KEY_F7      53
#define PS2_KEY_F8      54
#define PS2_KEY_F9      55
#define PS2_KEY_F10     56
#define PS2_KEY_F11     57
#define PS2_KEY_F12     58
//
#define PS2_KEYPAD_1	59
#define PS2_KEYPAD_2	60
#define PS2_KEYPAD_3	61
#define PS2_KEYPAD_4	62
#define PS2_KEYPAD_5	63
#define PS2_KEYPAD_6	64
#define PS2_KEYPAD_7	65
#define PS2_KEYPAD_8	66
#define PS2_KEYPAD_9	67
#define PS2_KEYPAD_0	68
#define PS2_KEYPAD_BAR	69 // E0
#define PS2_KEYPAD_STAR 70
#define PS2_KEYPAD_MIN	71
#define PS2_KEYPAD_PLUS 72
#define PS2_KEYPAD_ENT	73 // E0
#define PS2_KEYPAD_DEL	74
#define PS2_KEYPAD_NUM	75
//
#define PS2_KEY_ESCAPE	76
#define PS2_KEY_DELETE	77
#define PS2_KEY_PERIOD	78
#define PS2_KEY_LCTRL   79
#define PS2_KEY_LALT    80
#define PS2_KEY_SCROLL	81
#define PS2_KEY_ENTER   82
#define PS2_KEY_SPACE   83
#define PS2_KEY_LSHIFT  84
#define PS2_KEY_RSHIFT  85
#define PS2_KEY_CAPS	86
#define PS2_KEY_TLD		87
#define PS2_KEY_TAB		88
#define PS2_KEY_APOS	89
#define PS2_KEY_COMMA	90
#define PS2_KEY_COLON	91

/*
 * PS/2 key codes, indexed with the previous PS2_KEY_* definitions
 */

const uint8_t ScanCodes1[] = { 0x00, 0x48, 0x50, 0x4B, 0x4D, 0x52, 0x47, 0x49, 0x4B, 0x4F, 0x51,   // UP, DOWN, LEFT, RIGHT, INS, HOME, PUP, DEL, END, PDOWN
									 0x1E, 0x30, 0x2E, 0x20, 0x12, 0x21, 0x22, 0x23, 0x17, 0x24,   // A -> J
									 0x25, 0x26, 0x32, 0x31, 0x18, 0x19, 0x10, 0x13, 0x1F, 0x14,   // K -> T
									 0x16, 0x2F, 0x11, 0x2D, 0x15, 0x2C,						   // U -> Z
									 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,   // 1 -> 9, 0
									 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43, 0x44, 0x57, 0x58, // F1 -> F12
									 0x4F, 0x50, 0x51, 0x4B, 0x4C, 0x4D, 0x47, 0x48, 0x49, 0x52, 0x35, 0x37, 0x4A, 0x4E, 0x1C, 0x53, 0x45, // Keypad Buttons
									 0x01, 0x0E, 0x34, 0x1D, 0x38, 0x46, 0x1C, 0x39, 0x2A, 0x36, 0x3A, 0x29, 0x0F, 0x0D, 0x33, 0x27 }; // Others

const uint8_t ScanCodes2[] = { 0x00, 0x75, 0x72, 0x6B, 0x74, 0x70, 0x6C, 0x7D, 0x71, 0x69, 0x7A,   // UP, DOWN, LEFT, RIGHT, INS, HOME, PUP, DEL, END, PDOWN
									 0x1C, 0x32, 0x21, 0x23, 0x24, 0x2B, 0x34, 0x33, 0x43, 0x3B,   // A -> J
									 0x42, 0x4B, 0x3A, 0x31, 0x44, 0x4D, 0x15, 0x2D, 0x1B, 0x2C,   // K -> T
									 0x3C, 0x2A, 0x1D, 0x22, 0x35, 0x1A,						   // U -> Z
									 0x16, 0x1E, 0x26, 0x25, 0x2E, 0x36, 0x3D, 0x3E, 0x46, 0x45,   // 1 -> 9, 0
									 0x05, 0x06, 0x04, 0x0C, 0x03, 0x0B, 0x83, 0x0A, 0x01, 0x09, 0x78, 0x07, // F1 -> F12
									 0x69, 0x72, 0x7A, 0x6B, 0x73, 0x74, 0x6C, 0x75, 0x7D, 0x70, 0x4A, 0x7C, 0x7B, 0x79, 0x5A, 0x71, 0x77, // Keypad Buttons
									 0x76, 0x66, 0x49, 0x14, 0x11, 0x7E, 0x5A, 0x29, 0x12, 0x59, 0x58, 0x0E, 0x0D, 0x55, 0x41, 0x4C }; // Others

/*
 * USB to PS/2 key code translation table
 */

const uint8_t translationTableUSBToPS2[] = {

0,// #define KEY_NONE                               0x00
0,// #define KEY_ERRORROLLOVER                      0x01
0,// #define KEY_POSTFAIL                           0x02
0,// #define KEY_ERRORUNDEFINED                     0x03
11,// #define KEY_A                                  0x04
12,// #define KEY_B                                  0x05
13,// #define KEY_C                                  0x06
14,// #define KEY_D                                  0x07
15,// #define KEY_E                                  0x08
16,// #define KEY_F                                  0x09
17,// #define KEY_G                                  0x0A
18,// #define KEY_H                                  0x0B
19,// #define KEY_I                                  0x0C
20,// #define KEY_J                                  0x0D
21,// #define KEY_K                                  0x0E
22,// #define KEY_L                                  0x0F
23,// #define KEY_M                                  0x10
24,// #define KEY_N                                  0x11
25,// #define KEY_O                                  0x12
26,// #define KEY_P                                  0x13
27,// #define KEY_Q                                  0x14
28,// #define KEY_R                                  0x15
29,// #define KEY_S                                  0x16
30,// #define KEY_T                                  0x17
31,// #define KEY_U                                  0x18
32,// #define KEY_V                                  0x19
33,// #define KEY_W                                  0x1A
34,// #define KEY_X                                  0x1B
35,// #define KEY_Y                                  0x1C
36,// #define KEY_Z                                  0x1D
37,// #define KEY_1_EXCLAMATION_MARK                 0x1E
38,// #define KEY_2_AT                               0x1F
39,// #define KEY_3_NUMBER_SIGN                      0x20
40,// #define KEY_4_DOLLAR                           0x21
41,// #define KEY_5_PERCENT                          0x22
42,// #define KEY_6_CARET                            0x23
43,// #define KEY_7_AMPERSAND                        0x24
44,// #define KEY_8_ASTERISK                         0x25
45,// #define KEY_9_OPARENTHESIS                     0x26
46,// #define KEY_0_CPARENTHESIS                     0x27
82,// #define KEY_ENTER                              0x28
76,// #define KEY_ESCAPE                             0x29
77,// #define KEY_BACKSPACE                          0x2A
88,// #define KEY_TAB                                0x2B
83,// #define KEY_SPACEBAR                           0x2C
0,// #define KEY_MINUS_UNDERSCORE                   0x2D
0,// #define KEY_EQUAL_PLUS                         0x2E
0,// #define KEY_OBRACKET_AND_OBRACE                0x2F
0,// #define KEY_CBRACKET_AND_CBRACE                0x30
0,// #define KEY_BACKSLASH_VERTICAL_BAR             0x31
89,// #define KEY_NONUS_NUMBER_SIGN_TILDE            0x32
0,// #define KEY_SEMICOLON_COLON                    0x33
0,// #define KEY_SINGLE_AND_DOUBLE_QUOTE            0x34
0,// #define KEY_GRAVE ACCENT AND TILDE             0x35
90,// #define KEY_COMMA_AND_LESS                     0x36
78,// #define KEY_DOT_GREATER                        0x37
0,// #define KEY_SLASH_QUESTION                     0x38
86,// #define KEY_CAPS LOCK                          0x39
47,// #define KEY_F1                                 0x3A
48,// #define KEY_F2                                 0x3B
49,// #define KEY_F3                                 0x3C
50,// #define KEY_F4                                 0x3D
51,// #define KEY_F5                                 0x3E
52,// #define KEY_F6                                 0x3F
53,// #define KEY_F7                                 0x40
54,// #define KEY_F8                                 0x41
55,// #define KEY_F9                                 0x42
56,// #define KEY_F10                                0x43
57,// #define KEY_F11                                0x44
58,// #define KEY_F12                                0x45
0,// #define KEY_PRINTSCREEN                        0x46
81,// #define KEY_SCROLL LOCK                        0x47
0,// #define KEY_PAUSE                              0x48
5,// #define KEY_INSERT                             0x49
6,// #define KEY_HOME                               0x4A
7,// #define KEY_PAGEUP                             0x4B
8,// #define KEY_DELETE                             0x4C
9,// #define KEY_END1                               0x4D
2,// #define KEY_PAGEDOWN                           0x4E
4,// #define KEY_RIGHTARROW                         0x4F
3,// #define KEY_LEFTARROW                          0x50
2,// #define KEY_DOWNARROW                          0x51
1,// #define KEY_UPARROW                            0x52
75,// #define KEY_KEYPAD_NUM_LOCK_AND_CLEAR          0x53
69,// #define KEY_KEYPAD_SLASH                       0x54
70,// #define KEY_KEYPAD_ASTERIKS                    0x55
71,// #define KEY_KEYPAD_MINUS                       0x56
72,// #define KEY_KEYPAD_PLUS                        0x57
73,// #define KEY_KEYPAD_ENTER                       0x58
59,// #define KEY_KEYPAD_1_END                       0x59
60,// #define KEY_KEYPAD_2_DOWN_ARROW                0x5A
61,// #define KEY_KEYPAD_3_PAGEDN                    0x5B
62,// #define KEY_KEYPAD_4_LEFT_ARROW                0x5C
63,// #define KEY_KEYPAD_5                           0x5D
64,// #define KEY_KEYPAD_6_RIGHT_ARROW               0x5E
65,// #define KEY_KEYPAD_7_HOME                      0x5F
66,// #define KEY_KEYPAD_8_UP_ARROW                  0x60
67,// #define KEY_KEYPAD_9_PAGEUP                    0x61
68,// #define KEY_KEYPAD_0_INSERT                    0x62
74,// #define KEY_KEYPAD_DECIMAL_SEPARATOR_DELETE    0x63
0,// #define KEY_NONUS_BACK_SLASH_VERTICAL_BAR      0x64
0,// #define KEY_APPLICATION                        0x65
0,// #define KEY_POWER                              0x66
0,// #define KEY_KEYPAD_EQUAL                       0x67
0,// #define KEY_F13                                0x68
0,// #define KEY_F14                                0x69
0,// #define KEY_F15                                0x6A
0,// #define KEY_F16                                0x6B
0,// #define KEY_F17                                0x6C
0,// #define KEY_F18                                0x6D
0,// #define KEY_F19                                0x6E
0,// #define KEY_F20                                0x6F
0,// #define KEY_F21                                0x70
0,// #define KEY_F22                                0x71
0,// #define KEY_F23                                0x72
0,// #define KEY_F24                                0x73
0,// #define KEY_EXECUTE                            0x74
0,// #define KEY_HELP                               0x75
0,// #define KEY_MENU                               0x76
0,// #define KEY_SELECT                             0x77
0,// #define KEY_STOP                               0x78
0,// #define KEY_AGAIN                              0x79
0,// #define KEY_UNDO                               0x7A
0,// #define KEY_CUT                                0x7B
0,// #define KEY_COPY                               0x7C
0,// #define KEY_PASTE                              0x7D
0,// #define KEY_FIND                               0x7E
0,// #define KEY_MUTE                               0x7F
0,// #define KEY_VOLUME_UP                          0x80
0,// #define KEY_VOLUME_DOWN                        0x81
0,// #define KEY_LOCKING_CAPS_LOCK                  0x82
0,// #define KEY_LOCKING_NUM_LOCK                   0x83
0,// #define KEY_LOCKING_SCROLL_LOCK                0x84
0,// #define KEY_KEYPAD_COMMA                       0x85
0,// #define KEY_KEYPAD_EQUAL_SIGN                  0x86
0,// #define KEY_INTERNATIONAL1                     0x87
0,// #define KEY_INTERNATIONAL2                     0x88
0,// #define KEY_INTERNATIONAL3                     0x89
0,// #define KEY_INTERNATIONAL4                     0x8A
0,// #define KEY_INTERNATIONAL5                     0x8B
0,// #define KEY_INTERNATIONAL6                     0x8C
0,// #define KEY_INTERNATIONAL7                     0x8D
0,// #define KEY_INTERNATIONAL8                     0x8E
0,// #define KEY_INTERNATIONAL9                     0x8F
0,// #define KEY_LANG1                              0x90
0,// #define KEY_LANG2                              0x91
0,// #define KEY_LANG3                              0x92
0,// #define KEY_LANG4                              0x93
0,// #define KEY_LANG5                              0x94
0,// #define KEY_LANG6                              0x95
0,// #define KEY_LANG7                              0x96
0,// #define KEY_LANG8                              0x97
0,// #define KEY_LANG9                              0x98
0,// #define KEY_ALTERNATE_ERASE                    0x99
0,// #define KEY_SYSREQ                             0x9A
0,// #define KEY_CANCEL                             0x9B
0,// #define KEY_CLEAR                              0x9C
0,// #define KEY_PRIOR                              0x9D
0,// #define KEY_RETURN                             0x9E
0,// #define KEY_SEPARATOR                          0x9F
0,// #define KEY_OUT                                0xA0
0,// #define KEY_OPER                               0xA1
0,// #define KEY_CLEAR_AGAIN                        0xA2
0,// #define KEY_CRSEL                              0xA3
0,// #define KEY_EXSEL                              0xA4
0,// A5
0,// A6
0,// A7
0,// A8
0,// A9
0,// AA
0,// AB
0,// AC
0,// AD
0,// AE
0,// AF
0,// #define KEY_KEYPAD_00                          0xB0
0,// #define KEY_KEYPAD_000                         0xB1
0,// #define KEY_THOUSANDS_SEPARATOR                0xB2
0,// #define KEY_DECIMAL_SEPARATOR                  0xB3
0,// #define KEY_CURRENCY_UNIT                      0xB4
0,// #define KEY_CURRENCY_SUB_UNIT                  0xB5
0,// #define KEY_KEYPAD_OPARENTHESIS                0xB6
0,// #define KEY_KEYPAD_CPARENTHESIS                0xB7
0,// #define KEY_KEYPAD_OBRACE                      0xB8
0,// #define KEY_KEYPAD_CBRACE                      0xB9
0,// #define KEY_KEYPAD_TAB                         0xBA
0,// #define KEY_KEYPAD_BACKSPACE                   0xBB
0,// #define KEY_KEYPAD_A                           0xBC
0,// #define KEY_KEYPAD_B                           0xBD
0,// #define KEY_KEYPAD_C                           0xBE
0,// #define KEY_KEYPAD_D                           0xBF
0,// #define KEY_KEYPAD_E                           0xC0
0,// #define KEY_KEYPAD_F                           0xC1
0,// #define KEY_KEYPAD_XOR                         0xC2
0,// #define KEY_KEYPAD_CARET                       0xC3
0,// #define KEY_KEYPAD_PERCENT                     0xC4
0,// #define KEY_KEYPAD_LESS                        0xC5
0,// #define KEY_KEYPAD_GREATER                     0xC6
0,// #define KEY_KEYPAD_AMPERSAND                   0xC7
0,// #define KEY_KEYPAD_LOGICAL_AND                 0xC8
0,// #define KEY_KEYPAD_VERTICAL_BAR                0xC9
0,// #define KEY_KEYPAD_LOGIACL_OR                  0xCA
0,// #define KEY_KEYPAD_COLON                       0xCB
0,// #define KEY_KEYPAD_NUMBER_SIGN                 0xCC
0,// #define KEY_KEYPAD_SPACE                       0xCD
0,// #define KEY_KEYPAD_AT                          0xCE
0,// #define KEY_KEYPAD_EXCLAMATION_MARK            0xCF
0,// #define KEY_KEYPAD_MEMORY_STORE                0xD0
0,// #define KEY_KEYPAD_MEMORY_RECALL               0xD1
0,// #define KEY_KEYPAD_MEMORY_CLEAR                0xD2
0,// #define KEY_KEYPAD_MEMORY_ADD                  0xD3
0,// #define KEY_KEYPAD_MEMORY_SUBTRACT             0xD4
0,// #define KEY_KEYPAD_MEMORY_MULTIPLY             0xD5
0,// #define KEY_KEYPAD_MEMORY_DIVIDE               0xD6
0,// #define KEY_KEYPAD_PLUSMINUS                   0xD7
0,// #define KEY_KEYPAD_CLEAR                       0xD8
0,// #define KEY_KEYPAD_CLEAR_ENTRY                 0xD9
0,// #define KEY_KEYPAD_BINARY                      0xDA
0,// #define KEY_KEYPAD_OCTAL                       0xDB
0,// #define KEY_KEYPAD_DECIMAL                     0xDC
0,// #define KEY_KEYPAD_HEXADECIMAL                 0xDD
0,//DE
0,//DF
79,// #define KEY_LEFTCONTROL                        0xE0
84,// #define KEY_LEFTSHIFT                          0xE1
80,// #define KEY_LEFTALT                            0xE2
0,// #define KEY_LEFT_GUI                           0xE3
0,// #define KEY_RIGHTCONTROL                       0xE4
0,// #define KEY_RIGHTSHIFT                         0xE5
0,// #define KEY_RIGHTALT                           0xE6
0,// #define KEY_RIGHT_GUI                          0xE7

// E8 - EF

0,
0,
0,
0,
0,
0,
0,
0,

// F0 - FF
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0,
0

};


#endif //__PS2__
