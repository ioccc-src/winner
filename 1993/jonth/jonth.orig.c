  G	int i,j
  K	case
  R	return 0
  S(	x,y) for(x=0; x<y; x++)
  I	S(i,10
  z	I-6)B[t][u
  t	(X[m].b[i].i+g)
  u	(X[m].b[i].j+l)
  M(	x,y) XFillRectangles(D,p,x,a,y);
  s	B[i][j
  W	=XCreateGC(D,p,4,L)
  E(	W,_) k=0; I)S(j,22)if(W s]){ a[k].x=i*20; a[k].y=j*20+30; a[k].w=a[k].h=_; k++; }M(
  A(	W,_) &&!B[W]; if(!j){ z]=1; R; } else{ N(m); _; v(0); }
  Q	]=0; I-6&&j)j=
  F	I-6)B[X[w].b[i].i+g][X[w].b[i].j+l
  e(	x) break; K x:q(c,j,x);
  H	(m){ G; I-6){ a[i].x=t*20; a[i].y=u*20+30; a[i].w=a[i].h=
  v(	_) d(m); z+_]=1; R+1;
struct{
	short x,y,w,h;
} a[220],C;
struct{
	struct{
		G;
	} b[4];
} X[99];
G,l,g=3,p,B[10][22],L[99],o[99],n,r,h,_[4],D,J,T;
f(){
	*L=2;
	n||XSendEvent(D,p,n=1,0,L),XFlush(D);
	P();
}
Z(){
	_[1]=_[3]=(9-h)*40000;
	setitimer(0,_,0);
}
main(){
	G,*_=(int*)X;
	char*c=
"*{{{ {}{{*{{{ {}* {    {{*{{{   *{{{ {* {* * {  {{ {  { *{* {   {* *{{{ *{{{ {   * {  { *{{{ {{  *{{ {  {{* {   {*{{ {{ {{ {* { {*{{ {  *{{{{    *{{ {{ ";
	for(; *c; )
		*_++=(unsigned)(*c+++2)%4;
	srand(time(0));
	L[10]=32769;
	D=XOpenDisplay(0);
	L[1]=L[2]=XWhitePixel(D,j=XDefaultScreen(D));
	XMap@p=XCreate@XRoot@j),0,0,200,470,2,0,1,0,2056,L));
	T W;
	L[2]=XBlackPixel(D,j);
	J W;{
		G,O=0,c=0;
		Z(P());
		q(c,c,1);
		for(; ; ){
			i=lK();
			j=c;
			switch(i){
				K 'k':c=q(c="$#&'(%)+,-*/01.3254"[c]-35,j,4)?c:j;
				e('j')e('l')e(32)}
			if(n){
				if(!q(c,j,2)){
					G,n;
					for(j=21;j-1;j--){
						n=1;
						I&&n)n=s];
						n&&(X9(j++),O++);
					}
					n=0;
					I&&!n)n=B[i][21];
					Y();
					r++;
					c=rand()%19;
					if(!q(c,c,3))
						R+puts(L);
						U(Z(h=O/9));
					}
				n=0;
			}
		}
	}
}
Y(){
	G,E(,19)J,k)E(!,20)T,k)U();
}
lK(){
	XNextEvent(D,o);
	switch(*o){
		K 2:R+o[2]?0:XX k){
			G=1;switch(k){
				K 1:z+l]=1;
				d(m);R+1;
				K 'j':z Q t A(t-1][u,g--)K 'l':z Q t<9
				A(1+t][u,g++)K 4:F Q
				u<22&&t>=0&&t<10&&!B[t][u ];
				if(!j){
					F]=1;
					R;
				}
			N(w);
		v(0)K 32:for(;
	q(m,m,2);
	)n=r++;
	R+1;
	K 3:l=0;
	g=3;
	I-6&&j)j=!B[t][u+l ];
	if(!j)R;
	v(l)K 2:z Q(u+1)<22 A(t][u+1,l++)}
	R;
}
X9(_){
	G;
	for(j=_; j; j--)I)s]=s-1];
}
U(){
	void*a=&C;
	C.w=200;
	C.h=30;
	M(T,1);
	sprintf(L,"Score%9d Level%9d",r,h);
	XDrawString(D,p,J,7,15,L,29);}
P(){
	signal(14,f);
}

