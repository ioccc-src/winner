/*
 * bytecheck.c - writes the location of each string in a single char * but
 * ignores multibyte characters for a diff to make sure the locations are the
 * same in both versions of the data file. This is much less important with
 * mbcheck.c as that tool almost obsoletes it if it does not entirely.
 *
 * This version uses the source data file, data.src by default, and it reads one
 * 'string' at a time; it does not read in the whole file at once. With the -i
 * option it allows for another file. Redirecting to two different files allows
 * for comparing them, though there will be some differences based on emojis in
 * ASCII art (for one example) and differences in strings (for another).
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>

int main(int argc, char **argv)
{
    FILE *fp = NULL;
    size_t len = 0;
    char *buf = NULL;
    char *filename = "data.src";
    int k;
    int byte;
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
    errno = 0;
    fp = fopen(filename, "r");
    if (fp == NULL)
    {
        fprintf(stderr, "couldn't open data file: %s: %s\n", filename, strerror(errno));
        exit(1);
    }

    /*
     * i now starts out at 1 due to the way the padded file is
     */
    i = 1;
    while (getdelim(&buf, &len, '\0', fp) != -1)
    {

        printf("<%zu>\n", i);

        for (k = 0; k[buf]; ++k)
        {
            byte = k[buf];
            if ((byte & 0xE0) == 0xC0)
                ++k;
            else if ((byte & 0xF0) == 0xE0)
                k+= 2;
            else if ((byte & 0xF8) == 0xF0)
                k += 3;
            else putchar(byte);
        }
        ++i;
    }

    fclose(fp);
    fp = NULL;
}
