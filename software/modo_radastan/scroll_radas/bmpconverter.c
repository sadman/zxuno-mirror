#include <stdio.h>

int main()
{
	FILE *fin,*fout;
	unsigned char red, green, blue, color, pixel;
	int i,j;
	char filename[255];
	
	fin = fopen ("stage1_flipped.bmp", "rb");
	
	fseek (fin, 0x36, SEEK_SET);

	fout = fopen ("palette.sjasm", "wt");
	fprintf (fout, "Palette         db ");
	for (i=0;i<16;i++)
	{
		// B G R Z
		fread (&blue, 1, 1, fin);
		fread (&green, 1, 1, fin);
		fread (&red, 1, 1, fin);
		color = (green&0xe0) | ((red&0xe0)>>3) | ((blue&0xc0)>>6);
		fprintf (fout, "%d",color);
		if (i!=15)
			fprintf (fout, ",");
		else
			fprintf (fout, "\n");
		fread (&red, 1, 1, fin);  // advance one pos
	}
	fclose (fout);
	
	for (i=0;i<96;i++)
	{
		if ((i%16)==0)
		{
			sprintf (filename, "scan%.2d_to_%.2d.sjasm", i, i+15);
			fout = fopen (filename, "wt");
			fprintf (fout, "                org 49152\n");
		}
		fprintf (fout, "Scan%.2d          db ", i);
		for (j=0;j<1024;j++)
		{
			if ((j%32) == 0 && j!=0)
				fprintf (fout,"                db ");
			fread (&pixel, 1, 1, fin);
			fprintf (fout, "0%.2Xh", pixel);
			if ((j%32)==31)
				fprintf (fout, "\n");
			else
				fprintf (fout, ",");
		}
		if ((i%16)==15)
			fclose (fout);
	}
	
	fclose (fin);
	fclose (fout);
}
			
