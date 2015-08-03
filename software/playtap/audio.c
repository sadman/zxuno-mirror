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

#define LONG_BUFFER (576*2)

#ifdef NATIVEWIN32
#include <stdio.h>
#include <windows.h>
#include <mmsystem.h>

#define MAX_BUFFERS_REP 8
HWAVEOUT hwoRep;
WAVEHDR WHRep[MAX_BUFFERS_REP];

int InitAudio (int sfreq)
{
    MMRESULT ok;
    WAVEFORMATEX wfx;
    int i;

    wfx.wFormatTag = WAVE_FORMAT_PCM;
    wfx.nChannels = 1;
    wfx.nSamplesPerSec = sfreq;
    wfx.nAvgBytesPerSec = sfreq*2;
    wfx.nBlockAlign = 2;
    wfx.wBitsPerSample = 16;
    wfx.cbSize = 0;

    ok = waveOutOpen((LPHWAVEOUT)&hwoRep, WAVE_MAPPER, (LPWAVEFORMATEX)&wfx,
    NULL, (DWORD)0, (DWORD)CALLBACK_NULL);
	if (ok!=MMSYSERR_NOERROR)
	{
		fprintf (stderr, "Unable to open audio device. MMSYSERR = %d\n", ok);
		return -1;
	}

    for (i=0;i<MAX_BUFFERS_REP;i++)
	{
		memset(&WHRep[i],0,sizeof(WAVEHDR));
		WHRep[i].lpData=(char *)malloc(LONG_BUFFER);
	}
	return 0;
}

int WriteAudio (short *samples, int nbytes)
{
	int i;
	MMRESULT ok;
	int done=0;

	do
	{
	  for (i=0;i<MAX_BUFFERS_REP;i++)
		if (WHRep[i].dwFlags & WHDR_DONE || WHRep[i].dwFlags == 0)
		{
			ok = waveOutUnprepareHeader (hwoRep, &WHRep[i], sizeof(WAVEHDR));
			if (ok!=MMSYSERR_NOERROR)
			{
				fprintf (stderr, "Unable to release audio buffer. MMSYSERR = %d\n", ok);
				return -1;
			}
			memcpy (WHRep[i].lpData, samples, nbytes);
			WHRep[i].dwBufferLength = nbytes;
			ok = waveOutPrepareHeader (hwoRep, &WHRep[i], sizeof(WAVEHDR));
			if (ok!=MMSYSERR_NOERROR)
			{
				fprintf (stderr, "Unable to prepare audio buffer. MMSYSERR = %d\n", ok);
				return -1;
			}
			ok = waveOutWrite (hwoRep, &WHRep[i], sizeof(WAVEHDR));
			if (ok!=MMSYSERR_NOERROR)
			{
				fprintf (stderr, "Unable to write to audio device. MMSYSERR = %d\n", ok);
				return -1;
			}
			done=1;
			break;
		}
		Sleep(1);
	}
	while (!done);
	return 0;
}

void CloseAudio (void)
{
	MMRESULT ok;
	int i;
	BOOL quedanbuffers;

	quedanbuffers = TRUE;
	while (quedanbuffers)
	{
		quedanbuffers = FALSE;
		for (i=0;i<MAX_BUFFERS_REP;i++)
			if (!(WHRep[i].dwFlags & WHDR_DONE) && WHRep[i].dwFlags != 0)
				quedanbuffers = TRUE;
			else if (WHRep[i].lpData)
			{
				ok = waveOutUnprepareHeader(hwoRep,(LPWAVEHDR) &WHRep[i],sizeof(WAVEHDR));
				free (WHRep[i].lpData);
				WHRep[i].lpData = NULL;
			}
	}
	ok = waveOutClose (hwoRep);
}

#elif defined(SDLMIXER)
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

int canal=-1;

int InitAudio (int sfreq)
{
  if(SDL_Init(SDL_INIT_AUDIO) != 0)
  {
     fprintf(stderr, "Unable to initialize audio: %s\n", SDL_GetError());
     return -1;
  }
  if(Mix_OpenAudio(sfreq, AUDIO_S16SYS, 1, 576))
  {
     fprintf(stderr, "Audio could not be set up for %d Hz 16 bit mono: ",
       sfreq, SDL_GetError());
     return -1;
  }
  return 0;
}

int WriteAudio (short *samples, int nbytes)
{
  Mix_Chunk chunk;

  chunk.volume=MIX_MAX_VOLUME;
  chunk.abuf=(Uint8 *)samples;
  chunk.alen=nbytes;
  chunk.allocated=1;

  if(canal > -1)
     while(Mix_Playing(canal) != 0);
  canal=Mix_PlayChannel(-1, &chunk, 0);

  if(canal == -1)
  {
     fprintf(stderr, "Unable to play sound: %s\n", Mix_GetError());
     return -1;
  }
  return 0;
}

void CloseAudio (void)
{
  Mix_CloseAudio();
  SDL_Quit();
}

#elif defined(SDL)
#ifdef WIN32
  #include <windows.h>
#endif
#include <SDL/SDL.h>

volatile int buffer_usandose;
short int buffsamples[LONG_BUFFER];

void SDL_AudioCallback (void *userdata, Uint8 *stream, int len)
{
    memcpy (stream, buffsamples, len);
	buffer_usandose=0;
}

int InitAudio (int sfreq)
{
	SDL_AudioSpec parms;
	int res;
	
	parms.freq=sfreq;
	parms.format=AUDIO_S16SYS;
	parms.channels=1;
	parms.samples=576;
	parms.callback=SDL_AudioCallback;
	parms.userdata=NULL;
	
	res=SDL_OpenAudio (&parms, NULL);
	if (res<0)
	{
		fprintf (stderr, "Unable to open SDL audio device: %s\n", SDL_GetError() );
		return -1;
	}
	buffer_usandose=0;
	return 0;
}

int WriteAudio (short *samples, int nbytes)
{
	while (buffer_usandose)
#ifdef WIN32
        Sleep(1);
#else
		usleep(1000);
#endif
    memcpy (buffsamples, samples, nbytes);
	buffer_usandose=1;
	SDL_PauseAudio(0);
	return 0;
}

void CloseAudio (void)
{
	SDL_PauseAudio(1);
	SDL_CloseAudio();
}

#else

#include <stdio.h>
#include <stdlib.h>
#include <linux/soundcard.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int fd;

void send_ioctl_dsp (int fd, int cmd, int arg, char *ncmd, char *merror)
{
  int tmp=arg;
      
  if (ioctl (fd, cmd, &tmp) == -1)
  {
    perror (ncmd);
    exit (EXIT_FAILURE);
  }
  if (tmp != arg)
  {
    fprintf (stderr, merror);
    exit (EXIT_FAILURE);
  }
}

int InitAudio (int sfreq)
{
  int vol;

  if ((fd = open ("/dev/mixer", O_RDONLY)) == -1)
    perror("/dev/mixer");

  vol=0xffff;
  ioctl (fd, MIXER_WRITE(SOUND_MIXER_VOLUME), &vol);
  ioctl (fd, MIXER_WRITE(SOUND_MIXER_PCM), &vol);
  close(fd);

  if ((fd = open ("/dev/dsp", O_WRONLY, 0)) == -1)
  {
    perror ("open /dev/dsp");
    return -1;
  }
  send_ioctl_dsp (fd, SNDCTL_DSP_SETFMT, AFMT_S16_LE, "SNDCTL_DSP_SETFMT", "This soundcard doesn't accept 16 bit samples, little endian format. Exiting...\n");
  send_ioctl_dsp (fd, SNDCTL_DSP_CHANNELS, 1, "SNDCTL_DSP_NCHANNELS", "This soundcard doesn't accept mono samples. Exiting...\n");
  send_ioctl_dsp (fd, SNDCTL_DSP_SPEED, sfreq, "SNDCTL_DSP_SPEED", "This soundcard doesn't accept the programmed sampling frequency. Choose another. Exiting...\n");
  return 0;
}

int WriteAudio (short *samples, int nbytes)
{
  if (write (fd, samples, nbytes)<0)
  {
	  perror("write");
	  return -1;
  }
  return 0;
}

void CloseAudio (void)
{
  close (fd);
}

#endif

