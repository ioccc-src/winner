
   #define a(x) } else p b(#x)){ 
   #define I ; } else p i==j++){ 
        #define c sprintf
        #define   o    ->
        #define   p   if(
        #define   t   f++
        #define   s   ( )
        #define   z   x o
        typedef struct d*     e; struct d{ union{ char*f; double n; } ; char*g,h
        ,l,m; e e,x,b,q,(     *r) s; int u; } ; e q,v; int y,(*w) s=strlen, (*A)
        s=strcmp; char*B,     *f,C, r=0, g[99], *(*D) s=strdup; e E(int m){ e x=
        calloc(1, sizeof(     struct d)); z b=v; z m=m; return v=x; } e F(e q) {
        while(q){ p !A(g,     q o g)){ return q; } q=q o b; } return 0; } e G(e*
   q){ e x=E(4); z g=D(g)     ; z b=*q; z x = E(0); return *q = x; } H s{ int x;
   while((x=*f==47 & f[1]     ==47) |isspace(*f)){ p x){ while(*f && *f!=10)t; }
   else t; } } J s { H s;     p*f)t; } K(char*K){ char*d=strchr(K,*f); return d?
                              d-K:-1; } L s{ return K(";)]") != -1; } M(char*x){
                              return!A(x,g); } b(char*x){ int u=w(x); p !strncmp
(x,f,u)&!isalnum(f[u])){ f+=u; return 1; } return 0; } N s{ int x=1; while(*f&&x
){ C=*t; x+=C-123?C-125?0:-1:1; } } double O(e x){ char*P; return z m&1?z n:z m&
2?strtod(z f,&P) :0; } e Q(e x){ e n=E(2); char*f="[object]",m=z m; p m&1){ c(g,
"%g",z n); f=g; } p m &2)f=z f; n o f=D(f); return n; } e R(int); S s{ return 95
==*f||isalnum(*f); } T s{ char*d=g; while(S s)*d++=*t; *d=0; } e U(int h){ int i
=0,j,n,P,V; double X,Y; char*d,b; e l,y, x=E(0),u; H s; p L s){ return x; } i=K(
"-+!~"); p i>-1){ t; } C=*f; p C==40){ t; x=U(0); J s; } else p C==91|C==123){ z
m=4; t; J s; } else p C==34|C==39){ d=g; t; z m=2; while(* f!=C){ char P=*t; p P
==92){ P=*t; P=P==110?10:P==120?strtol(f,&f,16):P; } *d++=P; } *d=0; t; z f=D(g)
; } else p isdigit(*f)){ z m=1; z n=strtod(f,&f); } else p S s){ int W=0; g:T s;
p M("function")){ J s; J s; J s; d=f-1; x=E(2); N s; z f=strndup(d,f-d); } else{
p M("var")){ t; W=1; goto g; } u=F(q); p W|!u)u=G (&q); x=u o x; z e=u; } } p i>
-1){ X=O(x); n=X; p j=0){ I X=-X I I X=!n I X=~n; } x=E (1); z n=X; } while(*f){
H s; p L s)break; i=K(",=!&|><-+*/%[(."); p i>-1){ b=*f; p i<h){ break; } int W=
0,k=0,h=0; t; p *f==61){ W=2; t; } else p *f==b){ h=1; t; } y=0; l=E(1); X=O(x);
double*Z=&l o n; char m=z m; n=X; p i<13){ y=U(i==12?0:i); Y=O(y); P=Y; } p j=0)
{ I l=y I p W){ V:p m==y o m){ p m&4)V=x!=y; else p m &1) goto O; else goto Q; }
else p (m|y o m)==2){ Q:V=A(Q(x) o f,Q(y) o f); } else{ O:V=X-Y; } i=k; p j=0) {
I V=V==0 I V=V>=0 I V=V<=0 I V=V>0 I V=V<0 I V=V!=0; } *Z=V; W=0; } else{ W=1; p
y o m&4){ l=y; } else{ l=E(y o m); l o r=y o r; p y o m&2)l o f=D(y o f); else l
o n=y o n; } } I k=5; goto V I*Z=h?n&&P : n &P I*Z=h?n||P:n|P I p h){ *Z=n>>P; }
else{ k=3-W; goto V; } I p h){ *Z=n<<P; } else{ k=4-W; goto V; } I*Z=X-Y I p (m|
y o m)&2){ e u=Q(x); y=Q(y); d=malloc(w(u o f)+w(y o f)+1); c(d,"%s%s",u o f,y o
f); l o m=2; l o f=d; } else{ *Z=X+Y; } I*Z=X*Y I*Z=X/Y I*Z=n%P I J s; p m&2){ c
(g,"%c",P<w (z f)?z f [P]:0); l o m=2; l o f=D (g); } else{ c(g,"%s",Q (y) o f);
goto q; } I c(g,"arguments"); e B=q,u=G(&q) o x; i=0; while(*f){ H s; y=U (1); p
!r){ c(g,"%d",i++); G(&u o q) o x=y; u o u++; } p *f==41)break; t; } t; i=r; p z
r){ p !r)l=z r(u o q); } else{ d=f; f=z f; l=R (0); f=d; } p !i){ r=i&~1; } q=B;
I H s; T s; p M("length")){ *Z=m&2?w(z f):z u; } else{ q:y=F(z q); p !y){ y=G(&z
q ); z u ++; } l=y o x; p !l o e)l o e = y; } } p W){ p !r){ l=z e o x=l; } else
continue; } x=l; } else t; } return x; } h(e x,e l,int b){ p x&&x !=l){ e u=z x;
z h=y; p u){ p u o h!=y)h(u,0,0); h(u o q,0,1); } h(z q,0,1); p b)h (z b,l,1); }
} _(e l){ y=1; h(v,l,1); y=0; h(q,0,1); e*B=&v,x=v; while(x){ e*b=&z b; p z h&!z
l){ *B=*b; p z m&2)free(z f); p z g)free(z g); free(x); } else{ z h=0; B=b; } x=
*b; } } e R(int h){ e x=E(0),y,l,d=q,u=v; while(*f){ H s; p *f==123){ t; p !r)x=
R(1); else N s; } else{ int u=0,d; p *f==125){ t; break; a(if)char*B; int P; u:d
=r; j:B=f; J s; l=U (0); J s; p !(int)l o n)r=4; P=r; y=R(0); p *f==59)t; p !P){
x=y; } H s; p u){ p !r&!P){ x=y; f=B; goto j; } else{ } a(else)r=(!P&!d)*4; P=r;
y=R(0); p !P){ x=y; } } r=u?d&~2:d|(r&3); a(while)u=1; goto u; a(return)y=U (0);
p !r){ x=y; r|=1; } a(break)p !r)r|=2; } else p *f){ y=U (0); p !r)x=y; J s; } }
p !h)break; } z l=1; z l=0; q=d; return x; } e ba(e x){ printf("%s",Q(z x) o f);
return E(0); } main s{ c(g,"print"); e x=G(&q); z m=2; z z r=ba; char u [1<<16];
B = f = u ; while ( ( C = getchar s ) > 0 ) * t = C ; * f = 0 ; f = B ; R (1); }

