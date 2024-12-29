#define processor x86

#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/mman.h>

#define l int*
#define F char
 struct stat t;
 off_t N;
#define c return
#define I (P+=4,*L(P-4,0))
#define G (signed F)E(*L(P++,0))
#define C(O,D)E (D[B+V(010)/4+O*10])
#define U R[4]=E(V(17)-4),*(l)V(021)=
F       M [99],Q[99],b[9999],*ss,*d=b,*z;
#define O =(n=*(l)V(021),R[4]=E(V(17)+4),n)
#define p(a,b,c) system((sprintf(a,b,k[1]),c)),z
#define                         g (y/010&7)
#define                         R (B+13)
#define           x86           (F*)index\
(ss+V(i                         ),0100)
#define      D(y,n,a,m,i,c      )d+=sprintf( d,y,n,a,m,i,c ),(F*\
      )                         P
      l       B,i,n,a,r,y       ,
      P                         ;
#define     Tr(an,sl,at,or)     l an##i(d,sl){ c at? an##i(d,r):or; } \
l an(d,                         sl){ c \
r=V(014                         )&63,an##i(d,sl); }
#define add(Ev,Gv) Ev(){ i=((a-=16)+C(r,4))/4,(\
Gv?Ev()    :0)   ; } Ev##n(){ a=C(r,5),Ev(); }
int f;
Tr(L,r, C(r,3)&&C(r,3)<=d?(l)(((int)B)+d+C(r,4)-C(r,3)):(((int)B)^d)>>24&&--\
r,(l)d) Tr(Run,a,(ss=strcmp((F*)B+C((V(12)>>16),4)+C(--r,0),A(.strtab))?ss:(F\
*)B+C(r ,4),C(r,1)-2),0) add(Sca ,V(-~i)-P+2) add(ru,strcmp(ss+V(i),A(main)))
E(DX) { c *z? DX:DX <<030|(DX&65280)<<010|DX>>8&65280|DX>>24&0377; } l K(k){
c L(E(k [(l)V(17)]),0); } V(v){ c E(B[v]); }

int
pain(char *ck, char **k)
{
c (z?(stat(M,&t)?P+=a+'{'?0:3:execv(M,k),a=G,i=P,y=G&255,sprintf(Q,y/'@'-3?"*L(V(%d+%d)+%d,0)":"R[%d]",(y&7),'\r',y/0100-1?0:G),(a+127&&a+'}'&&a+1?(a+61&&a+24&&a+025?(P=a+'H'&&a%061<=0?P:i,D(a>0?"                           R[%d]=E(~-E(R[%d])),\0               U R[%d],\0               R[%d] O,\0                                          U %d,\0R[%d]=0,"+(a&'8')*3:a  <-  'c'?" %d, %c%s = R[%d], \0    %d, *R=%c%s==R[%d], \0          R[%d]=(int)%c%s,"-a%'w'%'j'*5:"%d,%d,%s=%d,",a>0?a-'h'?a-49?a&7:g:I:g,a>0?a&7:"& "[a%3%2+1],a+72?Q:A(*R),a>0|a<-99?g:I,0) ,(char* ) P):(P=i,i=a+61?a+21?E(I):G:0, D(a%' '+29+"P O,\0 U %d,P=%d,",P,P+i,0,0,0) , p(d,"A'",b)),z):(n=g-4?g%5-1?a+127?G:I:0:(Scan(), *( x86?processor :d)=0, (int)(ss+V(i))),g%5<2?d+=sprintf( d,g%5?"    %s=E(~-E(%s)), \0    U %s,"+4*g:"%s=E(E(%s)%c%d),",Q,Q,"+    -  "[g],n,0 ),(char* ) P:(a=G-'u'?'!':'=', D(g-4?"P=%d%c=%s?%d:%d,":"*R=E(((int(*)(l,l,l))%s)(K(1),K(2),K(3))),P O,",n,a,Q,P,P+G), p(d,"A'",b) ,z)))):(Run((z=(char*)&ck,stat(k[1],&t),B=(l)mmap(0,N=i=t.st_size,PROT_READ|PROT_WRITE,1,f=open(k[1],2),0))), magic((R[4]=E(B+i/4),run(),P=V(-~i), R[4]=E(V(17)-4),*(int*)V(021))), sprintf(M,A(.%s%d),k[1],P), D("%s %s '-DX=A(%s)' -o %s '-Dmagic=",X,__FILE__,X,M,fflush(0)) ,(char* ) P));
}
main (int cka, char **k) { char *ck = (char *)cka;
  (E((ck?pain((char*)cka,k):p(M,A(rm -f .%s),M),*R)));munmap(B,N);close(f);execv(k[1],k);
}
