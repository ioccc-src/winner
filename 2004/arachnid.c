#include <ncurses.h>/*****************************************************/
            int               m[256                   ] [         256   ],a
 ,b   ;;;   ;;;   WINDOW*w;   char*l=""   "\176qxl"   "q"   "q"   "k"   "w\
xm"   "x"   "t"         "j"         "v"         "u"         "n"         ,Q[
 ]=   "Z"   "pt!ftd`"   "qdc!`eu"   "dq!$c!nnwf"/**   ***   */"t\040\t";c(
int   u ,         int         v){                     v?m   [u]         [v-
 1]   |=2,m[u][v-1] &   48?W][v-1   ] &   15]]):0:0;u?m[u   -1][v]|=1   ,m[
 u-               1][   v]&         48?               W-1   ][v         ]&
15]   ]):0:0;v<   255   ?m[   u][v+1]|=8,m[u][v+1]&   48?   W][   v+1]&15]]
):0         :0;         u <               255   ?m[   u+1         ][v   ]|=
4,m[u+1][   v]&48?W+1][v]&15]]):0:0;W][   v]&   15]   ]);}cu(char*q){   return
 *q               ?cu   (q+         1)&         1?q   [0]               ++:
q[0   ]--   :1;   }d(   int   u ,   int/**/v,   int/**/x,   int   y){   int
Y=y   -v,   X=x         -u;   int         S,s   ;Y<         0?Y   =-Y   ,s,
s=-   1:(   s=1);X<0?X=-X,S   =-1  :(S=   1);   Y<<=   1;X<<=1;   if(X>Y){
int   f=Y               -(X   >>1   );;               while(u!=         x){
f>=   0?v+=s,f-=X:0;u   +=S   ;f+=   Y;m[u][v]|=32;mvwaddch(w,v   ,u,   m[u
 ][               v]&   64?   60:         46)         ;if         (m[   u][
v]&16){c(u,v);;   ;;;   ;;;   return;}}   }else{int   f=X   -(Y>>1);;   while
 (v   !=y         ){f   >=0         ?u   +=S,               f-=         Y:0
 ;v   +=s   ;f+=X;m[u][v]|=   32;mvwaddch(w,v   ,u,m[u][v]&64?60:46);if(m[u
 ][                     v]&         16)   {c(   u,v                     );
  ;   return;;;}}}}Z(   int/**/a,   int   b){   }e(   int/**/y,int/**/  x){
int               i ;         for         (i=         a;i               <=a
+S;i++)d(y,x,i,b),d(y,x,i,b+L);for(i=b;i<=b+L;i++)d(y,x,a,i),d(y,x,a+   S,i
 );                     ;;;         ;;;         ;;;               ;;;   ;
  mvwaddch(w,x,y,64);   ;;;   ;;;   ;;;   prefresh(   w,b,a,0,0   ,L-   1,S-1
);}             main(         int               V ,   char              *C[
  ]   ){FILE*f=   fopen(V==1?"arachnid.c"/**/   :C[   1],"r");int/**/x,y,c,
v=0         ;;;      initscr              ();               Z(Z         (raw
 ()   ,Z(   curs_set(0),Z(1   ,noecho()))),keypad(    stdscr,TRUE));w   =newpad
  (   300,  300               ) ;   for         (x=   255   ; x   >=0   ;x--
  )   for   (y=   255   ;y>=0;y--   )m[   x][   y]=   0;x=y=0;refresh( );while
  (   (c=                           fgetc (f)   )+1)                    {if(
0||c==10||  x==   256){x=0;y++;if(y==256  )break;;}   else{m[x][y]=(c   ==
'~'   ?64   : c   ==32              ?0:         16)   ;;x               ++;
      }}for(x=0   ;x<   256;x++)m   [x][0]=16   ,m[   x][   255]=16;for(y=0
;y<         256   ; y         ++)   m[0         ][y   ] =               16,
m[255][y]   =16   ;a=b=c=0;   x=y   =1;   do{v++;mvwaddch   (w,   y,x   ,m[
x][         y]&               32?   m[x                     ][y   ] &   16?
 0|   acs_map[l[m[x][y]&15]]:46 :   32);c==0163&&!(m[x][y+1]&16)?y++:   0;c
 ==   119         &&!         (m[                                       x][
 y-   1]&   16)   ?y--:0;;c   ==97  &&!(m[x-1][y]&16)?x--:0;c==100&&!(m[x+1
 ][   y]&   16)         ? x   ++:0              ;if(                    c==
 3-   1+1   ){endwin(   );;   return(0)   ;}x   -a<5?a>S-   5?a-=S-5:(a=0):
0;x               -a>         S-5?a<255   -S*         2?a               +=S
-5:(a=256-S):0;   y-b<5?b>L-5?b-=L-5:(b   =0)   :0;   y-b>L-5?b<255-L   *2?
b+=                                       L-5   :(b                     =256
-L)   :0;e(x,y);if(m[x][y]&64)break;}while((c=getch())!=-1);endwin();cu(Q);
printf(Q,v);}

