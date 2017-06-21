#include "fat.h"
//#include <stdlib.h>

//#define DEBUG_FAT2

typedef struct {
	BYTE	fat32;
	UDWORD	sectors_per_cluster;
	UDWORD	first_fat_sector;
	UDWORD	first_data_sector;
	UDWORD	current_data_sector;
	UDWORD	current_fat_sector;
	UDWORD	root_directory;
	UDWORD	root_directory_size;
} fat_t;

const fat_t *fat 					= 0xc010;
const UBYTE *fat_buffer				= 0xc100;
const UBYTE *data_buffer			= 0xc300;
const file_descr_t *directory_buffer= 0xc500;
//const BYTE *card_type 				= 0xc700; //q

void fat_init32();
void fat_init16();

DWORD load_dword(UBYTE *ptr)
{
	return (ptr[0])
		 | (ptr[1]<<8)
		 | (ptr[2]<<16)
		 | (ptr[3]<<24);
}

UWORD load_word(UBYTE *ptr)
{
	return (ptr[0])
		 | (ptr[1]<<8);
}

int fat_init()
{
	DWORD sector;
	UBYTE spc = 0x00;
	UBYTE hasMBR;

	sector = 0;
	if (!sd_load_sector(data_buffer, sector)) {
		console_puts("Error loading Sector 0\n");
		return FALSE;
	}

	if ((data_buffer[0x1fe]!=0x55) || (data_buffer[0x1ff]!=0xaa)) {
		console_puts("Wrong Sector 0\n");
		return FALSE;
	}
		//console_print_byte(data_buffer[0x1fe]); //q
		//console_print_byte(data_buffer[0x1ff]); //q
	switch (data_buffer[0x1c2]) {
	case 0x06:
	case 0x04:
		fat->fat32 = FALSE;
		hasMBR = TRUE;
		break;
	case 0x0b:
	case 0x0c:	
		fat->fat32 = TRUE;
		hasMBR = TRUE;
		break;
	default:
		if (data_buffer[0x55]==0x33) { //check possible FAT type when NO MBR found (32)
			fat->fat32 = TRUE;
			hasMBR = FALSE;
		} else if (data_buffer[0x39]==0x31) { //check possible FAT type when NO MBR found (16)
			fat->fat32 = FALSE;
			hasMBR = FALSE;
		} else {
			console_puts("Bad FileSystem (FAT16/32 only)\n");
			return FALSE;
		}
	}

	if (hasMBR)
		sector = load_dword(&data_buffer[0x1c6]); 
	else
		sector = 0; 

	//sector = 0x800;
#ifdef DEBUG_FAT
	debug_puts("first sector: ");
	debug_print_dword(sector);
	debug_puts("\n");
#endif

	//console_print_dword(sector); //q

	if (!sd_load_sector(data_buffer, sector)) {
		console_puts("ERR loading boot sector\n");
		return FALSE;
	}

	if ((data_buffer[0x1fe]!=0x55) || (data_buffer[0x1ff]!=0xaa)) {
		console_puts("Wrong boot record\n");
		//console_print_byte(data_buffer[0x1fe]); //q
		//console_print_byte(data_buffer[0x1ff]); //q
		//console_print_byte(data_buffer[0]);
		//console_print_byte(data_buffer[1]);
		//console_print_byte(data_buffer[2]);
		//console_print_byte(data_buffer[3]);
		//console_print_byte(data_buffer[4]);
		//console_print_byte(data_buffer[5]);
		return FALSE;
	}

	if ((data_buffer[11]!=0) || (data_buffer[12]!=2)) {
		console_puts("sector size != 0x200\n");
		console_print_byte(data_buffer[11]);
		console_print_byte(data_buffer[12]);
		return FALSE;
	}

	spc = data_buffer[13];
	fat->sectors_per_cluster = spc;

	// reserved sectors
	fat->first_fat_sector = sector + (DWORD)load_word(&data_buffer[14]);

	if (fat->fat32) {
		fat_init32();
	} else {
		fat_init16();
	}

#ifdef DEBUG_FAT
	debug_puts("sectors_per_cluster: ");
	debug_print_byte(fat->sectors_per_cluster);
	debug_puts("\n");
	debug_puts("first_fat_sector: ");
	debug_print_dword(fat->first_fat_sector);
	debug_puts("\n");
	debug_puts("first_data_sector: ");
	debug_print_dword(fat->first_data_sector);
	debug_puts("\n");
	debug_puts("root_directory: ");
	debug_print_dword(fat->root_directory);
	debug_puts("\n");
#endif

	return TRUE;
}

void fat_init32()
{
	UBYTE nb_fats;
	DWORD fat_size;

	nb_fats = data_buffer[0x10];
	fat_size= load_dword(&data_buffer[0x24]);
#ifdef DEBUG_FAT
	debug_puts("fat_size: ");
	debug_print_dword(fat_size);
	debug_puts("\n");
#endif

	fat->first_data_sector = fat->first_fat_sector;
	for (; nb_fats>0; --nb_fats) {
		fat->first_data_sector += fat_size;
	}
	fat->root_directory = load_dword(&data_buffer[0x2c]);

	fat->root_directory_size = fat->sectors_per_cluster; //Q

		//Q debug
	#ifdef DEBUG_FAT2
		console_gotoxy(0,0);
		console_puts("1ST_DAT_SEC=");
		console_print_dword(fat->first_data_sector);
		console_puts("-SEC_PER_CL=");
		console_print_dword(fat->sectors_per_cluster);
	#endif
}

void fat_init16()
{
	UBYTE nb_fats;
	DWORD fat_size;

	// root directory first sector
	nb_fats = data_buffer[0x10];
	fat_size = (DWORD)load_word(&data_buffer[22]);
	fat->root_directory = fat->first_fat_sector;
	for (; nb_fats>0; --nb_fats) {
		fat->root_directory += fat_size;
	}

	// root directory size (in sectors)
	fat->root_directory_size = (DWORD)load_word(&data_buffer[17])>>4;

	// first data sector = first sector after root directory
	fat->first_data_sector = fat->root_directory + fat->root_directory_size;

	//Q debug
	#ifdef DEBUG_FAT2
		console_gotoxy(0,0);
		console_puts("1ST_DAT_SEC=");
		console_print_dword(fat->first_data_sector);
		console_puts("-SEC_PER_CL=");
		console_print_dword(fat->sectors_per_cluster);
	#endif
}

int load_fat_sector(DWORD sector)
{
	sector += fat->first_fat_sector;
	if (fat->current_fat_sector==sector) {
		return TRUE;
	}

	if (sd_load_sector(fat_buffer, sector)) {
		fat->current_fat_sector = sector;
		return TRUE;
	}
	return FALSE;
}

int load_data_sector(UBYTE *buffer, DWORD sector)
{
	return sd_load_sector(buffer, sector);
}

DWORD first_sector_of_cluster(DWORD cluster)
{ 
/*#ifdef DEBUG
		debug_puts("cluster ");
		debug_print_dword(cluster);
		debug_puts(" => ");
		debug_print_dword(fat->first_data_sector + (cluster-2)*fat->sectors_per_cluster);
		debug_puts("\n");
#endif*/
	return fat->first_data_sector + ((cluster-2)*fat->sectors_per_cluster);
}

DWORD fat_next_cluster(DWORD current)
{
	DWORD fat_sector;

	fat_sector = (fat->fat32) ? (current>>7) : (current>>8);
	if (!load_fat_sector(fat_sector)) {
		return 0;
	}

	if (fat->fat32) {
		return load_dword(&fat_buffer[(current & 0x7f) << 2]);
	} else {
		return (DWORD)load_word(&fat_buffer[(current & 0xff) << 1]);
	}
}

int fat_is_last_cluster(DWORD cluster)
{
	if (fat->fat32) {
		return ((cluster&0xfffffff8)==0xfffffff8);
	} else {
		return ((cluster&0xfff8)==0xfff8);
	}
}

int fat_open_file(file_t *file, UDWORD cluster)
{
	file->cluster = cluster;
	file->sector  = first_sector_of_cluster(cluster);


	return TRUE;
}

int fat_load_file_sector(file_t *file, UBYTE *buffer)
{
	int i;

	//console_gotoxy(0,6);
	//console_puts("FILE SEC=");
	//console_print_dword(file->sector);

	if (file->sector==first_sector_of_cluster(file->cluster+1)) {
		file->cluster = fat_next_cluster(file->cluster);
#ifdef DEBUG2
		debug_puts("end of cluster -- next cluster is ");
		debug_print_dword(file->cluster);
		debug_puts("\n");
#endif
		if (fat_is_last_cluster(file->cluster)) {
#ifdef DEBUG2
			debug_puts("end of file\n");
#endif
			return FAT_EOF;
		} else {
#ifdef DEBUG2
			debug_puts("continuing\n");
#endif
			//file->sector  = first_sector_of_cluster(file->cluster); //?? Broke loading on fat32 lba
		}
	}


	return sd_load_sector(buffer, file->sector++);
}

void clear_directory_buffer()
{
	int i;
	for (i=0; i<0x100; i++) {
		directory_buffer[i].type = 0;
	}
}

int fat_process_directory_entry(file_descr_t *file_descr, UBYTE* data)
{
	UBYTE i;
	BYTE dir;

	if ((*data) == 0xe5) {		// deleted
		return FALSE;
	} 
	if ((data[11]&13) != 0) {	// fancy attributes
		return FALSE;
	}

	dir = ((data[11]&0x10)^0x10) | 0x01;

	if (!(data[8] == 0x53 && data[9] == 0x4D && data[10] == 0x53) && !(dir ==0x01) && 
		!(data[8] == 0x42 && data[9] == 0x49 && data[10] == 0x4E) || 
		(data[0] == 0x2e && data[1] == 0x20)) {	
	// if not .sms or .bin (or dir, or dot dir)...
		return FALSE;
	}

	if (data[0] > 0x7B || (data[0] >0x00 && data[0]<0x20))
		return FALSE;



	// first byte : directories are 0x01", files are 0x11
	file_descr->type = dir;

	// copy file name (11 bytes)
	for(i=0; i<11; i++) {
		file_descr->name[i] = *data++;
	}

	// copy cluster # (4 bytes)
	file_descr->cluster =  load_word(&data[0x0f]);
	 if (fat->fat32) {
	 	//file_descr->cluster |= (load_word(&data[0x9]))<<16;
	 	file_descr->cluster += (load_word(&data[0x9])*0x10000);
	 }

	 		//console_gotoxy(10,1);
		 	//console_puts("-CL=");
		 	//console_print_dword(file_descr->cluster);

	//file_descr->size
	//file_descr->fsize = "    ";
	file_descr->size = load_dword(&data[18]);  //Q

	if (file_descr->size>0x1000)
			return FALSE;

	itoa(file_descr->size/4, file_descr->fsize, 10); //file size in decimal
	

	return TRUE;
}
int process_directory_sector(file_descr_t** directory_ptr,UBYTE* buffer_ptr)
{
	UBYTE i;
	for (i=0x10; i>0; --i) {
		if ((*buffer_ptr) == 0) {
			(*directory_ptr)->type = 0; // marks last entry
			return TRUE;
		}
		if (fat_process_directory_entry(*directory_ptr, buffer_ptr)) {
			(*directory_ptr)++;
		}
		buffer_ptr += 0x20;
	}
	return FALSE;
}

file_descr_t* fat_open_root_directory16()
{
	DWORD sector;
	file_descr_t* directory_ptr;
	UBYTE* buffer_ptr;
	UBYTE i;

	clear_directory_buffer();

	sector = fat->root_directory;
	directory_ptr = directory_buffer;
	for (i=fat->root_directory_size; i>0; --i) {
		if (!sd_load_sector(data_buffer, sector)) {
			console_gotoxy(3,2);
			console_puts("ERR openRD16\n");
			return 0;
		}
		if (process_directory_sector(&directory_ptr,data_buffer)) {
			goto fat_open_root_directory16;
		}
		sector++;
	}

fat_open_root_directory16:
	(*directory_ptr)->type = 0; // marks last entry
	return directory_buffer;
}

file_descr_t* fat_open_directory(DWORD first_cluster)
{
	DWORD cluster;
	UDWORD sector;
	file_descr_t* directory_ptr;


	if (first_cluster==0) {
		if (!fat->fat32) {
#ifdef DEBUG_FAT
			debug_puts("opening root dir\n");
#endif
			return fat_open_root_directory16();
		} else {
			first_cluster = fat->root_directory; //Q re-read root from 1st level dirs
		}

	}

			// else { //Q debug
		#ifdef DEBUG_FAT2
		 	console_gotoxy(10,1);
		 	console_puts("-1ST_CL=");
		 	console_print_dword(first_cluster);
		#endif
		// }

	clear_directory_buffer();

	cluster = first_cluster;
	directory_ptr = directory_buffer;

		sector = first_sector_of_cluster(cluster);

			#ifdef DEBUG_FAT2
				console_gotoxy(0,3);
				console_puts("SECT=");
				console_print_dword(sector);
				console_puts("\n");
			#endif

	do {
		UBYTE i;
		sector = first_sector_of_cluster(cluster);

			// #ifdef DEBUG_FAT2
			// 	console_gotoxy(0,3);
			// 	console_puts("SECT=");
			// 	console_print_dword(sector);
			// 	console_puts("\n");
			// #endif

		for(i=fat->sectors_per_cluster; i>0; --i) {  //ORIG i=8
			if (!sd_load_sector(data_buffer, sector)) {
				// console_gotoxy(3,4);
				// console_puts("ERR fat_open_dir1. SECT=");
				// console_print_dword(sector);
				// console_puts("\n");
				// console_print_byte(i);
				return 0;
			}
			if (process_directory_sector(&directory_ptr,data_buffer)) {
				goto fat_open_directory_end;
			}
			sector++;
		}
		cluster = fat_next_cluster(cluster);
		if (cluster==0) {
			return 0;
		}
	} while (!fat_is_last_cluster(cluster));

fat_open_directory_end:
	(*directory_ptr)->type = 0; // marks last entry
	return directory_buffer;
}

file_descr_t* fat_open_root_directory()
{
	if (fat->fat32) {
		return fat_open_directory(fat->root_directory);
	} else {
		return fat_open_root_directory16();
	}
}

