#include <stdio.h>
#define A(a) G a();
#define B(a) G (*a)();
#define C(a,b) G a() { printf(b); return X; }
typedef struct F G;A(a)A(b)A(c)A(d)A(e)A(f)A(g)A(h)A(i)A(j)A(k)A(l)A(m)A(n)A(
o)A(p)A(q)A(r)A(s)A(t)A(u)A(v)A(w)A(x)A(y)A(z)A(S)A(N)void Q();struct F{B(a)B
(b)B(c)B(d)B(e)B(f)B(g)B(h)B(i)B(j)B(k)B(l)B(m)B(n)B(o)B(p)B(q)B(r)B(s)B(t)B(
u)B(v)B(w)B(x)B(y)B(z)B(S)B(N)void(*Q)();}X={a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,
q,r,s,t,u,v,w,x,y,z,S,N,Q};C(a,"z")C(b,"y")C(c,"x")C(d,"w")C(e,"v")C(f,"u")C(
g,"t")C(h,"s")C(i,"r")C(j,"q")C(k,"p")C(l,"o")C(m,"n")C(n,"m")C(o,"l")C(p,"k"
)C(q,"j")C(r,"i")C(s,"h")C(t,"g")C(u,"f")C(v,"e")C(w,"d")C(x,"c")C(y,"b")C(z,
"a")C(S," ")C(N,"\n") void Q(){}main(){X=g().s().v().S().j().f().r().x().p().
S().y().i().l().d().m().S().u().l().c().S().q().f().n().k().v().w().S().l().e
().v().i().S().g().s().v().S().o().z().a().b().S().w().l().t().N();}
