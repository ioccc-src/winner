#include <time.h>
#include <curses.h>
#define P(A,B,C,D,E) mvaddch(b+A,a+B,(q[y]&C)?D:E);
#define O(A,B,C) case A:if(q[x]&B)C;break;
#define R rand()
#define U 0,1,4,5
#define J(x) (1<<x)
#define V ' '


int r[27]                     ={0,J(0)
,2,1 ,3,J                     (2),5,U,
U,U,U,U},                     u[6]={-1
,7,49,-49,-7,1},q[343],x,y,d,l=342,a,b
,j='#';int main(){srand(time(0));for(x
=0;x<343;x++)q[x]=0;x=R%343;while(l){d
=r[R%27];if(((x%7==(x+u[d])%7)+(x/0x31
==(x+u[d]                     )/0x31)+
(((x/7)%7                     )==(((x+
u[d])/7)%                     7))==J(1
))&&(x+u[d]>=0)&&(x+u[d]<343)){if(!q[x
+u[d]]){q[x]+=J(d);x+=u[d];q[x]+=J(5-d
);l--;}else if(R<R/0x7){do{x=R%0x157;}
while(!q[x]);}}}x=294+R%0x31;initscr()
;noecho(                      );crmode
();clear                      (/*|*/);
refresh(                      );while(
x>0){move(J(0),60);printw("Level %d",(
x/0x31)+J(0)); q[x]|=J(J(3));for(y=(x/
0x31)*0x31;y<(J(0)+x/0x31)*0x31;y++)if
(q[y]&J(J(3))){a=J(0)+(3*((y/7)%7));b=
J(0)+(3*                      (y% 7));
mvaddch(                      J(1)+((y
%7)*3),J                      (1)+(((y



/7)%7)*3                      ),V);P(0
,0,0,0,j                      )P(3,0,0
,0,j)P(0,3,0,0,j)P(3,3,0,0,j)P(0,J(0),
J(0),V,j)P(0,J(1),J(0),V,j)P(J(0),3,J(
1),V,j)P(J(1),3,J(1),V,j)P(J(1),J(0),4
,'U',V)P(J(1),J(1),J(3),'D',V)P(J(0),0
,J(4),V,                      j)P(J(1)
,0,J(4),                      V,j)P(3,
J(0),J(5                      ),V,j)P(
3,J(1),J(                    5),V, j)}
 mvaddch(J                  (1)+((x%7
  )*3),J(1)                +(((x/7)%
   7)*3),'@')            ;refresh()
    ;switch(getchar()){O('k',J(0),
      x--)O('j',J(5),x++)O('l',J
        (1),x+=J(3)-J(0))O('h'
          ,J(4),x-=7)O('u',4


,(x+=49,    clear()))O('d',8,(x-=49,clear
()))case   'q':x=-1;break;}}clear();refresh
(/*v*/);   nocrmode ();echo();endwin();if(!
x)printf    ("You Escaped!\n");exit(0);}
