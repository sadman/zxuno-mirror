/***************************************************************************
 *   Copyright (C) 2009 by Miguel Angel Rodriguez Jodar                    *
 *   rodriguj@atc.us.es                                                    *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifdef WIN32
  #define _CRT_SECURE_NO_WARNINGS
  #include <windows.h>
  #include <io.h>
  #define strncasecmp _strnicmp
  #define open _open
  #define close _close
  #define read _read
#else
  #define O_BINARY 0
#endif

#ifndef PI
  #define PI 3.141592654
#endif

enum {SQUARE=0, SINE};
enum {INICIO=0, SILENCIO, TONOGUIA, SINCRO, DATOS, TONOFINAL};

int sfreq=44100;
int waverender=SQUARE;
int endtone=0;
int pausebtracks=1;
int keybtracks=0;
int quietmode=0;

int f_leader=800;
int f_bit1=1000;
int f_bit0=2000;
int f_synchr=2500;
int f_endtone=500;

char filename[256];
int input_file;

int is_bigendian=0;

int Estado=INICIO;
int teSilencio;
int teTonoGuia, ttTonoGuia;
int teSincro, ttSincro;
int teBit, ttBit;
int teTonoFinal, ttTonoFinal;
int DatoActual, PosicionBit, ValorBit, ContBits;
int muestraactual, byteactual;
int lbloque;

short int *SenalTonoGuia; // un periodo del tono guia (leader)
short int *SenalBit1;  // un periodo de un bit 1
short int *SenalBit0;  // un periodo de un bit 0
short int *SenalSincro; // un periodo del pulso de sincronismo
short int *SenalTonoFinal;  // un periodo del tono marca del final
char *Bloque;  // the TAP block currently being processed.

int  InitAudio  (int);
int  WriteAudio (short *, int);
void CloseAudio (void);

void CheckEndian (void)
{
	union
	{
		unsigned int s;
		unsigned char b[4];
	} val;
	
	val.s=0x12345678;
	
	if (val.b[0]==0x78)
	  is_bigendian=0;
        else
          is_bigendian=1; 
}

unsigned short letosys (unsigned short v)
{
	if (is_bigendian==0)
	  return v;
    else
      return (v&0xFF)<<8 | (v&0xFF00)>>8;
}

void ShowHeader (char *hdr)
{
  int i;
  char type;
  unsigned short lblk, par1, par2;
  
  type=hdr[1];
  lblk = letosys (*(unsigned short *)(hdr+12));
  par1 = letosys (*(unsigned short *)(hdr+14));
  par2 = letosys (*(unsigned short *)(hdr+16));
  
  switch (type)  // type of header
  {
    case 0:
      printf ("Program: ");
      break;
    case 1:
      printf ("Number array: ");
      break;
    case 2:
      printf ("Character array: ");
      break;
    case 3:
      printf ("Bytes:   ");
      break;
    default:
      printf ("Unknown type %2.2Xh: ", type);
      break;
  }
  
  for (i=2;i<=11;i++)
    putchar(hdr[i]);
  
  printf ("  Length: %d  ", lblk);
  
  if (type==0)
  {
    printf ("Autostart: ");
    if (par1<32768)
      printf ("%d  ", par1);
    else
      printf ("none  ");
    printf ("Vars at: %d", par2);
  }
  else if (type==3)
    printf ("Start: %d", par1);
  
  printf ("          \n");
}

void GenerarPeriodoCuadrado (short int *buffer, int l)
{
  int i;

  for (i=0;i<l;i++)
    if (i<(l/2))
      buffer[i]=-32760;
  else
    buffer[i]=32760;
}

void GenerarPeriodoSeno (short int *buffer, int l)
{
  int i;

  for (i=0;i<l;i++)
    buffer[i]=(short int)(-32760*sin(2*PI*i/l));
}

void GenerarSenales (void)
{
  if (waverender==SQUARE)
  {
    GenerarPeriodoCuadrado (SenalTonoGuia, sfreq/f_leader);
    GenerarPeriodoCuadrado (SenalBit1, sfreq/f_bit1);
    GenerarPeriodoCuadrado (SenalBit0, sfreq/f_bit0);
    GenerarPeriodoCuadrado (SenalSincro, sfreq/f_synchr);
    GenerarPeriodoCuadrado (SenalTonoFinal, sfreq/f_endtone);
  }
  else
  {
    GenerarPeriodoSeno (SenalTonoGuia, sfreq/f_leader);
    GenerarPeriodoSeno (SenalBit1, sfreq/f_bit1);
    GenerarPeriodoSeno (SenalBit0, sfreq/f_bit0);
    GenerarPeriodoSeno (SenalSincro, sfreq/f_synchr);
    GenerarPeriodoSeno (SenalTonoFinal, sfreq/f_endtone);
  }
}

void IniciarPlugin (void)
{
  SenalTonoGuia = malloc(sfreq*sizeof(short int)/f_leader);
  SenalBit1 = malloc(sfreq*sizeof(short int)/f_bit1);
  SenalBit0 = malloc(sfreq*sizeof(short int)/f_bit0);
  SenalSincro = malloc(sfreq*sizeof(short int)/f_synchr);
  SenalTonoFinal = malloc(sfreq*sizeof(short int)/f_endtone);
  Bloque = malloc(65536);
  memset (Bloque, 0, 65536);
  
  GenerarSenales();
}

int LeerBloque (char *bloque)
{
  unsigned short int lb;
  int leido;

  leido = read (input_file, &lb, 2);
  if (leido!=2)
    return 0;

  lb = letosys (lb);
  leido = read (input_file, bloque, lb);
  if (leido!=lb)
    return 0;

  return lb;
}

int Render576 (short int *buffer)
{
  int i;
  unsigned char flag;

  for (i=0;i<576;i++)
    buffer[i]=0;

  for (i=0;i<576;i++)
  {
    switch (Estado)
    {
      case INICIO:
        if (keybtracks==1 && quietmode==0 && (Bloque[0]!=0x00 || (lbloque!=19 && lbloque>1)))
        {
        	fflush (stdin);
            printf ("\nPress RETURN to continue...");
			getchar();	
        }
        lbloque=LeerBloque(Bloque);
        if (lbloque==0)                 // si no hay mas bloque, se acabo
        {
          if (endtone)
          {
            teTonoFinal=0;
            ttTonoFinal=3*sfreq;
            Estado=TONOFINAL;
            muestraactual=0;
            break;
          }
          else
            return 0;
        }
        Estado=TONOGUIA;
        teTonoGuia=0;
        muestraactual=0;
        byteactual=0;
        flag=Bloque[byteactual];
        if (flag&0x80)                 // la duración del tono guia la da el flag de grabacion
          ttTonoGuia=2*sfreq;    // duración tono guia corto: 2 s
        else
          ttTonoGuia=5*sfreq;    // duración tono guía largo: 5 s
        break;

      case SILENCIO:
        if (Bloque[0]==0x00 && lbloque==19 && quietmode==0 && teSilencio==0)
          ShowHeader(Bloque);
        buffer[i]=0;
        teSilencio++;   // tiempo en ms que dura una muestra
        if (teSilencio>sfreq || (pausebtracks==0 && teSilencio>(sfreq/10)))  // tiempo de silencio: 1000 ms (conf.) o 0.1s si no hay pausas
          Estado=INICIO;
        break;

      case TONOGUIA:
        buffer[i]=SenalTonoGuia[muestraactual];
        muestraactual=(muestraactual>=(sfreq/f_leader))? 0 : muestraactual+1;
        teTonoGuia++;
        if (teTonoGuia>=ttTonoGuia && muestraactual==0)
        {
          Estado=SINCRO;
          teSincro=0;
          muestraactual=0;
          ttSincro=sfreq/f_synchr;
        }
        break;

      case SINCRO:
        buffer[i]=SenalSincro[muestraactual];
        muestraactual=(muestraactual>=(sfreq/f_synchr))? 0 : muestraactual+1;
        teSincro++;
        if (teSincro>=ttSincro)
        {
          Estado=DATOS;
          DatoActual=Bloque[byteactual];
          PosicionBit=128;
          ContBits=0;
          ValorBit= (DatoActual&PosicionBit)? 1 : 0;
          muestraactual=0;
          teBit=0;
          ttBit=sfreq/((ValorBit==0)? f_bit0 : f_bit1);   //0 -> 2000 Hz, 1 -> 1000 Hz
        }
        break;

      case DATOS:
        buffer[i]=(ValorBit==0)? SenalBit0[muestraactual] : SenalBit1[muestraactual];
        muestraactual++;
        teBit++;
        if (teBit>=ttBit)
        {
          PosicionBit/=2;
          ContBits++;
          if (ContBits==8)
          {
            PosicionBit=128;
            ContBits=0;
            byteactual++;
            if (byteactual>=lbloque)
            {
              Estado=SILENCIO;
              teSilencio=0;
              break;
            }
            DatoActual=Bloque[byteactual];
          }
          ValorBit= (DatoActual&PosicionBit)? 1 : 0;
          muestraactual=0;
          teBit=0;
          ttBit=sfreq/((ValorBit==0)? f_bit0 : f_bit1);
        }
        break;

      case TONOFINAL:
        if (teTonoFinal<sfreq)
          buffer[i]=0;
        else
          buffer[i]=SenalTonoFinal[muestraactual];
        muestraactual=(muestraactual>=(sfreq/f_endtone))? 0 : muestraactual+1;
        teTonoFinal++;
        if (teTonoFinal>=ttTonoFinal)
          return 0;
        break;
    }
  }
  return 576*2;
}

int main(int argc, char *argv[])
{
  int i;
  short int *samples;
  
  if (argc<2)
  {
    fprintf (stderr, "Use -h to show usage and available options.\n");
    return EXIT_FAILURE;
  }

  CheckEndian();
  
  for (i=1;i<argc;i++)
  {
    if (argv[i][0]=='-')
    {
      switch (tolower(argv[i][1]))
      {
        case 'f':
          sfreq=atoi(&argv[i][2]);
          if (sfreq<8000)
            sfreq=44100;
          break;
          
        case 'r':
          waverender=(tolower(argv[i][2])=='s')? SQUARE : SINE;
          break;
          
        case 'l':
          f_leader=atoi(&argv[i][2]);
          if (f_leader<100)
            f_leader=800;
          break;
        
        case 's':
          f_synchr=atoi(&argv[i][2]);
          if (f_synchr<100)
            f_synchr=2500;
          break;
        
        case 'o':
          f_bit1=atoi(&argv[i][2]);
          if (f_bit1<100)
            f_bit1=1000;
          break;
        
        case 'z':
          f_bit0=atoi(&argv[i][2]);
          if (f_bit0<100)
            f_bit0=2000;
          break;
        
        case 'm':
          f_endtone=atoi(&argv[i][2]);
          if (f_endtone<20)
            f_endtone=500;
          break;
        
        case 'p':
          pausebtracks=(argv[i][2]=='0')? 0 : 1;
          break;

		case 'k':
		  keybtracks=(argv[i][2]=='0')? 0 : 1;
		  break;
          
        case 'e':
          endtone=(argv[i][2]=='1')? 1 : 0;
          break;
          
        case 'q':
          quietmode=1;
          break;
        
        case 'h':
        case '?':
          fprintf (stderr, "\nPlayTAP v0.2 . Using ");
          #if defined(SDL)
	         fprintf (stderr, "SDL audio system.\n");
          #elif defined(SDLMIXER)
             fprintf (stderr, "SDL audio system with SDL_Mixer support.\n");
          #elif defined(NATIVEWIN32)
         	 fprintf (stderr, "Win32 native audio system.\n");
          #else
	         fprintf (stderr, "OSS interface.\n");
          #endif
    
          fprintf (stderr, "(C)1998-2009 Miguel Angel Rodriguez Jodar (http://www.zxprojects.com)\n");
          fprintf (stderr, "GPL Licensed.\n");
        
          fprintf (stderr, "Usage: playtap [options] file[.tap]\n");
          fprintf (stderr, " OPTIONS:\n");
          fprintf (stderr, "   -fNNNN  : sets sampling frequency of resulting audio signal (def. 44100 Hz)\n");
          fprintf (stderr, "   -rs     : renders pulses using square waves (default).\n");
          fprintf (stderr, "   -rw     : renders pulses using sine waves.\n");
          fprintf (stderr, "   -lNNNN  : sets frequency for pilot tone (def. %d Hz).\n", f_leader);
          fprintf (stderr, "   -sNNNN  : sets frequency for synchr pulse (def. %d Hz).\n", f_synchr);
          fprintf (stderr, "   -oNNNN  : sets frequency for bit 1 (def. %d Hz).\n", f_bit1);
          fprintf (stderr, "   -zNNNN  : sets frequency for bit 0 (def. %d Hz).\n", f_bit0);
          fprintf (stderr, "   -mNNNN  : sets frequency for ending tone (only if -e1 used, def. %d Hz\n", f_endtone);
          fprintf (stderr, "   -p0|1   : if 1, inserts a 1 sec pause betwween blocks (def. enabled).\n");
          fprintf (stderr, "   -k0|1   : if 1, waits for a keypress between blocks (def. disabled).\n");
          fprintf (stderr, "   -e0|1   : if 1, issues a tone to mark the end of playing (def. disabled).\n");
          fprintf (stderr, "   -q      : Disables status and information (def. enabled).\n");
          fprintf (stderr, "   -h -?   : shows this help screen.\n\n");
          return EXIT_SUCCESS;
          break;
          
        default:
          fprintf (stderr, "Option not recognized. Use -h to get all the available options.\n");
          return EXIT_FAILURE;
      }
    }
    else
      strncpy (filename, argv[i], 250);
  }
      
  if (strncasecmp(filename+strlen(filename)-4, ".tap", 4)!=0)
    strcat (filename, ".tap");

  if (InitAudio(sfreq)<0)
	  exit (EXIT_FAILURE);

  input_file = open (filename, O_RDONLY | O_BINARY);
  if (input_file<0)
  {
    perror("Trying to open TAP file");
    exit (EXIT_FAILURE);
  }
 
  samples = malloc(576*sizeof(short int));
  IniciarPlugin();
  
  if (!quietmode)
  {
    printf ("\nPlayTAP v0.2 . Using ");
#if defined(SDL)
	printf ("SDL audio system.\n");
#elif defined(SDLMIXER)
    printf ("SDL audio system with SDL_Mixer support.\n");
#elif defined(NATIVEWIN32)
	printf ("Win32 native audio system.\n");
#else
	printf ("OSS interface.\n");
#endif
    printf ("(C)1998-2009 Miguel Angel Rodriguez Jodar (http://www.zxprojects.com)\n");
    printf ("GPL Licensed.\n");
    printf ("-------------- PARAMETERS --------------\n");
    printf (" Sampling frequency:   %d Hz\n", sfreq);
    printf (" Leader tone:          %d Hz\n", f_leader);
    printf (" Sinc pulse:           %d Hz\n", f_synchr);
    printf (" Bit 0:                %d Hz\n", f_bit0);
    printf (" Bit 1:                %d Hz\n", f_bit1);
    printf (" EOP mark tone:        %d Hz\n", f_endtone);
    printf (" Rendering:            %s\n", (waverender==SQUARE)? "square wave" : "sine wave");
    printf (" Pause between blocks: %s\n", (pausebtracks)? "YES" : "NO");
    printf (" Key between blocks:   %s\n", (keybtracks)? "YES" : "NO");
    printf (" Issue EOP mark tone:  %s\n", (endtone)? "YES" : "NO");
    printf ("-----------------------------------------\n");
       
    printf ("%s is loading. Please, wait.\n\n", filename);
  }        
 
  while (Render576(samples)==(576*2))
  {
    if (WriteAudio (samples, 576*2)<0)
		exit (EXIT_FAILURE);
    if (!quietmode && Estado==DATOS && lbloque>50)
    {
      putchar ('[');
      for (i=0;i<=(byteactual*50/lbloque);i++)
        putchar('=');
      for (;i<50;i++)
        putchar(' ');
      printf ("]       \r");
      fflush (stdout);
    }
  }

  printf ("\n");
  
  CloseAudio();
  close (input_file);
  
  return EXIT_SUCCESS;
}
