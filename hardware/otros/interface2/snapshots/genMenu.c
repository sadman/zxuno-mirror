#include <stdio.h>
#include <stdlib.h>

#define LREG  35//51 //35
#define LOFF  8//24 //8

unsigned char image[0xc000], font[0x1000], rotate;
char tmpstr[50];
unsigned short i, j, af, pos;
int k, mask, amask;
long long atr, celdas[4];
FILE *fi, *fo, *ft;

int main(int argc, char *argv[]){
  ft= fopen("fuente6x8.bin", "r");
  fread(font+0x80, 1, 0x380, ft);
  for ( i= 0x400; i<0x1000; i++ )
    rotate= font[i-0x400],
    font[i]= (rotate >> 2) | (rotate << 6);
  fi= fopen("menu.txt", "r");
  for ( i= 0; i<12; i++ ){
    fgets(tmpstr, 50, fi);
    k= 0;
    pos= i<<5&0xf0 | i<<8&0x800;
    while ( 1 ){
      for ( j= 0; j<8; j++, pos+= 0x100 )
        image[pos]= font[j|tmpstr[k]<<3];
      pos-= 0x800;
      if( tmpstr[++k]<14 )
        break;
      for ( j= 0; j<8; j++, pos+= 0x100 )
        image[pos]= image[pos]&0xfc | font[0xc00|j|tmpstr[k]<<3]&0x3,
        image[pos+1]= font[0xc00|j|tmpstr[k]<<3]&0xfc;
      pos-= 0x7ff;
      if( tmpstr[++k]<14 )
        break;
      for ( j= 0; j<8; j++, pos+= 0x100 )
        image[pos]= image[pos]&0xf0 | font[0x800|j|tmpstr[k]<<3]&0xf,
        image[pos+1]= font[0x800|j|tmpstr[k]<<3]&0xf0;
      pos-= 0x7ff;
      if( tmpstr[++k]<14 )
        break;
      for ( j= 0; j<8; j++, pos+= 0x100 )
        image[pos]= image[pos] | font[0x400|j|tmpstr[k]<<3];
      pos-= 0x7ff;
      if( tmpstr[++k]<14 )
        break;
    }
  }
  fo= fopen("screen.scr", "wb+");
  memset(image+0x1800, 0x38, 0x300);
  fwrite(image, 1, 0x1b00, fo);
  fclose(fi);
  fclose(fo);
  memset(font, 0, LREG*10);
  fo= fopen("rest.bin", "wb+");
  for ( i= 0; i<10; i++ ){
    sprintf(tmpstr, "game%d.sna", i);
    fi= fopen(tmpstr, "rb");
    fread(font+LREG*10, 1, 0x1b, fi);
    fread(image, 1, 0xc000, fi);
    pos= *(unsigned short*)(font+LREG*10+23);         // SP
    af= *(unsigned short*)(font+LREG*10+21);          // AF
#if LOFF==8
    pos-= 2;
    *(unsigned short*)(image+pos-0x4000)= af;
#endif
    fwrite(image, 1, 0xc000, fo);
    memcpy(font+i*LREG, image+0xbff8, 8);
    font[i*LREG+LOFF]= font[LREG*10];                 // I
    font[i*LREG+LOFF+1]= font[LREG*10+25]-1;          // IM
    memcpy(font+i*LREG+LOFF+2, font+LREG*10+1, 8);    // HL',DE',BC',AF'
    memcpy(font+i*LREG+LOFF+10, font+LREG*10+11, 8);  // DE,BC,IY,IX
    font[i*LREG+LOFF+18]= 0x21;                       // HL
    *(unsigned short*)(font+i*LREG+LOFF+19)= *(unsigned short*)(font+LREG*10+9);
    font[i*LREG+LOFF+21]= 0x31;                       // SP
    *(unsigned short*)(font+i*LREG+LOFF+22)= pos;
    font[i*LREG+LOFF+24]= 0xf3|font[LREG*10+19]<<3&8; // IFF
    font[i*LREG+LOFF+25]= 0x18;                       // jr rel
    if( i<3 )
      font[i*LREG+LOFF+26]= LREG*(3-i)-2;
    else if( i<6 )
      font[i*LREG+LOFF+26]= LREG*(6-i)-2;
    else
      font[i*LREG+LOFF+26]= LREG*(9-i);
    fclose(fi);
  }
  fclose(fo);
  fo= fopen("regs.bin", "wb+");
  fwrite(font, 1, LREG*10, fo);
  fclose(fo);
}
