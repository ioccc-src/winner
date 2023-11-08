/*
 * whereami.alt.c: wrapper program to westley.alt.c that checks first the
 * columns of the terminal, exiting if < 80 and otherwise running westley.alt
 * with the specified args. It is an error to not specify two args but it is not
 * an error to specify args that are not numbers. The atoi(3) function typically
 * returns 0 in that case which westley.alt.c uses.
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <curses.h>

int main(int argc, char **argv)
{
    int cols;

    if (argc < 3)
    {
	fprintf(stderr, "usage: %s <lat> <long>\n", argv[0]);
	exit(1);
    }

    /* init curses so we can get the number of columns */
    initscr();
    /* save columns */
    cols = COLS;
    /*
     * end curses so that we can either report an error or compile and run
     * westley.alt
     */
    endwin();

    if (cols < 80)
    {
	fprintf(stderr, "your terminal must be at\nleast 80 columns wide\nbut is only %d, sorry.\n", COLS);
	exit(2);
    }

    /* 
     * compile westley.alt and run if successful
     */
    if (system("make westley.alt >/dev/null"))
    {
	fprintf(stderr, "couldn't compile westley.alt.c, sorry.\n");
	exit(3);
    }
    execl("./westley.alt", "./westley.alt", argv[1], argv[2], NULL);
}
