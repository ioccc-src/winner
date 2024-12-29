%:define _POSIX_SOURCE
#include<fcntl.h>
#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<string.h>
#include<sys/types.h>
#include<sys/stat.h>
#define D(N,t)Z t*N V<%t*z U M0*z); H z)u z; X}
#define k(x,y)x<0||fstat(x,&y)||
#define h(x)=open(x,O_RDONLY)
#define b(x),(int)x.st_nlink
#define B ;typedef g
#define X exit (1);
#define O .st_size
#define U =malloc(
#define Y S.st_ino
#define v ;%>else
#define W .st_dev
#define o ||read(
#define Z static
#define g struct
#define u return
#define I char*
#define V (M2)
#define H if(
#define _ ->

/* HE WHO SAYS */

Z I A<:32767/      M0(I )]; Z g     stat S,T; Z        size_t    y B f{
I n ; g f *  x     ; dev_t d  ;    ino_t i; } f B      t{ M1     s,c; f
*l; g t*L,*R; }    t; D(a,t)D(E    ,f)Z t*J(t*p,I      n){ H!   p){ p=
a(); p    _ s =S      O; p _       c=1; p              _ L=p    _ R=0;
p _ l=    E(); p      _ l  _       n=n; p              _ l _   x=0; p
_ l  _    d=S W;      p _  l       _ i= Y              v H S   O==p _
s){ f*    e; for      (e=p _       l; e; e=e _ x)      { H S W==e _ 
d&&Y==    e _ i)      { u p;        } } e=E(); e _     x=p _ l; e _ 
n=n; e    _ d =S      W; e _                i=Y; p     _ l=e;  ++p _ 
c v  H    S O< p      _ s) {                p _ L=     J( p _  L,n)v{
p _ R=    J (p _      R,n );                } u  p     ; }  Z   int Q(
I G,I F){ int d    h(G),D h(F);    I m,*M; H k(d,S     )k(D,T   )(y =S 
O)-T O){ y= 0;     goto d; } H!    (m U y))||!(M U     y))o d    ,m,y)-
y o D,M,y)-y)      X y=!memcmp(     m,M,y); M5(m)      ; M5(M    ); d:V

 close (d );V      close(D); u        y; } Z M2 C(M1       z,M1 N){ M1     i=N*(N-1)/2,
j=1,s; I q,*e,*    p,*w,*l; e=q=     M4((size_t)i,1);     H!e) X p=q+i;    for(i=0; e-p
; ++e){ H!*e&&Q    (A[i:>,A[j])){   V printf("%""l""d"   "\t""%" "s""\t"   "%""s"
"??/t"             "%""c"   "\11"   "%""d"      "??/t"   "%""d"    "\n",   z,A[i]
,A[j],             S W -T   W?'X'   :'='b(      S)b(T)   ); H j    -i-1)   { s=N-
i-3; w             =e+s+1; l=q+N*   (j-1)-      j*(j-1   )/ 2 ;            do{ *w
=1; H w==l)        break; w+= s;    } while( s-->0); }   } H++j            ==N){ j=i+++
 2; } } M5(q);     } Z M2 P(t*p     ){ H p){ P(p _ R);   H  p _            c>1){ M1 i=0
         ; f*l=    p _ l;           for (;      i< p _   c; ++i            ){ A[i
         ]= l _    n; l=l           _ x; }      C (p _   s, p _    c); }   P (p _ 
         L) ; }    }  int           main V      { t*r=   0; I F    ; for   (; ; )
{ H!(F U 1024))    )X H !           fgets(      F,1024   ,stdin) )break;   *(F+(y
=strlen(F))-1)=    0; H!(          F=M3(F,      y)))X H   stat(F,&S)==0    &&S_ISREG(S.
 st_mode)&&S O     )r=J(r          ,F ); }      H r)P(r    ); u 0; }/*     Obfuscated C

IS FREE THINKS MONEY GROWS ON DIRECTORY TREE */
