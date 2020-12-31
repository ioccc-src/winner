#include <stdlib.h>
#include <curses.h>
#include <time.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#define F(x,y,w,h,c) G(c),XFillRectangle(A,B,D,x,y,w,h),G(3)
#define G(c) XSetForeground(A,D,C[c].pixel)
#define H(d) addch(y?y-e?ACS_VLINE:ACS_L##d:ACS_U##d)
#define I(i,c) init_pair(i,COLOR_##c,COLOR_##c)
#define J(a,b) j==X[(int[]){ KEY_##b,XK_##a} ]
#define K(q,r,s,t,u,v,w) (q=!!(w)*z[p v]>>8,(1<<(3*!!((((r)>>t)^(s))&u)))*!!q)
#define L z[p=rand()&63]

int c[9],e,f,g,               h,i,j,k,l,m,n,q               ,r,s,t,u,v,w,x,
y,X, z[64]; GC                D; Display * A;               Window B;  char
o[]="tdpsf\73!"               "&e!&e!&e\1",*Y               =o,b[64];XColor
C[8]; XEvent E;               int  R  (  )  {               XDrawString(A,B
,D,348,58, b, e               ); XNextEvent (               A, &E);  return
XLookupKeysym(&               E.xkey,0)*! (E.               type^KeyPress);
} void P(){ g =               DefaultScreen((               A=XOpenDisplay(
               0 ) ) ) ;   do                XAllocNamedColor
               (    A       ,                DefaultColormap(
               A,g),5*x+"#fff"               "\0#f00\0#0f0\0"
               "#000",C+x,C+4)               ; while(++x^4) ;
               XMapWindow(A,B=              XCreateSimpleWindow
               (A,RootWindow(A               ,g),0,0,460,300
               ,0, C[3].pixel,               C->pixel ) )  ;
XSelectInput(A,               B,KeyPressMask|               ExposureMask);D
=XCreateGC(A,B,               0,0); } void a(               ){ for(y=0; y<=
e; y++)if(X)for               (x=k; y%3==0&&y               ^e&&x<k+t; x+=6
)XDrawRectangle               (A,B,D,3+6*x,6+               12 *y, 36, 36);
else{ move(y,k)               ; H(LCORNER ) ;               for(x=0; ++x^t;
)addch(x%6?y%3?               32:ACS_HLINE: y               &&y-e?ACS_VLINE
: ACS_HLINE)  ;               H(RCORNER); } }               void  Q  ( )  {
               initscr ( )   ;               start_color( );
               keypad(stdscr,1               ); curs_set(0);
               I(1, RED); I(2,               GREEN ) ; I(3 ,
               WHITE); } void                d(){ for(k=!x ;
               k^t; X?F(u,v,6,               12,i):mvaddch(v
               ,u,32|COLOR_PAIR              (i))){ u=X+(1+5
               *X)*(x+((i=~e?!               !e*((((e-1)>>k)
&1)+1):3)>2?4:1               )*(k/2)); v=X+(               1+11*X)*(1+3*y+
k++%2); } } int               S(){ mvaddstr(t               ,58,b); refresh
();return getch               (); } int main(               int p,char**V){
((X=*++V&&**V==               88)?P:Q)(); for               (srand(time(0))
; ( *Y++)--; );               for(f=++n; k^64               ; !L&&(z[p]=++k
)); L|=*z<<8; g               =p&7; h = p /8;               for(--l; j^113;
J(Up,UP) ? m?h?               h--:1:w?w--:i:J               (Down,DOWN)?m?h
               ^7?h++: r :w^7?               w++:l: J( Left,
               LEFT)?m?g?g--:3               : 7 : J (Right,
               RIGHT)?m ? g^7?               g++:9:s:j==10||
               J(Return,ENTER)               ?m?z[p=8*h+g]>>
               8?m--:((((r=K(x               ,x-1,l,t,3,-1,g
               )+K(y,l,y-1,t,3               ,+1,g^7)+K(i,i-
               1,l,1,21,-8,h)+               K(e,l,e-1,1,21,
+8,h^7))+3)&~3)               ==k)?z[p]|= ++l               <<8,c[w]=0, l=~
--m, s += r * (               ")%##!!!!"[--q]               -33),f++:m:c[w]
?l=c[w]-!m++:n^               64?c[w]=z[n++]&               127,q++:X:k){ p
=k=X&&!(F(0, 0,               460,300,0)); t=               48; e=24; a( );
k=t+2; t/=8; a(               ); e=3; k+=8; a               (); for(; p^64;
j^7?(void)j:d()               ){ x=2+t*(j=p%8               ); y=p/8; e=z[p
++]>>8; d( ); x               +=8; e =c[y]; }               x+=8; y=0; e=l+

1; d() ; x+=m*(t*g-50)-9; y=m?h:w; t-=2; e=-1; d(); e=sprintf(b,o,s,f,(f*s)
                 >>6); j=(X?R:S)(); } return X||endwin(); }
