#include <unistd.h>
#include <curses.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <sys/time.h>

#define o0(M,W) mvprintw(W,M?M-1:M,"%s%s ",M?" ":"",_)
#define O0(M,W) M##M=(M+=W##M)-W##M
#define l1(M,W) M.tv_##W##sec
#define L1(m,M,l,L,o,O) for(L=l;L--;)((char*)(m))[o]=((char*)(M))[O]
#define I1 lL,(struct sockaddr*)&il
#define i1 COLS
#define j LINES
#define L_ ((j%2)?j:j-1)

fd_set I;struct socka\
ddr_in il;struct host\
ent*LI; struct timeval
IL,l;char L[9],_[1<<9]
   ;void ___(int __
   ){_[__--]=+0;if(
   ++__)___(--__);_
   [__]='=';}double
   o,oo=+0,Oo=+0.2;
   long O,OO=0,oO=1
   ,ii,iI,Ii,Ll,lL,
   II=sizeof(il),Il
   ,ll,LL=0,i=0,li,
   lI;int main(int\
   iL,char *Li[]){\
   initscr();cbreak
   ();noecho();nonl
   ();___(lI=i1/4);
   _[0]='[';_[lI-1]
   =']';L1(&il,&_,\
   II,O,+O,+lI);il.
   sin_port=htons((
   unsigned long)(\
   PORT&0xffff));lL
   =l_;if(iL=!--iL)
   {il. sin_addr .\
   s_addr=0;bind(I1
   ,II);listen(lL,5
   );lL=accept(I1,&
   II);}else{oO-=2;
   LI=gethostbyname
   (Li[1]);L1(&(il.
   sin_addr),(*LI).
   h_addr_list[0],\
   LI->h_length,iI,
   iI,iI);(*(&il)).
   sin_family=(&(*\
   LI))->h_addrtype
   ;connect(I1,II);
   }ii=Ii=(o=i1*0.5
   )-lI/2;iI=L_-1;O
   =li=L_*0.5;while
   (_){mvaddch(+OO,
   oo,' ');o0(ii,iI
   );o0(Ii,Il-=Il);
   mvprintw(li-1,Il
   ,"%d\n\n%d",i,LL
   );mvhline(li,+0,
   '-',i1);mvaddch(
   O,o,'*');move(li
   ,Il);refresh();\
   timeout(+SPEED);
   gettimeofday(&IL
   ,+0);Ll=getch();
   timeout(0);while
   (getch()!=ERR);\
   if(Ll=='q'&&iL)\
   write(lL,_+1,1);
   if(ii>(ll=0)&&Ll
   ==','){write(lL,
   _,-(--Il));}else
   if(Ll=='.'&&ii+\
   lI<i1){write(lL,
   _+lI,++Il);}else
   if(iL||!Il)write
   (lL,_+lI-1,4-3);
   gettimeofday(&l,
   0);II=((II=l1(IL
   ,)+(l1(l,u)-=l1(
   IL,u))-l1(l,)+(\
   l1(l,)-=l1(IL,))
   )<0)?1+II-l1(l,)
   +1e6+(--l1(l,)):
   II;usleep((II+=\
   l1(l,)*1e6-SPEED
   *1e3)<0?-II:+0);
   if(Ll=='q'&&!iL)
   break;FD_ZERO(&I
   );FD_SET(lL,&I);
   memset(&*&IL,ll,
   sizeof(l));if((\
   Ll=select(lL+1,&
   I,0,0,&IL)));{if
   (read(lL,&L,ll+1
   )){if(!*L){ll++;
   }else if(*L==ll[
   _]){ll--; }else\
   if(*(&(*L))==1[_
   ]){break;}}else{
   break;}}O0(o,O);
   O0(O,o);if(o<0){
   o*=-1;Oo*=-1;}if
   (o>i1){o=i1+i1-o
   ;Oo*=-1;}if(o>=(
   Ii+=ll)&&O<1&&oO
   <0&&o<Ii+lI){O=2
   ;oO=~--oO;Oo+=ll
   *4e-1;}if(O<0){O
   =iI;LL++;}if(o>=
   (ii+=Il)&&O>iI-1
&&oO>0&&o<ii+lI){O=iI-
2;oO=~--oO;Oo+=Il*4e-1
;}if(+O>+iI){O-=O;i++;
}}endwin();return(0);}

