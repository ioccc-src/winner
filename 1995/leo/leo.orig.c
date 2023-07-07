#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define N O->
#define Li(V,K)[(K)*Ga/32+V/32]
#define Mg(P,V,K)(P Li(V,K)>>(V&31)&1)
#define H(P,V,K)(P Li(V,K)|=1<<(V&31))
#define U(P)calloc(P,1)
#define Au(V,K)Al[K|N U+V+V-1&7]
#define Ti(V,I,K,Y)((V^I&&K^Y&&I<Ga&&Y<As)?D[0]=Mg(Au,(V<I?V:I),K<Y?K:Y),F&2||H\
	(Au,(V<I?V:I),K<Y?K:Y),D[0]:0)
#define Mn (V=rand()%100,(V>=Li/2)+(V<Li)-(V<Li/2))
#define Ge(P)P&&I[P]<Ga&&Y[P]<As&&!D[P]&&(Ge=Zr(I[P],Y[P],N T+1))&&!Mg(U,I[P],Y\
	[P])&&(Ag(I[P],Y[P],(N U+2*P-3)&7,N T+1,F&24?C:Ge),0)
#define W(P)4-2*P-D[8]&&(I[P]=N V+Au(P,0),Y[P]=N K+Au(P,8),D[P]=Ti(N V,I[P],N K\
	,Y[P]),printf("%d %d %lu %lu O ",Au(P,0)>>D[P],Au(P,8)>>D[P], N V, N K))

Ar *U, *Au, W, Li, F, time ();

Mo Al[27];

S
{
  Ar V, K, U, T;
  S *H;
}
*C, *Zn;

S *
Zr (Mo V, Mo K, Mo T)
{
  S *O = C, *W = Zn;
  *(Mg(U, V, K)?&W:&O)=0;
  while (O)
    O = (W = !N T || (N T &= -!!(N V - V | N K - K | !(T - N T ^ 1))) ? O : 0) ? N H : 0;
  return W;
}

void 
Ag (Mo V, Mo K, Mo P, Mo T, S * O)
{
  S *H = (O ? N H : C);
  *(H ? &O : &Zn) = O = *(O ? &N H : &C) = U (sizeof (S));
  N U = P; N T = T; N H = H; N V = V; N K = K;
  F & 32 || H(U, V, K);
}

void 
main (Mo V, char ** O)
{
  char *H;
  srand (time (0));

  while (*++O && (sscanf (*O, "%lu", W ? &Li : &W) ||
    (--**O, F |= !((**O - 57) % 14) << (**O - 57) / 14))
  );

  puts("%!\n/S{ 0 setlinewidth} /N{ showpage} /O{ moveto rlineto stroke} def def def S");
  for (V = 0; V < 8; Al[8 | (V - 2) & 7] = Al[V] = !!(V & 3) * (1 - (V & 4) / 2) * 4, V++);
  do
    {
      U = U (V = (As * Ga + 31) / 8);
      Au = U (V);
      for (*U = -W-1, H = U(W); ++*U; H[*U+W] = Mn);


      Ag (Ga / 2, As / 2, 5, 1, C);
      Ag (Ga / 2, As / 2, 1, 1, C);

      while (C) {
	Ar I[7], Y[5], D[13];
	S *Ge, *O = C;

	if (N T)
	  {
	    D[8] = (F & 4 ? Mn : W ? H[N T % W] : (N T & 85) % 3);
	    W ((!!C>>!C));
	    W ((!!C<<!!C));
	    Ge ((1 + D[8] / 2 + ((1 - ( F & 24 && (F & 16 || N T & 1))) & D[8])));
	    Ge (((1 + (F & 24 && (F & 16 || N T & 1))) & -(D[8] & 1)));
	  }
	free((C = N H, O));
      }

      puts ("N S");
      fflush (stdout);
      free (H);
      free (U);
      free (Au);
      sleep (3);
    }
  while (!(!(W >> 1) | F & 1));
}
