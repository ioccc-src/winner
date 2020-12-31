#include <stdio.h>
#include <math.h>
#define E return
#define S for
char*J="LJFFF%7544x^H^XXHZZXHZ]]2#( #@@DA#(.@@%(0CAaIqDCI$IDEH%P@T@qL%PEaIpBJCA\
I%KBPBEP%CBPEaIqBAI%CAaIqBqDAI%U@PE%AAaIqBcDAI%ACaIaCqDCI%(aHCcIpBBH%E@aIqBAI%A\
AaIqB%AAaIqBEH%AAPBaIqB%PCDHxL%H@hIcBBI%E@qJBH#C@@D%aIBI@D%E@QB2P#E@'C@qJBHqJBH\
%C@qJBH%AAaIqBAI%C@cJ%"   "cJ"   "CH%C@qJ%aIqB1I%PCDI`I%BAaICH%KH+@'JH+@KP*@%S@\
3P%H@ABhIaBBI%P@S@PC#",     *j   ,*e;typedef float x;x U(x a){E a<0?0:a>1?1:a; }
typedef struct{x c,a,t;      }   y;y W={1,1,1},Z={0,0,0},B[99],P,C,M,N,K,p,s,d,h
;y G(x t,x a,x c){K.c=t   ;      K.t=c; K.a=a;E K;}int T=-1,b=0,r,F=-111,(*m)(i\
nt)=putchar,X=40,z=5,o,   a,     c,t=0   ,n,R;y A(y a,y b,x c){E G(a.c+b.c*c,a.a
+c*b.a,b.t*c+a.t);}x H=   .5,Y   =.66     ,I,l=0,q,w,u,i,g;x O(y a,y b){E q=a.t*
b.t+b.c*a.c+a.a*b.a;}x Q(){E A(P,M,T       ),O(K,K)<I?C=M,I=q:0;}y V(y a){E A(Z,
a,pow(O(a,a),-H));}x D(y p){S(I=X,P         =p,b=T; M=B[++b],p=B[M.c+=8.8-l*.45,
++b],b<=r;Q())M=p.t?q =M_PI*H,w=atan2(   P.a-M.a,P.c-M.c)  /q,o=p.c-2,a=p.a+1,t=
o+a,w=q*(w>t+H*a?o:    w>t?t:w<o-H*a?t   :w<o?o:w),A(      M,G(cos(w),sin(w),0),
1):A(M,p,U(O(A(P,M,T)    ,p)/O(p,p)));   M=P;M.a=-         .9;o=P.c/8+8;o^=a=P.t
/8+8; M=Q        ()?o&1    ?G(Y,0,0):W   :G(Y,Y,1);E       sqrt        (I)-.45;}
int main(   int    L,char    **k){ S(e   =L>1?1[z=    0,   k]:J   ;*e   &&l<24 ;
++e)S(o=a   =0,j   =J+9;(c=    *++j)&&   !(o&&c<    X&&(q=l+=w)   );o   ?o=*j++/
32,b++[B]   =G(q   +=*j/8&3,*    j&7,0   ),B[r    =b++]=G((c/8&        3)*( o<2?
T:1), (c&   7)+    1e-4,o>2),1:    (o    =(a    =(c-=X)<0?w=c+6   ,t=   a+1:c?(t
?0:m(c),a        ):*++j)==((*e|32        )    ^z)&&1[j]-X));S(z   =3*(   L<3);++
F<110;)S(L=-301;p=Z,++L<300;m(              p.c),m(p.a),m(p.t))S(c=T;++c<=z;)S(h
=G(-4,4.6,29),d=V(A(A(A(Z,V(G(5,0         ,2)),L+L+c/2),V(G(2,-73,0)),F+F+c%2),G
(30.75,-6,-75),20)),g=R=255-(n=z)*64;    R*n+R;g*=H){S(u=i=R=0;!R&&94>(u+=i=D(h=
A(h,d,i)));R=i<.01);S(N=V(A(P,C,               T)),q=d.t*d.t,s=M,u=1;++i<6*R;u-=
U(i/3-D(A(h,N,i/3)))/pow(                             2,i));s=R?i=pow(U(O(N,V(A(
M=V(G(T,1,2)),d,T))))                                     ,X),p=A(p,W,g*i),u*=U(
O(N,M))*H*Y+Y,g*=                                             n--?Y-Y*i:1-i,s:G(
q,q,1); p=A(p,s                                                 ,g*u);h=A(h,N,.1
);d=A(d,N,-2*O                                                     (d,N));}E 0;}
