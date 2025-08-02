#include <stdio.h>
int main(void){
int i,j;
#define G "#define "
#define L p("#include __FILE__");
#define p puts
#define t printf
#define d(s,a)p(G#s" "#a);
#define g(s,a)p(G#s"(a,b) "#a);
#define e(s,x,y,z)p(G#s" "#x","#y","#z);
#define b(s)p("#if "#s);
#define u(s)p("#undef "#s);
#define l p("#else")
#define n p("#endif")
#define f(s)\
d(s##30,0) \
for(i=31; --i; n) { \
t("#if ("#s")/%d&1\n",1<<i); \
t(G#s"%d "#s"%d|%d\n",i-1,i,1<<i); \
l; \
t(G#s"%d "#s"%d\n",i-1,i); \
} \
b(s>0); \
u(s)\
d(s,(s##0)) \
l; \
u(s)\
d(s,-(s##0)) \
n;
#define r(s) \
u(s) \
for(i=31;i--;) \
t("#undef "#s"%d\n",i);
#define F(s) \
d(s##A,c(A,s)); f(s##A); \
d(s##B,c(B,s)); f(s##B); \
d(s##C,c(C,s)); f(s##C); \
u(s); e(s,s##A,s##B,s##C);
#define I(d,m,e) \
t("#if (c(%c,Z))/"#d"%%"#m"==%d\n",j,e)
#define J(a,b) \
for(i=10; i--; n){ \
I(a,10,i); \
t(G b"\n",i); \
}
#define X(v,p,q,r) \
e(v(x,a,b),x(A(a),p(b)),x(B(a),q(b)),x(C(a),r(b)))
#define T(x)\
d(i,N(o,t,h)) \
d(M,m(d(i,i))) \
f(M); \
d(j,d(g,O(U,i,M))) \
b(j<0) \
e(x,0,0,0) \
l; \
d(x,O(U,O(k,u,j),d(i,i))); \
n; \
F(x) \
u(i) \
r(M); \
u(j) \
n;
e(p,0,500,4000)
d(q,2000)
e(r,300,300,300)
e(s(x),900,200+x*700,900)
e(t,-2000,4000,1000)
e(u,50000,50000,50000)
e(v(x),500-x,500-x,500)
b(S)
d(V,N(o,P,p))
d(G,d(Q,Q))
d(f,d(V,Q))
d(Z,l(f)-k(G,(d(V,V)-l(q))))
b(Z>0)
d(M,m(Z))
f(M);
d(R,U(-M-f,G))
b(R<0)
u(R)
d(R,U(M-f,G))
b(R<0)
u(R)
n;
n;
n;
b(R)
f(R);
r(M);
d(h,N(K,P,O(k,Q,R)))
d(g,O(U,N(o,h,p),q))
T(D);
r(M);
u(V)
u(G)
u(f)
u(Z)
b(R>10)
d(F,N(K,O(k,g,10),h))
d(I,N(o,Q,O(k,g,d(g,Q)*2)))
F(F);
F(I);
u(P)
u(Q)
d(P,F)
d(Q,I)
u(h)
u(g)
r(R);
L
u(V)
d(V,N(k,N(K,D,w),r))
l;
u(h)
u(g)
r(R);
b(c(B,Q))
d(R,U(-2*S-c(B,P),c(B,Q)))
b(R<0||20000<R)
u(R)
n;
n;
b(R)
f(R);
d(h,N(K,P,O(k,Q,R)))
e(g,0,S,0)
T(E);
b(R>10)
d(w,N(k,O(k,E,l(c(A,h))+l((c(C,h)-c(C,p)))<l(q)?100:S),s((T(c(A,h))==T(c(C,h))))))
l;
d(w,v(c(B,Q)/2))
n;
F(w);
d(V,w)
n;
l;
d(S,1000)
g(K,(a+b))
g(o,(a-(b)))
g(k,((a)*(b)/S))
g(U,((a)*S/(b)))
d(l(a),k(a,a))
g(n,(b?(U(a,b)+b)/2:0))
d(m(x),n(x,n(x,n(x,n(x,n(x,(x)/2))))))
d(T(x),(x>0?x:S-x)/S%2)
d(A(x,y,z),x)
d(B(x,y,z),y)
d(C(x,y,z),z)
g(c,a(b))
e(L(a,b),a(A(b)),a(B(b)),a(C(b)))
X(N,A,B,C)
X(O,,,)
g(d,(k(A(a),A(b))+k(B(a),B(b))+k(C(a),C(b))))
e(Q,(S*X/W*2-S),(S-S*Y/H*2),S)
e(P,0,0,0)
L
d(e(x),m(x<0?0:x>S?S:x)*255/S)
d(Z,L(e,V))
for(j=64; j++<67; ){
I(100,10,0);
d(x(a),a)
l;
J(100,"x(a) %d##a")
n;
I(10,100,0);
d(y(a),a)
l;
J(10,"y(a) x(%d##a)");
n;
J(1,"z y(%d)");
p("z");
u(z)
u(y)
u(x)
}
n;
}
