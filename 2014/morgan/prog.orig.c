
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

#define A calloc(1, sizeof(m))
#define D m.
#define L ->
#define P malloc(
#define R &&
#define S ++
#define U for(
#define V if(
#define W L i
#define X L a
#define Y L b
#define Z L c

typedef struct T*_; struct T{ int t,i; char*a; _*b,c,d,e,f; } m,x,y; struct stat z; int u; void * H;
int K(int c){ return strchr(" \n\t",c); } void B(_ s,_ p) { s Y=realloc(s Y,S s W*sizeof(_)); s Y [s
W-1]=p; } _ C(char*d,int l){ _ s=A; s X=d?d:P 1); s W=l<0?d?strlen(d):0:l; return s; } _ E(_ s){ _ r
=A; int i=0; U; i<s W; ){ U; i<s W R K(s X[i]); )i S; int j=i; U; j<s W R !K(s X[j]); )j S; V j-i)B(
r,C(s X+i,j-i)); i=S j; } return r; } int F(_ a,_ b){ return a W==b W R !memcmp(a X,b X,a W); } void
I( _    s,char c ) {    char*d=P            1); *d=c    ; B(s,C(d,1)    ); }                    void
 J (    char*d,int l    ,int o,_            v){ _ n=    C(d,l); _ w;    U l=                    0; l
<D d        W; )        { w=    D d Y[l S ];    V F(    w Z,n)){    V o>w W)    return; goto  O; } }
B( D        d,w=        A );    w Z=n; O:w W    =o ;    w L d=v;    } int M(    _ b,int p,char*t,int
g ){    _ f=    A; f    L e=                    A; f            X=t; int h=g            ,i=0,j=0,n=b
 W ;    char    c=0,    d,*o                    =b X            ; U; p<n; ){            t=j?"":f X ;
 int    k=p; _ r=H ;    U; p    <n; ){ int l    = 0;    U; p<n R    o[p]==92    ; ){ l S; p S; } c=o
[p S    ]; V c^10||!    l% 2    ||!g){ d=c==    35 R    !i R!g||    c== 10 R    g^2; V d||strchr(t,c
)) {    r=C(o+k,p-k-    d*l/    2-1); V  d R    l%2)    { r X[r W-1]    =c^35                   ?32:
c; c    =0; } break;    }  }    c=0; } V!j)B    (f L    e,r?r:C(o+k,    n-k)                    ); r
=A; switch(c){ case 35:j S; case 0:break; case 10:goto O; case 36:switch(d=o[p S]){ case 36:I(f L e,
d); break; default:I(r Z=A,d); goto o; case 40:case 123:r L f=f; r L e=A; r X=d^40?"}$":")$"; f=r; }
break; default:V f L f){ r Z=f L e; f=f L f; o:r L t S; B(f L e,r); } else goto O; } i=f L f R g==1;
g=i?0:h; } O: x.c=f L e; x.t=c; return p; } _ N(_ s){ _ o=C(H,0); U int i=0; i<s W; ){ _ p=s Y[i S];
V p L t){ _ n=N(p Z); p=C(H,0); U int j=0; j<D d W; ){ _ w=D d Y[j S]; V F(w Z,n)){ M(w L d,0,"$",2)
; p=N(x.c); break; } } } o X=realloc(o X,o W+=p W); memcpy(o X+o W-p W,p X,p W); } return o; } _ O(_
t){ U int i=0; i<D e W; ){ _ s=D e Y[i S]; V F(s Z,t))return s; }_ s=A; s Z=t; s L d=A; s L t--; B(D
e,s); return s; } void Q(_ s){ _ d=s Z; V!stat(memcpy(calloc(1,d W+1),d X,d W),&z))s L t=z.st_mtime;
V!s W S){ u=!s L d W R s L t<0; int i=0,j,k=s L t<0; _ c=H,t; U; !u R i<s L d W; ){ _ a=s L d Y[i S]
; U j=0; !u R j<a L d W; ){ Q(t=O(a L d Y[j S])); k|=t L t<0||t L t>s L t; } V a Z W){ c=a Z; V a  L
d W)J("<", 1, 0, *a L d Y); } } U j=0; !u R c R k R j<c W; ){ J("@",1,0,d); s=N(c Y[j S]); U; s W  R
strchr("@+-",*s X); )s X S; u=system(s X); } } } void G(_ b){ U; b W R K(*b X); ){ b X S; b W--; } }

int main(int i,char**a,char**e){ D d=A; D e=A; D c=A; char p[]="NBLF\1Nblfgjmf\1",*q=p; U; (*q++)--;
); J(p,4,0,C(*a S,-1)); U i=0; i<3; i+=2){ U; *a; ){ q=*a; U; *q R*q^61; )q S; V*q)J(*a,q-*a,i+1,C(q
+1,-1)); else V!i)B(D c,C(*a,-1)); a S; } a=e; } stat(p+5,&z); i=z.st_size; _ b=C(H,0),c,d; b W=read
(open(p+5,0),b X=P i),i); U; u<i; ){ V b X[u]^9){ U; u<i R K(b X[u]); )u S; u=M(b,u,"=:$",0); y = x;
switch(x.t){ case 58:u=M(b,u,"$",0); D f=c=A; c L d=E(N(x.c)); c Z=A; d=E(N(y.c)); U; d W--; )B(O(*d
Y S) L d,c); break; case 61:u=M(b,u,"",0); G(c=N(x.c)); G(d=N(y.c)); U; d W--R K(d X[d W]); ); J(d X
,S d W,2,c); } } else { u=M(b,S u,"$",1); I(x.c,0); B(D f Z,x.c); } } V!D c W R D e W)B(D c,D e Y[0]
Z); U u=0; !u R D c W--; )Q(O(*D c Y S)); return u; }
