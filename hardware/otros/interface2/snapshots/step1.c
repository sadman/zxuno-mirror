#include <stdio.h>
#include <stdlib.h>

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
  memset(font, 0, 350);
  fo= fopen("rest.bin", "wb+");
  for ( i= 0; i<10; i++ ){
    sprintf(tmpstr, "game%d.sna", i);
    fi= fopen(tmpstr, "rb");
    fread(font+350, 1, 0x1b, fi);
    fread(image, 1, 0xc000, fi);
    pos= *(unsigned short*)(font+373);   // SP
    af= *(unsigned short*)(font+371);    // AF
    pos-= 2;
    *(unsigned short*)(image+pos-0x4000)= af;
    fwrite(image, 1, 0xc000, fo);
    memcpy(font+i*35, image+0xbff8, 8);
    font[i*35+8]= font[350];            // I
    font[i*35+9]= font[375]-1;          // IM
    memcpy(font+i*35+10, font+351, 8);  // HL',DE',BC',AF'
    memcpy(font+i*35+18, font+361, 8);  // DE,BC,IY,IX
    font[i*35+26]= 0x21;                // HL
    *(unsigned short*)(font+i*35+27)= *(unsigned short*)(font+359);
    font[i*35+29]= 0x31;                // SP
    *(unsigned short*)(font+i*35+30)= pos;
    font[i*35+32]= 0xf3+8*(font[369]&1);//IFF
    font[i*35+33]= 0x18;                // jr rel
    if( i<3 )
      font[i*35+34]= 35*3-2-i*35;
    else if( i<6 )
      font[i*35+34]= 35*6-2-i*35;
    else
      font[i*35+34]= 35*9-i*35;
    fclose(fi);
  }
  fclose(fo);
  fo= fopen("regs.bin", "wb+");
  fwrite(font, 1, 350, fo);
  fclose(fo);
}
