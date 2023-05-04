







                                      T(c,r) ??< return Y(c, r)?'??(' :' '; ??>
                                      W(r,a,b,c)??<return r==a||r==b||r==c; ??>
                          /* {   /KC 0000 K  } */
                          char*B=" yz0123456789";
          U(c,i)char*c; ??<while(i++<80)printf(" "); puts("|"); ??>
          char* B,*r; X(c,k)??<return isupper(c)?0:V(*(r+k),B); ??>
         L(c,i,j)char c??(81??)??(81??);??<G(*                (c+i),*(c+j));??>
  char*r=     "008y8yy8yyyyz8z8z88888z0yyz888 8888            88y00zz00z0088";
 E(r,s)char*r,*s; ??< if(t(                         0,1)&& F(r,s)<0)G(r,s); ??>
 char*d= "yyzzyzz zz z0y000 zz 00yzz00y00yzz Brian Westley zyy00yy0yy 0" ; ; ;
 t(a,b)??<return a;??>
#define t(a,b) t(b,a)
A(i ,c,j ,k) char *c; ??< for(j= -1; ++j<i; )for (k =j; k<i; )D(c ,j, k++); ??>
D(c,i,j)                        char c??(81??)??(81??);??<E(*(c+i),*(c+j));??>
F(r,s)char*r,*s; ??<return                          t(0,1)?H():strcmp(r,s); ??>
G(r,s)char*r,*s; ??<char t??( 81??); strcpy(t,r); strcpy(r,s); strcpy(s,t); ??>
H()??<static i=0; if (!i) ??< time(&i); srand(i); ??> return rand()-rand(); ??>
J(i,c,j)char*c; ??<for(j=t(i,0)            ; j+j<i; j++)L(c,j,i-j); M(i,c); ??>
M(i,c)char c??(81??)??(81??);??<i++;while(i--)t(1,0)?puts(*(c+i)):P(*(c+i));??>
P(c)char*c;                  ??<Q(1,0); R(c,1                    ); Q(0,0); ??>
Q(t,i)??< printf(t?" ":"|"); for(; i<80; i++) printf("_"); puts(t?"_":"|"); ??>
R(c,r) char *c; ??< printf( "/%-80s|??/n" ,c); for (; r< 13; r++)S (c,r,0); ??>
S(c,r,i)char*c; ??<printf("|");for(;*(c+i); i++)putchar(T(*(c+i),r));U(c,i);??>
V(c,k,i) char*k; ??<for (i=0; *(k+i) &&*(k+i)!=c; i++); return *(k+i)?i:-1; ??>
char* K;Y (c ,r) ??< int i=V ( tolower (c) ,K); return(i <0)?1 :Z(c ,r, i); ??>
char* d,*m,*B; Z(c,i,k)??<return W(i, V(*(d+k), B),V(*( m+k),B) ,X(c, k)); ??>
char*K= "gh$j|lm'pq&rv<x>z#);@_winky,.%/+*!=3-284106579 (:obfuscated??/?" ; ;
char*m= "7831734578 9547693564569528334164263z284106579 52626423135477"; ; ; ;
main(i)??<char c??(81??)??(81??);for(i=0;gets(*(c+i)); i++);A(i,c);J(i-1,c);??>
