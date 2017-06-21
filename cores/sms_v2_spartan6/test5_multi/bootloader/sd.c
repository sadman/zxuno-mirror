#include <sms.h>
#include "sd.h"
#include "console.h"
#include "debug.h"

#define DEBUG_SD2_

const BYTE *card_type = 0xc00F;

void card_SDHC(BYTE val) 
{
	card_type[0] = val;
}

void spi_set_speed(BYTE delay)
{
	#asm
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)
	and a, $7f
	or a,$80
	out ($c0),a
	#endasm
}

void spi_assert_cs()
{
	#asm
	in a,($00)
	and a,$7f
	out ($c0),a
	#endasm
}

void spi_deassert_cs()
{
	#asm
	in a,($00)
	or a,$80
	out ($c0),a
	#endasm
}

void spi_wait()
{
	#asm
send_byte_loop:
	in a,($00)
	and a,$80
	jr z,send_byte_loop
	#endasm
}

void spi_send_byte(BYTE data)
{
	#asm
	ld	hl, 2
	add	hl, sp
	ld	a, (hl)
	out ($c1),a
	#endasm
	spi_wait();
}

void spi_delay()
{
	spi_send_byte(0xff);
}

UBYTE spi_receive_byte()
{
	spi_delay();
	#asm
	in a,($01)
	ld l,a
	ld h,0
	#endasm
}



UBYTE sd_wait_r1()
{
	BYTE r,timeout;
	for (timeout=0xa; timeout>0; --timeout) {
		r = spi_receive_byte();
		if ((r&0x80)==0) {
			break;
		}
	}
	return r;
}

UBYTE sd_wait_r58()
{
	BYTE r,timeout;
	for (timeout=0xa; timeout>0; --timeout) {
		r = spi_receive_byte();
		if (r==0x01 || r==0xc0 || r==0x80 || r==0x20) {
			break;
		}
	}
	return r;
}

UBYTE sd_wait_ready()
{
	BYTE timeout,r;
	spi_receive_byte();
	for (timeout=0xa; timeout>0; --timeout) {
		r = spi_receive_byte();
		if (r==0xff) {
			break;
		}
	}
	return r;
}

UBYTE sd_cmd0()
{
	BYTE r;
	spi_delay();
	sd_wait_ready();

	spi_send_byte(0x40);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x95);

	r = sd_wait_r1();

#ifdef DEBUG_SD
	debug_puts("cmd0:");
	debug_print_byte(r);
	debug_puts("\n");
#endif
	return r;
}

UBYTE sd_cmd1() //MMC
{
	BYTE r;
	spi_delay();
	sd_wait_ready();

	spi_send_byte(0x41);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0xFF);

	r = sd_wait_r1();

	return r;
}

UBYTE sd_cmd8()
{
	BYTE r;
	spi_delay();
	sd_wait_ready();

	spi_send_byte(0x48);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x01);
	spi_send_byte(0xaa);
	spi_send_byte(0x87);

	r = sd_wait_r1();
	spi_delay();
	spi_delay();
	spi_delay();
	spi_delay();
	spi_delay();

#ifdef DEBUG_SD
	debug_puts("cmd8:");
	debug_print_byte(r);
	debug_puts("\n");
#endif
	return r;
}

UBYTE sd_acmd41(UBYTE byte0)
{
	BYTE r;
	spi_delay();

	spi_send_byte(0x77); // CMD55
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0xff);

	r = sd_wait_r1();

#ifdef DEBUG_CMD
	console_gotoxy(0,2);
	console_puts("A41R1 = "); //q debug
	console_print_byte(r); //q debug
#endif	
	
	if (r>1) {
	#ifdef DEBUG_SD
		debug_puts("cmd55 failed:");
		debug_print_byte(r);
		debug_puts("\n");
	#endif
		return -1;
	}

	sd_wait_ready();

	spi_send_byte(0x69); // CMD41
	spi_send_byte(byte0);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0xff);

	r = sd_wait_r1();

#ifdef DEBUG_CMD
console_gotoxy(12,2);
console_puts("A41R2 = "); //q debug
console_print_byte(r); //q debug
#endif	

	spi_delay();
	spi_delay();

#ifdef DEBUG_SD
	debug_puts("acmd41:");
	debug_print_byte(r);
	debug_puts("\n");
#endif
	return r;
}

UBYTE sd_cmd58()
{
	BYTE r;
	UBYTE r58;
	spi_delay();
	sd_wait_ready();

	spi_send_byte(0x7a);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0x00);
	spi_send_byte(0xff);

	r = sd_wait_r1();

#ifdef DEBUG_CMD
	console_gotoxy(0,3);
	console_puts("58R1 = "); //q debug
	console_print_byte(r); //q debug
#endif

	r58 =  spi_receive_byte();

#ifdef DEBUG_CMD	
	console_puts(" - 58R2 = "); //q debug
	console_print_byte(r58); //q debug
	console_puts("\n");
#endif

	if (r58==0xc0) //Q
		card_SDHC(1);
	else
		card_SDHC(0);
	//	card_type = r58;

/*	console_print_byte(r58); //q debug
	console_puts(" - card_type = ")
	console_print_byte(card_type[0]); //q debug
	console_puts("\n")
	r =  spi_receive_byte();

	console_print_byte(card_type); //q debug

	r =  spi_receive_byte();

	console_print_byte(r); //q debug

	r =  spi_receive_byte();

	console_print_byte(r); //q debug
*/

	spi_delay(); // if &0xc0==0xc0 => SDHC
	spi_delay();
	spi_delay();
	spi_delay();
	spi_delay();

#ifdef DEBUG_SD
	debug_puts("cmd58:");
	debug_print_byte(r);
	debug_puts("\n");
#endif
	return r;
}


int sd_init()
{
	UBYTE timeout;

	spi_set_speed(0x7f); // min speed

	// wait a bit
	spi_assert_cs();
	for(timeout=0x10; timeout>0; --timeout) {
		spi_send_byte(0xff);
	}
	spi_deassert_cs();
	spi_send_byte(0xff);
	spi_send_byte(0xff);
	spi_assert_cs();

	// go into idle state
	timeout = 0xff;
	while (sd_cmd0() != 0x01) {
		if (timeout==0) {
			spi_deassert_cs();
			return FALSE;
		}
		timeout = timeout-1;
	}

	if (sd_cmd8() == 0x01) {
		// SD card V2+
#ifdef DEBUG_SD
		debug_puts("SD card V2+\n");
#endif
		// initialize card
		spi_delay(); //q delay
		timeout = 0xff;
		while ((sd_acmd41(0x40)&1)!=0) {
			if (timeout==0) {
				spi_deassert_cs();
				return FALSE;
			}
			timeout = timeout-1;
		}

		// read OCR   //Q MOD for SDHC
		//if (sd_cmd58()!=0) {
		if (sd_cmd58()!=0) {
			spi_deassert_cs();
			return FALSE;
		}

	} else {
		// SD card V1 or MMC
		if (sd_acmd41(0x00)<=1) {
			// SD V1
#ifdef DEBUG_SD
			debug_puts("SD V1\n");
#endif
			timeout = 0xff;
			while ((sd_acmd41(0x00)&1)!=0) {
				if (timeout==0) {
					spi_deassert_cs();
					return FALSE;
				}
				timeout = timeout-1;
			}
		} else {
			// MMC Card : probamos inicializar con CMD1
		timeout = 0xff;
			while (sd_cmd1()!=0) {
				if (timeout==0) {
					spi_deassert_cs();
					return FALSE;
				} 
			}

/*
#ifdef DEBUG_SD
			debug_puts("MMC failed\n");
#endif
			spi_deassert_cs();
			return FALSE; */
		}
	}
    spi_delay();
	spi_deassert_cs();
	spi_set_speed(0x00); // max speed  0x00
	return TRUE;
}

/* loads $200 bytes from spi */
void load_data(UBYTE *target)
{
/*
	int i;
	for (i=0; i<0x200; i++) {
		*target++ = spi_receive_byte();
	}
*/
	#asm
	ld	hl, 2
	add	hl, sp
	ld	e, (hl)
	inc hl
	ld	d, (hl)
	ex de,hl
	ld bc,$0002
load_data_loop:
	ld a,$ff
	out ($c1),a
load_data_wait:
	in a,($00)
	and a,$80
	jr z,load_data_wait
	in a,($01)
	ld (hl),a
	inc hl
	djnz load_data_loop
	dec c
	jr nz,load_data_loop
	#endasm
}

int sd_load_sector(UBYTE* target, DWORD sector)
{
	DWORD address;
	BYTE r;
	WORD timeout;

	
	if (card_type[0] == 1)
		address = sector; //Q SDHC = block addres 
	else
		address = sector<<9; //SD no HD = byte address

#ifdef DEBUG_SD2
	debug_puts("loading address ");
	debug_print_dword(address);
	debug_puts("\n");
#endif

	//spi_delay();
	sd_wait_ready();
	// read block
	spi_delay();
	spi_assert_cs();
	spi_send_byte(0x51);		// CMD17
	spi_send_byte((address>>24)&0xff);
	spi_send_byte((address>>16)&0xff);
	spi_send_byte((address>>8)&0xff);
	spi_send_byte(address&0xff);
	spi_send_byte(0xff);


	r = sd_wait_r1();
	// spi_delay();
	 //spi_delay();
	// spi_delay();
	// spi_delay();
	// spi_delay();
	 spi_delay();


#ifdef DEBUG_SD
	debug_puts("cmd17:");
	debug_print_byte(r);
	debug_puts("\n");
#endif
	if ((r&0x80)!=0) {
		spi_deassert_cs();
		return FALSE;
	}

	// wait for 0xfe (start of block)
	timeout = 0x7ff;
	while (spi_receive_byte()!=0xfe) {
		if (timeout==0) {
			spi_deassert_cs();
			return FALSE;
		}
		timeout = timeout-1;
	}

	// read block
	load_data(target);

	// skip crc
	spi_delay();
	spi_delay();
	//spi_delay();

	// shutdown
	spi_deassert_cs();
	return TRUE;
}


