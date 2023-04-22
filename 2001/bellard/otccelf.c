#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <sys/mman.h>
#define r *(char*)
#define b if(
#define t *(int*)
#define k else
#define u while(
#define g av()
#define c ax(
#define f ==
#define aj =mmap(NULL, 99999, PROT_EXEC | PROT_WRITE | PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0)
#define j ()
#define O return 
#define l a)
#define A int 
#define n 0)
#define o aw(
#define p 1)
#define q s)
A e,C,J,m,T,U,K,v,P,i,ak,Q,D,V,al,Z,G,R,y;
L(l{
r D++=a;
}
w j{
b V){
m=r V++;
b m f 2){
V=0;
m=al;
}
}
k m=fgetc(ak);
}
am j{
O isalnum(m)|m f 95;
}
an j{
b m f 92){
w j;
b m f 110)m=10;
}
}
g{
A a,s,h;
u isspace(m)|m f 35){
b m f 35){
w j;
g;
b e f 536){
g;
L(32);
t e=1;
t(e+4)=D;
}
u m!=10){
L(m);
w j;
}
L(m);
L(2);
}
w j;
}
J=0;
e=m;
b am j){
L(32);
Z=D;
u am j){
L(m);
w j;
}
b isdigit(e)){
C=strtol(Z,0,n;
e=2;
}
k{
r D=32;
e=strstr(Q,Z-p-Q;
r D=0;
e=e*8+256;
b e>536){
e=T+e;
b t e f p{
V=t(e+4);
al=m;
w j;
g;
}
}
}
}
k{
w j;
b e f 39){
e=2;
an j;
C=m;
w j;
w j;
}
k b e f 47&m f 42){
w j;
u m){
u m!=42)w j;
w j;
b m f 47)m=0;
}
w j;
g;
}
k{
a="++#m--%am*@R<^1c/@%[_[H3c%@%[_[H3c+@.B#d-@%:_^BKd<<Z/03e>>`/03e<=0f>=/f<@.f>@1f==&g!='g&&k||#l&@.BCh^@.BSi|@.B+j~@/%Yd!@&d*@b";
u s=r a++){
h=r a++;
C=0;
u(J=r a++-98)<n C=C*64+J+64;
b s f e&(h f m|h f 64)){
b h f m){
w j;
e=1;
}
break;
}
}
}
}
}
o d){
u d&&d!=-p{
r v++=d;
d=d>>8;
}
}
E(a,d){
r a++=d;
r a++=d>>8;
r a++=d>>16;
r a++=d>>24;
}
ao(l{
A d;
return(r a&255)|(r(a+p&255)<<8|(r(a+2)&255)<<16|(r(a+3)&255)<<24;
}
ap(a,z){
A d;
u l{
d=ao(l;
b r(a-p f 5){
b z>=G&&z<i)E(a,z+y);
k E(a,z-K+R+y);
}
k{
E(a,z-a-4);
}
a=d;
}
}
H(l{
ap(a,v);
}
x(d,l{
o d);
E(v,l;
a=v;
v=v+4;
O a;
}
M(l{
x(184,l;
}
I(l{
O x(233,l;
}
aa(s,l{
o 1032325);
O x(132+s,l;
}
aq(l{
o 49465);
M(n;
o 15);
o a+144);
o 192);
}
W(s,l{
A d;
o s+131);
d=t a;
b d&&d<512)x(133,d);
k{
a=a+4;
t a=x(5,t l;
}
}
ab(q{
A d,a,h,F;
d=1;
b e f 34){
M(i+y);
u m!=34){
an j;
r i++=m;
w j;
}
r i=0;
i=i+4&-4;
w j;
g;
}
k{
F=J;
h=C;
a=e;
g;
b a f 2){
M(h);
}
k b F f 2){
ab(n;
x(185,n;
b a f 33)aq(h);
k o h);
}
k b a f 40){
B j;
g;
}
k b a f 42){
g;
a=e;
g;
g;
b e f 42){
g;
g;
g;
g;
a=0;
}
g;
ab(n;
b e f 61){
g;
o 80);
B j;
o 89);
o 392+(a f 256));
}
k b l{
b a f 256)o 139);
k o 48655);
v++;
}
}
k b a f 38){
W(10,e);
g;
}
k{
d=0;
b e f 61&q{
g;
B j;
W(6,l;
}
k b e!=40){
W(8,l;
b J f 11){
W(0,l;
o C);
g;
}
}
}
}
b e f 40){
b d)o 80);
h=x(60545,n;
g;
s=0;
u e!=41){
B j;
x(2393225,q;
b e f 44)g;
s=s+4;
}
E(h,q;
g;
b d){
x(2397439,q;
s=s+4;
}
k{
a=a+4;
t a=x(232,t l;
}
b q x(50305,q;
}
}
X(q{
A a,d,h;
b s--f p ab(p;
k{
X(q;
h=0;
u s f J){
d=e;
a=C;
g;
b s>8){
h=aa(a,h);
X(q;
}
k{
o 80);
X(q;
o 89);
b s f 4|s f 5){
aq(l;
}
k{
o l;
b d f 37)o 146);
}
}
}
b h&&s>8){
h=aa(a,h);
M(a^p;
I(5);
H(h);
M(l;
}
}
}
B j{
X(11);
}
ac j{
B j;
O aa(0,n;
}
S(q{
A h,d,a;
b e f 288){
g;
g;
h=ac j;
g;
S(q;
b e f 312){
g;
d=I(n;
H(h);
S(q;
H(d);
}
k{
H(h);
}
}
k b e f 352|e f 504){
a=e;
g;
g;
b a f 352){
d=v;
h=ac j;
}
k{
b e!=59)B j;
g;
d=v;
h=0;
b e!=59)h=ac j;
g;
b e!=41){
a=I(n;
B j;
I(d-v-5);
H(l;
d=a+4;
}
}
g;
S(&h);
I(d-v-5);
H(h);
}
k b e f 123){
g;
ar(p;
u e!=125)S(q;
g;
}
k{
b e f 448){
g;
b e!=59)B j;
U=I(U);
}
k b e f 400){
g;
t s=I(t q;
}
k b e!=59)B j;
g;
}
}
ar(q{
A h;
u e f 256|e!=-1&!q{
b e f 256){
g;
u e!=59){
b q{
P=P+4;
t e=-P;
}
k{
t e=i;
i=i+4;
}
g;
b e f 44)g;
}
g;
}
k{
t e=v;
g;
g;
h=8;
u e!=41){
t e=h;
h=h+4;
g;
b e f 44)g;
}
g;
U=P=0;
o 15042901);
h=x(60545,n;
S(n;
H(U);
o 50121);
E(h,P);
}
}
}
c d){
E(i,d);
i=i+4;
}
ad(d,l{
c d);
d=d+134512640;
c d);
c d);
c l;
c l;
}
ae(q{
A a,h,d,N,z,F;
N=0;
a=Q;
u p{
a++;
h=a;
u r a!=32&&a<D)a++;
b a f D)break;
e=T+(h-Q)*8+256-8;
z=t e;
d=t(e+4);
b d&&z!=p{
b!z){
b!q{
memcpy(i,h,a-h);
i=i+a-h+1;
}
k b s f p{
c N+22);
c n;
c n;
c 16);
N=N+a-h+1;
}
k{
N++;
u d){
h=ao(d);
F=r(d-p!=5;
E(d,-F*4);
c d-K+R+y);
c N*256+F+p;
d=h;
}
}
}
k b!q{
ap(d,z);
}
}
}
}
au(F){
A Y,af,as,ag,at,ah,d,a,ai;
R=i;
ai=v-K;
v=K;
o 5264472);
a=t(T+592);
x(232,a-v-5);
o 50057);
M(p;
o 32973);
i=i+ai;
af=i;
i++;
i=strcpy(i,"libc.so.6")+10;
i=strcpy(i,"libdl.so.2")+11;
ae(n;
as=i-af;
i=(i+3)&-4;
ag=i;
c n;
c n;
c n;
c n;
ae(p;
at=i;
d=(i-ag)/16;
c p;
c d);
c p;
c n;
a=2;
u a<d)c a++);
c n;
ah=i;
ae(2);
memcpy(R,K,ai);
Y=i;
i=G;
c 1179403647);
c 65793);
c n;
c n;
c 196610);
c p;
c R+y);
c 48);
c n;
c n;
c 2097204);
c 3);
c 3);
ad(144,19);
c 4);
c p;
c p;
ad(0,Y-G);
c 7);
c 4096);
c 2);
ad(164,88);
c 6);
c 4);
i=strcpy(i,"/lib/ld-linux.so.2")+20;
c p;
c p;
c p;
c 11);
c 4);
c at+y);
c 6);
c ag+y);
c 5);
c af+y);
c 10);
c as);
c 11);
c 16);
c 17);
c ah+y);
c 18);
c Y-ah);
c 19);
c 8);
c n;
c n;
a=fopen(F,"w");
fwrite(G,1,Y-G,l;
fclose(l;
}
main(int d, char **l{
b d<3){
printf("usage: otccelf file.c outfile\n");
O 0;
}
D=strcpy(Q aj," int if else while break return for define main ")+48;
i=G aj;
v=K aj;
T aj;
a=a+4;
ak=fopen(t a,"r");
y=134512640-G;
i=i+252;
v=v+17;
w j;
g;
ar(n;
a=a+4;
au(t l;
O 0;
}

