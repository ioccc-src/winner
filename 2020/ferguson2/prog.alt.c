%:include					    <stdio.h>
%:include					    <ctype.h>
%:include					   <string.h>
%:include					   <stdlib.h>
%:include					   <unistd.h>
%:define J(x)		  do(*x)=getchar(); while((*x)=='\n')

%:define A(y)				  *(&Y<:7:><:1:>+(y))
%:define D					      strchr(
%:define q(s,x)					D(s),(x))-(s)

%:define n					      isalpha
%:define V(k)				    E = q(Y<:8:>,(k))
%:define K				      fprintf(stderr,
%:define l(c)				     (c)=toupper((c))
%:define W(a,b)			 (a)<:(q((a),(b)) + 1) % 26:>
%:define O(a)		      k = Y<:8:><:(E - (a) + 26)%26:>
%:define d(a,b)                           v=(a)<:(E+(b))%26:>
char*M,*R<:3:>,Y<:20:><:27:>=<% "EKMFLGDQVZNTOWYHXUSPAIBRCJ",
"AJDKSIRUXBLHWTMCQGZNPYFVOE"  , "BDFHJLCPRTXVZNYEIWGAKMUSQO",
"ESOVPZJAYQUIRHXLNFTGKDCMWB"  , "VZBRGITYUPSDNHLXAWMJQOFECK",
"YRUHQSLDPXNGOKMIEBFZCWVJAT"  , "FVPJIAOYEDRZXWGCTKUQSBNMHL",
"ABBBCCQEVJZ","ABCDEFGHIJKLMNOPQRSTUVWXYZ", "Mjqq", "Lcxvago"
,"Huwfnbgt","Hdoqhmket fbvy","Mcromlhxo"} ,*S,*r; int *z=(int
<:13:>){ 0} ,*e,*g,*P; size_t L; char Z(char x){ for(*g=0; *g
<10;++*g) {r<:-2:>=Y<:14:><:*(e+1):>; r<:-3:>=Y<:15:><:1<:e:>
:>; if(r<:-3:> && r<:-2:> == r<:-1:>)return r<:-3:>; if (r<:-
2:>&&r<:-3:>==r<:-1:>)return r<:-2:>; }return x; } void  w  (
char *s, int k, int v) {  for(e<:2:> = 0; s<:*P:>; ++e<:2:>){
v = s<:e<:2:>:>; if(v > 64 && v < 91) s<:e<:2:>:> = (((v - 65
+k) % 26) + 65); } } void Q(void) { for(*g = 0; *g < 3; ++*g)
{ *Y<:16+e<:1:>:>=S<:e<:e<:1:>-3:>:>;R<:e<:1:>:>=Y<:e<:-3+e<:
1:>:>:>; w(R[*g],*(e+e<:1:>-6)=q(Y<:8:>,*Y<:7:>),*g); } }void
m(char*x){ char*p=x,a=A(0),b=A(2),c=A(4); int f,E; for( ; *p;
++p) { int u = islower(*p); if(n(l(*p))){char k=*p, v; f = 0;
c == *Y<:18:> && (f = 1) ; c=W(Y<:8:>,c); if (f) {f = 0; b ==
*Y<:17:> && (f = 1); b = W(Y<:8:>,b); f &&(f = 0 && (a= W(Y<:
8:>,a))); }else if(b==*Y<:17:>){ b = W(Y<:8:>,b); a= W(Y<:8:>
,a); } k = Z(r<:-1:> =k); e<:-6:> = q (Y<:8:>,a); e<:-5:> = q
(Y<:8:>,b); e<:-4:>=q( Y<:8:>,c); V(k); d(R<:2:>,e<:-4:>); V(
v); O(e<:-4:>); V(k); d(R<:1:>,e<:-5:>); V(v); O(e<:-5:>); V(
k); d(*R,e<:-6:>); V(v) ; O(e<:-6:>);(Y<:e<:-10:>+ 5:><:k-'A'
:>)&&(k=Y<:e<:-10:>+5:><:k-'A':>); V(k); d(Y<:8:>,e<:-6:>); E
=q(*R,v); O(e<:-6:>); V(k); d(Y<:8:>,e<:-5:>); E= q (R<:1:>,v
); O(e<:-5:>); V(k); d(Y <:8:>,e<:-4:>); E = q(R<:2:>,v); O(e
<:-4:>); k = Z(r<:-1:>=k); *p = u? tolower(k):k; } } } void E
(char*x, int s, int i){ if (n(l(s))) x<:i:>=s; } int p(char x
) {return D 14<:Y:>,x)||D Y<:15:>,x); }int main(int i, char**
v) { int j; e = z + 10; S = Y<:7:> + 6; r = S + 10 ; g = e +1
; P=g+1; for (j=-3; j < 0; ++j) e<:j:> = j+3; Q(); for (j +=9
; j < 14; ++j) m(Y<:j:>); if (!(v<:1:> && *v<:1:>=='-')) goto
k; for (i = 0; i < 3; ++i) { K"%s %d: ",Y<:9:>, i+1); J(&j) ;
j = j - '0'; e<:i-3:>=(j <1 ?  1 : (j>5?5:j))-1; K"%s %d: ",Y
<:10:>,i+1); J(&j); E(Y<:7:>, j, i+i%3); K"%s %d: ",Y<:11:>,i
+1); J(&j); E(Y<:7:>, j,i+i+1); }K"%s: ",Y<:13:>); J(&j); e<:
-10:> = (j < 1 ? 1:(j>1?2:j))-1; for (i = 0; i<10; ++i) { int
a, b; K"%s %d: " , Y<:12:>,i+1); J(&a); J (&b);if  (n(l(a))&&
n(l(b))&&a!=b&&!p(b)&&!p(a)) { Y<:14:><:i:> = a; 15<:Y:><:i:>
= b; } %>k: Q(); if(getdelim(&M, &L, EOF, stdin) > 0) <%m(M);
for(int i=0;i[M];putchar(i[M]),fflush(stdout),usleep(0<h?h:4\
00000), ++i); free	(M)        ;}%>
