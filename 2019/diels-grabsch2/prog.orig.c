#include <stdio.h>
#define  f(f,g){z e=0;for(;e<f;e++)g;}
#define  i(f,g)static z f(z a){return g;}
#define  j(f,g)static void f(z*a,z*b,z*c){g}
#define  h(f,g)static z f(z a,z b,z c){return g;}
#define  g(f,g,h,i,j)static z f(z b){z a=g,c=h;for(;i)a=j;return a;}
typedef unsigned char y;typedef unsigned long long z;extern y*w;static z b(z a,z b){return a>>b|a<<(64-b);}i(_,
(a>>6)^b(a,61)^b(a,19))i(_a,b(a,39)^b(a,28)^b(a,34))h(x,((a^b)&c)^(a&b))i(u,b(a,41)^b(a,18)^b(a,14))h(t,(((((3*(a*c+b*b)>>9)+(3*
b*c>>32))*a>>21)+(3*a*a*b>>6)+((b>>4)*(b>>4)*b>>46))>>18)+a*a*a)h(m,t((b<<16)|(c>>48),(c>>24)%(1<<24),c%(1<<24))>>48<a)h(s,(a&b)
^(~a&c))i(r,b(a,1)^b(a,8)^(a>>7))g(o,0,0,c<8;c++,a*256+w[b*8+c])g(d,0,0,c<13;c++,a*31+w[b*13+c]-96)g(p,0,4,c;c/=2,a|c*m(b,a|c,a)
)g(q,0,1ull<<63,c;c/=2,a|c*m(b,p(b),a|c))g(v,b>1,2,c<b;c++,a&&b%c)g(l,b?l(b-1)+1:2,a,!v(c);c++,c+1)j(n,z d=a[7]+u(a[4])+s(a[4],a
[5],a[6])+q(l(*b))+c[*b%16];f(8,a[7-e]=e-3?e-7?a[6-e]:d+_a(a[0])+x(a[1],a[2],a[3]):d+a[3])f(16*(*b%16>14),c[e]+=c[(e+9)%16]+r(c[
(e+1)%16])+_(c[(e+14)%16])))j(k,f(8,b[e]=a[e])f(80,n(a,&e,c))f(8,a[e]+=b[e]))int main(){z a[8],b[8],c[16];f(8,a[e]=d(e))f(16,c[e
]=e-15?o(e):d(8))k(a,b,c);f(16,c[e]=e?e-15?0:11264:1ull<<63)k(a,b,c);f(8,printf("%016llx%s",a[e],e-7?"":"\n"))return!w;}y*w=(y*)
"crsmyiajqhwy{unwa|hjoi`hlxhpxrzb~edko~rtr~ileqyjk`znqgsuitvgqnfdfa||wedvnmhozkpokootqzcexeld~oibqzpcsuw{ib{x`m`hsa`jmn}wcfzpb";
