#include <stdio.h>
#include <curses.h>

char graphtab[16][16] = {
' ', '.', '.', ',', '.', ';', ':', 'j', '\'',':', ':', ';', '\'',';', '!', '|',
'.', '_', ':', ',', ';', ';', ';', 'j', '/', ';', ';', ';', 'j', 'j', 'j', 'j',
'.', ',', '-', ',', 'r', '<', 'j', 'q', '/', ';', 'I', ';', '/', '|', 'I', '|',
',', ',', 'r', 'x', '/', '/', '/', 'd', '/', '/', '/', 'd', '/', '/', '/', 'd',
'.', ':', '\\',';', '-', '=', 'v', 'q', '\'',':', '<', '|', '\'',':', '+', '+',
';', ';', '>', ';', '=', '=', 'g', 'g', '\'',':', 'S', 'S', '/', '/', '/', '+',
':', '\\','\\','\\','r', '<', 'w', 'q', '/', '<', '6', '4', '/', '/', 'd', '+',
'l', 'L', '+', 'b', 'y', '[', 'p', 'g', '/', '<', '/', '6', '/', '/', '/', '+',
'`', ':', ':', ';', '`', '\\','\\','\\','"', ':', ':', ';', '`', '\\','Y', 'T',
';', ';', ';', ';', '`', '2', '>', '\\',':', '=', ';', ';', '?', '?', ']', ']',
':', ';', ';', ';', '>', '2', '>', '\\','F', ';', 'O', ';', '7', '?', ']', '7',
';', ';', ';', ';', '?', '2', '>', 'b', ';', ';', ';', ';', '?', '?', ']', '#',
'\'','\\','\\','\\','`', '\\','\\','\\','\'','\'','<', '5', '"', '"', 'V', 'q',
';', '\\','\\','\\','`', '=', '\\','\\','\'','\'','5', '5', '"', '?', 'g', 'g',
'I', 'L', 'L', 'L', 'D', '\\','b', 'f', 'F', '[', '[', '[', 'P', '?', '#', 'M',
'|', '|', '|', '|', '|', '#', '+', '#', 'T', '[', 'F', 'F', 'P', '?', 'P', 'M'
};

#define BITROWS 96
#define BITCOLS 160
#define SCREENROWS 23	/* one less so doesn't scroll off screen */
#define SCREENCOLS 79	/* one less so doesn't scroll off screen */
char framebuffer[BITROWS][BITCOLS];

#define BITSET(r, c) framebuffer[r][c] = 1;
#define BITCLR(r, c) framebuffer[r][c] = 0;

double f();
double atof();

FILE *d;

main(argc, argv)
char **argv;
{
	int i, a, b, c, r;
	char labbuf[100];

	for (i=0; i<48; i++) {
		r = scanf("%x %x %x", &a, &b, &c);
		bs(i, 0, a);
		bs(i, 16, b);
		bs(i, 32, c);
	}

	bitshow();
}

bs(r, c, v)
int r, c, v;
{
	int j, q;

	for (j=16; j>0; j--) {
		q = v&0x8000;
		v <<= 1;
		if (q)	/* !q for white on black */
			BITSET(r, c);
		c++;
	}
}

bitshow()
{
	bitshow2();	/* or bitshow1() for bigger version */
}

/* Show bits with 1x2 resolution, 48x80 on screen */
bitshow1()
{
	int r, c;
	int basei, basej;
	int i, j;
	char ch;

	for (r=0; r<SCREENROWS; r++) {
		for (c=0; c<SCREENCOLS; c++) {
			basei = 2*r;
			basej = 1*c;
			i = (framebuffer[basei+0][basej+0] << 1)
			  + (framebuffer[basei+1][basej+0] << 0);
			ch = " ,\"M"[i];
			/* mvaddch(r, c, ch); */
			putchar (ch);
		}
		putchar('\n');
	}
}

/* Show bits with 2x4 resolution, 96x160 on screen */
bitshow2()
{
	int r, c;
	int basei, basej;
	int i, j;
	char ch;

	for (r=0; r<SCREENROWS; r++) {
		for (c=0; c<SCREENCOLS; c++) {
			basei = 4*r;
			basej = 2*c;
			i = (framebuffer[basei+0][basej+0] << 3)
			  + (framebuffer[basei+1][basej+0] << 2)
			  + (framebuffer[basei+2][basej+0] << 1)
			  + (framebuffer[basei+3][basej+0] << 0);
			j = (framebuffer[basei+0][basej+1] << 3)
			  + (framebuffer[basei+1][basej+1] << 2)
			  + (framebuffer[basei+2][basej+1] << 1)
			  + (framebuffer[basei+3][basej+1] << 0);
			ch = graphtab[i][j];
			putchar(ch);
		}
		putchar ('\n');
	}
}
