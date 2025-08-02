/*
 * lencount.c - finds longest length string.
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>

static int testmode;

int main(int argc, char **argv)
{
    char *filename = "data.src";
    FILE *fp = NULL;
    char *buf = NULL, *p=0;
    size_t len = 0, strings = 0, longest = 0;
    int k, exitcode = 0;

    while ((k = getopt(argc, argv, "i:t")) != -1)
    {
        switch (k)
        {
            case 'i':
                filename = optarg;
                break;
            case 't':
                testmode = 1;
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

    while (getdelim(&buf, &len, '\0', fp) != -1)
    {
        ++strings;
        if (strlen(buf) >= BLOCKSIZE)
        {
            if (testmode)
                exitcode = 666;
            else
                printf("WARNING: string %zu is >= BLOCKSIZE length: %zu >= %d\n", strings, strlen(buf), BLOCKSIZE);
        }
        if (strlen(buf) > longest)
        {
            longest = strlen(buf);
            if (p)free(p);
            p = strdup(buf);
        }
    }
    if (p)
    {
        if (!testmode)
            printf("out of a total of %zu strings, %zu is the longest string:\n%s\n\n", strings, longest, p);
        free(p);
        p = NULL;
    }
    else
    {
        fprintf(stderr, "error: no string found!\n");
        exit(666);
    }

    if (testmode && exitcode != 0)
    {
        fprintf(stderr, "failed testmode: run '%s -i %s' (without -t) to see problematic strings!",
                argv[0], filename);
        exit(exitcode);
    }
}
