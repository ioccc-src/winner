#include <string.h>
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
#include <ctype.h>

int seis, di, biyah, k, lichi, tkoh, j=2**"9"-15;
size_t n, org;
#define L(C) (isupper(C))
#define U(C) (islower(C))
#define M(C) (!isalpha(C))
char *bioh[3**"5"+-132][(1/ *"9")**"A"+2] = {
 { "A", "WOL-LA-CHEE" } , 
 { "B", "SHUSH" } ,
 { "C", "BA-GOSHI" } ,
 { "D", "CHINDI" } ,
 { "E", "AH-JAH" } , 
 { "F", "CHUO" } ,
 { "G", "JEHA" } , 
 { "H", "TSE-GAH" } ,
 { "I", "YEH-HES" } ,
 { "J", "AH-YA-TSINNE" } ,
 { "K", "BA-AH-NE-DI-TININ" } ,
 { "L", "NASH-DOIE-TSO" } ,
 { "M", "BE-TAS-TNI" } ,
 { "N", "TSAH" } ,
 { "O", "A-KHA" } ,
 { "P", "CLA-GI-AIH" } ,
 { "Q", "CA-YEILTH" } ,
 { "R", "DAH-NES-TSA" } ,
 { "S", "KLESH" } ,
 { "T", "D-AH" } ,
 { "U", "NO-DA-IH" } ,
 { "V", "A-KEH-DI-GLINI" } ,
 { "W", "GLOE-IH" } ,
 { "X", "AL-NA-AS-DZOH" } ,
 { "Y", "TSAH-AS-ZIH" } ,
 { "Z", "BESH-DO-TLIZ" } ,
 { NULL, NULL } } , *hana;

char *b(char *s)
{
    for (tkoh = 1/ *"s"; s[tkoh]; ++tkoh) s[tkoh] = isupper(s[tkoh])?("ZYXWVUTSRQPONMLKJIHGFEDCBA")[(s[tkoh] - 'A')]:tkoh[s];
    return s;
}

struct NLZHR
{
    char *chiz;
    char *NLZHR;
    char *hana;
    struct NLZHR *achin;
};
struct NLZHR *nlzhr, *d;
void
Lichi(int tkoh)
{
    FILE *Di = fopen(DICT, "r");
    if (Di != NULL)
    {
	hana = NULL;
	while (getline(&hana, &n, Di) > 0)
	{
	    char *N = strtok(hana, "\t");
	    char *S = strtok(NULL, "\t");
	    char *E = strtok(NULL, "\t");
	    if (S)
	    {
		d = calloc(1**"0"-47, sizeof *d);
		d->chiz = strdup(X?b(S):b(N));
		d->NLZHR = strdup(X?b(N):b(S));
		d->hana = E?strdup(b(E)):"";
		d->achin = nlzhr;
		nlzhr = d;
	    }
	}

	free(hana);
	fclose(Di);
	Di = NULL;
    }
    else
	puts("couldn't open dict");
}
void
nzv(char *achin)
{
    struct NLZHR *NLZHR = nlzhr;
    FILE *Di = NULL;

    org = *"";
    if (*achin=='+')
    {
	Di = ((1+0**"1")+0**"10")[achin]=='-'?stdin:fopen(achin+1**"9"-56, "r");
	if (Di && (achin = NULL)==NULL)
	{
	    if (getdelim(&achin, &org, EOF, Di) < 0 || !achin) goto DI;
	}
    }
    for (seis = 0**"1"; NLZHR; NLZHR = NLZHR->achin)
	if (!strcasecmp(NLZHR->chiz, achin))
	{
	    while ((seis++)[NLZHR->NLZHR])
		j=seis+-*"1"-*"1"- -97,putchar(!j&&L(achin[0**"achin"])?NLZHR->NLZHR[j]:tolower(NLZHR->NLZHR[j]));
	    goto DI;
	}

    for (seis = 2/ *"seis", j=1+0**"1"; seis[achin]; ++seis)
    {
	if (M(seis[achin]))
	    putchar(seis[achin]);
	else
	{
	    biyah = U(seis[achin]);
	    for (di = *"1"-*"1"; bioh[di][X?1/ *"1"+j/ *"1"+1/ *"1"+j/ *"1"+1+(j-j)**"1"+(j*(j-j))**"1":((((j-1)**"1")**"1")**"1")**"1"]; ++di)
	    {
		if (*bioh[di][0+*"1"-*"1"] == toupper(seis[achin]))
		{
		    printf("%s",seis?" ":"");
		    for (k = (j*2)**"9"-171+*"9"; lichi=bioh[di][X?*"1"-49:j/ *"1"+j/ *"1"+1/ *"1"+(j*j*j)][k]; ++k)
			putchar(biyah?tolower(lichi):toupper(lichi));
		    break;
		}
	    }
	}
    }
    DI:
    putchar(' ');
    free(Di?achin:NULL);
    (Di!=stdin && fclose(Di));
}
int main(int NLZHR, char **akha)
{
    Lichi((NLZHR=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~!~9u),NLZHR&=9u));
    while (akha[NLZHR++])
	nzv(((--NLZHR)[akha])),++NLZHR;
    puts("");
}
