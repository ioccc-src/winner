#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#define H h[c&7]
#define C(a,b) case a:b; break;
#define X(n,t,o) C(n,b=(t)c o(t)b)
#define R b=m[++d]; n=a&127; if(n){ if(n-1)b=m[b&k]+(n>2?n-65:0); \
if(n-2){ n=b%4*8; b=b/4&k; b=m[b]>>n|m[b+1]*2<<~n%32; } } a>>=7;
#define Y(n,t,a,b,c,d)X(n,t,a)X(n+1,t,b)X(n+2,t,c)X(n+3,t,d)
#define B(i,a,j) if(c==i){ m[1]=E.a.x|E.a.y<<14|E.a.j<<28; b
#define O(n,t) Y(n,t,+,-,|,^)Y(n+4,t,&,*,/,%)\
Y(n+8,t,<<,>>,==,!=)Y(n+12,t,<,<=,>,>=)
#define M(x) x##PressMask|x##ReleaseMask|
#define W(c) m[d]=(m[d]|n c)^(~b&n)c;

int main(int c,char**x){ void*f=c-->1?fopen(x[1],"rb"):0,*h[8]={ stdin,stdout,s\
tderr} ; unsigned y=0,z=0,a,b=0,d,n=0,k=(1<<24)-1,*m=calloc(k+4,4); struct time\
val t; char s[33]={ 0} ; Window W=0; GC G=0; Display*D=0; XEvent E; XImage*I=0;
Atom A=0; if(m&&f){ for(; b<=k&&((a=fgetc(f))<256||(a=x[c][n++]&255)||(n=0,--c))
; b++)m[b/4]|=a<<b%4*8; ; fclose(f); for(m[1]=b; ; ){ a=m[d=*m&k]; *m+=4; R c=b;
R d=m[d+1]; switch(a>>9){ default:I?I->data=0:0; return a?1:c; C(1,b=H?c<0?fgetc
(H):fputc(b,H):-1)C(2,gettimeofday(&t,0); b=t.tv_sec*1000+t.tv_usec/1000)C(3,t.
tv_sec=0; t.tv_usec=b*1000; select(0,0,0,0,&t))C(4,s[c&31]=b&&b-48>9&&(b|32)-97>
25&&b-46?95:b)C(5,b=!(H=H?fclose(H),f=0:fopen(s,b?"wb":"rb")))C(6,b=H?c<0?ftell(
H):fseek(H,(int)b,c/8):-1)C(7,if(!(I||~(-c&-b)>>12)){ XSizeHints h; h.flags=PMi\
nSize|PMaxSize; h.min_width=h.max_width=c; h.min_height=h.max_height=b; G=XDefa\
ultGC(D=XOpenDisplay(0),0); W=XCreateSimpleWindow(D,RootWindow(D,0),0,0,c,b,1,0,
0); XSetStandardProperties(D,W,s,0,0,0,0,&h); XSelectInput(D,W,M(Key)M(Button)P\
ointerMotionMask); A=XInternAtom(D,"WM_DELETE_WINDOW",0); XSetWMProtocols(D,W,&A
,1); XMapWindow(D,W); I=XCreateImage(D,DefaultVisual(D,0),24,ZPixmap,0,0,y=c,z=b
,32,0); } b=I?6:0)C(8,while(b=2,I&&XPending(D)){ XNextEvent(D,&E); c=E.type; if(
c-ClientMessage||*E.xclient.data.l-A){ b=c==KeyRelease; if(b||c==KeyPress){ m[1]
=XLookupKeysym(&E.xkey,0); break; } b=c==ButtonRelease; B(ButtonPress||b,xbutton
,button)+=4; break; } B(MotionNotify,xmotion,x)=6; break; } } else{ b=3; break;
} } )C(9,b&=k; if(I&&b+y*z<k){ I->data=f=m+b; XPutImage(D,W,G,I,0,0,0,0,y,z); X\
Sync(D,0); } )C(10,; )O(32,unsigned)O(48,int)O(64,unsigned short)O(80,short)O(96
,unsigned char)O(112,signed char)} n=a&127; if(n){ c=0; d=n>2?m[d&k]+n-65:d; d=(
n-2?c=d%4*8,d/4:d)&k; n=-1; n>>=a>>4&24; W(<<c)d++; if(c)W(>>(32-c))} else *m+=b
?d:0; } } return 1; }
