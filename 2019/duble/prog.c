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

int a,b,c,d,e,f,h,i,j,k,l,m,n;fd_set p[1],q;struct{int A,B,C,D,E,   F
,G,H,I,J,L,K;}w  ,x;r(int r){return b=r,FD_ISSET(r,p);}enum{u=V*( 11 *W
+5)+16};t( int    t){FD_SET(t,&q);}struct sockaddr_un A,  B,*D,C={       .
sun_family=1};    char v[u];unsigned int E=sizeof(B),F=   sizeof(          x
);char*I="\e"     "[0m\e[2J\e[0;0H",*K,*L=&C.sun_path,    *M,*J           =
"\e[0;30;40"      "m \0\e[0m\n\0#!/bin/cat\n\e[1A",N;     O(){          n=
0;while(++n<      9)*(n+L)=rand()%13+65;t(b=socket(1      ,2           ,0
));n=bind(b,      b==4?&B:&C,E);}struct timeval y,z      ;H           (
){recvfrom(b      ,&w,F,0,&A,&E),a=w.A;}Q(){close       (           4)
;fopen(K,"r" )    &&(read(4,v,u),close(4),unlink      (K           )
),O();b=3;}P (    int P){strcat(v,J+P);}G(int G      ){          x.
A=G;D=G<5?0: G    ^8?&B:&A;return sendto(b,G^3      ?           &
x:&w,F,0,D,! !    D*E);}struct termios o;main      (          int
F,char**D){n =    0;for(P(18);n++<V;P(12))//     !           b+12
for(b=0;b++< W    ;)P(0);if(F==2)for(K=D[1     ],           t(0),
srand(getpid (    )),strcpy(L,K),B=C,*L=s     ,           x.J=44,
O(),Q(),G(6);F    ++-4;)for(tcsetattr(1,    0,           (//IOCCC
tcgetattr(1,&o    ),o.c_lflag^=g,&o));F    -4          ;) {//2019
gettimeofday(&    y,0);n=y.tv_usec;m||    (           m   =(3<<19
)+n);z.tv_usec    =(m-n)%999999;b=3;    *p          =q    ;select
(5,p,0,0,&z)||    (x.E^=1,G(9),m=0)    ;           r(     0)&&(b=
3,read(0,&N,1)    ,N%=65,34^N||(x.   D=           x.      D%6+1),
N^47&&N^43||(x    .J=N==x.J?x.E=0   ,           G(10      ),44:N)
,N<4&&(x.E=0,G    (9),x.F+=N==2&  (x           .F-=N      ==3&&x.
F)!=W-3,x.G+=N    ==1&(x.G-=! N  &&          x.G)!=V      -3,x.E=
1),x.J^43&&(x.    H=x.F,x.I=x   .           G),G(9),      48^N||(
x.E=0,G(9),G(7    )));if(r(4  ))          if(H(),a^6      )if(a^5
)while(++b<=c)    G(3);else  x           .K=v[w.L],b      =w.B,G(
4);else/*O()*/    connect( (O           (),x.C=b),&A      ,E),b>c
&&(c=b),G(1) ;    if(r(3) )           if(H(),a^2){ a      ||G(6),
a^1||(x.B=w.C,    x.D||(x.           D=x.B%6+1),x. L      ||G(5))
,a^4||(v[x.L++]  =w.K, x.          L<u?G(5):printf (      "%s%.*"
"s\r \e[97mmod"  "e:" ,           I,u-6,v));if(a==7)      if(x.B^
5||close(w.B),w.B==x.B          ){if(x.B==5)for(/**/      unlink(
K),write(creat(K,511           ),v,u),b=5;++b<=c;)if      (G(2)+1
)for(H();++b<=c;)G(           0);printf(I);break;}if      (a>8)//
for(d=w.F,e=w.G,f           =w.H,h=w.I,a=w.E,i=d<f?1      :-1,j=(
f-d)*i,k=e<h?1:-           1,l=(h-e)*k,n=(j>l?j:-l)/      2;M=34+
(v+(e+1)*(5+W *          11                               )+d*11)
,47^w.J&&43^w           .                                 J|w.A ^
10||(*M=w.D+          48                                  ),*(M-3
)=w.D*(w.D           +48!=*M)+48,*(M-6)=w.E*7+48,*(M+2)=a?42:32 ,
printf(""           "\e[%d;%dH%.11s\e[%d;%dH\e[0;4%dm%c%s%s",e+2,
d+2,M-8           ,V,8,x.D,x.J+65,I+8,J),f^d|e^h;)(b=n)>-j&&(n-=l
,d+=i)           ,b<l&&(n+=j,e+=k),a=0;fflush(stdout);}else//d+=i
   0+          Q(
  )           ,
 G          (6
   ),      G(
      8)  ;
        }}
