#define j(n,r,i) A*n=R(r[i].a);//
#define E X("syntax error\n",1)//
 #define     d(n) A*n(A*x,A*y)//
  #define    k(d,v) D(d);e v;//
   #define  F X("fail\n",-1)//
     #define h(n) A*n(A*x)//
      #include <stdlib.h>//
    #define     u(n) n[0].l//
   #include        <stdio.h>//
    #define       w union A//
      #define   e return//
					             #define N 5//
					         #define q c=getc(p)//
					    #define o(i,v) [i]={[1].p=v},//
					  #define m(i,I,n) [i]={{I},[1].l=n},//
					#define g(n) A*r=C(&(A){.l=n});r[1].a=//
#define s(x,y,i,q,n,o) if(x[3].a){if(u(x)==rT||u(x)==rC){i;if(q)k(y,x)}g(n)y;o;r[3].a=x;e r;}//
//
void X(char*f,int r){ fputs(f,stderr);exit(r);}typedef w{w* (*t) (w*x);w* (*l) (w*x,w*y);w*a;long long p;}A;h(R) {x[N-1].p++;e x;}h(Ch) ;h(Y) ;h(fA) ;d(fD) ;d(fT) ;d(fW) ;d(fCh) ;d(rA2) ;d(fA2) ;d(rY2) ;d(Y2) ;d(rS2) ;d(fS22) ;d(rD) ;d(rE) ;d(rT) ;d(rC) ;void D(A*f) {if(f&&!--f[N-1].p) {if(u(f)!=fW&&u(f)!=fCh) D(f[1].a);if(u(f)!=fT) D(f[2].a);if(u(f)!=rE&&u(f)!=rT&&u(f)!=rC) D(f[3].a);free(f);}}int ch=EOF,c;FILE*p;A T[256][2];void U(void) {do{if(c==EOF) e;if(T[c][0].t) e;if(!T[c][1].p) E;if(T[c][1].p==4) for(/**??/
/
q;c!='\n'&&c!=EOF;q);q;}while(1);}A*I(void){if(c==EOF)E;A*f=T[c];if
(f[0].t!=Ch){q;U();}e f[0].t(&f[1]);}h(C){A*r=malloc(sizeof(A[N]));
if(!r) X("memory error\n",-2); r[0]=*x; for(int i=1;i<N;i++)r[i]=(A
){0};e R(r); }int   main(int x,const char**y){if(x!=2)F;p=fopen(y[1
],"rb");if(!p)F;q;   U();while(c!=EOF){A*f=I();while(f[3].a){if(u(f
)==rT){f=f[1].u(a)(   R(f[1].a),f);}else if(u(f)==rC){T[96][0].t=Y;
j(r,f,1) D(f); f=r;}   else{g(fT)f;r[2].p=ftell(p)+(c==EOF);f=u(f)(
R(f),r);}}D(f);}e 0;}   h(Ch){A*r=C(x);q;if(c==EOF)E;r[1].p=c;q;U()
;e r;}h(NL){A*r=C(x);r   [1].p='\n';e r;}d(rT){j(r,x,2)D(y);k(x,r)}
d(fD0){g(fD)y;k(x,r)}d(   fA1){s(y,x,,1,fA2,)e u(x)(x,y);}d(fA2){j(
a,x,1)j(b,x,3)k(x,fA1(a,   u(b)(b,y)))}d(rA1){s(y,x,,0,rA2,)if(u(y)
==fD0){g(fD)R(x[2].a);D(y   );k(x,r)}A*r=fA(x[2].a);k(x,fA1(y,r))}d
(rA2){j(f,x,1)j(a,x,3)k(x,   rA1(f,u(a)(a,y)))}h(fA){R(x);if(x[0].t
!=fA)e x;e rA1(x,fA(x[1].a)   );}d(fD1){s(x,y,,1,rD,)e u(x)(x,y);}d
(rD){j(a,x,3)j(b,x,1)k(x,fD1   (u(a)(a,y),b))}d(fD){A*a=fA(x[1].a);
k(x,fD1(a,y))}h(Yt){(void)x;A   *r=C(&(A){.t=fA});r[1].a=I();r[2].a
=I();e r;}h(YE){(void)x;k(I(),   I())}d(Y1){s(y,x,,1,Y2,)e u(x)(x,y
);}d(Y2){j(a,x,1)j(b,x,3)k(x,Y1   (a,u(b)(b,y)))}h(rY1){if(x[3].a){
if(u(x)==rT)e x;if(u(x)==rC){k(I   (),x)}A*r=C(&(A){.l=rY2});r[3].a
=x;e r;}if(u(x)!=fD0)e Y1(x,I()     );D(x);T[96][0].t=Yt;g(fD)I();T
[96][0].t=Y;e r;} d(rY2) {j(a,   x   ,3)k(x,rY1(u(a) (a,y)))}h(Y){(
void)x;e rY1(I());}d(fK1){j(r   ,x,   1)D(y);k(x,r)}d(fK0){g(fK1)y;
k(x,r)}d(fS21){s(y,x,,1,fS22   ,)e u   (x)(x,y);}d(fS22){j(a,x,1)j(
b,x,3)k(x,fS21(a,u(b)(b,y))   )}A*rS1   (A*x,A*y,A*z){s(y,x,D(z),1,
rS2,r[2].a=z)if(u(y)==fD0)   {g(fD)C(&   (A){.t=fA});r[1].a[1].a=R(
x[2].a);r[1].a[2].a=z;k(x   ,r)}j(r,x,2   )k(x,fS21(y,u(r)(r,z)))}d
(rS2){j(a,x,3)j(b,x,2)j(   f,x,1)k(x,rS1   (f,u(a)(a,y),b))}d(fS2){
j(a,x,1) R(y);e rS1(x,u   (a)(a,y),y);}d(   fS1){g(fS2)R(x[1].a);r[
2].a=y;k(x,r)}d(fS0){g   (fS1)y; k(x,r)}d(   fI){k(x,y)}d(fV){k(y,x
)}d(fW) {putc(x[1].p,   stdout);k(x,y)}d(fR   ){ch=getc(stdin);A*r=
C(&(A){.l=ch!=EOF?fI   :fV});k(x,u(y)(y,r))}   d(fCh){A*r=C(&(A){.l
=ch==x[1].p?fI:fV})   ;k(x,u(y) (y,r))}d(fP){   A*r=C(&(A) {.l=ch!=
EOF?fW:fV}); if(ch   !=EOF)r[1].p=ch;k(x,u(y)(   y,r))}d(rE){if(y[3
].a==y)e u(y)(y,x   );j(r,x,1)k(x,u(r)(r,y))}d(   fE){g(rE)y;r[3].a
=r;k(x,r)} d(fT)   {g(rT) R(x[1].a); r[2].a=y;r[   3].a=r; if(fseek
(p, x[2]. p -1,   SEEK_SET))F;q;U();k(x,r)}d(rC){   (void)x;e y;}d(
fC){g(rC)y;r[3   ].a=r; T[96][0].t=YE; k(x,r)}A T[   256][2]={m(46,
Ch,fW)m(63,Ch   ,fCh)o(32,1)m(64,C,fR)[96]={{Y}},o(   9,2)m(99,C,fE
)o(10,3)m(100,C,fD0)m(101,C,fC)o(35,4)m(105,C,fI)m(107,C,fK0)o(11,5
)o(13,6)m(114,NL,fW)m(115,C,fS0)m(118,C,fV)o(12,7)m(124,C,fP)};/*/;
int main(){printf("```s``." "3`.2. `.d`" "``k.rik" "`d`.y`" "``."//
"l``c.n.o.gr```s`.n`.e`.c.h```.r`.u```k.td.y. i`.c`.e`.tk\n");}/**/
