#include <ctype.h>
#include <curses.h>
#define T isspace(*(t=Z(p)))&&
#define V return
#define _ while
int d,i,j,m,n,p,q,x,y;char*c,b[BUF],*f,*g=b,*h,k[]="hjklHJKL[]tbixWRQ",*t;
char*Z(a){if(a<0)V b;V b+a+(b+a<g?0:h-g);}P(a)char*a;{V
a-b-(a<h?0:h-g);}S(){p=0;}bf(){n=p=P(c);}Q(){q=1;}C(){clear();Y();}
G(){t=Z(p);_(t<g)*--h= *--g;_(h<t)*g++= *h++;p=P(h);}B(){_(!T b<t)--p;_(T
b<t)--p;}M(a){_(b<(t=Z(--a))&&*t-'\n');V
b<t?++a:0;}N(a){_((t=Z(a++))<c&&*t-'\n');V
t<c?a:P(c);}A(a,j){i=0;_((t=Z(a))<c&&*t-'\n'&&i<j){i+= *t-'\t'?1:8-(i&7);++a;}V
a;}L(){0<p&&--p;}R(){p<P(c)&&++p;}U(){p=A(M(M(p)-1),x);}
D(){p=A(N(p),x);}H(){p=M(p);}E(){p=N(p);L();}
J(){m=p=M(n-1);_(0<y--)D();n=P(c);}K(){j=d;_(0<--j)m=M(m-1),U();}
I(){G();_((j=getch())-'\f'){if(j-'\b')g-h&&(*g++=j-'\r'?j:'\n');else
b<g&&--g;p=P(h);Y();}}X(){G();p=h<c?P(++h):p;}
F(){j=p;p=0;G();write(i=creat(f,MODE),h,(int)(c-h));close(i);p=j;}W(){_(!T
t<c)++p;_(T
t<c)++p;}int(*z[])()={L,D,U,R,B,J,K,W,H,E,S,bf,I,X,F,C,Q,G};
Y(){m=p<m?M(p):m;if(n<=p){m=N(p);i=m-P(c)?d:d-2;_(0<i--)m=M(m-1);}
move(0,0);i=j=0;n=m;_(1){p-n||(y=i,x=j);t=Z(n);if(d<=i||c<=t)break;
if(*t-'\r')addch(*t),j+= *t-'\t'?1:8-(j&7);if(*t=='\n'||COLS<=j)
++i,j=0;++n;}clrtobot();++i<d&&mvaddstr(i,0,"<< EOF >>");move(y,x);
refresh();}main(u,v)char**v;{h=c=b+BUF;if(u<2)V
2;initscr();d=LINES;raw();noecho();idlok(stdscr,1);if(0<(i=open(f= *++v,0))){
g+=read(i,b,BUF);g=g<b?b:g;close(i);}S();_(!q){Y();i=0;j=getch();
_(k[i]&&j-k[i])++i;(*z[i])();}endwin();V 0;}
