#include<stdio.h>
#include<ctype.h>
#define w printf
#define p while
#define t(s) (W=T(s))
char*X,*B,*L,I[99];M,W,V;D(){W==9?(w("`%.*s' is ",V,X),t(0)):W==40?(t(0),D(),t(41)):W==42?(t(0),D(),w("ptr to ")):0;p(W==40?(t(0),w("func returning "),t(41)):W==91?(t(0)==32?(w("array[0..%d] of ",atoi(X)-1),t(0)):w("array of "),t(93)):0);}main(){p(w("input: "),B=gets(I))if(t(0)==9)L=X,M=V,t(0),D(),w("%.*s.\n\n",M,L);}T(s){if(!s||s==W){p(*B==9||*B==32)B++;X=B;V=0;if(W=isalpha(*B)?9:isdigit(*B)?32:*B++)if(W<33)p(isalnum(*B))B++,V++;}return W;}
