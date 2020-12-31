#include <stdlib.h>
#include <SDL.h>

#include <sys/mman.h>
#define M(a) mmap(0, a, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0)

#define W 400
#define H 300
#define I 128

#define L char*
#define _ Sint32
#define h(a,b) for(a=0; a<b; a++)
#define O while(
#define b D[j][i][
#define J(b) a(#b)

										 SDL_Event
										   e;
										SDL_Surface
									    *F; float f, m,
									     n,d,D[H][W][6],
									    v; L A; L X; L
									     V,G[H][W]; L
							     E	 ;            L Q; double
							      R=2/(    W-1. ),T=2/(H-1.),c,g, z=2	 ,*
							       K,*Z,*S; _ B, C, o,i,j,q,k,l,x,y,*u,Y=512; P(
							      L f){ *(u=V)=f-X-5; V+=4; } a(L e){ O l=*e++)
								l-38?l==36?s(2),o--:l-37?*V++=l==35?k=*e++
							 ,k*  16+*e++-81:l^128:o>7?J(Yv]#JJ), P(S++):o++
							  :s(4); } s(_ n){ O o<n){ J(]#IB); P(--S); J(]);
			       *V			  ++=217+o++; } } p(L e,_ q,L *t){ _ x=9; do{ A="%]#IB"
			       ; _	  i     	=*e; 5==q?*K=strtod(e,t),e-*t?e=*t,a(A),P(K++), J(%Yn)
				 : i<6	  ?p   (	e+1,4,t),i-5||J(Y`YIY`YI), e=*t:i>96?a(A),P(Z+i-97),a
				  (A),P (Z+*e++-71)	:(p(index( e, 40)+1,1,t), i^82?i^73?i^65?i^69?i^76?1:J
				 (%YhY`%YmY}]YYB%YBXHYIXH$^A$YqYJ$Ys):J(%Y{YJ%Yj^IY@Y|\\iYIYp%Yh$^AY}$]Y\\J$^I)
			       : J(XHYIXH^AYn):J(]YYn)	: J (]XYn),e= index( *t,41 )+ 1): p ( e , q+ 1, &e); A
			 =	"&%YCXJYLXIYK\\J$^I$^k$^A"; (x -=3)<1?J(&]X]Y),1L <<31<0? J(Zi_`#JO):J(_i]X),x
			 ?J	(#HH):J(#HC),J(#AD#IJPC) ,o-=4:--x?--x?--x?x-3?J(&%YA%YAXHYIXH^AYh$^q\\J$^IY`)
	 ,		  a(A):  1:a(A):J(&$^j$^j):J(&$^B$^B); } O q==(x=*(*t=e++))/2); } main(_ r,L*U){
  X    =V=(Z  =(S=(K=M(Y*32))+Y)+ Y)+Y; J(h#AA#AA#AA#AA#FJ:+-*/); h(q,2){ A =E =Q=U[ q+1]; O * A=*A^B++
	 [	       ";<>+-*/" ]?*A:B,(B%=7)||(isspace(*E=*A)||++E,*A++)); E=V; O B=*Q){ if(Q[1]-61)p(
			 Q,1,&Q); else{ p(Q+2,1,&Q); h(j,2){ J(]#JJ); P(Z+B-71-j*26); o--; } } *Q&&Q++; }
			 }	J(#PPJ#AP#IF); P (E -V+X +1); J(#IJPC); 0[u =X+7] =I; SDL_Init( 32 ); F=
				SDL_SetVideoMode(W,H,8 ,0); A=F->pixels; B=F->pitch; O 1){ C^=3; h(j,H)h(i,
			       W   )b C+2]=9; if(r=(k	=SDL_GetMouseState(&x,&y))&5){ f=z/50; f=k&1 ?f:-f ;
				  c+=(x*T-T/R)*f; g	+= f*y*T-f; z*=f=1-f/z; v=1/f; h(j,H)h(i,W)h(q,4){ k=
				   x+(i-   x)* f       +q/2; l=y+(j-y)*f+q%2; if(k>=0&k<W&l>=0&l<H){ m=x+(k+D[
				l][k	  ][    	3-C]-x)*v-i; n=y+( l+D[l][k][4 -C]-y)*v-j; d= m*m+ n*n;
			       if	  (		 d<b C+2]){ b C]=m; b C+1]=n; b C+2]=d; G[j][i]=A[l*B+
			       k			 ]; } } } }  h(j,H)h(i,W)if(q=b C+2]){ Z[2]=(i *T-T /
							 R)*z+c; Z[28]=z-j *T*z-g; Z[8]= 0; Z[34]=1; q =((_(*
							   )(  ))X)(); A[j* B+i]=q? *u-q:0; h(q,3)b C+q]=0;
								} else A[j*B+i]=G[j][i]; SDL_UpdateRect(F,
							       0,0,W,H); O(r?SDL_PollEvent:SDL_WaitEvent)(&e
							     )) { k=e.type; l=e.key.keysym.sym; if  (	k==
							     12|k==    2&  l  ==27)return;    if(
									      e.type-5?k==
									     2&(l==270|l==
									      269)?*u=l-270
									    ? *u/2:*u*2:0:1
									      )  break;
										    }
										   }  }
