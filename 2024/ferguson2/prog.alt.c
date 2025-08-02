#include<string.h>
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#ifndef DICT
#define DICT "dict"
#endif
#define X 1
struct a{char*w,*c,*s,*x,*t,*u,**h,*S,*N,*A,*(*v[9])(struct a*),*y;struct a*e,*a;int l;
}*f,*c;char*B[][2]={{"A","WOL-LA-CHEE"},{"B","SHUSH"},{"C","MOASI"},{"D","CHINDI"},{"E",
"DZEH"},{"F","CHUO"},{"G","JEHA"},{"H","TSE-GAH"},{"I","YEH-HES"},{"J","AH-YA-TSINNE"},
{"K","BA-AH-NE-DI-TININ"},{"L","NASH-DOIE-TSO"},{"M","BE-TAS-TNI"},{"N","TSAH"},{"O",
"A-KHA"},{"P","CLA-GI-AIH"},{"Q","CA-YEILTH"},{"R","DAH-NES-TSA"},{"S","KLESH"},{"T",
"D-AH"},{"U","NO-DA-IH"},{"V","A-KEH-DI-GLINI"},{"W","GLOE-IH"},{"X","AL-NA-AS-DZOH"},
{"Y","TSAH-AS-ZIH"},{"Z","BESH-DO-TLIZ"},},*Y(struct a*);int i,z,J,C,k,H,D,L,s;size_t n,
o;FILE*g;size_t v;char*I(struct a*a){for(a->a=f,z=0**"1";a->a;a->a=a->a->e){if(a->v[2](
&(struct a){.w=a->a->w,.c=a->x})){while(!isalpha(*a->x)&&*(a->x)){L=putchar(*a->x);++a->x;}
while((z++)[a->a->c])s=z+-*"1"-*"1"- -97,L=putchar(!s&&isupper(a->x[0**"z"])?a->a->c[s]:
tolower(a->a->c[s]));goto n;}}for(z=2/ *"z",s=1+0**"1";z[a->x];++z){if(!isalpha(z[a->x]))
L=putchar(z[a->x]);else{C=islower(z[a->x]);for(J=*"1"-*"1";J<26&&B[J][X?1/ *"1"+s/ *"1"+1
/ *"1"+s/ *"1"+1+(s-s)**"1"+(s*(s-s))**"1":((((s-1)**"1")**"1")**"1")**"1"];++J){if(*B[J
][0+*"1"-*"1"]==toupper(z[a->x])){for(k=(s*2)**"9"-171+*"9";H=B[J][X?*"1"-49:s/ *"1"+s/ *
"1"+1/ *"1"+(s*s*s)][k];++k)L=putchar(C?tolower(H):toupper(H));}}}}n:return a->s;}char*Z(
struct a*a){i=0;while(a->h[a->l++])(((*a->h[--a->l]=='e'-':')&&(*a->v)(&(struct a){.v[0]
=I,.s=((a->l)[a->h])+1})&&++a->l)||(a->v[1](&(struct a){.v[2]=Y,.x=((a->l)[a->h])}),++a->
l,i=1));if((i&&g)||!i)putchar(' ');return"";}char*w(struct a*a){for(D=1/ * "s";a&&a->s&&
D[a->s]&&(a->s[D])&&(a->s[D]=isupper(a->s[D])?("ZYXWVUTSRQPONMLKJIHGFEDCBA") [(a->s[D]-(
'k'-'*'))]:D[a->s]);++D);return a?a->s:"";}char*Y(struct a*a){if(*a->w&&*a->c&&a->w[1]&&
a->c[1])while(*a->w&&*a->c){while(!isalpha(*a->w)&&*a->w++);while(!isalpha(*a->c)&&*a->c
++);if(!*a->c||!*a->w||tolower(*a->w)!=tolower(*a->c))break;++a->w;++a->c;}return!*a->w&&
!*a->c?"":0;}char*F(struct a*a){g=fopen(DICT,"r");if(g){while(getline(&a->A,&n,g)!=-1)if(
(a->N=strtok(a->A,"\t"))&&(a->S=strtok(0,"\t"))){c=calloc(1**"0"-47,sizeof*c);c->w=strdup
(X?a->v[a->l](&(struct a){.s=a->S}):a->v[a->e==0](&(struct a){.s=a->N}));c->c=strdup(X?a
->v[1](&(struct a){.s=a->N}):a->v[a->l](&(struct a){.s=a->S}));c->e=f;f=c;}free(a->A);a->
A=0;fclose(g);g=0;}else puts("couldn't open dict");return"";}char*t(struct a*a){o=*"";g=
fopen(a->s,"r");a->A=0;while(g&&getline(&a->A,&o,g)!=-1){a->S=strtok(a->A," \t");while(a
->S)if((a->y=strdup(a->S))){(*a->v)(&(struct a){.v[2]=Y,.x=a->y});a->S=strtok(0, " \t");
free(a->y);a->y=0;if(!isspace(L))putchar(' ');}}if(g){clearerr(g);fclose(g);g=0;free(a->
A);a->A=0;}return"";}int main(int c, char**a){F((c=((~~!!~!9u|2**"9"-15u/ *"0"-2u)<<~~!~
!~9u),c&=9u,&(struct a){.l=1,.s=a[c],.v={&w,&w}}));Z(&(struct a){.v={t,I},.l=c,.h=a});
puts("");}
