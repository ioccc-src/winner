#ifdef AH
#include<alloca.h>
#endif
#include<setjmp.h>
#include<stdio.h>
#if !NM
#include<sys/mman.h>
#endif
#define vo volatile
#define A(x,y,z) O(x,y,z##1)O(x,y,z##2)O(x,y,z##3)
#define B(x,y) A(x,y,1)A(x,y,2)A(x,y,3)
#define C(x,y) B(x,y##1)B(x,y##2)B(x,y##3)
#define D(x) C(x,1)C(x,2)C(x,3)
#define E(x) D(x##1)D(x##2)D(x##3)
#define G E(1)E(2)E(3)
#define S d->
#define M S a
#define R(x) ; S r(#x);
#define L(x,y) S l[x](d)R(y)
#define F(x) void l##x(vo dt d) {
#define Q(x); M--; *M=*M x M[1]; R(x)
#define O(x,y,z) x##y##z,
#define q typedef
#define H 9<<16
#define I case
#define J(i) calloc(i,1)
#define W(c) e=(k*)memcpy(e,x[(u)c],y[(u)c])+y[(u)c];
#define N break; I
q char k;
q void o;
q int u;
q o(*f) (vo o *);
q struct {
    u *a, **R, *m, h, c;
    k **s;
    f *l, *j, r;
} *dt;
u m[] = { G 0 } ;

u n[H];
dt st;
u sk[H];
k *w;
o *x[H];
u y[H];
k *j, *e;
u l=256;
o g(u v)
{
    if (v > l) {
        g(v / l);
        g(l);
        W('*') g(v % l);
    W('+')} else {
    W(m[v])}
}

f K(k * p, dt d)
{
    k c, n = 0;
    f r = (f) e;
    W(1) while ((c = *p)) {
        switch (c) {
          I '#':
            while (*++p != 10);
          N '[':c = 1;
            S s[S c] = ++p;
            for (; c; p++) {
                if (*p == '[')
                    c++;
                else if (*p == ']')
                    c--;
            }
            p[-1] = 0;
            g(S c++);
          N '!':n = 1;
            c = *++p;
            if (!(c & 1))
              I '<': I '>':
                c ^= 2;
          I '=':W(c) if (n) {
                W('!') n = 0;
            }
            g(*++p);
            W('|') p++;
          N 's': I 'S': I 'l':
          I 'L':g(*++p);
            W(c) p++;
          N '_':p++;
        default:
            if (isdigit(*p)) {
                g(atoi(p));
                while (isdigit(*p))
                    p++;
            } else
                p++;
        W(c)}
    }
    W(2) return r;
}

o t(vo dt d)
{
    S r("\01") Q(+)Q(-)Q(*) * M = -*M;
    R(_)Q( ==) Q(<)Q(>) * M = !*M;
    R(!)M[-1] ^= *M;
    *M ^= M[-1] R(r) M[1] = *M;
    M++ R(d) * S R[*M] = M[-1];
    M--;
    R(s) * ++S R[*M] = M[-1];
    M--;
    R(S) * M = *S R[*M];
    R(l) * M = *S R[*M]--;
    R(L) L(1, /)L(2, p) L(3, x) L(4, |)
#undef O
#define O(x,y,z) *++M=S m[(x*S h+y)*S h+z]; S r("");
    G S l[0] (d);
}

o T()
{
}

o rd(u v)
{
    k *a = 0, **b = &a, **c = b + 32;
    x[v] = w;
    for (; b < c && (*b < w || *b > (k *) T || *b == (k *) (long) v); b++);
    if (b == c) {
        jmp_buf *j = alloca(sizeof(*j));
        setjmp(*j);
        rd(v);
    } else {
        y[v] = *b - w;
        w = *b;
    }
}

q o(*rt) (u);
vo rt rs = rd;
o re(vo k * rec)
{
    static u i = 0;
    *(st->a = sk + 9) = 0;
    rs(*rec ? *rec : m[i++]);
} F(d) M--;

*M /= M[1];
} F(p) printf("%d\n", *M);
} F(x) u n = *M--;

if (!S j[n])
S j[n] = K(S s[n], d);
S j[n] (d);
}

F(1) M -= 2;
if (M[1])
{
M++;
*M = *S R[M[1]];
lx(d);
}
}
o *lib1[] = { T, T, T, T, T } ;
o *lib2[] = { T, ld, lp, lx, l1 } ;

u main()
{
    u i;
    k *b;
    dt d = st = J(sizeof(*st));
    M = sk + 9;
    S R = J(l * sizeof(k *));
    for (i = 0; i < l; i++)
        S R[i] = J(H);
    S m = n;
    S s = J(H);
    S l = (f *) lib1;
    S j = J(H);
    S r = (f) re;
    for (i = 0; m[i]; i++)
        n[m[i]] = i;
    w = (k *) t;
    t(d);
    x[2] = w;
    y[2] = (k *) T - w + 8;
    S h = 100;
    S l = (f *) lib2;
    S r = (f) T;
    j = e =
#if NM
        malloc(H);
#else
        mmap(0, H, -1, MAP_PRIVATE | MAP_ANON, -1, 0);
#endif
    while (b = fgets(malloc(999), 999, stdin))
        ((f) K(b, d)) (d);
}
