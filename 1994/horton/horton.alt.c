#include <stdio.h>
/*
 * Obfuscated version is simpler but can't display labels.
 */

char graphtab[] =
" ..,.;:j'::;';!|._:,;;;j/;;;jjjj.,-,r<jq/;I;/|I|,,rx///d///d///d.:\\;-=vq':<|':++;;>;==gg':SS///+:\\\\\\r<wq/<64//d+lL+by[pg/</6///+`::;`\\\\\\\"::;`\\YT;;;;`2>\\:=;;??]]:;;;>2>\\F;O;7?]7;;;;?2>b;;;;??]#'\\\\\\`\\\\\\''<5\"\"Vq;\\\\\\`=\\\\''55\"?ggILLLD\\bfF[[[P?#M|||||#+#T[FFP?PM'"
;

#define BITROWS 96
#define BITCOLS 160
#define SCREENROWS 23	/* one less so doesn't scroll off screen */
#define SCREENCOLS 79	/* one less so doesn't scroll off screen */
char framebuffer[BITROWS][BITCOLS];
char screen[SCREENROWS][SCREENCOLS];

#define BITSET(r, c) framebuffer[r][c] = 1;
#define BITCLR(r, c) framebuffer[r][c] = 0;

double f();
double atof();

/* row and column boundaries in frame buffer */
int minr= 10;
int maxr= 80;
int minc= 20;
int maxc=150;

/* x and y boundaries in formula */
double maxy= 500;
double miny=-500;
double maxx=  10;
double minx= -20;

double three, two, one, zero;	/* coefficients */

double xbase, ybase;

main(argc, argv)
char **argv;
{
	double x, y;
	char labbuf[100];

	if (argc < 5) {
		printf("Usage: %s cube square linear constant\n", argv[0]);
		exit(1);
	}

	/* Arguments are four coefficients to polynomial */
	three = atof(argv[1]);
	two = atof(argv[2]);
	one = atof(argv[3]);
	zero = atof(argv[4]);

	gbox(minr,maxr,minc-2,maxc+2);

	plotinit();
	for (x=minx; x<=maxx; x += .05) {
		fplot(x, f(x));
	}

	bitshow();

	hlabel(minr-4, (maxc+minc)/2 - 10, "A Cubic Function");
	sprintf(labbuf, "y=%gx^3+%gx^2+%gx+%g", three, two, one, zero);
	vlabel(12, 5, labbuf);
	hlabel(maxr+4, (maxc+minc)/2, "x");

	sprintf(labbuf, "%g", minx);
	hlabel(maxr+4, minc, labbuf);
	sprintf(labbuf, "%g", maxx);
	hlabel(maxr+4, maxc-strlen(labbuf)*2, labbuf);

	sprintf(labbuf, "%g", miny);
	vlabel(minr+4, minc-4, labbuf);
	sprintf(labbuf, "%g", maxy);
	vlabel(maxr-strlen(labbuf)*4, minc-4, labbuf);

	/* bigshow(20, 55, 0, 70); */
	srefresh();
}

double f(x)
double x;
{
	double y;

	y = three*x*x*x + two*x*x + one*x + zero;
	return y;
}

fplot(x, y)
double x, y;
{
	int r, c;

	r = (maxy - y) * ybase + minr;
	c = (x - minx) * xbase + minc;
	if (r >= minr && r <= maxr && c >= minc && c <= maxc)
		BITSET(r, c);
}

hlabel(r, c, lab)
int r, c;
char *lab;
{
	r = r/4;
	c = c/2;
	while (*lab)
		screen[r][c++] = *lab++;
}

vlabel(r, c, lab)
int r, c;
char *lab;
{
	r = r/4;
	c = c/2;
	while (*lab && r<maxr)
		screen[r++][c] = *lab++;
}

plotinit()
{
	ybase = (maxr-minr)/(maxy-miny);
	xbase = (maxc-minc)/(maxx-minx);
}

/* Draw the frame buffer onto the screen, 96x180 mode, 4x2 per character */
bitshow()
{
	int r, c;
	int basei, basej;
	int i, j;
	char ch;

	for (r=0; r<SCREENROWS; r++)
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
			ch = graphtab[i*16+j];
			screen[r][c] = ch;
		}
}

/* Show all the bits separately */
bigshow(rbase, rmax, cbase, cmax)
{
	int i, j;
	char ch;

	for (i=rbase; i<=rmax; i++) {
		for (j=cbase; j<=cmax; j++) {
			if (framebuffer[i-rbase][j-cbase])
				ch = 'X';
			else
				ch = ' ';
			putchar(ch);
		}
		putchar('\n');
	}
}

/* Draw the box around the graph */
gbox(rmin, rmax, cmin, cmax)
{
	int i;
	for (i=rmin; i<=rmax; i++) {
		BITSET(i, cmin);
		BITSET(i, cmax);
	}

	for (i=cmin; i<=cmax; i++) {
		BITSET(rmin, i);
		BITSET(rmax, i);
	}
}

srefresh()
{
	int r, c;

	for (r=0; r<SCREENROWS; r++) {
		for (c=0; c<SCREENCOLS; c++)
			putchar(screen[r][c]);
		putchar('\n');
	}
}
