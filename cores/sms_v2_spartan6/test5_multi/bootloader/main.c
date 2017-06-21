#include <sms.h>
//#include <stdio.h>
//#include <string.h>
//#include <stdint.h>
#include "console.h"
#include "sd.h"
#include "fat.h"

//#define DEBUG_MAIN

unsigned char pal[] = {
	0x10, 0x3f, 0x08, 0x28, 0x02, 0x22, 0x0A, 0x2A,
	0x15, 0x35, 0x1D, 0x3D, 0x17, 0x37, 0x1F, 0x3F,
	0x10, 0x03, 0x08, 0x28, 0x02, 0x22, 0x0A, 0x2A,
	0x15, 0x35, 0x1D, 0x3D, 0x17, 0x37, 0x1F, 0x3F };


void print_dir(file_descr_t *entries, file_descr_t *current);
void load_rom(file_descr_t *entry);
void pick_and_load_rom();
void start_rom();
void wait_key();

// void irq_handler()
// {
// 	// nothing
// }

// void nmi_handler()
// {
// 	// nothing
// }

void main()
{
	int i;
	char *ptr;

	vdp_set_address(0x8004); // mode 4, disable hbl irq
	vdp_set_address(0x8160); // screen on, enable vbl irq
	vdp_set_address(0x820e); // name table @ $3800
	//vdp_set_address(0x85ff); // sprite table @ $3f00
	vdp_set_address(0x8700); // backdrop is color 0
	vdp_set_address(0x8800); // scrollx is 0
	vdp_set_address(0x8900); // scrolly is 0

	vdp_set_address(0xc000);
	ptr = pal;
	for (i=0; i<32; i++) {
		vdp_write(*ptr++);
	}

	// turn off sprites
	vdp_set_address(0x3f00);
	vdp_write(0xd0);

	//Sound off - if resetted from a prior game
	set_sound_volume(0,0);
	set_sound_volume(1,0);
	set_sound_volume(2,0);
	set_sound_volume(3,0);

	//set_vdp_reg(VDP_REG_HINT_COUNTER, 0xFF);
	//set_vdp_reg(VDP_REG_FLAGS1, VDP_REG_FLAGS1_SCREEN/* | VDP_REG_FLAGS1_VINT*/);
	//set_bkg_map(hello, 0, 6, 13, 1);
	load_tiles(standard_font, 0, 255, 1);
//	load_palette(pal1, 0, 16);
//	load_palette(pal2, 16, 16);		

	while (1) {
		console_init();
		console_clear();
		console_gotoxy(3,0);
		console_puts("MASTER SYSTEM ROM LOADER\n");
		console_gotoxy(3,1);
		for (i=0; i<24;i++) { console_putc(0xC4); } //continuous dash
		console_puts("\n")
		//console_puts("------------------------\n");
		//console_gotoxy(3,3);
		i = 0;
		if (!sd_init()) {
			console_puts("Error initializing SD/MMC card\n");
		} else {
	#ifdef DEBUG2
			console_puts("SD card initialized\n");
	#endif
			if (!fat_init()) {
				console_puts("EER init FAT\n"); //qq
	
			} else {
	// #ifdef DEBUG2
	// 			console_puts("FAT system initialized\n");
	// #endif
				i = 1;
			}
		}


		choose_mode(i);
	}
}

void choose_mode(int sd_ok)
{
	int i = 0;
	console_gotoxy(9,10);
	if (sd_ok) {
		//console_puts("load from SD card");
		pick_and_load_rom();
	} else {
		console_puts("retry SD/MMC card");
	}
	//console_gotoxy(9,12);
	//console_puts("boot SRAM");

	for (;;) {
		int key;
		console_gotoxy(6,10);
		if (i==0) { console_puts(">"); } else { console_puts("  "); }
		console_gotoxy(6,12);
		if (i==1) { console_puts(">"); } else { console_puts("  "); }
		key = wait_key();
		switch (key) {
		case JOY_UP:
			i = 0;
			break;
	//	case JOY_DOWN:
	//		i = 1;
	//		break;
		case JOY_FIREA:
		case JOY_FIREB:
			if (i==0) {
				if (sd_ok) {
					pick_and_load_rom();
				}
			} else {
				start_rom();
			}
			return;
		}
	}
}

void pick_and_load_rom()
{
	int cont = 0;
	int cdiv = 3;
	file_descr_t *entries,*top_of_screen,*current;

	entries = fat_open_root_directory();
	if (entries==0) {
		console_gotoxy(3,2);
		console_puts("ERR reading root DIR");
		return;
	}

	top_of_screen = entries;
	current = entries;
	for (;;) {
		int key;
		print_dir(top_of_screen,current);
		//key = wait_key();
		key = read_joypad1();
		//switch (key) {
		//case JOY_UP:
		cont++;
		if (cont>20)
		   cdiv= 3;
		if ((key & JOY_UP) && (cont%cdiv==0)) {
			if (current!=entries) {
				current--;
				cdiv = 6;
				if (current<top_of_screen) {
					top_of_screen = current;
				}
			}
		cont = 0;
		}	//break;
		if ((key & JOY_DOWN) && (cont%cdiv==0)) {
		//case JOY_DOWN:
			if (current[1].type!=0) {
				current++;
				cdiv = 6;
				if ((current-top_of_screen)>19) {
					top_of_screen++;
				}
			}
		cont = 0;
		}	//break;
		//case JOY_LEFT:
		if ((key & JOY_LEFT) && (cont%(cdiv)==0)) {
			if ((current!=entries) && current>(entries+4)) {
				current = current-5;
				cdiv = 6;
				if (current<top_of_screen) {
					top_of_screen = current;
				}
			} else {
			   current = entries;
			   top_of_screen = current;
			}
		cont = 0;
		}	//break;
		//case JOY_RIGHT:
		if ((key & JOY_RIGHT) && (cont%(cdiv)==0)) {
			if (current[5].type!=0 && current[4].type!=0 && current[3].type!=0 && current[2].type!=0 && current[1].type!=0) {
				current = current + 5;
				cdiv = 6;
				if ((current-top_of_screen)>19) {
					top_of_screen = top_of_screen + 5;
				}
			}
			else {
				if (current[1].type == 0)			
					current = current;
				else if (current[2].type == 0)			
					current = current+1;
				else if (current[3].type == 0)			
					current = current+2;
				else if (current[4].type == 0)			
					current = current+3;
				else if (current[5].type == 0)			
					current = current+4;
				//top_of_screen = current;
			cdiv = 6;
			     }
		cont = 0;
		}	//break;
		//case JOY_FIREA:
		//case JOY_FIREB:
		if ((key & (JOY_FIREA | JOY_FIREB)) && (cont%cdiv==0)) {
			if ((current->type&0x10)==0) {
				entries = fat_open_directory(current->cluster);
				if (entries==0) {
					console_gotoxy(0,2);
					console_puts("ERR reading DIR-");
					#ifdef DEBUG_MAIN
					  console_puts("CURR_CL=");
					  console_print_dword(current->cluster);
					#endif

				  return;
				}
				top_of_screen = entries;
				current = entries;
				cdiv = 8; 
			} else {
				load_rom(current);
				start_rom();
				return;
			}
		cont = 0;
		}	//break;
		//}
	}
}

void load_rom(file_descr_t *entry)
{
	file_t file;
	int i;
	DWORD size;
	DWORD fsize;

	console_clear();
	console_puts("Loading ");
	for (i=0; i<8; i++) {
		console_putc(entry->name[i]);
	}
	console_putc('.');
	for (i=8; i<11; i++) {
		console_putc(entry->name[i]);
	}
	console_puts("\n");

	fat_open_file(&file, entry->cluster);

	size = 0;
	fsize = entry->size*256;

	#ifdef DEBUG_MAIN
		console_puts("CL=");
		console_print_dword(entry->cluster);
	#endif

	console_puts("\n");

	while (1) {
		UBYTE* data;
		if ((size&0x3fff)==0) {
			// switch page 1
			*((UBYTE*)0xffff) = (size>>14)&0xff;
		}
		// write to page 2
		data = 0x8000+(size&0x3fff);
		data = fat_load_file_sector(&file,data);
		if (data==0) {
			console_gotoxy(3,2);
			console_puts("ERR reading FILE\n");
		//} else if (data==FAT_EOF) {
		} else if (data==FAT_EOF || size>=fsize) {
			console_gotoxy(0,2);
			return;
		} else {
			// process data
			size += 0x200;
			if ((size)%16384 == 0)
			   console_putc(219); //block
			//console_gotoxy(0,5);
			//console_print_dword(size);
			//console_puts(" bytes loaded");
		}
	}
}

void start_rom()
{
	*((UBYTE*)0xfffd) = 0;
	*((UBYTE*)0xfffe) = 1;
	*((UBYTE*)0xffff) = 2;
	//console_puts("booting rom...\n");
	// any write to $00 when in bootloader mode sets normal mode and reboots the CPU
	#asm
	out ($00),a
	#endasm
}

void print_dir_entry(file_descr_t *entry)
{
	BYTE dir;
	int i;
	//char fsize[3];
	dir = (entry->type&0x10)==0;

	if (!dir) {
		console_putc(0x20);
	} else {
		console_putc('[');
	}
	for (i=0; i<8; i++) {
		console_putc(entry->name[i]);
	}
	if (entry->name[8] != 0x20 || !dir) 
			console_putc(0x2e);
	else
			console_putc(0x20);
	for (i=0; i<3; i++) {
		console_putc(entry->name[8+i]);
	}
	if (!dir) {
		console_putc(0x20);
	} else {
		console_puts("]  <DIR>"); //new with dir
		//console_puts("]"); // old
	}
	if (!dir)  { //Q
		//itoa(entry->size/4, fsize, 10);
		console_puts("  ");
		console_puts(entry->fsize);
		console_puts("K  ");
	}
}

void print_dir(file_descr_t *entries, file_descr_t *current)
{
	int i;
	for (i=0; i<20; i++) {
		console_gotoxy(3,4+i);
		if (&entries[i]==current) {
			console_puts("> ");
		} else {
			console_puts("  ");
		}
		if (entries[i].type!=0) {
			print_dir_entry(&entries[i]);
		} else {
			console_puts("                      "); // with dir and size
			//console_puts("             "); //ORIG 13
		}
	}
}

void wait_key()
{
	int j1,nj1;
	j1 = read_joypad1();
	while (1) {
		nj1 = read_joypad1();
		if (nj1&~j1) {
			return nj1&~j1;
		} else {
			j1 = nj1;
		}
	}
}
