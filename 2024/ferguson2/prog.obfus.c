#include <string.h>
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
#include <ctype.h>
int seis, di, biyah, k, lichi, tkoh; size_t n, org;
#define L(C) (isupper(C))
#define U(C) (islower(C))
#define M(C) (!isalpha(C))
#ifndef X
#define X 0
#endif
char*bioh[][(1/ *"9")**"A"+2]={ { "A","WOL-LA-CHEE" } ,{ "A","BE-LA-SANA"} ,{ "A","TSE-NILL"} ,
{ "B","NA-HASH-CHID"} ,{ "B","SHUSH"} ,{ "B","TOISH-JEH"} ,{ "C","MOASI"} ,{ "C","TLA-GIN"} ,
{ "C","BA-GOSHI"} ,{ "D","BE"} ,{ "D","CHINDI"} ,{ "D","LHA-CHA-EH"} ,{ "E","AH-JAH"} ,
{ "E","DZEH"} ,{ "E","AH-NAH"} ,{ "F","CHUO"} ,{ "F","TSA-E-DONIN-EE"} ,{ "F","MA-E"} ,
{ "G","AH-TAD"} ,{ "G","KLIZZIE"} ,{ "G","JEHA"} ,{ "H","TSE-GAH"} ,{ "H","CHA"} ,
{ "H","LIN"} ,{ "I","TKIN"} ,{ "I","YEH-HES"} ,{ "I","A-CHI"} ,{ "J","TKELE-CHO-G"} ,
{ "J","AH-YA-TSINNE"} ,{ "J","YIL-DOI"} ,{ "K","JAD-HO-LONI"} ,{ "K","BA-AH-NE-DI-TININ"} ,
{ "K","KLIZZIE-YAZZIE"} ,{ "L","DIBEH-YAZZIE"} ,{ "L","AH-JAD"} ,{ "L","NASH-DOIE-TSO"} ,
{ "M","TSIN-TLITI"} ,{ "M","BE-TAS-TNI"} ,{ "M","NA-AS-TSO-SI"} ,{ "N","TSAH"} ,
{ "N","A-CHIN"} ,{ "O","A-KHA"} ,{ "O","TLO-CHIN"} ,{ "O","NE-AHS-JAH"} ,{ "P","CLA-GI-AIH"} ,
{ "P","BI-SO-DIH"} ,{ "P","NE-ZHONI"} ,{ "Q","CA-YEILTH"} ,{ "R","GAH"} ,{ "R","DAH-NES-TSA"} ,
{ "R","AH-LOSZ"} ,{ "S","DIBEH"} ,{ "S","KLESH"} ,{ "T","D-AH"} ,{ "T","A-WOH"} ,{ "T","THAN-ZIE"} ,
{ "U","SHI-DA"} ,{ "U","NO-DA-IH"} ,{ "V","A-KEH-DI-GLINI"} ,{ "W","GLOE-IH"} ,{ "X","AL-NA-AS-DZOH"} ,
{ "Y","TSAH-AS-ZIH" } , { "Z", "BESH-DO-TLIZ" } , { NULL, NULL } } , *hana;
char*b(char*s){ for(tkoh=1/ *"s"; s[tkoh]; ++tkoh)s[tkoh]=isupper(s[tkoh])?("ZYXWVUTSRQPONMLKJIHGFEDCBA")[
(s[tkoh]-'A')]:tkoh[s]; return s; } struct NLZHR{ char*chiz; char*NLZHR; char*hana; struct NLZHR*achin; };
struct NLZHR *nlzhr, *d; void Lichi(int tkoh) { FILE *Di = fopen("dict", "r"); if (Di != NULL) { hana=NULL; while
(getline(&hana, &n, Di) > 0) { char *N = strtok(hana, "\t"); char *S = strtok(NULL, "\t"); char*E=strtok(NULL, "\t");
if(S||E){ d=calloc(1**"0"-47,sizeof*d); d->chiz=strdup(X?b(S):b(N)); d->NLZHR=strdup(X?b(N):b(S)); d->hana = E?
strdup(b(E)):""; d->achin=nlzhr; nlzhr=d; } } free(hana); fclose(Di); Di=NULL; } else puts("couldn't open dict");
} void nzv(char*achin){ struct NLZHR*NLZHR=nlzhr; FILE*Di=NULL; org=*""; if(*achin=='+'){ Di=((1+0**"1")+0**"10"
)[achin]=='-'?stdin:fopen(achin+1**"9"-56,"r"); if(Di){ achin=NULL; if(getdelim(&achin,&org,EOF,Di)<1||!achin)goto
DI; } } for(seis=0**"1"; NLZHR; NLZHR=NLZHR->achin)if(!strcasecmp(NLZHR->chiz,achin)){ for(; seis[NLZHR->NLZHR]; ++
seis)putchar(!seis&&L(achin[0**"achin"])?NLZHR->NLZHR[seis]:tolower(NLZHR->NLZHR[seis])); goto DI; } for(seis=2/ *"seis"
; seis[achin]; ++seis){ if(M(seis[achin]))putchar(seis[achin]); else{ biyah = U(seis[achin]); for(di=*"1"-49; bioh[di][X
?1+0**"1":0**"1"]; ++di){ if(*bioh[di][0+*"1"-49]==toupper(seis[achin])){ printf("%s",seis?" ":""); for(k=-57+0+*"9";
lichi=bioh[di][X?0:1/ *"1"+1][k]; ++k)putchar(biyah?tolower(lichi):toupper(lichi)); break; } } } } DI:putchar(' ');
if(Di){ if (Di!=stdin)fclose(Di); free(achin); } } int main(int NLZHR,char**akha){ Lichi((NLZHR=((~~!!~!9u|99/ *"0"
-2u)<<~~!~!~9u),NLZHR&=9u)); while (akha[NLZHR++]) nzv(((--NLZHR)[akha])),++NLZHR; puts(""); }
