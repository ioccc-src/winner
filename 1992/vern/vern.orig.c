#include <stdio.h>
;	m(x)(x<0?-1:!!x)
;	g tj()-J
;	a(x)(x<0?-x:x)
;	h(x)((x)<=K?x:N-(x))
;	f 9999
;	A return
;	H printf{ 
;	R double
;	U int
;	V for
;	b else
;	u while
;	B if
U v,w,Y}	 -1,W,J,p,F,o}	f,M,N,K,X,YY,_,P[f],s{ } ;
typedef U{ *L} { } ;
L q[f];
tj{ } {
U S}	m{ v} +{ m{ w} <<K} ; 
B{ !S} A J; 
V{ v}	W+S; v!}	J&&!q[v]; v+}	S} ;
A v; 
}
k{ } {
_}	K; 
A v?a{ v} >1||w-Y||!q[J]:{ w-Y&&{ w-Y*2||q[W+Y*{ N+1} ]||
    { J>>K} -K+{ Y-1} / 2} } ||q[J]; 
}
z{ } {
_}	5; 
A v*w||g; 
}
e{ } {
_}	 -2; 
A{ v*v*v-v||w*w*w-w} &&{ J-W-2||{ W&N} -4||{ W>>K!}	{ Y-1?N:0} } ||
    q[W+1]||q[W+2]||q[W+K]!}	z||P[W+K]*Y<0} ; 
}
R VR{ } {
int PZ}	0x7fff; 
A{ R} { rand{ } &PZ} /{ R} PZ; 
}
l{ } {
_}	K+1; 
A{ v*w&&a{ v} -a{ w} } ||g; 
}
R UC{ } {
R {	}	0,d; 
u{ { {	+}	d}	VR{ } } <1.0} ; 
A d; 
}
c{ } {
_}	 -11; 
A a{ v} -a{ w} ||g; 
}
I{ ur,n,x} {
W}	ur; 
J}	n; 
B{ P[W]!}	Y||P[J]}	}	Y} A J+1;
v}	{ J&N} -{ W&N} ; 
w}	{ J>>K} -{ W>>K} ; 
A q[W]{ } ||{ x&&QL{ W,J,s} } ; 
}
TT{ W} {
v}	w}	0; 
A q[W]{ } +K; 
}
s{ } {
U j}	 -1,{	; 
Y}	 -Y; 
V{ {	}	0; {	<M; ++{	} {
B{ j<0&&P[{	]}	}	 -Y&&TT{ {	} &&_}	}	 -2} 
{
j}	{	; 
{	}	 -1; 
}
b B{ j>}	0&&!I{ {	,j,0} } A Y}	 -Y; 
}
A!{ Y}	 -Y} ; 
}
bb{ } {
_}	1; 
A a{ v*w} -2; 
}
uv{ } {
V{ v}	0; v<f; ++v} {
B{ h{ v>>K} }	}	0} {
U S}	h{ v&N} ;
q[v]}	!S?z:{ S}	}	1?bb:{ S}	}	2?c:{ v&N>K?l:e} } } ; 
}
b B{ h{ v>>K} }	}	1} q[v]}	k; 
b q[v]}	0;
P[v]}	!!q[v]*{ 28-v} ; 
}
}
y{ } {
U G}	Y,{	; 
J}	0; 
V{ {	}	0; {	<M; ++{	} {
{	%8||H"\n%4o ",{	} ;
B{ { Y}	P[{	]}	m{ P[{	]} } &&TT{ {	} } H"%c ",_+93+Y*16} ; 
b H"- "} ; 
}
H"\n    "} ; 
do 
H"%2d",{	++&N} ; 
u{ {	&N} ; 
Y}	G; 
H"\n"} ; 
}
O{ W,J} {
B{ { q[J]}	q[W]} }	}	k&&h{ J>>K} }	}	0} q[J]}	l; 
B{ q[W]}	}	e} B{ J-W}	}	2} O{ J+1,J-1} ;
b B{ W-J}	}	2} O{ W-1,W+1} ; 
P[J]}	P[W]; 
q[W]}	0;
P[W]}	0; 
}
QL{ W,J,D} L D; 
{
U HQ}	P[J],YX; 
L AJ}	q[J],XY}	q[W]; 
O{ W,J} ; 
YX}	D{ } ;
O{ J,W} ; 
q[J]}	AJ; 
q[W]}	XY; 
P[J]}	HQ; 
A YX; 
}
C{ } {
U {	,j,BZ}	0; 
V{ {	}	0; {	<M; ++{	} {
L Z}	q[{	]; 
B{ Z} {
U r}	h{ {	>>K} +h{ {	&N} ,G}	Y,
    S}	Z}	}	z?88:{ Z}	}	k?11+r+{ P[{	]<0?N-{ {	>>K} :{ {	>>K} } :
{ Z}	}	l?124-{ { YY<8&&{ { {	&N} !}	K||
    { {	>>K} !}	{ P[{	]>0?0:N} } } ?M:0} :
{ Z}	}	c?41+r:{ Z}	}	e?f-r-r:36+r+r} } } } ; 
Y}	P[{	];
V{ j}	0; j<M; ++j} B{ !I{ {	,j,0} } S+}	{ P[j]?5:1} ; 
BZ+}	G}	}	Y?S:-S;
Y}	G; 
}
}
B{ !{ ++X&M-1} } write{ 1,".",1} ; 
A BZ; 
}
PX{ } {
U {	,Q}	0,XP}	0,JZ}	M*M,E}	 -f,t,S}	o; 
B{ !F--} A++F+C{ } ;
V{ {	}	0; {	<JZ; ++{	} B{ !I{ {	>>K+K,{	&M-1,1} } {
Y}	 -Y; 
o}	 -E;
t}	 -QL{ {	>>K+K,{	&M-1,PX} ; 
Y}	 -Y; 
B{ t>E} {
++XP; 
Q}	{	; 
E}	t; 
B{ E>}	S} 
A++F,E; 
}
}
B{ !XP} E}	s{ } ?-f+1:0; 
p}	Q; 
A++F,E; 
}
RZ{ } {
U {	,j,T}	0; 
V{ ; ; } {
y{ } ; 
o}	f; 
do{
H"\n%d %d %d %s ",X,T,C{ } ,s{ } ?"!":">"} ;
fflush{ stdout} ; 
}
u{ scanf{ "%o%o",&{	,&j} !}	2||I{ {	,j,1} } ;
O{ {	,j} ; 
y{ } ; 
X}	0; 
++YY;
Y}	 -Y; 
T}	PX{ } ; 
{	}	p>>{ K<<1} ; 
j}	p&{ M-1} ; 
B{ I{ {	,j,1} } {
H"Rats!\n"} ; 
A; 
}
O{ {	,j} ; 
Y}	 -Y; 
B{ T>M*M} H"\nHar har.\n"} ; 
}
}
main{ ac,av} char**av; 
{
long time{ } ,j}	time{ &j} ; 
R {	}	0; 
srand{ { U} j} ;
V{ M}	0; M<}	f; ++M} {	+}	UC{ } ; 
M}	{	/100;
B{ M&3} ++M; 
B{ M&1} --M; 
V{ N}	1; N*N<M; ++N} ;
K}	 --N/2; 
F}	ac>1?atoi{ av[1]} :2; 
uv{ } ;
RZ{ } ; 
}
