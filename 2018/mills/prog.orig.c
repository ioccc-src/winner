#include<fcntl.h>
#include<unistd.h>
#include<termios.h>
#include <sys/time.h>
#include  <sys/mman.h>
# define L } if(!i -- ){
struct timeval F,G; struct termios H,U={ T} ; enum{ N=64,a=N<<7,b=a-1,c=a*32,d
=c-1,    e=c/    2,f=    a*2,    g=a/2,h =g/2,j =h/ 2,Q=V*j*5} ; char*s=P,K,M;
int*      p,      l[      a]      ,m,n,J,o=A,    O=j,E,R,i,k,t,r,q,u,v,w,x,y,z
,B,C,    *D,Z    ;int    main    (){ for(D=mmap(D,4*Q,3,W,open(I,2 ),K); *s; o
++[ l]=k|=* s++%N){ k=* s++%N<<12; k|=*s++% N*N; } tcgetattr(q,& H); tcsetattr
(y,2,    &U);    for(    fcntl(B,4,4); ; o&=b){ if(k&    c){ q=- --k%N; if(!q)
k-=c      ;i      =k      /N&7; { L L if(J&1)    m+=      t; J|=m%N*c; J/=2; m
/= 2;    if(!    q&&r    ^n){ m^=d; J^= d; n=0; } L L    J+=J; J|=m>=0; if(q){
m+=m; m|=J/c; m+=m<0?t:-t; } else{ m+=(m<0)*t; if(r)m^=d; if(n^r)J^= d; n=0; }
L if(    (m^2    *m)/    e%2)    k&=d; else{ J+=J; m+=m; m|=J/c; } L m|=n*c; J
|= m      %N      *c      ;m      /=2; J /=2;    L m+=m; J+=J; J|=n; m|=J/c; L
m+=m;    m|=n    ;  }    J&=d    ; } else{ i=k/f; t=i?k&b:16; p=l+t; if(k&a)p=
l+((*p+=13>i&&7<t&&16>t)&b); { L i=1; L*p=m; L*p++=o|n*e; o=p-l; L*p=0; L m=*p
; L m ^=*p ; L t=m; m    +=*p; m+=d<m    ; n|=((m^t)&    (m^*p))/e; L    m+=*p
; n=m/c; L k=*p; if(      !Z||k/f-8)      /*$    %*/      continue ;      k=-k
; L++*p; o +=!(*p&=d)    ; L m&=*p; L     if(m!=*p)++    o; L o=p -l;    L if(
k&a)n=m/e; if(k&g)J= 0; r=k&h&&m&e; if(k&j)J|=m; else if(r)m^=d; if(k&512)m=0;
i=k/N    &7; { L if(k    &4)J    ^=d; if(k&2)m|=J; if    (k&1    )m|=    q;  }
else      { if(k%N)k      +=      c; { L t =o    ++[      l]      ;       if(r
)J^=d;   L L t=o++[l];   if(r    )J^=d; m-=t; if(m>=0    ){ k    -=c;     n=1;
++o; } } i=2; } L if(Z)k=-1; else{ if(k&8)m=0; t=r=0; i=k/N%N; if(i==27){ if(k
&2)u=v=w=Z=0;    } if    (i==57){ i=k/16&3; { L w =1;    if(k&1)x =0;    if(k&
2) { t= z/N;      t=      t/80*/*/*/100+t% 80;   r=0      ; while(t)      {  r
+=t%10*w; t/=    10;w    <<=4; } m|=r; } if(k&4){ r=m    ; t=0; while    (r) {
t+=r%16*w; w*=10; r>>=4; } r=t/100; t%=100; if(V<=r||79<t)x|=c/8; else z=(r*80
+t)*N    ;  }    w=0;    L if(k& 1&&x    &(e|g) )++o;    if(k& 2)m|=x    |y;if
(k&4      )C      =-      m&65535; L      if(    k&1      )x=y=0; if      (k&2
)B=m;    if (    k&4)    { y^=m&(h|j|    j/2); if(y&j    ){ y^=j;x|=g    ; do{
B&=b; if(y&j/2)z[D]=B[l]; else B[l]=z[D]; ++z; z%=Q; ++B; } while(-- C); } } }
x%=e;    if(x    /a)x    |=e;    if(x&(e|g)&&y&h)u|=c    ; else u%=c;    L if(
k&1)      t=      h;      if      (k&2 )r= e;    if(      k&4){ r=j;      u&=~
h ; }    if(k    &16)    Z=f*    2; L L L t=f; if(k&2    )m|=M|Y; if(    k&4)m
|=u|v; L t=a; if(k&4){ K=m&~Y; write(1,&K,1); u|=t; t=0; } } i=2; if(t){ if(k&
1&&u&t)++ o; if(k&2)u    &=~ t; } if(    r){ if(k&32)    w=r;    else v&=~r; }
} L if(k&a)m=k; else      { t=0; if(      k &    N)t      |=      m/e%2; if(k&
128)t|=!m; if(k&256)t    |= n; if( k&    512 )t=!t; o    +=t;    if(k& h)n =0;
if(k&g)m=0; if(k&1)m^=d; if(k&2)n^=1; if(k&4)m|=S; if(k&8){ m|=n*c; m+=m; if(k
& j)m    +=m;    m|=m    /a/N    ; n=m/c; } if(k&16){ m|=n*c;    m|=m    *2%N*
c; m      /=      2;      if      (k&j) m/=2;    n=m/c; } if      (k      &32)
{ if(    Z)k=    -1 ;    else    break; } } } } n&=1; if(k<c)    {  m    &= d;
o &=b; if(!R--){ if (~u&f &&read(0, &M,1)>0){ if(X&& M== X)break; R=0; u|=f; }
gettimeofday(&G,0); G.tv_usec/=16667; if(G.tv_sec>F.tv_sec||F.tv_usec<G.
tv_usec){ F=G; if(v&j){ p=l+7; ++*p; *p&=d; if(!*p)u|=h; } R=0; } if
(!R){ E=O/4; O=4; } O+=R=E; } if(!++k||(v&e&&u)){ *l=o|n*e|Z;v%=
e; o=1+!k; Z=0; } v|=w; w=0; k=o++[l]; } }tcsetattr(w,1,&H); }
