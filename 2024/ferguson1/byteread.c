/*
 * very similar to bytecount.c but it doesn't print out the location of each
 * byte AND it also parses the file WITHOUT caring about the NUL bytes (how does
 * that work?).
 *
 * Note that this one does not have an option to specify which file is to be
 * read and it shouldn't need one at the late stage (at the time of writing
 * there was only one file - then I added the ASCII only one and then later
 * changed out the data.src to be data.scrnshot.src and made data.src wider in
 * text).
 */
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
int main(void)
{
    FILE *fp = fopen("data.src", "r");
    char *p = NULL;
    size_t len = 0;
    char *buf = NULL;
    size_t i = 0, j = 0, k = 0;

    /*
     * the question I had to determine the answer to is if getdelim() will stop
     * at the NUL byte. I feared it would but my fear was ungrounded. It
     * actually read up to the EOF!
     */
    if (fp == NULL)
    {
        fprintf(stderr, "couldn't open data file\n");
        exit(1);
    }

    /*
     * as I already knew that getdelim(3) would read up to the EOF even with NUL
     * bytes in the file, I wanted to make sure the algorithm would work okay.
     * It's not exactly the algorithm I use as in the game I have to print only
     * a single string, not every string in the single char *. The algorithm
     * here is pretty simple to understand but it was important in testing.
     *
     * It simply prints out each string in the source data file but of course
     * the game itself prints the flat char *y which is the contents of the data
     * file itself.
     */
    if (getdelim(&buf, &len, EOF, fp) != -1)
    {
        p = buf;
        while (i < len)
        {
            j = strlen(p);
            k = 0;
            while (k < j)
            {
                putchar(*(p+k));
                ++k;
            }
            i += j + 1;
            p += j + 1;
        }
    }

    free(buf);
    buf = NULL;
    fclose(fp);
    fp = NULL;
}
