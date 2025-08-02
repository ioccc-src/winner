


                                     /* N/+
                            + +   /  n /  /  /    +
                        T/      +k  NXr        /    , /,
                     /;  t  t/      nt /C   * l    %    d
                  v     %   +i  =cS*Dc /=/1 /]+k    s o D   0+
                + A    *;  =     ; / %#3:   i o    C   /OC X*)
              +     C  ,    >      !3=(s 8  (      *   *     { ,/+
            +  4t niN  !    o f  */long/*  / n / ** T    +C C 5  , a
           +          %= * *   */long/*      */N,M,/*a1%(*-,    *   o
          +(+/  io    5a(M  A */S,T,W/* */,X;char A[/*I      /[   ct 5
         +k/    i  / /%c1[ds  */9999][9999]={0},B/*        i   d /    +
        + / *v R*   d*/[/*o*/9999][9999];void Q/*   c     c2 N   W  [  +
        ;       N;  */(int/**/t,int d){for(int i,j,k=~/*M        C /  o]
       +  t , v     **/d/2*3+3,l;j=k!=2,k-(3+5*d)/2;k+=d)/*   i         +
       + ,s / *IO aQ */{long long m=M*N,n=j?M:N,u=(2*k-k/2*3/*b c   S r +
        / *=   }/     */-k/3*5)*d,x,y,w,s;for(i=m;i--;)B[i%N/**   c *ira
      d*   / * ]!      */][i/N]=A[i%N][i/N];for(i=n;/* * *, =!n%   i  AA +
      +D   ^    /-=+     */i--;){s=S+k;for(w=0,l=6;l-=2/*       ]c  ;C R +
          * D,  c**/;s=(s+T)*W%X,x=l*i+s%W*n*t/W/5+n*(n+/* b /         *
       +  dr+ =   */s%W)-n*t/10,w+=x%n*(n-x%n)*(x/n%2*2-1/*       I  C  +
       +   ; ~t   / {*/)*(3+k%3+k/2));w=(w+n*n/(w>0?2:-2)/*0  (  /-A ),N+
        ,  C=     =  * **/)/n/n;for(l=j?N:M;l--;x=   j*i+u/*/nC    M [A+
         =*    %+  /      n    */*l+m*4,y=!j*i+d*j/***/*l/*  o/N=   /  +
         ; N*  i    * C   D  */+m*4,A[y%N][x%M]=B/*rc  %i2/      d   v+
          8    )ic i   b0 */[(y+d*j*w)/*N*/%N][(/*  /  3*- Anc ; c  Ng
           + sv ok{  [[>=*/x+u*w)/**  T  */%M])/*  a *  +3 /   /    +
            + i-d=    c o/       i     */;}}}/*    I o -} ] OA  /r i
              /5  1/ d+ *g  c /+ a    ( ia2(]   *  O*    /d/ ;   0
                +ck d  ,,o  vv a/      2+13 k   nd}   C  c     >
                  / * o> b]  < a     %-       nr o / =    C/ +
                     N Rn*     /   r     h  a          =  +
                        + R   C O   O0c s +l*a  R     *v
                            A;+I   *  N )  n *rW< +%
                                     o+ +*/



#include <stdio.h>
#include <unistd.h>

void      P(int   c){int i   =M*N;for(   ;i--;){A[i%N] [i/N]=(!(c= A[i%N   ][i/N
])?32     :c);}  }int main(  int u,char  **v){char *s; int x=0,y=0 ,i,j,   n[256
]={0}     ,a,b, c;W=33331;X= 33333331;N= 40;S=T=0;if(+ --u&&sscanf  (*++v ,"%l"
"ld",&   N)){-- u;v++;};if(u )for(s=*v++ ;*s;)T=(T*W+* s++)%X;for(  ;(c=getchar
 ())>=   0;n[c  ]++)c-10?A[y ][x++  ]=c:(    y++,x     =0);M         =2*N;P(0)
 ;for(i =33;i<  127;i  ++)S= (3331  *S+n[    i])%W     ;for(i=c=0;    128>i;i
  ++){x=-(6>>   i/32    )%2* 2+1;Q((96+i     *x+~-     x/2)%32,x);     for(j
  =a=0;i%64==   31&&    j<N* M;b=A[j/M][     j%M]&     95,c+=x*(a|     !b&&(
   j%M)),a=b    ,j=1+  j);}; for(x=0;32      >=x;x     ++){j=9999;    while(j
   --){s=A[j    ];while(*s)s ++;while(*      --s==     32)*s         =0;}for(j
    =x/32,a     =~-9999;~j;j --){;for(;a     &&!*A     [a];)a--;fprintf(stderr,
    x?"%s":     "%s\033[2J", "\033" "[H")    ;for(     i=0;j?i<=a:  i<y|| i<N;i
     ++)!j       ?!fprintf(  stderr  ,"%s\033[K\n"     ,A[i]):puts (A[i]   );}P(
      0);         if(x-32)   c<0?Q    (31-x  ,-1):     Q(x,1);usleep(W<<   1);}}
