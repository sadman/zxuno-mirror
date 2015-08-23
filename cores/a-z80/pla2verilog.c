#include <stdio.h>
#include <string.h>

// Format:
// ....1.. .1.1.11.1.1..1.1\t-\t10\t11100011\tex (sp),hl

int main (void)
{
	FILE *fi;
	FILE *fo;
	char s[1024];
	char *temp, *comment;
	char prefix[8];
	char opcode[9];
	int i, npla;
	int poner_amps;
	
	fi = fopen ("z80-pla.txt", "rt");
	if (!fi)
	{
		fprintf (stderr, "z80-pla.txt not found!\n");
		return 1;
	}
	
	fo = fopen ("pla-decode-table.vh", "wt");
	fgets (s, 1023, fi);
	for (; !feof(fi); fgets(s, 1023, fi))
	{
		printf (s);
		if (s[0] =='#') continue;
		
		strncpy (prefix, s, 7);
		temp = strchr (s, '\t');
		if (!temp) continue;
		temp++;
		if (temp[0] == 'D') continue;

		temp = strchr (temp, '\t');
		temp++;
		npla = temp[0]-'0';
		temp++;
		while (temp[0]>='0' && temp[0]<='9')
		{
			npla *= 10;
			npla += (temp[0]-'0');
			temp++;
		}
		temp++;
		strncpy (opcode, temp, 8);
		comment = strchr (temp, '\t');
		if (comment)
			comment++;
		
		for (i=strlen(s)-1;i>=0;i--)
		{
			if (s[i]>=' ')
			{
				s[i+1] = '\0';
				break;
			}
		}
		
		fprintf (fo, "if (");
		poner_amps = 0;
		for (i=0;i<7;i++)
		{
			if (prefix[i]=='1')
			{
				if (poner_amps) fprintf (fo, " && ");
				poner_amps = 1;
				fprintf (fo, "prefix[%d] == 1'b1", 6-i);
			}
		}
		
		for (i=0;i<8;i++)
		{
			if (opcode[i] == '0' || opcode[i] == '1')
			{
				if (poner_amps)  fprintf (fo, " && ");
				poner_amps = 1;
				fprintf (fo, "opcode[%d] == 1'b%d", 7-i, opcode[i]-'0');
			}
		}
		
		fprintf (fo, ") pla[%3d] = 1'b1; else pla[%3d] = 1'b0;", npla, npla);
		if (comment)
			fprintf (fo, "\t\t// %s\n", comment);
		else
			fprintf (fo, "\n");
	}
	return 0;
}

		
				
		
		
