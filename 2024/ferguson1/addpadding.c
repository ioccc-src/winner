/*
 * addpadding.c - add padding for each string in the data file.
 *
 * This DOES NOT ENCRYPT the data! That is the other submission. If this were to
 * encrypt then the tools and game would print out rubbish.
 */
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <getopt.h>
#include <errno.h>

static char padding[] = "ha_ha(){hell:goto hell;}main(){goto hell;hell:goto hell;ha_ha();main();goto hell;}";
static char comment1[] = "/*useless code below, goto end of file*/";
static char comment2[] = "/*useless code above, goto start of file*/";
static FILE *in, *out, *prog;
static char *buf, *p;
static size_t len, len2, count, i, j, padlen;
static char *data_src = "data.src";
static char *data = "data";
static char *data_asc_src = "data.asc.src";
static char *data_asc = "data.asc";
static char *data_scrnshot_src = "data.scrnshot.src";
static char *data_scrnshot = "data.scrnshot";
static char *prog_c_filename = "prog.c";
static char *prog_c;
static int l, k;

void make_data(char const *dst, char const *src)
{
    if (in)
    {
        fclose(in);
        in = NULL;
    }

    if (out)
    {
        fclose(out);
        out = NULL;
    }

    errno = 0;
    in = fopen(src, "r");
    if (in == NULL)
    {
        fprintf(stderr, "%s: couldn't open data source file: %s\n", src, strerror(errno));
        exit(1);
    }

    errno = 0;
    out = fopen(dst, "w");
    if (out == NULL)
    {
        fprintf(stderr, "%s: couldn't open output data file: %s\n", dst, strerror(errno));
        fclose(in);
        in = NULL;
        fclose(prog);
        prog = NULL;

        free(prog_c);
        prog_c = NULL;
        exit(1);
    }
    l = fprintf(out, "%s",comment1);
    for (i = l; i < BLOCKSIZE; )
    {
        for (j = 0; j < padlen; ++j)
            if (j + i + 1 < BLOCKSIZE + 1)
                fputc(padding[j], out);
        i += j;
    }

    while (getdelim(&buf, &len, '\0', in) != -1)
    {
        if (*buf == '%')
            fprintf(out, "%s", buf);
        else if (*buf == '\a')
            fprintf(out, "\b%s", buf+1);
        else for (p = buf; *p; ++p)
            fputc(*p, out);
        fputc('\0', out);
        for (i = strlen(buf) + 1; i < BLOCKSIZE; )
        {
            for (j = 0; j < padlen; ++j)
                if (j + i < BLOCKSIZE)
                    fputc(padding[j], out);
            i += j;
        }
    }
    fprintf(out, "\n%s%s\n", comment2, comment1);

    for (count = 0, p = prog_c; *p; ++p)
    {
        if (*p == '\n')
        {
            if (count<15)
                fputc('\n', out);
            else fprintf(out, "\n%s%s%s\n", comment1, padding, comment2);
            ++count;
            continue;
        }
        else fputc(*p, out);
    }
    fprintf(out, "%s",comment2);
    fclose(in);
    in = NULL;
    fclose(out);
    out = NULL;
    free(buf);
    buf = NULL;
}

int main(int argc, char **argv)
{
    while ((k = getopt(argc, argv, "i:I:o:O:p:dt")) != -1)
    {
        switch (k)
        {
            case 'i':
                data_src = optarg;
                break;
            case 'I':
                data_asc_src = optarg;
                break;
            case 'o':
                data = optarg;
                break;
            case 'O':
                data_asc = optarg;
                break;
            case 'p':
                prog_c_filename = optarg;
                break;
            case ':':
            case '?':
                exit(1);
                break; /* this triggers an annoying warning but it's a sanity check */
        }
    }

    padlen = strlen(padding);

    errno = 0;
    prog = fopen(prog_c_filename, "r");
    if (prog == NULL)
    {
        fprintf(stderr, "%s: couldn't open prog.c code file: %s\n", prog_c_filename, strerror(errno));
        fclose(in);
        in = NULL;
        exit(1);
    }

    errno = 0;
    if (getdelim(&prog_c, &len2, EOF, prog) == -1)
    {
        fprintf(stderr, "couldn't read prog.c\n");
        fclose(in);
        in = NULL;
        fclose(prog);
        prog = NULL;
        exit(1);
    }

    make_data(data, data_src);
    make_data(data_asc, data_asc_src);
    make_data(data_scrnshot, data_scrnshot_src);

    fclose(prog);
    prog = NULL;
}
