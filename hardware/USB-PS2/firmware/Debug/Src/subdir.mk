################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/main.c \
../Src/stm32f1xx_hal_msp.c \
../Src/stm32f1xx_it.c \
../Src/system_stm32f1xx.c \
../Src/usb_host.c \
../Src/usbh_conf.c 

OBJS += \
./Src/main.o \
./Src/stm32f1xx_hal_msp.o \
./Src/stm32f1xx_it.o \
./Src/system_stm32f1xx.o \
./Src/usb_host.o \
./Src/usbh_conf.o 

C_DEPS += \
./Src/main.d \
./Src/stm32f1xx_hal_msp.d \
./Src/stm32f1xx_it.d \
./Src/system_stm32f1xx.d \
./Src/usb_host.d \
./Src/usbh_conf.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft '-D__weak=__attribute__((weak))' '-D__packed="__attribute__((__packed__))"' -DUSE_HAL_DRIVER -DSTM32F105xC -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Drivers/STM32F1xx_HAL_Driver/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Drivers/STM32F1xx_HAL_Driver/Inc/Legacy" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Core/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Class/AUDIO/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Class/CDC/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Class/HID/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Class/MSC/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Middlewares/ST/STM32_USB_Host_Library/Class/MTP/Inc" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Drivers/CMSIS/Device/ST/STM32F1xx/Include" -I"/media/datos/Devel/stm32/openstm_proyectos/PruebaUSB7/Drivers/CMSIS/Include"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


