/*
 * printer.c - prints out everything from data file for visual inspection
 *
 * This tool can be used to not only help identify if your system will work with
 * the emojis data file but also show what the strings are without having to
 * look at the source data file (this program decrypts the strings in a similar
 * way to the game itself, see below).
 *
 * Using the macro (identical except it uses puts() on some of the strings that
 * are unencrypted) from prog.c we will print out every string
 * at every location in the order it occurs.
 *
 * IMPORTANT NOTE: as some strings have a marker that indicates to not be
 * encrypted but the marker is not in the data file itself, the bytecount.c
 * might be better in that it uses the data source file.  However for my own
 * purposes I have this tool too. This tool, to prevent display problems, checks
 * for specific known locations where it should not decrypt anything due to not
 * being encrypted (the '%' ones notwithstanding), and if it is that number it
 * will print it out with puts() instead (can't be printf() as it has %
 * conversions). A BEL byte also is unencrypted (if it's the first character of
 * the string it's skipped and printed without encrypting it).
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>

/*
 * macro similar to prog.c
 */
#define Z(x) (x)*BLOCKSIZE
#define V(x) puts(&y[Z(x)]);
static char *p;
static char *y;
static char *filename = "data";
static size_t len;
static int k;

int main(int argc, char **argv)
{
    FILE *fp = NULL;

    while ((k = getopt(argc, argv, "i:")) != -1)
    {
        switch (k)
        {
            case 'i':
                filename = optarg;
                break;
            case ':':
            case '?':
                exit(1);
                break; /* this triggered an annoying warning but it's an extra sanity check */
        }
    }

    errno = 0;
    fp = fopen(filename, "r");
    if (fp == NULL)
    {
        fprintf(stderr, "couldn't open data file %s: %s\n", filename, strerror(errno));
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
