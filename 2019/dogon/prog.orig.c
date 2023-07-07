#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>
#define G >>
#define O <<
#define S E(4)k=V+(V&2),
#define P(V,I)	U(q+V,t*4+I)
#define E(b) for(int V=0; V<b; V++)
#define R a d; long t,r,c,k; unsigned q[16]
											      long H,A,s,h,
											   L, I, f, e; unsigned
											 F=-1,D,l,i,g= 2; typedef
			 unsigned		 long a,			       *T; typedef unsigned*o; T p,
			 C; o n,		 w; a y=			     -1,j,m; void J(unsigned I, o f){
			R; S f[k		]=C[I]&				    64?p[I+(V&2)]G	V%2*32:p[I]G V
			%2*4+16			*(V&2)&				   F ; } void u(	  int l, int g,
			long I,			long b,				   long M){ R;		    c=4l O g; r
			= Y G 5			O s; t=				  X G 5 O s ;		     if(l<194&s>
			6|I>=H+		       t|I+2 *c				  <=H-t|b>=A		      +r|b+ 2* c
		       <= A-r)		       return;				 o n=w+(b-A		       +r O 4 G s
		       )*D+(I-		       H+t O 4				 G s); if(			g<=s -7){
		       *n =-1;		       return;				 } J(l,q);			if( g--){
		       S u(q[k		       ],g,I+V				 %2*c,b+V			 /2*c,M*8
		      +V ); }		      else{ t				 =0; r=4-			 s; if(r<
		      0){ t=-		      r; r=0;				 } M^=M G			 1; E(8 O
		      r){ for		      (k=0; k				 <8 O r;k			 ++){n[(V
		      G t)*D+		      (k G t)				 ]|=V*k|r			 <2?-(p[l
		      ]G(V G		      r)*8+(k				 G r)&1)|M			&513 O 12
       :99; } } } } a U(o v,a j){ R; r=0; t=j/4; T N=(T)v; if			  (t>0){ S		       J(v[k],q+
       2*k),r=917*r+v[k]; if(j&1)return P(5,-2);d=N[0];} else			  { r=(d=v[		       0]|v[1 ]O
       4)+719*(m=v[4]|v[5]O 4); if(j&1)return d G 18&3855| (m			   &15420 )		      O 14; d|=
       m O 32 ; } for(; c=n[r&=Z-1]; r++)if(d==p[c]&(!t|p[c+2			   ]==N[2]))		     break; int
       L=t--+1; if(L>h)L=h; if(C[c]&63^L|!c){ if(!c){ p[n[r]=			    c=g]=d; p		     [g+=2]=N[
       2]; g+=t>=0; } if(t<0){ E(2-!h){ r=0; E(4){ a B=d G V&			    y; B+=d*2		    G V&y; B+=
		    d/2 G V		    &y; B+=				     (B O 8)+(		   B G 8 ); r
		    |=(((B+		    y&y*6^3				      *y)+y G 3		  )&(d G V|B
		    )&y)O V		    ; } d=r				      ; } d=(d G	 18&F )O 32;
		   } else{		   E(11)if				       (V+1&3)q[V	]=P(V,0); S
		   q[k]=P(		   k,(t>h-					2)); d=64|     P(0,2)O 32;
		   } C[c]=		   L| d; }					 return j&2   ?c:C[c]G 32
		   ; } int		   main(){					  n=calloc(Z,8); F/= 17;
		  w=n+Z+F		  / 256 ;					   char*b=(char*) w-99;
		  o z=w+F		  /32 ,Q;					    p=(T)(99999+z); C=
		  p+1; R;		  y/= 15;					     E(64){ { S q[k]=
		  l; } t=		  V; l=P(			0,2); g+=!V; } Display*_=XOpenDisplay(0); while(gets(b)) {
		 if(I ++		 &&b[0]^			35){ if(sscanf(b,"%d%d%d%d%d",&t,q,q+1,q+2,q+3)==5){ t-=3;
		 S q[k]=		 q[V]?w[			q[V]]:t*3-1; } else{ t=p[0]=j=k=r=0; while(f=b[r++]){ if(f
		 ==42)p[		 0]|= 1l			O j*8+k; k++; if(f==36)j++,k=0; } J(0,q); } l=w[++D]=P(0,2
       ); } } *z=l; z[1]=t; Window f = XCreateSimpleWindow(_,		RootWindow(_,0),0,0,X,Y,1,0,0); Q=z+=2; D=X+128; XImage*j=
       XCreateImage(_, DefaultVisual(_,0),24,2,0,(char*)w,X,Y					,32,D*4);
       XEvent m; XSelectInput( _, f, 1 ); XMapWindow(_, f); d					: printf(
       "G:%ld M:%d L%d S%d\n",e,g,t,s); K:L-=L>2; u(l,t,-4l O					t,-4l O t
       ,0); XPutImage(_,f,DefaultGC(_,0),j,0,0,0,0,X,Y); E(Y*					(X+128))w
       [V]=0; if(XCheckWindowEvent(_,f,1,&m)){I=XLookupKeysym					(&m.xkey,
	       0) &63;		       if((I-1							&15)<4)*(
	       I&1?&H:		       &A)+=(I							-1&2)-1 O
	       s +2; i		       ^=I==8;							h+=(I==29
	       )-(h&&I		       ==27);							s+=(I==45
	      )-(s&&I		      == 61);							L^=I==32|
	      2*(I ==		      48) ; }							if(L&1 ){
	      if(!i){		      e+=1l O							h; d=t+2;
	      do{E(16		      )q[V]=3							*t-1; t++
	      ; r=t<d		      |t<h; J							(l, q+5);
	     S q[k]=		     P(2*k,-							2); l=P(0
	     ,2 *r);		     } while							(r);while
	     (--t-1)		     { J(l,q							+10); S J
	    (q[10+k		    ],q+2*k							);E(16)if
	    ((V^V/2		    )&5^5&&							q[V]-3*t+
	    4){ *++		    z=l;*++							z=t;*++z=
	    e; goto		    d; } l=							P(5 ,-2);
	    } }else		    { if(z>							Q){ z-=3;
												e=*z; t=z
												[-1]; l=z
												[- 2] ; }
												goto d; }
												}goto K;}
