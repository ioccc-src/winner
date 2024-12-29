#include<curses.h>
#include<stdlib.h>
#include<unistd.h>
#define E x/Y
#define F x%Y
#define P(  o  ,  O  ,  t  )  move  (  o  +  3  ,  O  +  3  )  ;  addch  ( t );
#define I(n) ( 2 * ( n / ( X + Y ) ) - 1 + ( ( n % ( X + Y ) - X ) < 0 ? 1 :2))
#define D(T) switch(I(p)){ case 3:P(2*(X+Y)-1-p,-2,T); break; case 2:P(Y+1,2*X\
+ Y-p -1, T);  break;  case 1:P(p-X, 1 +X, T);  break;  case 0: P( -2, p, T); }
#define R for(x=0; x<X*Y; x++){ P(F,E,(L[E][F]>84)?42:L[E][F]); } move(5+Y,2) \
;  clrtoeol();  printw("score: %d", s);  move(0, 0);  clrtoeol() ;  refresh() ;

 int main(int t, char *u[]) { char c, *C="POOT", L[99
 ][                                                99
 ]; int X, Y, n, x, a, b, A,  B, p, s, S ; X = Y=  p=
                          s=  0;               if  (t
                          ==  3)               {   X=
                          atoi (               u[ 1])
                           ; Y  = atoi(u[2]); }   if
                            (X                   <6
                             || X > 98|| Y > 98 ||

      Y < 6 ) { X = 15 ; Y = 12; }
  initscr                      (); for
 (x        =0; x < X * Y; x++        ){
 L[     E][F                ]=32    ; P
 (-    1,                      E,    45
 );    P(                      Y,    E,
 45     ); P                (F,-     1,
 124       ); P(F, X, 124); }        P(
  -1, -1,                      43); P(
      -1, X, 43) ; P(Y, -1, 43 ) ;

      P(Y,X,43); c=C[random()%4];
  D(c); R                     ; for(; 
 ; )      { switch (x = getch       ()
 ){     case               97 :     D(
 32    );                     if   (--
 p<    0)                     p=    (X
  +Y    )*2-1;           break;   case
 115      : D(32); if (++p >        (X
  +Y)* 2-                     1) p =0
      ; break ; case 100: a = ( (
                                    n=I(p))%2)
                                    ?X      +(
                                    n/2)*(  1-
                                        X)  -1
                                        :(  1-
n)*p+(n/2)*(2*X+Y-1); b = (n%2)?((n/2)?(2*  (X
+Y                                          )-
p-1): (p-X)) :Y+ ((2-n) /2) *(1-Y)-1; if(L  [a
                                        ][  b]
                                        !=  32
                                    )break ; A
                                    =(      n%
                                    2)?n-2:(n-

1)*((c%3-1)*-1); B=(n%2)?(n-2)*((c%3-1)*(-1)):(n-1)*-1; D(32); for(; ; ){ P(b,
a,32); if((!a)&&A<0)if(!B){ A=0; B=1; } else A*=-1; if((!b)&&B<0)B*=-1; if(( a
==(X-1))&&A>0)if(!B){ A=0; B=1; } else A*=-1; if(((b==(Y-1))&&B>0)||(L[a+A][b+
B]!=32))break; a+=A; b+=B; P(b,a,c); move(0,0); refresh(); usleep(5000); } ++s
; L[a][b]=c; c=C[random()%4]; p=0; f:for(S=1,x=0; x<X*Y; x++)for(A=-1; A<2; ++
A)for(B=-1; B<2; ++B)for(n=0; n<4; n++){ a=E+n*A; b=F+n*B; if((!(a<X&&b<Y&&a>=
0&&b>=0))||((L[a][b]!=C[n])&&((L[a][b]-9)!=C[n])))break; if(n==3)for(n=0; n<4;
n++,S*=2)L[E+n*A][F+n*B]+=9; } if(S>1){ R; sleep(1); s+=S; for(x=0; x<X; x++ )
do for(n=0,a=Y-1; a>=0; a--){ if(L[x][a]>84)n=1; if(n)L[x][a]=a>0?L[x][a-1]:32
;   }  while  (  n  )  ;  R  ;  goto  f  ;  }   }  D  (  c  )  ;  R  ;   }   }
