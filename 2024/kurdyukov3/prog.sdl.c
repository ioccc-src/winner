#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#ifdef _WIN32
#include <fcntl.h>
#else
#define _setmode(a,b) 0
#endif
#if SDL_MAJOR_VERSION == 2
#define V(a,b) b
#else
#define V(a,b) a
#endif
#define H h[c&7]
#define C(a,b) case a:b; break;
#define X(n,t,o) C(n,b=(t)c o(t)b)
#define R b=m[++d]; n=a&127; if(n){ if(n-1)b=m[b&k]+(n>2?n-65:0); \
if(n-2){ n=b%4*8; b=b/4&k; b=m[b]>>n|m[b+1]*2<<~n%32; } } a>>=7;
#define Y(n,t,a,b,c,d)X(n,t,a)X(n+1,t,b)X(n+2,t,c)X(n+3,t,d)
#define O(n,t) Y(n,t,+,-,|,^)Y(n+4,t,&,*,/,%)\
Y(n+8,t,<<,>>,==,!=)Y(n+12,t,<,<=,>,>=)
#define B(i,a,j) if(c==i){ m[1]=E.a.x|E.a.y<<14|E.a.j<<28; b
#define W(c) m[d]=(m[d]|n c)^(~b&n)c;

int main(int c,char**x){ void*f=c-->1?fopen(x[1],"rb"):0,*h[8]={ stdin,stdout,s\
tderr} ; unsigned y=0,z=0,a,b=0,d,n=0,k=(1<<24)-1,*m=calloc(k+4,4); char s[33]={
0} ; SDL_Surface*S=0; SDL_Event E; V(; ,SDL_Window*W=0); if(m&&f){ for(; b<=k&&(
(a=fgetc(f))<256||(a=x[c][n++]&255)||(n=0,--c)); b++)m[b/4]|=a<<b%4*8; ; fclose(
f); for(m[1]=b; ; ){ a=m[d=*m&k]; *m+=4; R c=b; R d=m[d+1]; switch(a>>9){ defau\
lt:d=(*m-4)&k; if(S)SDL_Quit(); return a?1:c; C(1,b=H?c<0?fgetc(H):fputc(b,H):-1
)C(2,b=SDL_GetTicks())C(3,SDL_Delay(b))C(4,s[c&31]=b&&b-48>9&&(b|32)-97>25&&b-46
?95:b)C(5,b=!(H=H?fclose(H),f=0:fopen(s,b?"wb":"rb")))C(6,b=H?c<0?ftell(H):fseek
(H,(int)b,c/8):-1)C(7,if(!(S||~(-c&-b)>>12)){ SDL_Init(SDL_INIT_VIDEO); V(S=SDL\
_SetVideoMode(y=c,z=b,32,SDL_SWSURFACE); SDL_WM_SetCaption(s,0),n=SDL_WINDOWPOS\
_UNDEFINED; S=SDL_GetWindowSurface(W=SDL_CreateWindow(s,n,n,y=c,z=b,0))); } b=S?
V(12,16)+(S->format->Rmask*513>>24&3):0)C(8,while(b=2,S&&SDL_PollEvent(&E)){ c=E
.type; b=c==SDL_KEYUP; if(b||c==SDL_KEYDOWN){ m[1]=E.key.keysym.sym; break; } b=
c==SDL_MOUSEBUTTONUP; B(SDL_MOUSEBUTTONDOWN||b,button,button)+=4; break; } B(SD\
L_MOUSEMOTION,motion,x)=6; break; } if(c==SDL_QUIT){ b=3; break; } } )C(9,b&=k;
if(S&&b+y*z<k){ for(n=0; n<z; n++)memcpy((char*)S->pixels+n*S->pitch,m+b+n*y,y*4
); V(SDL_Flip(S),SDL_UpdateWindowSurface(W)); } )C(10,b=!b&&H?_setmode(_fileno(H
),O_BINARY):0)O(32,unsigned)O(48,int)O(64,unsigned short)O(80,short)O(96,unsign\
ed char)O(112,signed char)} n=a&127; if(n){ c=0; d=n>2?m[d&k]+n-65:d; d=(n-2?c=d
%4*8,d/4:d)&k; n=-1; n>>=a>>4&24; W(<<c)d++; if(c)W(>>(32-c))} else *m+=b?d:0; }
 } return 1; }
