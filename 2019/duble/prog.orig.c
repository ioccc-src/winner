#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/un.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <sys/time.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

struct sockaddr_un u,v={.sun_family=1},*w=&v,x;struct timeval b,c   ;
fd_set r,t[ 1];  enum{z=V*(11*W+5)+15};struct{int A,B,C,D,E,F,G,H ,I  ;
char J,K[z];}A    ,B;y(int y){return FD_ISSET(y,t);} int  d,e,f,h,      i,
j,k,l,m,n,o,p,    q;unsigned int I=sizeof(x),J=sizeof(B   );char*          E
=B.K,*D="\e["     "0;30;40m \0\e[0m\n\0#!/bin/cat\n\e"    "[1A"           ,
*C="\e[0m\e"      "[2J\e[0;0H",*F,*G=&v.sun_path,H;K(      int          K)
{strcat(E,D+      K);}struct termios a;N(){p=0;while       (           ++
p<9)*(p+ G)=      rand()%13+65;p=bind(d=socket(1,2,      0)           ,
w,I);FD_SET(      d,&r);}O(){close(4);fopen(F,"r"       )           &&
(read(4,B.K, z    ),close(4),unlink(F)),w=&x;N()      ;d           =
3;}L(int L){ B    .A=L;return sendto(d,&B,J,0,w      ,I          *!
!w);}M(int M )    {return recvfrom(M,&A,J,0,&u      ,           &
I);}main(int P    ,char**Q){for(p=0,K(18);p++     <V          ;K(
12))for(d=0; d    ++<W;)K(0);if(P==2) for(F=     Q           [1],
srand(getpid (    )),FD_SET(0,&r),strcpy(G     ,F           ),x=v
,*G=s,B.J=44 ,    N(),O(),L(0);P++-4;)for     (           (float)
tcsetattr(1,0,    ((int)tcgetattr(1,& a)    ,a           .c_lflag
^=g,&a));P-4;)    {gettimeofday(& b,0);    p=          b. tv_usec
;q||(q=(3<<19)    +p);c.tv_usec=0+(q-p    )           %   999999;
d=3;w=&x;*t=r;    select(5,t,0,0,&c)    ||          (B    .E^=1,L
(7),q=0);y( 0)    &&(!read(0,&H,1),    H           %=     65,H^34
||(B.D=B.D%6+1    ),H^47&&H^43||(B   .J           =H      ==B.J?B
.E=0,L(8),44:H    ),H<4&&(B.E=0,L   (           7),B      .F+=H==
2&(B.F-=H==3&&    B.F)!=W-3,B. G  +=           H==1&      (B.G-=!
H&&B.G)!=V-3,B    .E=1),B.J^ 43  &&          (B.H=B.      F,B.I=B
.G),L( 7),H^48    ||(B.E=0,L(   7           ),L(2)))      ;if(y(4
))if(M(4),p=4,    A.A)while(  ++          p<=e)send(      p,&A,J,
0);else w= &v,    connect((  N           (),B.C=d),&      u,I),d>
e&&(e=d),w=0,L    (4);if(y (3           ))if(M(3),A.      A^5){A.
A^1||L(+0),A.A    ^4||(B. B           ||printf("%s%"      ".*s\r"
" \e[97mmode:"    ,C,z-5,A           .K),B.B=A.C,B.D      ||(B.D=
B.B%6+1),strcpy  (B.K, A.          K));if(A.A==2)if(      B.B^5||
close(A.B),A. B  ==B. B           ){if(6==1+B.B)for(      unlink(
F),write(creat(F,511),          B.K,z),d=5,w=0;++d<=      e;)if(L
(5)+1)for(M(d);++d<=           e;)L(1);(int)printf(C      );break
;}if(A.A>6)for(h=A.           F,i=A.G,j=A.H,k=A.I,f=      A.E,l=h
<j?1:-1,m=(j-h)*l           ,n=i<k?1:-1,o=(k-i)*n,p=      (m>o?m:
-o)/2;E=34+(B.K+           (i+1)*(5+W*11)+h*11),47^A      .J&&43^
A.J|8^A.A||(*E=          48                               +A.D),*
(E-3)=A.D*(A.           D                                 +48!=*E
)+48,*(E-6)=          A.                                  E*7+48,
*(E+2)=f ?           42:32,printf("\e[%d;%dH%.11s\e[%d;%dH\e[0;4"
"%dm%c%s"           "%s",2+i,h+2,E-8,V,8,B.D,B.J+65,C+8,D),j^h|i^
k;)(d=p           )>-m&&(p-=o,h+=l),d<o&&(p+=m,i+=n),f=0;fflush (
stdout           );}else&v+111,(unsigned int)O(),/* IOCCC 2019 */
   +L          (0
  )           ,
 w          =&
   u,      L(
      6)  ;
        }}
