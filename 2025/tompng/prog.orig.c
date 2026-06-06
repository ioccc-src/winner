#include<math.h>
#include<time.h>
#include<stdio.h>
#include<stdlib.h>
#define D    double
#define r      rand()
#define R (D)r/RAND_MAX
#define E(i)t=s[i];s[i]=(\
s[i]*x-s[i+1]*y)*f[i/2]+v;s[i+                                1]=(t*y+s[i+1]*x)*                                 f[i/2];
D F(D*s,D e,D x,D y,D v){D f[]={e,                       e*e,e*e*e},t ; E(0)E(2)E(4)                        return sqrt(
1-e)*20*(s[0]-2*s[2 ]+s[4]);}D*I[13],*J[           195],K[18][6],M[6] , N[3],O[10],Q,S,T;              int U[6],V[13],W[
195],H=44100,X,SEED,P=13,L=sizeof(D);void G(int a){D**b=I,*o,g,c,d,e,f;for(int*p=V,l,h,i=0,j,k,m,n;i<15-5*a;i++,b=J+l,p=
W+l)for(k=P,l=i*k;k--;){h=r%P;c=a?(d=R*H/2,e=1,f=1+R/5,.3):(d=(.2+R)*H/3*pow(1.1,i),e=1.2+R/10,f=1.3+R/5,.5);if(r%2)g=e,
e=f,f=g;g=c+R;c+=R;J[l+k]=o=calloc(W[l+k]=j=fmax(p[k]/e,p[h]/f+d)+1,L);while(j--)m=j*e,n=fmax(j-d,0)*f,o[j]=g*(m<p[k]?b[
k][m]:0)+c*(n<p[h]?b[h][n]:0);}}int main(int _,char**A ) { D x,y,z,e,f[7],g;int a,b,c,d,i,j,k,h[]={750912,619552,553760,
685360},n[256],o,l,m,t,u;char*v="sound.wav",*B;for(srand(time(0));*++A;a=a&&!*B?X?(srand(a),0):(X=a*H):(v=*A,0))a=strtol
(*A,&B,0            );X=X ?X:H*                 300  ;    for(k=P;k--;){D s[6]={0};     I[k]=calloc(   V [   k ]    = j=
28098,L)               ;for(i=0                 ;i<j;i    ++)I[k][i]=F(s,.998,.9995     ,.0316,R-.5)*    pow(.1    ,i*8.
/H)-8e-6    ;}G(0)      ;for(k=    P;k--;){I[k]=calloc    (3e5,L);for(i=15;i--;){a       =i*P+(k+i)%P;    b=r%    3000 ;
for(j=W[    a];j--;V     [ k ]=    fmax(V[k],j+b+1))I[    k][j+b]+=J[a][j]*pow(.63       ,i);} } G(1);{          FILE*w=
v[0]-45    ?fopen(v,    "wb"):    stdout;int   C []={    1179011410, X * 4 + 36,         1163280727   ,        544501094
,  16 ,    131073,H,    H* 4,1    <<20|4,1635017060,X    *4};for(i= 0 ;i<44;i++)         fputc(C[i/4]>>i      %4* 8 ,w);
for(i=0    ;i<X;i++     ){for(                 k= 3;k    --;U[k]++){if(!(j=U[k+    3])    ||U[k]>W[j])j=U    [k+3]=4*P+r
%(6*P),    N[k]=1      +R/3,U[                 k]=0;a    =U[k]*N[k];f[k]=a<W[j]    ?J[    j][a]: 0 ;}Q=Q*    .96+R-.5;S=
S*.99+              (x=R-.5);    T=T*.8+x; e=F(M,.7,    .71,.71,R-.5)*.6+11*(    M[1]-    2*M[3]+M[5]);      for(k=4;k--
;)f[k+             3]=F(K[k],    1-1e-5,1,0,R-.5);if    (i%(a=H*60)<1)l=r%4,m             =8+r%4,m+=m>        10,t= 2+r%
10,u=2    +r%10     ,o=0;g=0;    c=(i-H*10)%a;a=H/4;    j=c/a;if( !(c<0||c%a               ||c>H*40))    {x    =fmin(1,(
H*45-c    )*.1/H     );a=o<m?    -1:n[o-m];b=j%(d=m*    8)<m;a=b?o<d?-1:n[o-    d]:a;a=    a<0||(j%(    m*4)    <m&&!b?R
<.5:R    <.2)?r%     5:a;a=R                 <.1?a%                 5+5:a;    n[o++]=a;    b=(H*40    -c)<8.    *H*R;d=j
%m;c=    d*t%P;if     (c<3+(                 (j/m/2                 ^u)%4)    ||((j+u)/    m%2&&c    >11)){if    (b)O[0]
+=x*R;else if((O[a]+=x*R,c=d%3)&&(c=o-7-6*c)>=0)O[n[c]]+=x*R;}O[0]+=.4*x*!d;}for(k=10;k--;)g+=sin(pow(2,k/5+(h[l]>>k%5*4
)%16/12.)/48*i)*F(K[k+8],.99,1,0,O[k]*=1-4e-5);for(k=2;k--;fputc(j=z*z*(3-2*z)*x/sqrt(1+x*x)*32768,w),fputc(j>>8,w)){j=2
*k-1;x=f[0]+(f[1]+            f[2])/2+(f[1]-f[2])*j/5;y=F(K[k+4],            1-1e-4,1,0,fabs(x));x+=y*T/1e4+F(K[
k+6],1-5e-5,1,                    0,y)*e/1e7+(Q*pow(1.5,f[3]+                    j*f[5]/9)+S*pow(1.5,f[4]+j*
f[6] /9))/                            32;x=x/ 9 +g/400;z=                            fmin(i/1e5,fmin((X-
i ) /                                      2e5,1));}                                      }fclose(w);}}
