/*
 * bytecount.c - writes the location of each string in a single char *.
 *
 * This version uses the source data file, data.src, and it reads one
 * 'string' at a time; it does not read in the whole file at once.
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>

int main(int argc, char **argv)
{
    FILE *fp = NULL;
    size_t len = 0;
    char *buf = NULL;
    char *filename = "data.src";
    int k;
    size_t i = 0;

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
    fp = fopen(filename, "r");
    if (fp == NULL)
    {
        fprintf(stderr, "couldn't open data file\n");
        exit(1);
    }

    /*
     * i now starts out at 1 due to the way the padded file is
     */
    i = 1;
    while (getdelim(&buf, &len, '\0', fp) != -1)
    {
        printf("<%zu>\n%s\n", i, *buf=='\a'?buf+1:buf);
        ++i;
    }

    /*
     * the next test was necessary earlier on but is not needed now. I keep it
     * here to document my procedure.
     */

    #if 0
    /*
     * clear out buf first
     */
    free(buf);
    buf = NULL;
    /*
     * reset EOF
     */
    rewind(fp);

    /*
     * now we have to verify that string 2 is what we see from the output (34).
     *
     * Obviously (if you look at data.src) the file has changed some since this byte
     * check.
     */
    if (getdelim(&buf, &len, EOF, fp) != -1)
    {
        /*
         * we want to print the string that starts out at 34:
         */
        printf("\n34: %s\n", buf+34);
    }

    free(buf);
    buf = NULL;
    #endif

    fclose(fp);
    fp = NULL;
}
