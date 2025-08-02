double static F=
  1.5e-3
,t,b,D[1<<20],*E,U[4],X;

int static B=
  17e3
,J,I,N;

unsigned static q0[]={
  0x0ce97522,
  0xc02972e5,
  0xeceddaca,
  0xfeedfaad,
};

int static q1[]={
  -2, 0,  7,
   0, 3, 10,

  -5, 0, 0,  2, 3, 0, 2,  2,
  -2, 0, 7, 12, 3, 7, 5, 10,

   0, 3, -5,
  -2, 7,  3,
  -2, 2, -5,
 -10,-2,  5
}

; char static*q2[]={
  "XBWFgnu!"    ,
  "ebub","SJGG" ,
  "\njust a moment.."
} ,*P,M[1<<29]

#define S sin
#define O pow
#define H tanh
#define C(b)double*j=G(n+2),o; int c=(int)j[n+1]; b; if(++c>=n)c=0; j[n+1]=c; return o;
#define A(n)for(j=0; j<n; ++j)
; int  static  T( int x )       { return I/(B<<x)                           ; }
double static dp( int a,int  c ){ return (double)((I+B*c)%(B<<a))    /(B<<a); }
 void  static  L(short w){ *P++=( char ) w; *P++=w>>3                    >>5; }
double static  Q( int a )       { return dp                            (a,0); }
 void  static  Z(char*s ) { for ( char*q=s; *q; ++q, ++P) *P=*q           -1; }
double static qb( int p )       { return I%p<p>>2                      ?1:-1; }
double static* G( int n ) { E+=n; return E                                -n; }
 void  static  W( int l ) {  L( ( short )l);  L((short)(l>>13            >>3) )
                                                                            ; }
#include  <math.h>
#include<stdlib.h>
#include <stdio.h>

void static Y(double p, double g, double e, double r)
{
  U[2] += e           * X               ;
  U[0] += X           * p * fmin(1,1-g) ;
  U[3] +=               r * X           ;
  U[1] += fmin(g+1,1) * X * p           ;
}

double static eq(double x,double a,double h,double c,double d,double e)
{
  double    *z=
  G(2) , y=a*x+
  z[0] ;
  z[0] = x*h-d*y+
  z[1] ;
  z[1] = c*x-y*e;
  return y;
}

double static ap(double x,int n,double f,double d) { C (
  o=
  j[c]   ;
  j[n] =o* (1-d)+
  j[n] *d;
  j[c] =x+
  j[n] *f
  ;
  )
  } double         static cm
  ( double x,int n,double
  f         )
  {         C
  ( double u=
  j [c  ]; o=u-x;
  j[c ]     =f*u+x; )
       }   int
  main
    (   void     )
         { int j  ,
   k  ,  l ,  m    ;
 char  *  px   =    P
   =  M
       ,
     *        pa  ,
       *
p0         ; FILE
 *    o    ;



  N=(B*5)<<8;



Z ( q2 [ 2 ] )  ;   W
( 36 + ( N << 2 ) ) ;
Z    (  q2  [  0 ]  )
;  W  ( 16      )   ;
L (   1  )   ;  L ( 2
)  ;  W (   1 <<   18
)  ;  W (   4 <<   18
)  ;  L (   4  )   ;L
( 16    )   ; Z  ( q2
[1 ]    )   ;  W(N <<
2) ; for( pa  = P ; ;
) {  E= D  ;  A ( 4 )
U [   j ]     = 0   ;











  l=((T(3)+32)%64)-61;
  t=H(Q((l<0?3:l)));
  X=H(50*S(t*141+t*(15e3/(4+t*330)))*O(1-H(t),9));
  if (T(10)) X=0;
Y(.5,0,.07,.1);


  X=0;
  A(8) X+=qb(211+(j*113+T(2)*91)%1291);
  X=eq(X,.973,-1.946,.973,-1.942,.951);
  X=H(X*2);
  l=T(4)%8>6;
  switch (T(8)) {
  case 0           : t=H(Q((T(4))%4)); break;
  case 2           : t=H(Q(2-l));      break;
  default : case 1 : t=H(Q(1-l));      break;
  } if (++I>N)                         break;
  X*=O(1-t,4)*O(Q(3),2);
  X=H(X*1.4);
  if (!(T(7)&7) || T(10)) X=0;
Y(.8,S(I*1e-5),.16,.4);


  t=1-(((T(2)&63)>61)?H(Q(1))/6:H(dp(4,8)));
  X=I&(1<<12)?(double)(rand())/RAND_MAX-.5:.1*qb(1400-(int)(t*301));
  X=H(30*X*O(t,40));
  if (!(T(7)&3) || T(10)) X=0;
Y(.8,.3,1,.3);

  l=T(6)%4;
  k=(q0[l>2]>>((T(3)&7)<<2))&15;
  b=F*I*O(2,(double)k/12);
  k=T(8)%2;
  m=((q0[2+l%2])>>(T(1)&31))&1;
  X=m?S(b+1.5*S(I*7e-5)+S(I*3e-7)*(4+3*S(I*1.7e-7))*S(b*(1+k))):0;
  if (T(8)) X+=((S(b*.501)>.95)-(S(b*.498)>.8))*15*O(Q(3),2);
  t=1-H(Q(1));
  X=H(25*X*O(t,3));
  if (T(10)) X=0;
Y(.4,0,.12,.02);


  A(3) {
    k=T(1)%32+3;
    k-=k/4*3;
    l=T(6)&1;
    k=l ? 24+q1[6 + T(7)%2*8 + T(3)%8] : T(9) ? 24+q1[22+(k+j)%3+T(4)%4*3] : q1[k%3+T(7)%2*3] + (k/3)*12;
    X=F*I*O(2,((double)(14+k)+(j-1)*.4)/12)+S(j+I*(l?1e-4:3e-4))*(l?4:1);
    t=S(X)+.3*(fmod(X,6.3)-3);
    X=t+.3*(t>.9*S(I*6.3e-7)?1:-1);
    t=1-H(Q(l?2:m?2:1));
    X=H(X*O(t,9)*(T(10)?O(1-Q(8),3):1));
    if (T(6)%2*!T(9) || !T(8)) X=0;
Y(  1,S(2*j+I*3e-6),.3,.3);
  }

  X=ap(U[3],(int)(B*6.1),.2,.2);
Y(1,-.6,.1,0);
  X=cm(U[3],(int)(B*3.8),.2);
Y(.7,.6,.1,0);


  for (k=0; k<2; ++k) {
    X=0;
    A(8) X+=ap(U[2],4001+(j*2131+k*1555)%3491,.8,.5);
    A(4) X=cm(X,800+((j+T(8))*1337+k*1441)%1303,.4);
    X=H(X/4);
Y(  .3,k?-1:1,0,0);
  }









   A(
   2)
   L             (
       (           short)
   (fmin            (1
   ,fmax            (-1,
   U                  [
   j                  ]
   )                  )    *32e3
   )   );   if        (        !
   (   I    %(
   B   *    8)        )        )
   { putchar  (q2
   [3         ]
         /*{*/[
   ++J&15     ]       )        ;
fflush  (   stdout    )        ;
              }       }  pa=P  ;
  Z("opx!fokpz!"      ); p0=P  ;
  Z("qsph/xbw"        );
  o=fopen(p0,"wb")     ; fwrite(
          px,         1,       (

  unsigned
  long )( pa-px),o); fclose(
  o); puts  ( pa ) ; return(

                signed
                )0; }
