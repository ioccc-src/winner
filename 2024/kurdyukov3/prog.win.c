#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <fcntl.h>
#define H h[c&7]
#define C(a,b) case a:b; break;
#define X(n,t,o) C(n,b=(t)c o(t)b)
#define Q(x) (QueryPerformance##x(&q),q.QuadPart)
#define R b=m[++d]; n=a&127; if(n){ if(n-1)b=m[b&k]+(n>2?n-65:0); \
	if(n-2){ n=b%4*8; b=b/4&k; b=m[b]>>n|m[b+1]*2<<~n%32; } } a>>=7;
#define Y(n,t,a,b,c,d)X(n,t,a)X(n+1,t,b)X(n+2,t,c)X(n+3,t,d)
#define O(n,t) Y(n,t,+,-,|,^)Y(n+4,t,&,*,/,%)\
	Y(n+8,t,<<,>>,==,!=)Y(n+12,t,<,<=,>,>=)
#define W(c) m[d]=(m[d]|n c)^(~b&n)c;

static int E=0; static LRESULT CALLBACK P(HWND a,UINT b,WPARAM c,LPARAM d){ E|=b
==2; ; return DefWindowProcA(a,b,c,d); } int main(int c,char**x){ void*f=c-->1?
fopen(x[1],"rb"):0,*h[8]={ stdin,stdout,stderr} ; unsigned y=0,z=0,a,b=0,d,n=0,k
=(1<<24)-1,*m=calloc(k+4,4); char s[33]={ 0} ; LARGE_INTEGER q; HWND W=0; HDC D=
0; MSG M; double F=1000.0/Q(Frequency); timeBeginPeriod(1); if(m&&f){ for(; b<=k
&&((a=fgetc(f))<256||(a=x[c][n++]&255)||(n=0,--c)); b++)m[b/4]|=a<<b%4*8; ; fcl\
ose(f); for(m[1]=b; ; ){ a=m[d=*m&k]; *m+=4; R c=b; R d=m[d+1]; switch(a>>9){ C(
1,b=H?c<0?fgetc(H):fputc(b,H):-1)C(2,b=Q(Counter)*F)C(3,Sleep(b))C(4,s[c&31]=b&&
b-48>9&&(b|32)-97>25&&b-46?95:b)C(5,b=!(H=H?fclose(H),f=0:fopen(s,b?"wb":"rb")))
C(6,b=H?c<0?ftell(H):fseek(H,(int)b,c/8):-1)case 7:if(!(W||~(-c&-b)>>12)){ WNDC\
LASSA C={ 0,P,0,0,0,0,0,0,0,s} ; RECT r={ 0,0,y=c,z=b} ; RegisterClassA(&C); n=1
<<31; AdjustWindowRect(&r,c=WS_CAPTION|WS_SYSMENU|WS_VISIBLE,0); D=GetDC(W=Crea\
teWindowExA(0,s,s,c,n,n,r.right-r.left,r.bottom-r.top,0,0,0,0)); } b=W?10:0; br\
eak; default:return a?1:c; C(8,b=E*3; if(!b)while(b=2,W&&PeekMessageA(&M,W,0,0,1
)){ b=M.message-512; if(b<11){ m[1]=M.lParam+(M.wParam&(b>9)<<30); b+=9; break;
} b=(b|4)+252; if(b<2){ m[1]=M.wParam; break; } DispatchMessageA(&M); } )case 9:
b&=k; if(W&&b+y*z<k){ int B[10]={ 40,y,-z,1<<21|1} ; SetDIBitsToDevice(D,0,0,y,z
,0,0,0,z,m+b,f=&B,0); SwapBuffers(D); } break; C(10,b=!b&&H?_setmode(_fileno(H),
O_BINARY):0)O(32,unsigned)O(48,int)O(64,unsigned short)O(80,short)O(96,unsigned
char)O(112,signed char)} n=a&127; if(n){ c=0; d=n>2?m[d&k]+n-65:d; d=(n-2?c=d%4*
8,d/4:d)&k; n=-1; n>>=a>>4&24; W(<<c)d++; if(c)W(>>(32-c))} else *m+=b?d:0; } }
return 1; } 
