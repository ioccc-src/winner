#include<stdlib.h>
#include<Xlib.h>
#include<keysym.h>
#define b(b)XDraw##b(i,J,k,
#define l :q==
#define o if(
#define a for(
#define t(t)XSetForeground(i,k,t##Pixel(i,0));
#define i(i)o g>1&&*P==*#i){ g--; m[g-1]i##=m[g]; } else
#define n (W-r)
#define s (Z-u)
#define I n*Q-Q,(s+2)*S,Q*3,Q*3,360*A/F*64,360*e/F*64);
#define d E[X][Y]
#define e m[q]
int   q,P,W,Z,X,Y,r,u; char   E[U][U][T+1] ,D[T];   Window J; GC k;  XEvent  w;
 Display*i; v(c,j ,K){ char*P=E[c][j],*X,g=0;  double A=0,F=0,m[T];  a;  K<U&&*
 P;   ){ m[g]=strtod(P  ,&X); a  q=-1;   ++q  <g; F+=*P==64? e:0,A=*P==33 ? e>A
? e:A  :0);  o    isupper(*P)*isdigit(P[1])){ o v(*P-65  ,atoi(P+1)  ,K+1))goto
i; a     m[g++]=atof(D);     P++&&isdigit(*P); ); } else o P-X){  g++;  P=X;  }
else{ i(=)i(+)i(-)i(*)i(/)o  *P-32)goto i;  P++; } }  o !--g)return !sprintf(D,
 "%10.2f",*m); i: a; A&&q--; XFillRectangle(i,J,k,(n+q)*Q+S,s*S+S-K,Q/2,K))K=Q*
  e/A; a;  q--&&F;  A+=e){ o     q%2)t(White)XFillArc(i,J,k,I  t(Black)b(Arc)I}
   return   !!strcpy(D   ,E[c][j]); } main(){  read(q,E,z);  i=XOpenDisplay(0);
k=XCreateGC(i,J=RootWindow(i,W),Z,0); XSelectInput(i  ,J=XCreateSimpleWindow(i,
J,P,q,M ,H ,r,u ,WhitePixel(i,X))  ,ButtonPressMask|KeyPressMask|ExposureMask);
a   XMapWindow(i,J); ;   b(String)S ,S,d ,P=strlen(d))){    XNextEvent(i  ,&w);
  XLookupString(&w.xkey,D ,1,&q,0);  q &    96&&q<128  ?   d[P++]=q l C ? Y-- l
L ? Y++  l V ? X++ l  _  ?  d[--P]=0 l   O&&X ? X--:P; o  w.type==ButtonPress){
X=r   +(w.xbutton.x-S)/  Q;     Y=u+w.xbutton.y/S-1;  } X%=26; a  X>r+p ?   r++
 :X;  X<r;   r--);  Y%=U; o  Y<1)Y=1; a; q== R;  exit(write(1 ,E,z))); a  Y>u+G
? u++  :u;  Y<=u; u--);   XClearWindow(i,J); a  Z=u+1;  sprintf(D  ,"%3d" ,Z)&&
Z<=u+G; Z++){ b(String)0,(s+2)*S-B,D,3); a  W=r;   W<=r+p;  b(String)n*Q+S+N,S*
2-B,D,1),W++){ b(Rectangle)n*Q+S,s*S+S,Q,S); v(W,Z,0);  b(String)n*Q+S+N,(s+2)*
S-B,D ,strlen(D)); *D=65+W; } } b(Rectangle)(X-r) *Q+S+1,(Y-u) *S+S+1,Q-2,S-2);
             }                                                        }        
