#include <math.h>
#define e(a, d) for(a=0;a<d;a++)
char*v="T{ ;	; :}>{	y} 4};	1}	s;	{;9{ -	$} ; q{;	}	u;d}	}	3{d} ,{	3; 1fB{A{ 	}{+	D}9}	v{p{ pa} {	N{${ ;P;{	z;	({ .{*}n{w{ v; j{$}<}S}y}@; {	Q`{UN 9}0@{Z}'{ {%;	h;	5} g} e	S ~	q}'{#;e; B{;M}	mP; b{y 7{ u;rOK}%}  b}3 {	k _{ { a{D{	W} L} q	{ '}A;	AX;u}76*-	h{O;p}	} q}s}M} Q;;	Y }D; H{ A ASRs}*	n}P-{	{F}u; G;	l{ D}	~;	,;	} }8}{+Z	O	c;	;M{	A{Q} g} }}	n	U;k; |{	{<;	/}	H B}},} }	L;"
"_{ j}1{ z}	= h{	S;1; 2;O; ;	h{P;	v; c{	H;;N;d;l}P}	a; DBx}3{5	e A; {u} { FZ}8}	; ;	7;;{	$}~{	~{q [ x;n#};	#{W{3; M ;;	=;5; ;{}	s};	*;	v^}	QB}n 9}}	1e <;}g{v} C{ :{a{ 	} o}	R} .}}}	, { 4 VX{s}r@{v 3} 7{{;	y;{	{K; v 2O; t}&} ;	L} t}3/;	);e{(]f; ,}(}Nx;7}X} {A;R{;<;[;	G;C} O;	o}W}{	s; ); }{}[} (} C}	;	Y{	0}8}	{m}{K}{	^{.	;}';^;O	 }M{z;	J,;{	};;	"
"W;	n	H;	f;	{-; v{}; {	!} F- r	l} {m		} ;P}	9{p{ C}}G	={	3 @{ 5}4{	|	;	q	^;f} + -{-;	} w{	]{Q;.{	r{	Z  {	C	4{ +}o;	y}	b{[;	Wg{N}	o{	9;;,{	P{z;+}>; a{}}p[{{{{b{b; @H{{s;	{=}&}0; }} 8{N} {X;	}I;	3}	W{ 9;P{ {}	}	Hi}A {	U{}D;};t;s;	S;+;	{O}nV}	7; x{f{ P}	4}B{	M ;Y} g};?{	;{	t;5K	;*		{	H}w; SE	n{D} I{&; {} =9 }B;	W{4}p;	l{Au;	q{X~ +;O{ $j	{G; ;'rb}3 j9} }`} m}4;	r;	8; y;r}"
"t}>;	~}	E;	G}	9}	5	;/i}p{:; C{I}	;  2{ c{	x}}} ?}5{	i{ <} {})} C{ V} ?;X*;P{L{ c{M;T{<_{ {}M;	V; q{ }	$}l}P{Y{ #{N{9);]}	u{ {F	;( '	)%J	} x	=; Y	Q{Q}I'}B { }	g}|{! n ({} C;	#	|; {=}D{3} }L{F}#} ` k}	M;	]} J{	}7}	4} Z}	]}}	v6	;	X; Y{Qx}{	;};{	.<{b}7{ } 6	; {x;	& {]{~; [ P r}X}	W 9 } 	{O{ ;f	;)}:;&{-;	Eg{)}{0} Z{S}y;	} N;;  ; k}Y{`z;}? Kv}	&;	6 1; ^ Y{ }{){A{${	#}	M	w; "
"6{ >}B}o}; M{	({ ({}H; ` h	j{z; };	7;f;	{ L; #{;{#}	4}	N{z j}{ o;3{j;l B} 9} F} J;F 2	;FTw+} y{ _		};l{	}}	4}	8} ]} l{ }K; ;@}{ v;b0; 0; }V;	*} R; p;j; &;_;9;	;	{J;W #}	{ h;^{t;|Q} [;U; >} ^}	/	~{ @}	{n	k{	N} {H{	j}	 {W;	X;	8{ 3; u:}T{P;0;  	k;	Z}	v{X} {;{`{#{ ;n} ;U}	d}d{&{n {|t{	aT} v}	$}7;Q;	f; W; O}	E;}	c} F{	8}AA;	~{ `;	w;	x<;G}f}7;rE{ ~{	n}F	5} ^{	c{;	{!{|} "
"1{[}	;3}	;{ 8 a}pIg;9{ n}	-} T} e{	!}  ;		/0{9;V{>;  W}F;	+}L}	F{S}	+{ ,	}	 o; {	x;		i; 9 ";
int w[3][16384],h[512],T[160],p,q=1,g=128;
M(){
int b;
q*=1968;
p*=1968;
if(b=*v){
p+=b-1-(b>10)-(b>13)-(b>34)-(b>92)<<4;
b=v[1];
v+=2;
p+=b<33?(b^8)*2%5:(b^6)%3*4+(*v++^8)*2%5+4;
}
}
r(A){
int s,j,B,*m;
if(q<1968)M();
m=T+A*2;
B=*m+m[1]+2;
s=q*(*m+1)/B;
if(j=p>=s){
p-=s;
q-=s;
}
else q=s;
m[j]++;
if(B>63){
*m/=2;
m[1]/=2;
}
return j;
}
C(A){
int a,b;
a=0;
while(!r(A+a))a++;
b=1;
while(a--)b=b<<1|r(3);
return b-1;
}
N(O,U,P,V,Q,d,R)int*O,*P;
{
int D,a,i,E;
e(E,d)e(a,d){
D=0;
e(i,d)D+=P[i*V+E*Q]*(i>0?lrint(cos(acos(-1)/d*(a+0.5)*i)*1448.155):1024);
O[a*U+E*Q]=D+(1<<R-1)>>R;
}
}
S(x,k,l){
int t,a,i,F,d,j,y,*n,c,z,o,G,f,u,H;
if(l>2&&(l>4||r(0+l-3))){
c=1<<--l;
e(a,4)S(x+a%2*c,k+a/2*c,l);
}
else{
c=1<<l;
d=c*c;
o=C(70);
e(y,3){
n=w[y]+k*g+x;
z=y>0;
e(a,d)h[a]=0;
e(a,d){
if(r(60+l*2+z))break;
a+=C(4+z*10);
j=1-2*r(2);
h[a]=j*(C(24+(z+(a<d/8)*2)*10)+1)*(y?76:38);
}
if(!o){
t=0;
e(a,c){
t+=k?n[-g+a]:0;
t+=x?n[a*g-1]:0;
}
*h+=x&&k?t/2:t;
}
N(h+d,1,h,1,c,c,10);
N(n,g,h+d,c,1,c,10+l);
if(o){
u=(G=o<17)?9-o:o-25;
e(a,c)e(i,c){
e(F,2){
f=a*u+u;
H=f&7;
f=(f>>3)+i+F;
if(j=f<0)f=(f*8+u/2)/u-2;
f=f<c?f:c-1;
h[F]=j^G?n[f*g-1]:n[-g+f];
}
n[G?i*g+a:a*g+i]+=(*h*(8-H)+h[1]*H+4)>>3;
}
}
}
}
}
I(b){
putchar(b<0?0:b>255?255:b);
}
main(){
int a,k,J,K,L;
M();
S(0,0,7);
puts("P6\n128 128\n255");
e(a,g*g){
k=w[0][a];
J=w[1][a];
K=w[2][a];
L=k-J;
I(L+K);
I(k+J);
I(L-K);
}
return 0;
}

