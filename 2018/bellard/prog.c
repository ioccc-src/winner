#include <math.h>
#define e(a, d) for(a=0;a<d;a++)
char*x="	{k/;	y{ q ; }	c {	@;	={ 	S}	c}	W;;	{4}	k |; w{	+9;{;	8; 9{	S;	/}	y{ K}	{;}	l{	{ ~{ ;	V}k}g< t{	E	v;M{ B}y}	<{7;/;	Y} t}kp; Y} $Ha{e} w};} R} /{>}a	;} ;	`	$W-}	D}B; e;f;*;	~;A;s O{	o;>{1; m{ `} R}]{ T} v}={ I} ; }a?&; A}$;W;R{u} `; j}W;s{e}	A;[	R;	X  P; 4 ,F;({<8{#;%}@J{)}	}o^*{u/{'}]{	*}	}	;{ r}	f	/;}e} }w{ ${{;,; @ d	$}];>(}	I{ d}	&;	U}	{	y;Y}	{ P{	R} T}_{ }R } l	{ T}"
"';	|; ${=}	H} (}}8{cp{ s} #}+}	3}kF}<H	 .{ }G}x;	r	D c{; W; {	b;6; k{}B;*};	]} ~	{ ;;} !}}	x}v}n;^;	6V}Y{ h; ~	%*}! H; G{ r{ f;Y{ i}z} N  %}.{;	( 	v} _}	h; 7;<}	^;Z;0; ;	<;<; M; N{	}	_{O} !{f{]{M{;A{}	0;S}${	@;x}y}@	L;1	t{ 3{c{s{_{	`{	D{ ]}!;	${	_J;v+ }	3{B; ]{	}	E6	.x{?+; {x; }v{$};6}T; O; ; (}X7}	j; @} :}#	c{ !{ }x	KXt} >; ?{ c; ;	W;	; l;} h}p}	i{ %	}P}	/{	*}	%L; ;	!{ S{ n} "
"x;  { 1	J;v{	U}({	@ X{ k} H;4;e J	6;;v; G{{]	&{A d{ lM{;K;;	4-{}} p h{;	{	rW;	v{;	f}	}1{^&{9{{ ;~;n;q{	9 R	6{	{ u;a;	;	U;	;Y}	+}}2sk; 8	{	JK;'i;	;$;	W{	P!{{{P	} [;	(;Q; Un;+}g{C;{{	; <{	vS} b;6`} ?{+	%;	}n;q{ r}k; ;{c{ S} 2}~{	4;RW v} R;	kI}|; d; [ O}5; ;;}Z d	{ {&;h	o{ V	v ;	_{{/}  F{f{r{4{{?{ 4;S}	:;];E}	;	&} #e !{>{H; {O{ 0;} H;	p; w}>{1}{	-} 4;"
"S}}	u L{ y} %;2  |{(}	/;,{ )}Y;g}	G}v;T}	};}i {{};[{ E{q} g;T{ ={}R;	k{ j;_;h}gPc;({	F;6}	}} 3	,}<; 0	 P;{'t}u};		}U}s{8{ E} >{}E	{G{H :{  Yog}	}F  D{ R{	 -;M?;= q}_ U	{ ;	 I	{ |{{}	 	1{,}{ x{{ U{ s;J}}	6{>7;,{ D{	{{ ;]}	;M; &}{ V}	n{&	T~;({	}[;	r{#	u{X 9;L; Uf})}   {T}		p{	N;	>{	>	}}D} m{1{	{}X; o}	w}$}	^v} K  f	,}	^3; { @{_} _{	o;	4}	h}H;#.{	{}	;	<{ {G{ $;{ "
"z {a{{D;	?|}{{ ;	`} }	Q}j;4} 	3{Q}	{	* ;}r{a}	} R{p @;  N{ {f; A;8}L	$}{ }}J{ }	k{r} { [; -;p{	I{ {	&}J;	T}	?{Z{>;	5>; ];  wz ^}	u;);	H}	; L	&;	V	E{1{g;C} V} ~;U; ^{	J; { /}	{;(}y} aK /}	.};K;N{w{ `{	}T{l`; #;N{lX;	?; +}{ 	w{	;	q;	z;_;y} 8} 	&{X}	V{ WG}	,; [}U{	v{	Q;	w{	[	Y}N	Yu i{ {!A{}{ b0;	X~} ;-; 8{	E }	;F{	y{}{	";
int y[3][1<<20],i[2048],X[166],p,r=1,f,s,O,P;
Q(){
int b;
r*=s;
p*=s;
if(s>>9){
if(b=*x){
p+=b-1-(b>10)-(b>13)-(b>34)-(b>92)<<4;
b=x[1];
x+=2;
p+=b<33?(b^8)*2%5:(b^6)%3*4+(*x++^8)*2%5+4;
}
}
else{
b=getchar();
p+=b<0?0:b;
}
}
t(E){
int u,k,F,*m;
if(r<s)Q();
m=X+E*2;
F=*m+m[1]+2;
u=r*(*m+1)/F;
if(k=p>=u){
p-=u;
r-=u;
}
else r=u;
m[k]++;
if(F>63){
*m/=2;
m[1]/=2;
}
return k;
}
n(E){
int a,b;
a=0;
while(!t(E+a))a++;
b=1;
while(a--)b=b<<1|t(4);
return b-1;
}
R(S,Y,T,Z,U,d,V)int*S,*T;
{
int G,a,j,H;
e(H,d)e(a,d){
G=0;
e(j,d)G+=T[j*Z+H*U]*lrint(cos(acos(-1)/d*(a+0.5)*j)*sqrt(2-!j)*1024);
S[a*Y+H*U]=G+(1<<V-1)>>V;
}
}
W(z,l,g){
int v,a,j,I,d,k,A,*o,c,B,q,C,h,w,J;
if(g>5||g>2&&t(g-3)){
c=1<<--g;
e(a,4)W(z+a%2*c,l+a/2*c,g);
}
else{
c=1<<g;
d=c*c;
q=n(73);
e(A,3){
o=y[A]+l*f+z;
B=A>0;
e(a,d)i[a]=0;
e(a,d){
if(t(61+g*2+B))break;
a+=n(5+B*10);
k=1-2*t(3);
i[a]=k*(n(25+(B+(a<d/8)*2)*10)+1)*(A?P:O);
}
if(!q){
v=0;
e(a,c){
v+=l?o[-f+a]:0;
v+=z?o[a*f-1]:0;
}
*i+=z&&l?v/2:v;
}
R(i+d,1,i,1,c,c,10);
R(o,f,i+d,c,1,c,10+g);
if(q){
C=q<17;
w=C?9-q:q-25;
e(a,c)e(j,c){
e(I,2){
h=a*w+w;
J=h&7;
h=(h>>3)+j+I;
if(k=h<0)h=(h*8+w/2)/w-2;
h=h<c?h:c-1;
i[I]=k^C?o[h*f-1]:o[-f+h];
}
o[C?j*f+a:a*f+j]+=*i*(8-J)+i[1]*J+4>>3;
}
}
}
}
}
K(b){
putchar(b<0?0:b>255?255:b);
}
main(D){
int a,l,L,M,g,N;
s=D>1?256:1968;
Q();
g=n(5);
f=1<<g;
N=f-n(5);
O=n(5);
P=n(5);
W(0,0,g);
printf("P6 %d %d 255 ",f,N);
e(a,N*f){
l=y[0][a];
L=y[1][a];
M=y[2][a];
D=l-L;
K(D+M);
K(l+L);
K(D-M);
}
return 0;
}

