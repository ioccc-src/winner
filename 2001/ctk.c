#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <signal.h>
#define m(b)a=b;z=*a;while(*++a){y=*a;*a=z;z=y;}
#define h(u)G=u<<3;printf("\e[%uq",l[u])
#define c(n,s)case n:s;continue
char x[]="((((((((((((((((((((((",w[]=
"\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b";char r[]={92,124,47},l[]={2,3,1
,0};char*T[]={"  |","  |","%\\|/%"," %%%",""};char d=1,p=40,o=40,k=0,*a,y,z,g=
-1,G,X,**P=&T[4],f=0;unsigned int s=0;void u(int i){int n;printf(
"\233;%uH\233L%c\233;%uH%c\233;%uH%s\23322;%uH@\23323;%uH \n",*x-*w,r[d],*x+*w
,r[d],X,*P,p+=k,o);if(abs(p-x[21])>=w[21])exit(0);if(g!=G){struct itimerval t=
{0,0,0,0};g+=((g<G)<<1)-1;t.it_interval.tv_usec=t.it_value.tv_usec=72000/((g>>
3)+1);setitimer(0,&t,0);f&&printf("\e[10;%u]",g+24);}f&&putchar(7);s+=(9-w[21]
)*((g>>3)+1);o=p;m(x);m(w);(n=rand())&255||--*w||++*w;if(!(**P&&P++||n&7936)){
while(abs((X=rand()%76)-*x+2)-*w<6);++X;P=T;}(n=rand()&31)<3&&(d=n);!d&&--*x<=
*w&&(++*x,++d)||d==2&&++*x+*w>79&&(--*x,--d);signal(i,u);}void e(){signal(14,
SIG_IGN);printf("\e[0q\ecScore: %u\n",s);system("stty echo -cbreak");}int main
(int C,char**V){atexit(e);(C<2||*V[1]!=113)&&(f=(C=*(int*)getenv("TERM"))==(
int)0x756E696C||C==(int)0x6C696E75);srand(getpid());system("stty -echo cbreak"
);h(0);u(14);for(;;)switch(getchar()){case 113:return 0;case 91:case 98:c(44,k
=-1);case 32:case 110:c(46,k=0);case 93:case 109:c(47,k=1);c(49,h(0));c(50,h(1
));c(51,h(2));c(52,h(3));}}
