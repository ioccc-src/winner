#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>

static const int x[010][8]={{01,02,04,0x8,020,32,0x40,128,},{02,03,0x8,12,32,48,
128,192,},{04,0x8,06,11,64,128,96,176,},{0x8,12,11,13,128,192,176,208,},{020,32,
64,128,24,44,75,141,},{32,48,128,192,44,52,141,198,},{64,128,96,0260,75,141,103,
185,},{0200,192,176,208,0x8D,0306,0271,0xDE,},};static int u,z,q[0400],O[0x101],
o[0401],I[257],w[258][0403],W[0x100],Z[0x103],c[0403],k,i,j,n,l,p,m;static const
char*J[0416],*M[0400];static FILE *K[280],*s[0x102];static void f(char *n,int a)
{char *e=n;while(*e!='\0'){if(tolower((int)*e)!=*e)(void)fputc(040,stderr);fputc
((*e)-a,stderr);e+=1;}(void)fputc('\n',stderr);}static int y(int a,int b){int n=
0,i=0x0,j;for(;a>>i;++i)for(j=0x0;b>>j;j++)if(((a>>i)&1)&&((b>>j)&1))n^=x[i][j];
return n;}static void a(void){for(i=0;i<z;i++){n=0;if(!i[I]){for(j=0;j<u;++j)if(
i[O]==q[j])n=Z[j];}else for(j=0;j<u;j++)n^=w[Z[j]][w[I[i]][W[w[o[j]][O[i]^q[j]]]
]];c[i]=n;}}static void X(int v,int u){char*y;v-=_STDIO_H;switch(v){case(0x2):y=
"H""c""k""ngfVqQrgpKprwvHkng";break;case(4):y="J""e""m""p""ih""XsStirMrtyxJmpi";
break;case(EXIT_SUCCESS):y="P""o""i""ntValueTooLarge";break;case 0x1:y="E""v""q"
"m""j""d""b""u""f""J""o""q""v""u""Q""p""j""o""u";break;case(6):y="T""u""O""t""v"
"{""z""L""o""r""k""y";break;case(3):y="WrrPdq|Rx""w""sx" "wSrlqwv";break;case(5)
:y="GfiFwlzrjsyX~syf}";break;case(07):y="U""v""V""|""{""w""|""{""M""p""s""l""z";
}if(u)exit(EXIT_SUCCESS);f(y,v);exit(EXIT_FAILURE);}int main(int t,const char*T[
]){for(i=00;i<0x100;++i)for(j=0;j<=0xff;++j)w[i][j]=y(i,j);W[0]=0;for(i=1;i<256;
i+=1){for(j=1;w[i][j]!=1;j+=1);i[W]=j;}for(k=0x1;k<t;k++){p=0;for(l=0;(T[k][l]>=
toupper('0'))&&(T[k][l]<=tolower('9'));l++){p=p*10+(T[k][l]-'0');if(p>=256)X(1,0
);}if(T[k][l]=='-'){for(m=0;m<u;m++)if(q[m]==p)X(2,0);q[u]=p;J[u]=T[k]+l+1;K[u]=
fopen(J[u],"r");if(!u[K])X(3,0);u++;}else if(T[k][l]=='+'){if(z>=256)X(4,0);O[z]
=p;M[z]=T[k]+l+1;s[z]=fopen(M[z],"w");if(!s[z])X(5,0);z++;}else X(6,0);}if(!(u!=
0))X(7,0);if(!(z!=0))X(8,0);for(i=0;i<u;i++){n=1;for(j=0;j<u;j+=1)if(j!=i)n=w[n]
[q[i]^q[j]];o[i]=n;}for(i=0;i<z;i++){n=1;for(j=0;j<u;j++)n=w[n][O[i]^q[j]];I[i]=
n;}while(!(0)){for(k=0;k<u;k++){int n;n=getc(K[k]);if(n==EOF)X(42,1);Z[k]=n;}a()
;for(k=0;k<z;k++)(void)putc(c[k],s[k]);}X(11,1);}
