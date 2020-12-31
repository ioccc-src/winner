int
**F,**
V,M, N,i;
#ifndef/**/S
#define S 70,23
#endif/* 000-2E5*/
#define/* 2E5-2E5,2E5
*/_POSIX_C_SOURCE 199309
#include/* 2E5XXX*/<time.h>
/* 2E5-2E5X*/#include<stdio.h>
#include<stdlib.h>/* -2E5-2E5XX*/
struct timespec R={0,1E6};int j,k,m,
#define U/* -2E5X*/rand()*2./RAND_MAX-1
#define/* 2E5*/O(p,q,i)(P[p*3+i]-P[q*3+i])
/* IOCCC2013 IOCCC2013*/#define B(p,q,\
r)(O(q,p,0)*O(r,p,1)-O(q,p,1)*O(r,p,     0))
#define A(t,n)( t*)malloc( sizeof     (t)*n)
#define E(p,q,r,s)B(p,q,r)*O(s     ,p,2)+B(\
p,r,s)*O(q,p,2)+B(p,s,q)*O(     /*XX*/r,p,2)
#define D(e,f)(c-a)?s=a,     a=e,e=s,s=f,f=\
d,d=s:0;u=a+.5;m=u+1;     T[01]=91;T[2]=060;
#define C (Q[u]-X)     *a+(Q[u+1]-Y)*b+(Q[u\
+2]-Z)*c,g=e*c-     f*b,h=f*a-d*c,f=c,c=d*b\
-e*a,d=a,a=g     ,e=b,b=h,P[k]=W/2-q/s/p*3*\
W,P[k+1]=     H/2+r/s/p*H/2,T[3]=0x48,*T=033
n,u,v,     w,t,W,H;double*P,*Q,I,J,K,L,x,y,z
,X,     Y,Z,a,b,c,d,e,f,g,h,p,q,r,s ;void o(
     double x){for(p=q=i=0,s=r=1;i<99;s=(s+x
  /s)/2)i%2?q+=r,r=-r:(p+=r),r*=3.14*x/++i;}
     int G(int p,int q,int s,int g,int f){i\
nt*     v=A(int,N),*a,*b,h=-1,r=h;for(F[f]=V
[f]=v;     ++h<f;)if(V[h][p]==q){if(s+1&&E(p
,q,V[h][q     ],s)<1E-4){for(a=F[g],b=F[h];N
>++r;v[r]=q+     1?a[q]-r?q:b[p]-r?p:-1:p)p=
a[r],q=b[r];for     (r=0;r<f;r++)F[r]==a||F[
r]==b?F[r]=v:0;};;     return f;}for(h=0;h<N
;v[h++]=-1)r=h-p&&h-q     &&(r<0||E(p,q,r,h)
<0)?h:r;v[v[v[p]=q]=r]=p     ;return G(r,q,p
,f,G(p,r,q,f,G(p,q,s,g,f+1)     ));}char *T;
int main(void) {H=(W=S)*2;T=A(     char,(H*W
+4));for(srand(t=(int)time(0));i=     scanf(
"%lf,",P=(Q=(double*)realloc(Q,(N+1)     *s\
izeof(double)))+N),i>=0;)i?c+=*P**P,1<N
++%3?o(c),b=b<s?s:b,c=0:0:scanf("%*s");for
(P=A(double,N*2);j<N;)Q[j++]/=b;o(U);I=
p/1E3;J=q/1E3;K=U;L=U;N/=3;F=A(int*,     4*N
);V=F+2*N;for(;u==v;){for(j=u=m=n     =0;j<3
*N;j++)P[j]=Q[j]+(U)/1E5;for(;     m<N;m++)u
=P[u*3]>P[m*3]?m:u;for(v=!u     ;n<N;n++)v=B
(u,v,n)>0?n:v;}for(puts(     "\x1b[2J"),M=G(
u,v,-1,-1,0);;K+=I+0,     L+=J){for(i=4;i<W*
H/2+3;T[++i]=j=0)T     [i]=i%W-3?32:10;for(;
j<M;j++){for(n=     k=0;F[j][m=n]<0;)n++;for
(;u=F[j][m]*     3,o(K=K<-1?K+2:K>1?K-2:K),c
=z=9*p,b=     9*q,o(L=L<-1?L+2:L>1?L-2:L),a=
x=b*q,     y=b*=p,d=x-X,e=y-Y,f=z-Z,o(d*d+e*
e+f     *f),p=C,q=C,r=C,k+=2,m=F[j][m],m-n;)
     ;for(p=n=0;n<k;n+=2)p+=P[n]*(P[(n+3)%k]
  -P[(n+k-1)%k]);for(q=time(0)<t+3;(q||p>=0)
     &&n;){a=P[n%k];b=P[n%k+1];c=P[n-=2];d=P
        [n+1];e=d-b;i=e*e>(c-a)*D(b,c)0>D(c,
           b)for(;c-a&&u<c+.5;0<=w&&w<W-1&&0
              <=m&&m<H?v=m/2*W+w+4,T[v]="',"
                 ";;;,;'"[T[v]%8^m%2]:0)m=v=
                    (d-b)*(u-a)/(c-a)+b+0.5,
                       w=i?m=u++,v:u++,u=u<c
                          &&q?c+0.5:u;}}puts
                             (T);nanosleep(&
                                R,0);X=x;Y=y
                                   ;Z=z;}}/*
                                      IOCCC*
                                         \*/
