/*
 * bytetest.c
 *
 * Write output in the game, to verify the bytes (locations) are okay.
 *
 * If the data file changes in certain ways these tests have to be run again and
 * the code of the game would potentially have to be updated too. This is why
 * the program exists.
 *
 * The bytecount.c is similar except it reads from the data source file and
 * reads a string at a time (NUL terminated).
 *
 * For this to work right one should run 'make makedata' first.
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <errno.h>

char *p = NULL, *y;
/*
 * Z calculates the block location.
 */
#define Z(x) (x)*1663
#define V(x) { printf("<%zu>\n", (size_t)(x)); puts(&y[Z(x)]); }

int main(void)
{
    FILE *fp = fopen("data", "r");
    size_t len = 0;

    errno = 0;
    if (fp == NULL)
    {
        fprintf(stderr, "couldn't open data file: %s\n", strerror(errno));
        exit(1);
    }

    if (getdelim(&y, &len, EOF, fp) != -1)
    {
        /*
         * now we have to test every single string to make sure it's valid.
         * The makedata.sh script generates V.c.
         */
        #include "V.c"
    }

    free(y);
    y = NULL;
    fclose(fp);
    fp = NULL;
}
