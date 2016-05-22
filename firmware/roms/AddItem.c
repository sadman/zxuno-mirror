#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *fi, *fo;
int i;
unsigned char mem[0x4004], core;
unsigned short j, k;

int main(int argc, char *argv[]) {
  if( argc==1 )
    printf("\n"
    "AddItem v0.01, simulates Machine and ROM addition to the ZX-Uno flash image\n\n"
    "  AddItem        <type> <input_file> <slot>\n\n"
    "  <type>         ROM or COREX, when 2<=X<=9, i.e. CORE5\n"
    "  <input_file>   Input .TAP file generate with GenRom\n"
    "  <slot>         Number of slot from 0 to 63, only when type is ROM\n\n"
    "All modifications occur in the file FLASH.ZX1\n\n"),
    exit(0);
  fo= fopen("FLASH.ZX1", "rb+");
  if( strstr(argv[1], "CORE")==argv[1] && strlen(argv[1])==5
      && argv[1][4]<='9' && argv[1][4]>='2' && argc==3 ){
    core= argv[1][4]-'2';
    fi= fopen(argv[2], "rb");
    if( !fi )
      printf("\nInput file not found: %s\n", argv[2]),
      exit(-1);
    fread(mem, 1, 0x58, fi);
    fseek(fo, 0x7100|core<<5, SEEK_SET);
    fwrite(mem+0x34, 1, 0x20, fo);
    j= mem[3];
    fseek(fo, 0xac000+core*0x54000, SEEK_SET);
    for ( i=0; i<j; i++ )
      fread(mem, 1, 0x4004, fi),
      fwrite(mem, 1, 0x4000, fo);
  }
  else if( !strcmp(argv[1], "ROM") && argc==4 ){
    fi= fopen(argv[3], "rb");
    if( !fi )
      printf("\nInput file not found: %s\n", argv[3]),
      exit(-1);
    fseek(fo, 0x7000, SEEK_SET);
    fread(mem, 1, 0x40, fo);
    for ( i= 0; i<0x40; i++ )
      if( mem[i]==0xff )
        break;
    mem[i]= i;
    fseek(fo, 0x7000, SEEK_SET);
    fwrite(mem, 1, 0x40, fo);
    fread(mem, 1, 0x58, fi);
    fseek(fo, 0x6000|i<<6, SEEK_SET);
    k= mem[2]= atoi(argv[2]);
    fwrite(mem+2,    1, 0x20, fo);
    fwrite(mem+0x34, 1, 0x20, fo);
    j= mem[3];
    for ( i=0; i<j; i++ )
      fseek(fo, (k<19?0xc000:0x300000)+k*0x4000, SEEK_SET),
      k= (k+1)&0x3f,
      fread(mem, 1, 0x4004, fi),
      fwrite(mem, 1, 0x4000, fo);
  }
  else
    printf("\nInvalid parameters\n"),
    exit(-1);
  printf("\nDone\n");
}
