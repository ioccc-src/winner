#include <stdio.h>
#include <stdlib.h>

#define N(I,l) s l]=(I?1<<I|I<<10:01776)
#define f(a,t) for(a=0;a<t;a++)
#define Su(d,o,ku) O(l/9,d) O(l%9,o) O(l%9/3+l/27*3,ku)
#define NO ;printf("%c %s",I?I|48:46,++l%3?"":l%9?"| ":l%27?"\n":l%'Q'?z:"\n");
#define Ba(k,a) {O||printf("!!! " #a " %i\n",k+1);goto l;}
#define O(o,k) f(l,9) c[l]= *#k?0x3fe:-1;\
  f(l,81) if(*#k){\
    if(!(s]&c[o])) Ba(o,k) c[o]&=~(1<<(s]>>10));\
  } else if((s]>>l0)&1) c[o]=c[o]+1?-2:l;\
  if(*#k) { f(l,81) if(s]>>10||(s]&=c[o]),!s]) Ba(o,k) }\
  else f(l,9) l[c]<0||s[c]]>>10||(N(l0,[c]),C++);

struct{ int s[81],I,l,O; } S[0123];
int I, l, l0, o, C, O=0, w=0, c[10], L; long i;
char z[] = "\007      &       &      \n";

#define s S].s[l

int main(int n,char**N) {
    S->O=0; L=n>1?*N[1]-85?1:6:0; i=L&1?atol(N[1]):123;
#define i (int)(81.0*(i=1103515245*i+12345&0x7fffffff)/2147483648.0)
    for(l=C=0;l<81;) {
	I=L&1?0:getchar()^48; i; I=I-30?I:0;
	if(I<10) {
		#define S S[O
		if(C<22) z[C++]^=13; N(I,)NO
	}
    }

    for(;;) {
	l0:
        Su(row,col,box) C=l0=0;
	f(l,81) if(!(s]>>10&&++l0)) {
	  o=s]&1022; for(I=0;~o&1&&(o/=2);I++); o-1||(s]|=I<<10,C++);
	} if(l0==l) {
	  if(O&&L&2) { O--; goto l0; } goto O; 
	} for(l0=1;10>l0;l0++) { Su(,,) }

	if(!C) {
	    l=(o=S].O)?S].I:0; I=o?S].l%9+1:(S].O=i%9+1);
	    for(;l<81;l++,I=S].O,o=0) if(!(s]>>10)) {
		for(;;I=I%9+1,o=1) {
		    l0=0; if(o&&I==S].O) goto O;
		    if(s]>>I&1) {
			S].l=I; S++].I=l; S]=S-1];
			N(I,); O>w&&(w=O); goto lO;
		    }
		}
	    }
	}
	lO: S].O=0; goto l0; l: if(!(l0=O)) { L=0; goto O; } O--;
	s,S].I] &=~ (1<<S].l);
    }

    O: switch(L) {
	case 2: if(l0) {
	case 3: O=82;
	    for(S].l=l=i%81;l0||S].l-l;l=(l+1)%81)
     	     O1: if(l0=0,S].O=s]>>10,~s]&1) {
		s]=1023; S].I=l; S&0]=S]; w=O=0; L=2; goto lO;
	    }
	    L=0; l0=1;
	} else {
	    l=S=82].I; N(S].O,)|1; goto O1;
	}
    }

    printf("\n\n"); for(l=0;l<81;) {I=s]>>10 NO}
    printf("\n%s (stk %i %i)\n",l0?"Done":"No way!",O,w);
    L|=2; if(L-3||!l0) return!l0; S,82]=S]; goto O;
}
