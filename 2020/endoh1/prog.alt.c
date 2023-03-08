                               #include/**/<time.h>
                               #include <ncurses.h>
                               # include <stdlib.h>
             /**               */#define O()for(y-=               !!\
           y;y<H&&           /*semi-automatic----*/y<           p/W+2;\
         y++)for(x=p%   W,x-=!!/*-----minesweeper*/x;x<W&&   x<p%W+2;x++)
       #define _(x)COLOR_##x/*IOCCC2019IOCCC2019IOCCC2019IOCCC2019IOCCC20*/
     #define Y(n)attrset(COLOR_PAIR(n)),mvprintw/*IOCCC2019IOCCC2019IOCCC20*/
   int*M,W,H,S,C,E,X,T,c,p,q,i,j,k;char G[]=" x",U[256];int F(int p){int r=0,x,
      y=p/W,q;O()q=y*W+x,r+=M[q]^=p-q?(M[q]&16)<<8:0;return r;}int K( int p,
         int f,int g){int        x=(g+f/256)%16-(f+g/256)%16,y=p/W,c=0,n=
          g/4096,m=x==n             ?0:x==g/16%16-f/16%16-n?256:-1;if(m+
         1)O()if((M[n=               y*W+x]&4368)==4112)M[n]=(M[n]&~16)|m
        ,c++;return c;               }void D(){int p,k,o=0,n=C;if(LINES-1<
       H||COLS/2<W)/*|               */clear(),Y(4)(LINES/2,COLS/2-16,"Mak\
e the terminal window "             "bigger!");else{for(p=0;p<S;o+=k==3,Y(k)(p/W+1
,p%W*2,G),p++)G[1]="_*!.."       "12345678"[k=E?M[p]&256?n--,2:E-2||M[p]%2<1?M[p]&
16?3:4+F(p)%16:1:3];k=T+time(0);T=o||T>=0||E-1?T:k;k=T<0?k:T;Y(7)(0,0,"%03d%*s%03\
d",n>999?999:n,W*2-6,"",k>999?999:k);Y(9)(0,W-1,E>1?"X-(":E-1||o?":-)":"[-)");}re\
fresh();}int main(int A,char**V){short B[]={_(RED),_(BLACK),_(WHITE),_(BLUE),_(GR\
EEN),_(RED),_(MAGENTA),_(YELLOW),_(CYAN)};MEVENT e;FILE*f;srand(time(0));initscr()
;for(start_color();X<12;X++)init_pair(X+1,B[X&&X<10?X-1:2],B[X?X<3?2:1:0]);noecho(
);cbreak();timeout(9);curs_set(0);keypad(stdscr,TRUE);for(mousemask(BUTTON1_CLICK\
ED|BUTTON1_RELEASED,0);;){if(A-->1){f=fopen(V[A],"r");fscanf(f,"%d %d %d",&W,&H,&C
       );}else{f=0;W=COLS/2;H=LINES-1;C=W*H/5;}S=W*H;M=realloc(M,S*2*sizeof
        (int));for(i=0;i<S;i++)!f?M[i]=i:fscanf(f,"%d",M+i);for(i=0;!f&&i<
         S;i++)k=M[j=i+rand()%(S-i)],M[j]=M[i],M[i]=k;if(f)fclose(f);T=E=
          X=0;for(clear();D(),c=getch(),c-'r'&&(c-KEY_RESIZE||E);){if (c
         =='q')return(endwin(),0);if(c==KEY_MOUSE&&getmouse(&e)==OK&&e.x/
      2<W&&e.y<=H){if(!e.y&&(W-2<e.x&&e.x<W+2))break;p=e.x/2+e.y*W-W;if(p>=0
   ){if(!E){for(i=0;i<S;i++)M[S+M[i]]=i,M[i]=16+(M[i]<C);C-=M[p]&1;M[p]=16;E=1;
     T=-time(0);}if(E<2)M[p]&=(M[p]&257)==1?T+=time(0),E=2,273:257;}}for(p=0;
       p<S&&E==1;)M[p++]&=273;for(i=(X+S-1)%S;E==1&&i!=X;X=(X+1)%S){if(!(M[
         p=M[X+S]]&272   )){if(K(p,c=F(p),0))goto N;for(k   =p/W-2,k=k<0?
           0:k;k<H          &&k<p/W+3;k++)for(j=p%W-2           ,j=j<0?
             0:j               ;j<W&&j<p%W+3;j++)if               (!(
                               M[q=j+k*W]&272)){if(
                               K(p,c,F(q)))goto N;F
                               (q);}F(p);}}N:;}}}
