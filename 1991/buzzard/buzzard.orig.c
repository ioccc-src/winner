#include <stdio.h>
#define X(s) (!(s&3)-((s&3)==2))
#define W while
char Z[82][82],A,B,f,g=26;z(q){return atoi(q);}m(d,l){return
Z[   B       +    X      (   f     +
3) * d+l *X(f+ 2 )][ A+X ( f ) * d +
l* X           (     f     + 3 ) ] ;}int
h= 0;D(p,s)char*s; {W(h>>3<p>> 3 ) {putchar('\t'
);           h =       (       h   +8
)&~7 ;}W(h < p ){putchar(' ');++h; }(void)printf(
"%s"   ,   s                 )     ;h+=strlen(s);}main(x,a)char **a; {
# define P(x) (x?(5-(x))*(6-(x ))/2:11)
int b; { char b[256],i,  j=0;  FILE*F;F=fopen(x-1?a[1]:"buzzard.c","r");W(
fgets( b ,256 ,F)){for(i=0;b[ i];++ i)
Z[j][i ] =( b [     i   ]     ==' '?1:2*(b[i]==(x>2?*a[2]:'\\')));++j;}fclose
(F);}A   =4 ; B = 3 ; f = 1;x >3? A=z(a[3]),B=z(a[4]):0;b='\n';do{if(b=='\n'
){int y ,     s , d , p   , q       ,i;for
(y=-11; y<= 11;++ y){ for(s = 1 ,d=0;s+3;s-=2){for
(;d!=2    +       3   * s     ;     d+=s){
if(m(d,0) !=1 ){p=P (d) ;if (abs( y )
   <p&&   !   m       (       d   , 0 )||abs(y)>p)break;for
(i  =-p;i<p;++i)D(g+i*2,"--");D(0,"\-");break;}if(d==5)continue;
p=P(d+1);q=P(d);if
(abs(y)		>q)continue;if 
(abs(y)		<p)D(g-s*(2*p+1),"|");else if(m(d,s)){if
(abs(y)		<=p)for(i=(s==1?-q:p);i!=(s==1?-p:q);
(abs(y)		),++i)D(g+2*i+(s==-1),"--");}else if
(abs(y)		==p)D(g-s*(2*p+1),"|");else D(g-
(abs(y)		*s*2),(s==1)^(y>0)?"\\":"/");}d-=s;}puts(
"");h=0;}}f+=(b=='r')-(b=='l');f&=3;if(b=='f'){if(!m(1,0))continue;
A+=X(f);B+=X(f-1);}}W((b=getchar())!=-1&&m(0,0)==1);return 0;}
