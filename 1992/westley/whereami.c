/*
 * whereami.c: wrapper program to westley.c that checks first the
 * columns of the terminal, exiting if < 80 and otherwise try compiling
 * westley.c (with make) and then if is already compiled or ends up being
 * compiled it will be run with the specified args to this program.
 *
 * It is an error to not specify two args but it is not an error to specify args
 * that are not numbers. The atoi(3) function typically returns 0 in that case
 * which westley.c uses.
 *
 * The reason to use this wrapper is because westley.c needs at least 80 columns
 * to show the output right. Previously it required 80 column wrapping but in
 * 2023 this limitation was removed, allowing it to work as long as there are at
 * least 80 columns.
 */
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <curses.h>

int main(int argc, char **argv)
{
    int cols;
    char *cc = NULL; /* for if the user passes in CC=foo */
    char *buf = NULL;

    if (argc < 3)
    {
	fprintf(stderr, "usage: %s <lat> <long>\n", argv[0]);
	exit(1);
    }

    /* try and get compiler to use */
    cc = getenv("CC");
    if (!cc)
	cc = "cc";

    buf = calloc(1, strlen(cc) + strlen("CC=") + 1);
    if (buf != NULL)
	sprintf(buf, "CC=%s", cc);
    else
	buf = "CC=cc";


    /* init curses so we can get the number of columns */
    initscr();
    /* save columns */
    cols = COLS;
    /*
     * end curses so that we can either report an error or compile and run
     * westley
     */
    endwin();

    if (cols < 80)
    {
	fprintf(stderr, "your terminal must be at\nleast 80 columns wide\nbut is only %d, sorry.\n", COLS);
	exit(2);
    }

    /* 
     * compile westley.c and run if successful
     */
    buf = calloc(1, strlen("make CC=") + strlen(cc) + strlen("westley") + strlen(">/dev/null") + 1);
    if (buf)
	sprintf(buf, "make CC=%s westley >/dev/null", cc);
    else
	buf = "make westley >/dev/null";

    /* compile source file */
    if (system(buf))
    {
	fprintf(stderr, "couldn't compile westley.c, sorry.\n");
	exit(4);
    }
    /* if we get here we compiled the code or it was already compiled so run it */
    execl("./westley", "./westley", argv[1], argv[2], NULL);

    return 0;
}
