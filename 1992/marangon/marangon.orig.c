#include <stdio.h>
#include <curses.h>

#define ST strchr
#define SRD srand48
#define RD lrand48

#define Q return
#define W wrefresh(r)
typedef int i;

#define Z(d,a) (RD()%((a)-(d)+1)+(d))
i f[3][3] = {15,52,36,20,-39,48,60,0,-25};

char z[6][6];
#define Y(x) (4*(x)+3)
#define X(x) (2*(x)+1)
#define I for
WINDOW *r=NULL;
#define K endwin()

char *g ="\
Use l-h-k-j for move.\nUse + for increment. Use - for decrement.\nUse Q to quit.";

i (*d())();
nt()
{
long time();
SRD(time((i *)0));
memset(z,5,36);
initscr();
cbreak();
noecho();
nonl();
if (COLS<80||LINES<24)
K,exit(1);
if (!(r=newwin(X(6),Y(6),
(LINES-X(6))/2,(COLS-Y(6))/2)))
K,exit(1);
mvaddstr(LINES-5,0,g);
refresh();
}
i ci()
{
i x,y=0;
I (;y<6;++y)
I(x=0;x<6;++x)
mvwaddch(r,X(y),Y(x),z[x][y]+'0'); Q(0);
}
void main()
{
char *ST();
i a=0,b=0,c,q,t,s,x,sc=0;
i(*(*p)())()=(nt(),d);
I(x=0 ; x++<20; )d(Z(0,5),Z(0,5),Z(1,2));
I(t=Z(0,2),q=s=0; q<3; s+=f[q][t]*f[q++][t]);
I(box(r,'|','-'),ci(),wmove(r,X(a),Y(b)),
W; (ST ("+-Qlkjh",(char)(c=wgetch(r))))&&
((i)((i)(q^=s%=Y(q),s/=2)!=(i)(s^=q)&&c&64&&(!(c&7|0)&&--b<0&&
(b=q^s)&0|| c&4&&++b==6&&c&4<(~b&23?q^=s,b^=b
:b&12?b=3:b|2)||c&2&&~c&1&&++a==++q/2+1&&c&16>(
!a|12?a=7,a&=~a:a|4?a=2:a&2)||~c&4&&c&
1&&--a<0&&(a+=6)&0)||~c&64&&(**p(b,a,~c))()||
c&16)?K,exit(0):1)||c; sc==36?ci(),W,K,exit(0):wmove(r,X(a),Y(b)),
W)
I(t=Z(0,2),q=s=0; q<3; s+=f[q][t]*f[q++][t])
I(sc=0; sc<36&&*((char *)z+sc++)==5; );
}
i (*d(a,b,c))()i a,b,c;
{
i x,y;
I(x=a>0?a-1:0; x<=(a<5?a+1:5); ++x)
I(y=b>0?b-1:0; y<=(b<5?b+1:5); ++y)
if(x==a&&y==b&&z[x][y]==(c&2?1:9)||z[x][y]==(c&2?9:1)&&(x!=a||y!=b))Q(ci);
I(x=a>0?a-1:0; x<=(a<5?a+1:5); x++)
I(y=b>0?b-1:0; y<=(b<5?b+1:5)&&(x==a&&y==b&&(z[x][y]+=(c&2?-1:1))||(z[x][y]+=(c&2?1:-1))); y++); Q(ci);
}
