#define _(x)for(F=0;x>F;++F)
												   float x,
													T=240
					,B,j=			.53,f,y,O[4426112],			  Z,w,
				   R,			   n,				     m,E	   ,i
			       ,							       U,g=
				      0;	       char P[60737];int d=80,X=79,Y=64,l=40,    L=
			       551368,	     t,I,a,F,G,e,M=6400,c=15168,J	   =949,K=12,k=
				      0x1fbb4000;float*W(int t,int I,int a,int T){	    return&O[(t
	       +      82*I+6724 *a)+(c+T*L)];}float b(float x,float y,float n){x=x*x+y*y+n*n;int s=k+(*
	   (       int*)&x>>1);return*(float*)&s;		     }void H(float x,float y,float n,
		 float*k,float*h,float*c)	    {U=b(x,y,n);*k=x/U;*h=y/U;*c=n/ U;}void s(int x,	int
       S){     _(L)O[c+x*L+F]+=.4*O[	     c+S*L+F];}float*D(int o){return &O[(t   *X+I)*3+o];}     float
      z(      float k){return 0>k?	-k:k;}void o(int x,int y){_(e){G=F%M;t= G%d+1;I=G/d+1;a=F   /M+1;*W		(t
     ,I,a   ,x)=*W(  t,I,a,y);}}      void A(float*z){*z=*z<.5?.5:*z>85?85:*z;}void u(int E,	 int y,int     u       ,
    int v  ,int w)    {_(e){G=F%M;t=G%d+1;I=G/d+1;a=F/M+1;float U=t-d*.4**W(t,I,a,u),J=I-    d*.4**W(t,I,  a,v)	     ,e=
     a-d*  .4**W(t      ,I,a,w);A(&U);A(&J);A(&e);float F=U-(int)U,j=J-(int)J,l=1-j,    i=e-(int)e,c=1-i;*W(t	   ,I,a
     ,E)=(1-F)*(l*c		**W(U,J,e,y)+j*c* *W(U,1+J,e,y)+l*i**W(U,J,e+1     ,y)+j*i**W(U,1+J,1+e,y)	 )+F*(
      l*c**W(U+1,J,e,y)			 +j*c**W(1+U,1+J,e,y)+l*i**W(1+    U,J,1+e,y)+j*i**W(1+U,J+1,e+	       1,y)
 )     ;}}int puts(const char*);void v(int x,int E,int k,int    b,int c){*W(t,I,a,x)-=40*(*W(t+k,I+b	    ,a+c
  ,E	  )-*W(t-k,I-b,a-c,E));}void q(int u,int T,int w,int E){_(e){G=F%M;t=G%d+1;I=G/d+1;a=F/M+
  1;*W		(t,I,a,E)=-1./3*((*W(1+t,I,a,u)-*W(t-1,I,a,u))/d+(*W(t,I+1,a,T)-*W(t,I-1,a,T)	 )/
    d+(*W     (		     t,I,1+a,w)-*W(t,I,a-1,w))/d);}_(e){G=F    %M;t=G%d+1;I=G/d+     1;a=F/
		 M+1;v(u,E,1,0,0);v(T,E,0,1,0);v(w,E,0,0,1	    );}}char h[]=
		 "             (\\tjxucXUCQOmqdkaoM&%$\033[38;5;141m+";		 int main(){e=M*d;I=c+
			L*8;P[J*Y]			 ='\0';_(I)O[F]=0;for(t=0;t<Y;++t){P[t*J+X*K
			    ]='\n';for(I=0;I<X;){H(I ++-40,t-32,-145,&w,&Z,&R);*D(0)=w;*D(1)=Z;*D(2        )=
		    R;}}	for(;Q){_(L)O[c+3*L+F]=O[c+4*L+F]=O[c+5*L+F]=O[c+7*L    +F]=0;_(e){G     =F%M
		       ;t=G%d+1;I=G/d+1;a=F/M+1;x=t-l;y=a-l;U=x*x+y*y;G=k+(*(int*)&U>>1);i=*(float*)  &G;if
			       (I<13&I>10){if (i<2){*W(t,I,a,4)=1.5;m=g+(I/d);U=m*m;w=m*m;m=m-(U*m)/6+(U*
						 U*m)/120;E=1-w/2+(w*w)/24;*W(t,I,a,3)=m/2+.0275;*W(t,I
					       ,a,5)=E*.7-.35;}}if(I<2&i     <3)*W(t,I,a,7)=.1;}s(0,
						  3);s(1,4);s		(2,5);o(5,2);o(4,1);o(3,0    )
						    ;q(3,4,5,1);u(1,4,3,4,5);u(0,3,3,4,5);u(2     ,5,3
				 ,          4,5);     q(0,1,2,4);s(6,7);o(7,6);u(6,7,0,1,2   );x=T*
						   .9998+B*.02;B=.9998*B-T*.02;T=x;H(- T,0,-B,&R,&w,&            Z
				     );g+=              .1;g=g>3.14	?-g:g;H(Z,0,-R,&m,&E   ,&i);_(
					  5056){G=	 F%5056;t=G%Y;I=G/Y;U=*D(0);	  float v=*D     (1),g
							  =*D(2),V=U*m+v*(E*Z	    -w*i)+g*-R,s=U*E +v*(i*
					  R-Z*		  m)+g*-w;U=U*i+v*(m*w-R*E)+g*-Z;f=0;int q=t*
					      J+I*K+8;for(a=0;a<K;++a)P[q+a-8]=h[35+a];while(f<d*5
						     ){x=z(T+V*f)-l,y=z(s*f)-l,n=z(B+U*f)-l;float
							   k=y>n?y:n,c=x>k?x:k,F=(c<0?c:0)+b(x<0
							  ?0:x,y<0?0:y,n>0?n:0);if(F<.01){x=T+f
							 *V+l;y=f*s+l;n=B+f*U+l; f=1;a=0;for(;
									  (a++<1)|(d>x&	y<d&
					  n<d&			      x>0&0<y&   n>0);  )
					     {f*=1-*W(n+1,1+y,x+1,6)*j;x=x+V*j;y=y+s*j;n=n+U
						   *j;}a=(1-f)*35;a=0>a?0:a>34?34:a;
						    int c=240+.44*a;P[q]=(c-200
						   )/10+48;P[q+1]=c%10+48
						  ;P[q+3]=h[a];break;}f+=F
						;}}puts(P);}}

