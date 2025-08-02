#include <string.h>
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
#include <ctype.h>

#ifndef X
#define X 0
#endif
char *l[][2] = {
 { "A", "WOL-LA-CHEE" },
 { "A", "BE-LA-SANA" },
 { "A", "TSE-NILL" },
 { "B", "NA-HASH-CHID" },
 { "B", "SHUSH" },
 { "B", "TOISH-JEH" },
 { "C", "MOASI" },
 { "C", "TLA-GIN" },
 { "C", "BA-GOSHI" },
 { "D", "BE" },
 { "D", "CHINDI" },
 { "D", "LHA-CHA-EH" },
 { "E", "AH-JAH" },
 { "E", "DZEH" },
 { "E", "AH-NAH" },
 { "F", "CHUO" },
 { "F", "TSA-E-DONIN-EE" },
 { "F", "MA-E" },
 { "G", "AH-TAD" },
 { "G", "KLIZZIE" },
 { "G", "JEHA" },
 { "H", "TSE-GAH" },
 { "H", "CHA" },
 { "H", "LIN" },
 { "I", "TKIN" },
 { "I", "YEH-HES" },
 { "I", "A-CHI" },
 { "J", "TKELE-CHO-G" },
 { "J", "AH-YA-TSINNE" },
 { "J", "YIL-DOI" },
 { "K", "JAD-HO-LONI" },
 { "K", "BA-AH-NE-DI-TININ" },
 { "K", "KLIZZIE-YAZZIE" },
 { "L", "DIBEH-YAZZIE" },
 { "L", "AH-JAD" },
 { "L", "NASH-DOIE-TSO" },
 { "M", "TSIN-TLITI" },
 { "M", "BE-TAS-TNI" },
 { "M", "NA-AS-TSO-SI" },
 { "N", "TSAH" },
 { "N", "A-CHIN" },
 { "O", "A-KHA" },
 { "O", "TLO-CHIN" },
 { "O", "NE-AHS-JAH" },
 { "P", "CLA-GI-AIH" },
 { "P", "BI-SO-DIH" },
 { "P", "NE-ZHONI" },
 { "Q", "CA-YEILTH" },
 { "R", "GAH" },
 { "R", "DAH-NES-TSA" },
 { "R", "AH-LOSZ" },
 { "S", "DIBEH" },
 { "S", "KLESH" },
 { "T", "D-AH" },
 { "T", "A-WOH" },
 { "T", "THAN-ZIE" },
 { "U", "SHI-DA" },
 { "U", "NO-DA-IH" },
 { "V", "A-KEH-DI-GLINI" },
 { "W", "GLOE-IH" },
 { "X", "AL-NA-AS-DZOH" },
 { "Y", "TSAH-AS-ZIH" },
 { "Z", "BESH-DO-TLIZ" },
 { NULL, NULL }
 };


struct c
{
    char *w;
    char *C;
    char *L;
    struct c *n;
};
struct c *c;

void
L(void)
{
    FILE *f = fopen("dict", "r");
    if (f != NULL)
    {
	char *line = NULL;
	size_t n = 0;
	ssize_t len;
	while ((len = getline(&line, &n, f)) > 0)
	{
	    char *lst = strtok(line, "\t");
	    char *snd = strtok(NULL, "\t");
	    char *erd = strtok(NULL, "\t");
	    if (snd || erd)
	    {
		struct c *d = calloc(1, sizeof *d);
		d->w = strdup(X?snd:lst);
		d->C = strdup(X?lst:snd);
		d->L = erd?strdup(erd):"";
		d->n = c;
		c = d;
	    }
	}

	fclose(f);
	f = NULL;
    }
    else
	puts("could not open dictionary");
}

#define up(C) (isascii((C))&&isupper(C))
#define lo(C) (isascii((C))&&islower(C))
#define na(C) (!isascii((C))||!isalpha(C))

void
print(char *w)
{
    struct c *C = c;
    int i = 0, j, u=1, k, L;
    char *v;
    for (v = strtok(w, " "); v; v = strtok(NULL, " "))
    {
	for (C = c ; C; C = C->n)
	    if (!strcasecmp(C->w, v))
	    {
		u = up(v[0]);
		for (i = 0; i[C->C]; ++i)
		    putchar(!i&&u?C->C[i]:tolower(C->C[i]));
		goto F;
	    }
	for (i = 0; i[v]; ++i)
	{
	    if (na(i[v]))
		putchar(i[v]);
	    else
	    {
		u = lo(i[v]);
		for (j = 0; l[j][X?1:0]; ++j)
		{
		    if (*l[j][0] == toupper(i[v]))
		    {
			printf("%s",i?" ":"");
			for (k = 0; L=l[j][X?0:1][k]; ++k)
			    putchar(k||u?tolower(L):L);
			break;
		    }
		}
	    }
	}
	F:printf(" ");
    }
}

void
F(char *w)
{
    int i = 0, j, u=1, k, L;
    size_t s=0;
    struct c *C = c;
    FILE *f = NULL;
    char *v;

    if (*w=='+')
    {
	f = 1[w]=='-'?stdin:fopen(w+1, "r");
	if (f)
	{
	    w=NULL;
	    while (getdelim(&w, &s, EOF, f) > 0)
		print(w);

	    if (!w) goto E;
	}
    }
    #if 0
    for ( ; C; C = C->n)
	if (!strcasecmp(C->w, w))
	{
	    u = up(w[0]);
	    for (; i[C->C]; ++i)
		putchar(!i&&u?C->C[i]:tolower(C->C[i]));
	    goto E;
	}
    #endif

    for (v = strtok(w, " "); v; v = strtok(NULL, " "))
    {
	for (C = c ; C; C = C->n)
	    if (!strcasecmp(C->w, v))
	    {
		u = up(v[0]);
		for (i = 0; i[C->C]; ++i)
		    putchar(!i&&u?C->C[i]:tolower(C->C[i]));
		goto F;
	    }
	for (i = 0; i[v]; ++i)
	{
	    if (na(i[v]))
		putchar(i[v]);
	    else
	    {
		u = lo(i[v]);
		for (j = 0; l[j][X?1:0]; ++j)
		{
		    if (*l[j][0] == toupper(i[v]))
		    {
			printf("%s",i?" ":"");
			for (k = 0; L=l[j][X?0:1][k]; ++k)
			    putchar(k||u?tolower(L):L);
			break;
		    }
		}
	    }
	}
	F:printf(" ");
    }

    E:
    putchar(' ');
    if (f)
    {
	if (f!=stdin)
	    fclose(f);
	free(w);
    }
}
int main(int C, char **V)
{
    L();
    for (C = 1; V[C]; ++C)
	F(V[C]);
    puts("");
}
