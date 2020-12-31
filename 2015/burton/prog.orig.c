#include<stdio.h>
#include<setjmp.h>
#define R return
#define W(x)for(;x;)
#define I typedef
#define H unsigned
I jmp_buf J;
I void P;
I char L;
I int Q;
I H C;
I long long V;
I H char O;
I H short Y;
I H long long Z;

				       O S[]="syntax_error!"
				  "M@K~|JOEF\\^~_NHI]"; L*N,*K,*
			     B,*E,*T,*A,*x,D,v; Q(*k)(); V z(P),j,_,*
			   o,b,f,u,s,c,a,t,e,d; J l; Q _k(P){ R*K?*K++:
			 ~-d; } V r(L a){ R a&&putchar(a); } L n(){ R*T=j=
		       k(),++j; } O G(P){ *o=d,longjmp(l,b); } Z g(Y a){ R a
		    >>s|(a&~-e)<<s;} C p(L*T) { W(r(*T++)); *--T-c&&r(c);} L m
		  (P){ W(!((v=A[*T++])-f)); R v; } P q(L**N) { O*q; b=!b; f=-~b;
		 u=f|b; s=b<<u; c=s|f;			       a=s<<f; t=-~u; e=a
	       <<u; D=v=u<<t;q=S				    +c-~t; q[~s]=a;
	      q--[f]+=a;q--[c						]+=a; B=(L*)
	      N+~e*e;x=B+e						   ; A=B+e/f;
	    o=(V*)(x+a								); A[-
	    ~s]=f; T								 =K =A-
	   a*f;A[*--								  q]=c+
	   c; *q=!								   c; W
	  (++j&&*								    ++q)
	  A[*q-a								    ]=j;
	  W(v<D									     +c)
	  x[v-									     D]=
	  v,A[									     v++
	  ]=j;									     ++j
	   ,v=									    D=e/
	    t;									   W(++
	     v<=								  D+f*
	      u)x							       [v-D+~
	      -c]=							      v|a,A[
		v]=A							    [v|a]=j;
		  W((							 A[v]=A[v|a
		    ]=j							 ,++v<a*u+~t));
		       for(						 ; E=*++N;T[~d]
			  =a)W						 (*T++=*E++);k=
			    T
		    -K?_k:
		 getchar; } Z h
	       (C a){ R(g(a)<<s*
	      f)+g(a>>s*f); } P _i	     (L*T)
	     { *o||p(T); } V _b(V a	    ){ Z e=a
	    ; R A[*T++]!=v+c?G():~-v	   ?a<<z():c-A
	   [*T++]+b	     ?--T,a>>	   z():e>>z();}
	  V _c(L*	       l){ T=B	    +a; W(j)*T--
	  =v+j%c		,j/=c;	     E=B+  (*B==
	  a+c+u			);W(T<		    B+a)*
	  E++=*			++T; T		     =E ;
	  l-B&&			++ *--		     E; }
	   P M(			Z k){		    L*p,e
	    =a>>		u; m		   ()&&G(
	     ); p	       =T=B		  ; _=j=k
	      ; v=u	     <<t,*		T=a; j<d
	      &&(*T+++=c+u,j=j==-j?++p,--j:-j);!j?*T++=
	     v:_c(p); *T++=-~s; *T++=v;*T++=a*t-s; p=T
	   ; E=T+=s*f; W(k)*T--=x[k&~-a/f],k>>=e; W(T
	  -e*f>p)*T--=v; W(T<E)*p++=*++T; *p=d;} P U
	  (L*E){ V*N=o,f; *E=f=d; W(++f<c*u-u)*++N
	  &&(M(*N),r(f+a*u),r(-~s),p(B),*(T=E)=d)
	  ; } V w(P){ L*S=N,*x=N; E=T=B; E+=a
	  <<f;
	  W(T
	  <E

	  &&n(									   ))*
	  T==a									   -~u
	  ?U(T),T:*T==c?E=S?T=S:T:S?T:*T==(a|u)?S=T:*T==a*f-c/f?E=T:!x&&A[*T]!=f?x=T++:
	  ++T; *T=d;R j&&!x?w():T-B; } P _d(V e){ L T=c*f-f;V o=j*e+v; D=d; A[v]==T++?D
	  =u<<t:e>c&&A[v]==T++&&(v|a)-a*-~f<~-s?D=b+(v&a)+a*f-c:d; D&&(j=o-D); }V y(P){
	  V a=z();W(m()&&v<c+f&&(v-=u<<b)>=d)v?v-b?v-f?v-u?v-=t,a=_b(a):(a&=z()):(a%=z(
	  )):(a/=z()):(a*=z()); R--T,a;} V _f(P){ V e=c; j=d; D=b; *T==u<<t&&(e-=f)&&(*
	  ++T|a)>>f==a-f&&(e<<=b)&&T++; W(D&&(v=*T++))_d(e); R--T,j; } V F(P){ V n=y();
	  W(m()&&v<u*f)v<t?n+=(v-f)*y():v-b^t?n^=y():(n|=y()); R--T,n; } V i(Z n){R n>>
	  a/f?
	  n>>a
			  ?h(n)<<a|h(n>>a
		     ):h(n):g(n); } Q main(Q x
		    ,L**K){ V*A; q(K); W(w())**
		  K-c*c-b||p(B),_i(!setjmp(l)?T=B
		,M(((A=(*o=m()==c-~s&&(j=a|T[-b])&&
	      s-m()==~s)?&o[j-a*u]:(T=B,&_)),*A=F())
	     ),B:(L*)S);		   } V z(P){ V
	    s; W(m()			       &&v<=f*c
	    )R v<t				 ?(v-f)*
	   z():(				  v-=u<<
	   f)<f					   ?v?--v
	  ?G()					    : i(z(
	  )):~					     z( ):
	  (v-=					     f) <u
	  ?v?s					     = F()
	  ,m()					     ==a>>
	   b?s					    :G ():
	   _:!					    (v-=
	    t)?					  --T,_f
	     ():				v-f?o[
	      (T[			      -b]|a)-
	      a*u]:			      !z();
		G();			       }
