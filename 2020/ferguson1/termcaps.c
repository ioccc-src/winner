/* ioccc/2020/ferguson1 - Snake terminal testing utility
 *
 * This will imperfectly:
 *
 * (0)	Test if terminal supports the features Snake uses.
 * (1)	Report terminal (and playing) size(s).
 * (2)	Estimates the minimum number of columns to play unhindered (based on the
 *      size, max size and growth rate).
 * (3)	Reports the max size of the Snake and the number of bugs required to
 *	reach that size but doesn't use shedding.
 */

#include <curses.h>
#include <term.h>
#include <stdlib.h>
#define f(a,b) ((a)<(b)?(a):(b))
static char *v;
static size_t Y=997,X=5, S=5, rows,N, K;
static int x, y;
struct caps
{
    char *caps, *sup, *desc;
    int fatal;
};
static size_t b(size_t n)
{
    size_t i=n/10, j=1;
    while (i)
    {
        i/=10;
        ++j;
    }
    return j;
}
static size_t a(int n)
{
    int i=n/10;
    size_t j=1;
    while (i)
    {
        i/=10;
        ++j;
    }
    return j;
}

static struct caps caps[] =
{
    { "cup", NULL, "cursor movement", 1 },
    { "civis", NULL, "making cursor invisible", 0 },
    { "bold", NULL, "bold", 0 },
    { NULL, NULL, NULL, 0 }
};

static size_t c(size_t M, size_t V)
{
    size_t i;

    if (!S) S = 5;

    for (i=0; V<M; ++i)
	V += S;

    return i;
}
int main(void)
{
    int i, j, k = 0, f = 0;
    if (!initscr())
    {
	fprintf(stderr, "FATAL: couldn't initialise curses\n");
	return -1;
    } 
    j = has_colors();
    k += !j;
    getmaxyx(stdscr, y, x);
    endwin();

    if (y < 10 || x < 10)
    {
	fprintf(stderr, "FATAL: terminal size must be at least 10 lines and 10 columns\n");
	return -1;
    }
   
    for (i = 0; i[caps].caps; ++i)
    {
	i[caps].sup = tigetstr(caps[i].caps);
	/* tigetstr() returns (char *)-1 if the capability name isn't
	 * recognised; check for this before suggesting it's (un)?supported: */
	if (caps[i].sup == (char *)-1)
	    caps[i].sup = NULL;
	if (!caps[i].sup) ++k;
    }

    for (i = 0; i[caps].caps; ++i)
    {
	printf("terminal%s support%s %s", caps[i].sup?"":" does not",caps[i].sup?"s":"", caps[i].desc);
	if (caps[i].fatal && !caps[i].sup)
	{
	    ++f;
	    printf(" (fatal)");
	}
	puts("");
    }
    printf("terminal%s support%s colours\n\n",j?"":" does not",j?"s":"");
    printf("terminal rows %3d (%-3d playable)\n", y, y - 3);
    printf("terminal cols %3d (%-3d playable)\n\n", x, x - 2);

    K = (size_t)((y-3)*(x-3));;

    v = getenv("MAXSIZE");
    if (v) Y = strtoul(v, NULL, 0);
    Y = f(K,Y);
    v = getenv("GROW");
    if (v) S = strtoul(v, NULL, 0);
    v = getenv("SIZE");
    if (v) X = strtoul(v, NULL, 0);
    N = c(Y,X);
    printf("snake size: %5zu (max size: %zu)\n", Y, K);
    printf("      bugs: %5zu (max size: %zu)\n\n", N, c(K,X));

    rows = 14 + b(Y)*2 + a(y)*2 + a(x)*2 + b(N);
    if (x < (int)rows + 1) ++k;
    printf("at least %zu columns (currently %d) recommended for snake size %-5zu\n", rows+1,x, Y);

    rows = 14 + b(K)*2 + a(y)*2 + a(x)*2 + b(c(K,X));
    printf("at least %zu columns (currently %d) recommended for capped snake size %-5zu\n\n", rows + 1,x, K);


    if (!k)
	printf("No problems detected.\n");
    else printf("%d problem%s detected (%d fatal).\n", k, k!=1?"s":"", f);

    return f?-1:k;
}
