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
 * (https://github.com/spark2k06/zxuno/tree/master/joy2ps2)
 *
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
 * History
 *
 * 29-Aug-2017 - First release
 *
 *
 ********************************************************************************
 */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32f1xx_hal.h"
#include "usb_host.h"

/* USER CODE BEGIN Includes */

#include "usbh_hid_keybd.h"

#include "PS2.h"

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/
UART_HandleTypeDef huart3;

/* USER CODE BEGIN PV */

extern uint32_t uwTick;

// Microseconds for PS/2 half bit and full bit
#define CK1 16
#define CK2 32

#define MAX_KEYB_KEYS 6
#define NUM_CONTROL_KEYS 3
#define MAX_KEYB_BYTES ( MAX_KEYB_KEYS * 5 + NUM_CONTROL_KEYS * 3 )

// These are PS/2 codes
uint8_t keyCodeQueue[ MAX_KEYB_BYTES ];
int numBytesInQueue = 0;

// These are USB HID key codes of keys currently pressed
uint8_t keysPressed[ MAX_KEYB_KEYS ];

// These are flags
#define CONTROL_KEY_LEFT_CONTROL 0
#define CONTROL_KEY_LEFT_ALT 1
#define CONTROL_KEY_LEFT_SHIFT 2
uint8_t controlKeysPressed[ NUM_CONTROL_KEYS ];

// Macros para poner estado de los pines del PS/2
#define SET_PIN_PS2_DATA( x ) HAL_GPIO_WritePin( GPIOA, PS2_DATA_PIN_Pin, x ? GPIO_PIN_SET : GPIO_PIN_RESET )
#define SET_PIN_PS2_CLK( x ) HAL_GPIO_WritePin( GPIOA, PS2_CLK_PIN_Pin, x ? GPIO_PIN_SET : GPIO_PIN_RESET )

// Puerto serie solo para salida de debug
UART_HandleTypeDef *phuart3 = &huart3;

/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART3_UART_Init(void);
void MX_USB_HOST_Process(void);

/* USER CODE BEGIN PFP */


void enqueueUSBKey( uint8_t usbCode, uint8_t release );
void enqueueUSBByte( uint8_t code );
void enviarBytePS2( uint8_t code );
void sendPS2Queue();

void enviarByteUSART3( uint16_t dato );
void enviarCadenaUSART3( const char* cadena );
char *byte2ascii( uint8_t b, char *s );
char *uint32_2ascii( uint32_t b, char *s );
void printByteToUART3( uint8_t data );
void printUInt32ToUART3( uint32_t data );

void DWT_Init( void );
uint32_t DWT_Get(void);
void DWT_Reset();
uint32_t DWT_GetUs(void);
__inline uint8_t DWT_Compare( int32_t tp );
void DWT_DelayUS( uint32_t us );
void DWT_DelayMS( uint32_t ms );

/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

int main(void) {

	/* USER CODE BEGIN 1 */

	/* USER CODE END 1 */

	/* MCU Configuration----------------------------------------------------------*/

	/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
	HAL_Init();

	/* USER CODE BEGIN Init */

	/* USER CODE END Init */

	/* Configure the system clock */
	SystemClock_Config();

	/* USER CODE BEGIN SysInit */

	/* USER CODE END SysInit */

	/* Initialize all configured peripherals */
	MX_GPIO_Init();
	MX_USART3_UART_Init();
	MX_USB_HOST_Init();

	/* USER CODE BEGIN 2 */

	DWT_Init();

	uint32_t t0, t1;
	t0 = HAL_GetTick();

	for ( uint16_t i = 0; i < MAX_KEYB_KEYS; i++ ) {
		keysPressed[ i ] = 0;
	}

	/* USER CODE END 2 */

	/* Infinite loop */
	/* USER CODE BEGIN WHILE */
	while (1) {

		/* USER CODE END WHILE */
		MX_USB_HOST_Process();

		/* USER CODE BEGIN 3 */

		if (getAppliState() == APPLICATION_READY) {
			USBH_HandleTypeDef *phost = getUSBH_Handle();

			// Read keyboard
			HID_KEYBD_Info_TypeDef *keybInfo = USBH_HID_GetKeybdInfo(phost);

			if ( keybInfo != NULL ) {
				//enviarCadenaUSART3( "Evento de tecla:\r\n" );

				// Send/release the control keys
				if ( keybInfo->lctrl ) {
					if ( ! controlKeysPressed[ CONTROL_KEY_LEFT_CONTROL ] ) {
						// Press
						enqueueUSBKey( KEY_LEFTCONTROL, 0 );
						controlKeysPressed[ CONTROL_KEY_LEFT_CONTROL ] = 1;
					}
				}
				else {
					if ( controlKeysPressed[ CONTROL_KEY_LEFT_CONTROL ] ) {
						// Release
						enqueueUSBKey( KEY_LEFTCONTROL, 1 );
						controlKeysPressed[ CONTROL_KEY_LEFT_CONTROL ] = 0;
					}
				}

				if ( keybInfo->lshift ) {
					if ( ! controlKeysPressed[ CONTROL_KEY_LEFT_SHIFT ] ) {
						// Press
						enqueueUSBKey( KEY_LEFTSHIFT, 0 );
						controlKeysPressed[ CONTROL_KEY_LEFT_SHIFT ] = 1;
					}
				}
				else {
					if ( controlKeysPressed[ CONTROL_KEY_LEFT_SHIFT ] ) {
						// Release
						enqueueUSBKey( KEY_LEFTSHIFT, 1 );
						controlKeysPressed[ CONTROL_KEY_LEFT_SHIFT ] = 0;
					}
				}

				if ( keybInfo->lalt ) {
					if ( ! controlKeysPressed[ CONTROL_KEY_LEFT_ALT ] ) {
						// Press
						enqueueUSBKey( KEY_LEFTALT, 0 );
						controlKeysPressed[ CONTROL_KEY_LEFT_ALT ] = 1;
					}
				}
				else {
					if ( controlKeysPressed[ CONTROL_KEY_LEFT_ALT ] ) {
						// Release
						enqueueUSBKey( KEY_LEFTALT, 1 );
						controlKeysPressed[ CONTROL_KEY_LEFT_ALT ] = 0;
					}
				}


				// Search for keys previously pressed and now released
				for ( uint16_t i = 0; i < MAX_KEYB_KEYS; i++ ) {
					uint8_t keyPressed = keysPressed[ i ];
					if ( keyPressed ) {
						uint8_t found = 0;
						for ( uint16_t j = 0; j < MAX_KEYB_KEYS; j++ ) {
							uint8_t usbCode = keybInfo->keys[ j ];
							if ( keyPressed == usbCode ) {
								found = 1;
								break;
							}
						}
						if ( found == 0 ) {
							// Key is released
							enqueueUSBKey( keyPressed, 1 );
							keysPressed[ i ] = 0;
						}
					}
				}

				// Iterate through keys that were just pressed
				for ( uint16_t i = 0; i < MAX_KEYB_KEYS; i++ ) {

					uint8_t usbCode = keybInfo->keys[ i ];

					if ( usbCode ) {

						uint8_t found = 0;
						int freeIndex = -1;
						for ( uint16_t j = 0; j < MAX_KEYB_KEYS; j++ ) {
							uint8_t keyPressed = keysPressed[ j ];
							if ( keyPressed == 0 ) {
								freeIndex = j;
							}
							if ( keyPressed == usbCode ) {
								freeIndex = -1;
								found = 1;
								break;
							}
						}

						if ( freeIndex >= 0 ) {
							// Save key as pressed
							keysPressed[ freeIndex ] = usbCode;
						}

						if ( ! found ) {
							// Key is newly pressed
							enqueueUSBKey( usbCode, 0 );
						}

						//enviarCadenaUSART3("Tecla: ");
						//printByteToUART3( usbCode );
						//enviarCadenaUSART3("\r\n");

					}
				}

				sendPS2Queue();

				//enviarCadenaUSART3("Fin evento.\r\n");

			}
		}

		/*
	    t1 = HAL_GetTick();
	    if ( t1 - t0 > 1000 ) {
	    	t0 = t1;

	    	enviarCadenaUSART3( "Test - " );
	    	printUInt32ToUART3( DWT_GetUs() );
	    	enviarCadenaUSART3( "\r\n" );

	    }
	    */

	}
	/* USER CODE END 3 */

}

/** System Clock Configuration
 */
void SystemClock_Config(void) {

	RCC_OscInitTypeDef RCC_OscInitStruct;
	RCC_ClkInitTypeDef RCC_ClkInitStruct;
	RCC_PeriphCLKInitTypeDef PeriphClkInit;

	/**Initializes the CPU, AHB and APB busses clocks
	 */
	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
	RCC_OscInitStruct.HSEState = RCC_HSE_ON;
	RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
	RCC_OscInitStruct.HSIState = RCC_HSI_ON;
	RCC_OscInitStruct.Prediv1Source = RCC_PREDIV1_SOURCE_HSE;
	RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
	RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
	RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL6;
	RCC_OscInitStruct.PLL2.PLL2State = RCC_PLL_NONE;
	if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK) {
		_Error_Handler(__FILE__, __LINE__);
	}

	/**Initializes the CPU, AHB and APB busses clocks
	 */
	RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK
			| RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
	RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
	RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
	RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
	RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

	if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK) {
		_Error_Handler(__FILE__, __LINE__);
	}

	PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_USB;
	PeriphClkInit.UsbClockSelection = RCC_USBCLKSOURCE_PLL_DIV3;
	if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK) {
		_Error_Handler(__FILE__, __LINE__);
	}

	/**Configure the Systick interrupt time
	 */
	HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq() / 1000);

	/**Configure the Systick
	 */
	HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

	/**Configure the Systick interrupt time
	 */
	__HAL_RCC_PLLI2S_ENABLE();

	/* SysTick_IRQn interrupt configuration */
	HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* USART3 init function */
static void MX_USART3_UART_Init(void) {

	huart3.Instance = USART3;
	huart3.Init.BaudRate = 57600;
	huart3.Init.WordLength = UART_WORDLENGTH_8B;
	huart3.Init.StopBits = UART_STOPBITS_1;
	huart3.Init.Parity = UART_PARITY_NONE;
	huart3.Init.Mode = UART_MODE_TX;
	huart3.Init.HwFlowCtl = UART_HWCONTROL_NONE;
	huart3.Init.OverSampling = UART_OVERSAMPLING_16;
	if (HAL_UART_Init(&huart3) != HAL_OK) {
		_Error_Handler(__FILE__, __LINE__);
	}

}

/** Configure pins as 
 * Analog
 * Input
 * Output
 * EVENT_OUT
 * EXTI
 */
static void MX_GPIO_Init(void) {

	GPIO_InitTypeDef GPIO_InitStruct;

	/* GPIO Ports Clock Enable */
	__HAL_RCC_GPIOD_CLK_ENABLE()
	;
	__HAL_RCC_GPIOA_CLK_ENABLE()
	;
	__HAL_RCC_GPIOB_CLK_ENABLE()
	;

	/*Configure GPIO pin Output Level */
	HAL_GPIO_WritePin(GPIOA, PS2_DATA_PIN_Pin | PS2_CLK_PIN_Pin, GPIO_PIN_RESET);

	/*Configure GPIO pins : PS2_DATA_PIN_Pin PS2_CLK_PIN_Pin */
	GPIO_InitStruct.Pin = PS2_DATA_PIN_Pin | PS2_CLK_PIN_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

}

/* USER CODE BEGIN 4 */

void enviarBytePS2( uint8_t code ) {

	uint8_t parity = 1;

	SET_PIN_PS2_DATA( 0 );
	DWT_DelayUS( CK1 );

	SET_PIN_PS2_CLK( 0 );
	DWT_DelayUS( CK2 );
	SET_PIN_PS2_CLK( 1 );
	DWT_DelayUS( CK1 );

	for ( int i = 0; i < 8; i++ ) {

		if ( code & ( 1 << i ) ) {
			SET_PIN_PS2_DATA( 1 );
			parity = parity ^ 1;
		}
		else {
			SET_PIN_PS2_DATA( 0 );
		}

		DWT_DelayUS( CK1 );
		SET_PIN_PS2_CLK( 0 );
		DWT_DelayUS( CK2 );
		SET_PIN_PS2_CLK( 1 );
		DWT_DelayUS( CK1 );

	}

	// Bit de paridad
	SET_PIN_PS2_DATA( parity  );

	DWT_DelayUS( CK1 );
	SET_PIN_PS2_CLK( 0 );
	DWT_DelayUS( CK2 );
	SET_PIN_PS2_CLK( 1 );
	DWT_DelayUS( CK1 );

	// Bit de parada
	SET_PIN_PS2_DATA( 1  );

	DWT_DelayUS( CK1 );
	SET_PIN_PS2_CLK( 0 );
	DWT_DelayUS( CK2 );
	SET_PIN_PS2_CLK( 1 );
	DWT_DelayUS( CK1 );

	DWT_DelayUS( 50 );

}

void enqueueUSBKey( uint8_t usbCode, uint8_t release ) {

	uint8_t key = translationTableUSBToPS2[ usbCode ];
	uint8_t codigoPS2 = ScanCodes2[ key ];

	uint8_t extended = 0;

		//checkeamos si es una tecla con scancode extendido (E0)
	switch ( key ) {
		case PS2_KEY_UP:
		case PS2_KEY_DOWN:
		case PS2_KEY_LEFT:
		case PS2_KEY_RIGHT:
		case PS2_KEY_INS:
		case PS2_KEY_HOME:
		case PS2_KEY_PUP:
		case PS2_KEY_DEL:
		case PS2_KEY_END:
		case PS2_KEY_PDN:
		case PS2_KEYPAD_BAR:
		case PS2_KEYPAD_ENT:
			extended = 1;
			break;
		default:
			extended = 0;
			break;
	}

	if ( extended ) {
		enqueueUSBByte( 0xE0 );
	}

	// Set 1 release
	//if ( release && scancodeset == 1 ) {
	//  enqueueUSBByte( codigoPS2 | 0x80 );
	//}

	// Set 1 make
	//if ( ! release && scancodeset == 1) {
	//  enqueueUSBByte( codigoPS2 );
	//}

	// Set 2 release
	if ( release ) {
		enqueueUSBByte( 0xF0 );
	}

	// Set 2 make or release
	enqueueUSBByte( codigoPS2 );

}

void enqueueUSBByte( uint8_t code ) {
	keyCodeQueue[ numBytesInQueue++ ] = code;
}

void sendPS2Queue() {

	for ( int index = 0; index < numBytesInQueue; index++ ) {

		uint8_t sendCode = keyCodeQueue[ index ];

		enviarBytePS2( sendCode );

	}

	numBytesInQueue = 0;

}

void enviarByteUSART3(uint16_t dato) {

	while ( __HAL_UART_GET_FLAG( phuart3, UART_FLAG_TXE ) == 0) {
		// Just wait for the transmission of the previous byte.
	}

	huart3.Instance->DR = (dato & (uint16_t) 0x01FF);

}

void enviarCadenaUSART3(const char* cadena) {

	while (*cadena != 0) {
		enviarByteUSART3((uint16_t) (*cadena));
		cadena++;
	}

}

char *byte2ascii(uint8_t b, char *s) {

	// converts number b to decimal string
	// s must be 4 bytes long at least
	// Returns pointer to end of string (contains 0)

	if (b >= 100) {
		*s++ = '0' + (b / 100);
		b = b - (b / 100) * 100;
	}
	else {
		*s++ = '0';
	}

	if (b >= 10) {
		*s++ = '0' + (b / 10);
		b = b - (b / 10) * 10;
	}
	else {
		*s++ = '0';
	}

	*s++ = '0' + b;

	*s = 0;

	return s;

}

char *uint32_2ascii(uint32_t b, char *s) {

	// converts number b to decimal string
	// s must be 11 bytes long at least
	// Returns pointer to end of string (contains 0)

	if (b >= 1000000000L) {
		*s++ = '0' + (b / 1000000000L);
		b = b - (b / 1000000000L) * 1000000000L;
	}
	else {
		*s++ = '0';
	}

	if (b >= 100000000L) {
		*s++ = '0' + (b / 100000000L);
		b = b - (b / 100000000L) * 100000000L;
	}
	else {
		*s++ = '0';
	}

	if (b >= 10000000L) {
		*s++ = '0' + (b / 10000000L);
		b = b - (b / 10000000L) * 10000000L;
	}
	else {
		*s++ = '0';
	}

	if (b >= 1000000L) {
		*s++ = '0' + (b / 1000000L);
		b = b - (b / 1000000L) * 1000000L;
	}
	else {
		*s++ = '0';
	}

	if (b >= 100000L) {
		*s++ = '0' + (b / 100000L);
		b = b - (b / 100000L) * 100000L;
	}
	else {
		*s++ = '0';
	}

	if (b >= 10000) {
		*s++ = '0' + (b / 10000);
		b = b - (b / 10000) * 10000;
	}
	else {
		*s++ = '0';
	}

	if (b >= 1000) {
		*s++ = '0' + (b / 1000);
		b = b - (b / 1000) * 1000;
	}
	else {
		*s++ = '0';
	}

	if (b >= 100) {
		*s++ = '0' + (b / 100);
		b = b - (b / 100) * 100;
	}
	else {
		*s++ = '0';
	}

	if (b >= 10) {
		*s++ = '0' + (b / 10);
		b = b - (b / 10) * 10;
	}
	else {
		*s++ = '0';
	}

	*s++ = '0' + b;

	*s = 0;

	return s;

}

void printByteToUART3(uint8_t data) {

	char s[4];

	byte2ascii(data, s);

	enviarCadenaUSART3(s);

}

void printUInt32ToUART3(uint32_t data) {

	char s[11];

	uint32_2ascii( data, s );

	enviarCadenaUSART3(s);

}

extern uint32_t SystemCoreClock;

// Microseconds timing functions obtained from:
// https://kbiva.wordpress.com/2013/03/25/microsecond-delay-function-for-stm32/
void DWT_Init(void) {
//	if ( ! ( CoreDebug->DEMCR & CoreDebug_DEMCR_TRCENA_Msk ) ) {
		CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
		DWT->CYCCNT = 0;
		DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
//	}
}

uint32_t DWT_Get(void) {
	return DWT->CYCCNT;
}

void DWT_Reset() {
	DWT->CYCCNT = 0;
}

uint32_t DWT_GetUs(void) {
	return (uint32_t)( ( 1000000.0 * DWT_Get() ) / SystemCoreClock );
}

__inline uint8_t DWT_Compare( int32_t tp ) {
	return ( ( (int32_t ) DWT_Get() - tp) < 0 );
}

void DWT_DelayUS( uint32_t us ) {
	int32_t tp = DWT_Get() + us * (SystemCoreClock / 1000000);
	while ( DWT_Compare( tp ) ) {
		// Wait
	}
}

void DWT_DelayMS( uint32_t ms ) {
	DWT_DelayUS( ms * 1000 );
}

/* USER CODE END 4 */

/**
 * @brief  This function is executed in case of error occurrence.
 * @param  None
 * @retval None
 */
void _Error_Handler(char * file, int line) {
	/* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */
	while (1) {
	}
	/* USER CODE END Error_Handler_Debug */
}

#ifdef USE_FULL_ASSERT

/**
 * @brief Reports the name of the source file and the source line number
 * where the assert_param error has occurred.
 * @param file: pointer to the source file name
 * @param line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t* file, uint32_t line)
{
	/* USER CODE BEGIN 6 */
	/* User can add his own implementation to report the file name and line number,
	 ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
	/* USER CODE END 6 */

}

#endif

/**
 * @}
 */

/**
 * @}
 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
