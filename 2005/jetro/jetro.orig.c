#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "SDL.h"

#define X2(a) a a
#define X4(a) a a a a
#define S1(a,b,c) #a".."#b".."#c"."
#define S14(a,b,c) X4(S1(a,b,c))
#define S2(a) #a"."#a"....."
#define S24(a) X4(S2(a))
#define S4(a) #a#a#a#a
#define S3(a,b,c) S1(a,b,c)S4(..)
#define SE X4(X4(S4(..)))

char l[]=SE SE X2(S3(J,H,M)S3(J,H,E)S3(F,E,A)S3(F,E,J)S3(H,E,O)S3(H,E,C)S3(H,F,
x)S3(H,F,L)),b[]=SE X2(S4(j.jv.j.v)S4(f.fr.f.r)S4(e.eq.e.q)S4(h.ht.h.t))SE,*r[3
]={S14(v,v,q)S14(r,r,m)S14(q,q,l)S14(t,t,o),S24(J)S24(F)S24(E)S24(H),S24(M)S24(
J)S24(H)S24(L)};

#define B int
#define C double
#define S static
#define I(a,b,c,d,f,g) a=(f-d)/10.,b=1e-2*(d*(28-g)-f),c=1e-2*(d*f-8*g/3);\
d+=a,f+=b,g+=c;
S C T;typedef float A;S B D,R,U,p=0;S A F[5][0100000]={{0},{0}};

void AA(void*u,Uint8*_,B L){u=u;while(L>0){B M=p&037777,s=p>>12,u=(s%R)[
l],J=(s%U)[b],w=0,a=0,n;A v,q,m,E=(0x2000-(p&017777))/8192e0f;v=q=0;
#define EF_(x) F[w][1638##x+M
#define EF(l,s,ms) ((s*ms+EF_(4)-l]*(1-ms))/2.f+EF_(3)]/2.f)
#define FQ(s) (A)sin((0.12*pow(2,n/12.))*p*s)
#define IZ(v,c) v*=v c?v:0;
#define BF F[w][M]=F[w][M+16384]=q;v+=q;++w
#define IP(n,x,y,z,c) if(n!=46){x}q=EF(y,q,z);c;BF;
#define IS(s,c) if(q c s 0.75f)q=s 0.75f;
#define NQ(x,a,m) n=x-(x>=97?121:65)+a;q=FQ(m);
IP(u,NQ(u,12,1)m=FQ(1.01f);IZ(q,>6e-1)IZ(m,>6e-1)q+=m;q*=5e-1f*(E+1);,12288,
0.2f,;)for(;a<3;++a){char sn=(s%D)[a[r]];q=0;IP(sn,NQ(sn,12,0.25f)IZ(q,<0.3),
12288,0.2f,;)}q=0;IP(J,NQ(J,0,1/8.f)X4(q*=q;)q=(A)fmod(q*20,4)*4;,6144,0.25f,IS
(-,<)IS(+,>)q*=E)v*=0.6f;*(Sint16*)_=(Sint16)(v*32767);_++,++_,++p,--L,L--;}}

B main(B c,char**a){SDL_AudioSpec f,d;c=c,a=a;D=strlen((!!c&24)[r]),R=strlen(l)
,U=strlen(b);if(SDL_Init(16)<0)exit(1);atexit(SDL_Quit);f.freq=22050,f.format=\
AUDIO_S16,f.channels=1,f.samples=4096,f.callback=AA,f.userdata=0;if(SDL_OpenAu\
dio(&f,&d)<0)exit(2);T=0;SDL_PauseAudio(0);getchar();SDL_CloseAu\
dio();return 0;}
