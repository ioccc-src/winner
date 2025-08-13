/*
 * mbcheck.c - writes the location of each string in a single char * but
 * ignores single byte characters to see ONLY emojis. By write location and see
 * where only emojis are it means warn about it, not print it out itself.
 *
 * This way I can check if the ASCII only data file has any emojis (or other
 * multibyte characters) by accident. This is why it reads from the ASCII only
 * data source file by default, but it can be used on data.src too with -i
 * data.src to see which strings have emojis.
 *
 * It reads one 'string' at a time; it does not read in the whole file at once.
 * The -i option allows for another file.
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>
#include <stdint.h>

static unsigned loc = 0;
static char const *filename = "data.asc.src";
static uintmax_t unicode = 0;
static uintmax_t codes = 0;
static size_t i = 0;

int
main(int argc, char **argv)
{
    FILE *fp = NULL;
    size_t len = 0;
    char *buf = NULL;
    int k;
    int byte;

    while ((k = getopt(argc, argv, "i:l")) != -1)
    {
        switch (k)
        {
            case 'i':
                filename = optarg;
                break;
            case 'l':
                loc = 1;
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

    /*
     * i now starts out at 1 due to the way the padded file is
     */
    i = 1;
    while (getdelim(&buf, &len, '\0', fp) != -1)
    {
        for (codes = k = 0; k[buf]; ++k)
        {
            byte = k[buf];
            if ((byte & 0xF8) == 0xF0)
            {
                if (loc) printf("<%zu:%d>\n", i, k);
                k += 3;
                ++unicode;
                ++codes;
            }
            else if ((byte & 0xF0) == 0xE0)
            {
                if (loc) printf("<%zu:%d>\n", i, k);
                k+= 2;
                ++unicode;
                ++codes;
            }
            else if ((byte & 0xE0) == 0xC0)
            {
                if (loc) printf("<%zu:%d>\n", i, k);
                ++k;
                ++unicode;
                ++codes;
            }
        }
        if (codes)
            fprintf(stderr, "%4ju unicode character%s found in string %zu in file %s\n", codes,
                    codes==1?"":"s", i, filename);
        ++i;
    }

    fclose(fp);
    fp = NULL;
    printf("%ju unicode character%s found in %s\n", unicode, unicode==1?"":"s", filename);
    if (unicode > 0)
        exit(666);
}
