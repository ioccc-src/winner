#define C char
#define F X,perror("oops"),1
#define G getchar()
#define I ;if(
#define P putchar
#define Q 256
#define W ;while(
#define X return 0
#include<stdio.h>
long M,N,c,f,m,o,r,s,w;y(l){o^=l;m+=l+1;f=f*2+l+(f>>31&1);}int
O,S,e,i,k,n,q,t[69001];b(g){k=4 W g<k)y(P((C)(w>>--k*8)&255));w=0;}C D[Q*Q],h
[Q*Q];main(g,V)C**V;{I**V-97)X,a()W G-10)W(g=G)+1&&g-'x')if(g-10){I
4<k)b(0)I g>32&g<'v')w=w*85+g-33,++k;else{I
g-'z'|k)F;w=0;k=5;}}W G-78)I scanf("%ld%lx E%lx S%lx R%lx ",&M,&N,&c,&s,&r)-5)F
I M){b(g=3-(M-1&3))W g--)y(0);}I(M-N|c-o|s-m|r-f)&4294967295)F;X;}long
g(){C*p I m<f&n<k&&(m=(1L<<++n)-1)||O>=S){O=0;S=fread(D,1,n,stdin)*8 I
S<8)X-1;S-=n-1;}p=D+O/8;q=O&7;O+=n;X,(1<<8-q)-1&*p>>q|m&((15<n+q)*p[2]*Q|p[1]&
255)<<8-q;}a(){C*p=D+Q;G;G;k=G;e=k>>7&1;k&=31 I k>16)F;w=Q
W w--)t[w]=0,h[w]=w;n=8;f=Q+e;i=o=w=g()I o<0)X,1;P(i)W(w=g())+1){I
w==Q&e){W w--)t[w]=0;m=n=8;f=Q I(w=g())<0)X;}c=w
I w>=f)*p++=i,w=o W w>=Q)*p++=h[w],w=t[w];P(i=h[w])W
p>D+Q)P(*--p)I(w=f)<1L<<k)t[w]=o,h[f++]=i;o=c;}X;}
