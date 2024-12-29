
#include <stdlib.h>
#include <stdio.h>

#define JF 0
#define JG 1
#define JH 2
#define JI 3

#define a(p,q,r,s) s=(p<r)?s:(p=q,s+1)
#define b(p,q,r,s,t,u,v) a(p,q,r,s),a(s,t,u,v)
#define c(p,q,r) for(p=q; p<r; p++)
#define d(p,q,r,s,t,u) for(p=q,s=t; s<u; p++,a(p,q,r,s))
#define e(p,q,r,s,t,u,v,w,x) for(p=q,s=t,v=w; (v<x); p++,b(p,q,r,s,t,u,v))

#define f
#define g(p) ,p
#define h(p) j(p,f,f)
#define i(p,q) j(p,q r,g(r))
#define j(p,q,r) p* N##p(q) { p* s=(p*)malloc(sizeof(p)); s->M=L[J##p]; ((p##0)s->M[0])(s r); U s; }
 
#define k(p, q) C struct { K* M; q } p
 
#define l(p) printf(O+p

#define m(p, q) (_->P+(q<<4&0360))[017&p]

#define n void
#define o int

#define A char
#define B const
#define C typedef

#define D C n
#define E C o

#define U return
#define V(p) (p<3)?0:(p<6)?3:6
#define W(p,q,r) ((p)q->M[r])(q)

B A* B O = "  %c%s\0\n0 1 2  3 4 5  6 7 8\n\n\0%s\n\0you win\0you: \0%1s\0%d %d\0you lose\0cpu: %c %d %d\n\0  \0";
 
D (*K)(n);

k(F, o P[00400]; );
k(G, F* Q; B A* R; );
k(H, F* Q; B A* R; );
k(I, F* Q; B A* R; );

D (*F0)(F*);
E (*F1)(F*);
D (*F2)(F*, o, o, o);
E (*F3)(F*, o, o, o);
D (*F4)(F*);
D (*G0)(G*, F*);
E (*G1)(G*);
E (*G2)(G*, o*, o*, o*);
E (*G3)(G*);
D (*H0)(H*, F*);
D (*I0)(I*, F*);

n OOOO(F* _) {
  o p;
  c(p, 0, 0xFF) _->P[p] = 0;
}

o OOOl(F* _) {
  o p, q, r;
  e(p, 0, 9, q, 0, 9, r, 1, 10) if(((F3)_->M[3])(_, p, q, r)) U 1;
  U 0;
}

n OOlO(F* _, o p, o q, o r) {
  m(p,q) = r;
}

o OOll(F* _, o r, o s, o t) {
  o u = 0;
  if(t > 0 && t < 10 && r >= 0 && r < 9 && s >= 0 && s < 9 && m(r,s) == 0) {
    o p, q;
    o w = V(r);
    o x = V(s);
    c(p, 0, 9) if(m(p,s) == t || m(r,p) == t) goto v;
    d(p, w, w+3, q, x, x+3) if(m(p,q) == t) goto v;
    u = 1;
    v: U u;
  }
  goto v;
}

n OlOO(F* _) {
  o p, q;
  for(q = 0, l(28)), p = 0; q < 9; p++, q = (p < 9)?q:(p=0,l(0), q+'a', O+((q == 2 || q == 5) ? 27 : 28)),q+1)) {
    l(2), m(p,q) == 0 ? '.' : '0' + m(p,q), O+((p == 2 || p==5) ? 82 : 83));
  }
  l(7));
}

n lOll(G* _, F* p) {
  _->Q = p;
  _->R = O+6;
}

o OlOl(G* _) {
  o p, q, r;
  if(((G2)_->M[2])(_, &p, &q, &r)) {
    ((F2)_->Q->M[2])(_->Q, p, q, r);
    U 1;
  }
  U 0;
}

n OllO(G* _) {
  l(30), _->R);
}

n Olll(H* _, F *p) {
  lOll((G*)_, p);
  _->R = O+34;
}

o lOOO(H* _, o* p, o* q, o* r) {
  do {
    A s[3];
    l(42));
    fflush(stdout);
    scanf(O+48, s);
    if(*s == 'q') U 0; else *q = (*s >= 'a' && *s <= 'i') ? *s - 'a' : 9;
    scanf(O+52, p, r);
  } while(!((F3)_->Q->M[3])(_->Q, *p, *q, *r));
  U 1;
}

n lOOl(I* _, F* p) {
  lOll((G*)_, p);
  _->R = O+58;
}

o lOlO(I* _, o* p, o* q, o* r) {
  o s, t, u;
  o v = 0;
  o w[01331];
  e(s, 0, 9, t, 0, 9, u, 1, 10) if(((F3)_->Q->M[3])(_->Q, s, t, u)) w[v++] = s | (t << 5) | (u << 10);
  s = rand() % v;
  *p = w[s] & 0x1f;
  *q = (w[s] & 0x3e0) >> 5;
  *r = (w[s] & 0x7c00) >> 10;
  l(67), *q + 'a', *p, *r);
  U 1;
}

K M[17] = {
  (K)OOOO,
  (K)OOOl,
  (K)OOlO,
  (K)OOll,
  (K)OlOO,
  (K)0000,
  (K)OlOl,
  (K)0000,
  (K)OllO,
  (K)Olll,
  (K)OlOl,
  (K)lOOO,
  (K)OllO,
  (K)lOOl,
  (K)OlOl,
  (K)lOlO,
  (K)OllO
} ;

K* L[4] = {
  M+0x0,
  M+0x5,
  M+0x9,
  M+0xD
} ;


h(F)
i(G, F*)
i(I, F*)
i(H, F*)

o main(o s, A** t) {
  o p = 42;
  
  F* q = 0;
  G* r[2] = { 0, 0} ;

  if(s-- > 1) {
    srand(atoi(t[s]));
    U main(s, t);
  }
  
  q = NF();
  r[0] = (G*)NH(q);
  r[1] = (G*)NI(q);

  for(p&=1; !(p&4); p&=5) {
    W(F4,q,4);
    if(W(G1,r[p],1)) {
      if(!W(F1,q,1)) {
        W(F4,q,4);
        W(G3,r[p],3);
        p = 4;
      }
    } else {
      p = 4;
    }
    p++;
  }

  free((n*)q);
  free((n*)r[0]);
  free((n*)r[1]);

  U 0;
}
