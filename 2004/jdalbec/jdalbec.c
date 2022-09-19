#define Nd Np define
#define Ni(N) Np include <std##N##.h>
#define Np ??=

Ni(def)
Ni(io)
Ni(lib)

Nd Ba BC(B, I)
Nd Be BC(Br, I)
Nd Ca(C, Ca) CB(B, In C, Ca)
Nd Cl(Cl) Cl Cl
Nd Cs const
Nd FrB N = Zr; Fr((O, B = BrB(BrF, I)))
Nd Fe(F) FO (In = Zr; F; In++)
Nd FF FB(B); FB(BF);
Nd FI Fe(IO)
Nd FO for
Nd Fr(F) FO (I = Zr; F; I++)
Nd II I I, In
Nd In(I, Ir) main(I, Ir)
Nd IO In[O[C + I]]
Nd Ir(I) if (I)
Nd Nb N > N && N > -O
Nd Rb(Rb, B) BBr(Br, Rb, B)
Nd Re return
Nd Sc struct
Nd Si(Te) sizeof (Te)
Nd Te typedef
Nd Zn N < Zr

Te char C;
Te int I;
Te size_t Si;
Te void V;

Cs C *Na =

    "H   "                                                              "He  "
    "Li  Be  "                                      "B   C   N   O   F   Ne  "
    "Na  Mg  "                                      "Al  Si  P   S   Cl  Ar  "
    "K   Ca  Sc  Ti  V   Cr  Mn	 Fe  Co  Ni  Cu  Zn  Ga  Ge  As	 Se  Br  Kr  "
    "Rb  Sr  Y 	 Zr  Nb  Mo  Tc  Ru  Rh  Pd  Ag  Cd  In  Sn  Sb  Te  I   Xe  "
    "Cs  Ba* Lu  Hf  Ta	 W   Re  Os  Ir  Pt  Au  Hg  Tl  Pb  Bi  Po  At  Rn  "
    "Fr  Ra**"

        "   *La	 Ce  Pr  Nd  Pm	 Sm  Eu	 Gd  Tb  Dy  Ho	 Er  Tm	 Yb  "
        "  **Ac  Th  Pa  U   Np  Pu  ";
Cs C *Xe = "111%%d:\0\n";
Cs C H[] = "22";
Cs C U[] = "3";
Cs I Zr = 0;
Cs I O = 1;
Cs I W = 2;

V (*At)(V) = abort;
V (*F)(V *) = free;
V *(*Mo)(Si) = malloc;
I (*Pr)(Cs C *, ...) = printf;
I (*P)(I) = putchar;

Nd Tm(B,C) \
Sc B { \
	C *B; \
	I N; \
} ; \
Te Sc B *B; \
\
B N##B (I) ; \
V F##B (B) ; \
C B##C (B, I) ; \
V C##B (B, I, C) ; \
\
B N##B (I N) { \
	B B; \
\
	Re (W, B = Mo(Si(Sc B))) ? \
		(O, B->B = Mo(((W, B->N = N) ? N : O) * Si(C))) ? \
			B Cl(: (At(), B)); \
} \
V F##B (B B) { \
	F(B->B); \
	F(B); \
} \
C B##C (B B, I N) { \
	Re B->Nb ? B->B[N] : (C) Zr; \
} \
V C##B (B B, I N, C C) { \
	N; \
	B->Nb ? B->B[N] = C : C ? At(), C : C; \
}

Tm(B,C)

V Pb (B) ;
I Bi (B) ;
C Co (B, B, I) ;
B Sb (B, I) ;

V Pb (B B) {
	I I;
	Fr(Ba) 
		P(Ba);
}
I Bi (B B) {
	I I;
	Fr(Ba) ;
	Re I;
}
C Co (B Br, B B, I N) {
	I I;
	Fr(I < N)
		Ir(Be - Ba)
			Re Be - Ba;
	Re Zr;
}
B Sb (B Br, I N) {
	B B;
	I I;

	B = NB(Zn ? Bi(Br) + N : N);
	FO(I = Zn ? -N : Zr; Zn ? Be : I < N; I++)
		CB(B, Zn ? I + N : I, Be);
	Re B;
}

Tm(Br,B)

V PBr (Br, I) ;

V PBr (Br B, I N) {
	I I;
	Pr(W * W + Xe, N);
	Fr(BrB(B, I)) {
		P(O[Na]);
		Pb(BrB(B, I));
	}
	P(Xe[W << W]);
}

B Dy (B, I) ;
I S (C, B) ;
Br Sr (Br) ;

B Dy (B Br, I N) {
	B B;
	C C, Cr;
	II;

	B = NB(W * Bi(Br));
	FO(In = I = Zr; (O, C = Be); I++) {
		FO(Cr = O; (W, C == BC(Br, I + Cr)); Cr++) ;
		I += Cr - O;
		Ca(++, Cr + Si(H)**H - Si(U)**U);
		Ca(++, C);
	}
	Ir(N)
		FB(Br);
	Ca(-N, W[H]);
	Re B;
}
I S (C C, B Br) {
	B B, BF;
	II;

	Ir(C == BC(Br, Zr))
		Re Zr;

	Fr(Be) {
		B = Cl(BF = Sb(Br, I); )

		Fe(BC(B, Zr)) {
			B = Dy(B, W);
			Ir(C == BC(B, Zr)) {
				FF
				Re Zr;
			}

			Ir(In % W)
				BF = Dy(BF, W);

			Ir(Zr == Co(B, BF, Bi(BF))) {
				FF
				Re O;
			}
		}

		FF
	}
	B = Dy(Br, Zr);
	I = S(C, B);
	FB(B);
	Re I;
}
Br Sr (Br BrF) {
	Br Br;
	B B, BF;
	II, N;

	FrB
		N += Bi(B);
	Br = NBr(N);
	FrB {
		Rb(N++, B);
		Fe(BC(B, In + O))
			S(BC(B, In), BF = Sb(B, -In - O)) ?
				Ca(+O, O[U]),
				Rb(N++, B = BF),
				In = Zr :
				(FB(BF), W);
	}
	FBr(BrF);
	Rb(N, (V *) Zr);
	Re Br;
}

I In (I, C **) ;

I In (I N, C ** C) {
	Br Br;
	B B;
	II;

	Br = NBr(--N);
	Fr(I < N) {
		FI ;
		Rb(I, B = NB(In));
		FI
			Ca(-Zr, IO);
	}

	Fr(BrB(Br, Zr)) {
		Br = Sr(Br);
		PBr(Br, I);

		Fe((W, B = BrB(Br, In))) {
			Rb(In, Dy(B, Zr));
			FB(B);
		}
	}
	
 {   }  {    }  {   } { } { }  {  }  {  }   { } {     } {   } {    }
{     } { { } } { }   { } { } { }   { }    {   }  { }   { }   { { } }
{ { } } {    }  {   } { } { }  { }  { }   { { } } { }   {   } { {  } }  C;
{     } { { } } { }   { } { }   { } { }   {     } { }   { }   { { } }
 {   }  {    }  { }    {   }  {  }   {  } { } { } { }   {   } {    }

	Re Zr;
}
