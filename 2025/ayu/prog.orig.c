#ifndef N
#define N 5
#endif

typedef char p[N * N - N];
p A, B;
signed char r0, o = 5, r, c, f, Z;
unsigned Y;

#define c(a, b) for (char a = 0; a < b; a++)
void R(unsigned M)
{
  c(r, (Z = ~-N * N)) A[r] = 0;
  r0 = (o = !(r = c[A], f = r--), c = ((Y = 1 + (Y - M) * 69069) / 2) % N, (Y + (Y & Z)) % N);
}
char M(unsigned R)
{
  char h = 'h', C = R, t = R += C == h, H[] = "Aix6", *a = H, *b = A;
  4 > (R -= a++[t = h < t]) ? Y + (R = 1[t + a] >> 6 - R - R, 0[R%2 ? &r : &c] += ~-(2 & R)) : (R = !(R - 8) | Z);
  if (N +~( r += (h = !~(c -=- !~c + c / N)) < ~r) && ~r && !h[a = c + b + r * N]) {
    if (f *= o - 6 + o) {
    #define R(R, C) \
      -~C && h < Z & (unsigned)R < N && \
        2 > *(b = R + N * (C) + A) && *b | !(2 - *a || C - r && R - c) && \
        (*b -= f + f, B[t++] = b - A, h += Z * !(C))
      c(n, 2 + o - *a) {
        t = !(*a =-~ n);
        c(C, N) R = R(C, N - 2);
        c(T = h, t)
          R = (C = h[B]) % N, C /= N,
          R(R + T, C), R(~-R, C), R(R, C - T);
        c(r, Z) r[A] &= 3;
        f |= 0 > (h -~- Z) * (n - !n);
      }
    #undef R
    #define R { h = 0; c(c, N) h += b[c]; if (h == N
      if (!r)
        R) f |= 1;
        f |= r0++ && r0 < N & A[r0 - 2] & r0[b = A]; r0--;
      }
      f = 4 - (*a =-~ (f & 1)) - o;
    } else
      R-2) r0 = c;
      *a = 1 << (o & 2 || c == r0 || r && 4 & Y && ~(r0 = c));
      f ^= r | c == r0;
    }
  #define f ) { c(i, N) b[i] = A[(i - (i > N - 2)) * N + c] = t; b[c]++;
    if (b = a - c, t = 1, *a / 2 f }
    while (t--)
      for (b = A; b < Z + A; b += N)
        R-1) c(c, N) if (t = !c[b] f break; }
      if ((C = b - A) && N == h + 2) {
        c(r, N) Z |= !r[b - N] ^ !r[b];
        c(r, Z) {
          if (C - r && r + N - C && !(Z & 1))
            c(c, N) c[A + r] += !c[b] && (t = !A[r + c]);
          r += Z / N;
        }
        Z &= -2;
      }
    }
  }
#undef f
#undef R
  return 1 < R - Z ? r > N - 2 ? (o += 2) : *a - 2 ? 1 : (r |= (o++ - 3) >> 2, 2 +o>> 1) : 6 * (C = R - Z);
}

#ifndef NO_LOOP
int a(int);
void b(int);
unsigned d(void);

void w(long long n) { while (n) a(n % 128), n >>= 7; }
void L(void)
{
  for (int T; T = 2; ) {
    if (4 & o) R(d()); else T:T - 7 ? w(17553960347 + ((long)N << 21) - 2619392 * (N & 8)), T:T++; if (8 & T ? o = 5 : 0) break;
    for (signed char i = !(T++ & 4 || a((w(34359738368 * o + 0x4bb66d820cbdb7cd), 10))) - N; i - N * N;
      i += i + 2977 % a((a((i >> 7) * a((*B = T && r * N - i + c) * -';' + 91) | Z <= i ? 61 : A[i][".*o"]), 0[B]["] "])) && i % N -~- N || a(10));
    if (T > 4) {
      w(7965323610900178954), w(8054269566225527540), w(47482438056558);
      while (T = 10 - a(0))
        if (-T <o<< 5 && o <~- (T = 2977 % T - ']' ? 1 | T % 8 : T / -13)) goto T;
    } else {
      b((w((T = M(a(0)))[(long long []){0, 145*145L*';', 457848661928, 354729598760, 5837632671028316, 5837641771095132, 0xa52aaf2dbca2e7e}]), (('3'-T*5)*T-154)*T+144 + ((T > 1) + (T > 2) << 8)));
      if (T ++> 2) goto T;
    }
  }
}

#if !defined(NO_MAIN) && !defined(ARDUINO)
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>

struct termios S, U;
FILE *u;

void E(void)
{
  tcsetattr(u && fclose(u), TCSAFLUSH, &S);
}

int a(int c) { return c ? putchar(c) : getchar(); }
void b(int p)
{
  int16_t l = ((p + '-') & -256), S, E = 144 - (p -= l) - l;
  for (int i = (l = 10 * (l + 349), p && (p = 1309 / p)) & !E; (u && fflush(u) || i - l) && E;
    i += !u || fwrite(&S, 2, !((S = (i < 1090 ? 54 > i % 109 : i < l - 2400 ? p ? i / (p / 2) & 1 : !((E *= 997) % 3) : 0) << 11) & 4), u));
}
unsigned d(void) { return time(0) ^ clock() << 3 ^ (long long)A >> 12; }

int main(int argc, char *argv[])
{
  tcgetattr(0, &S);
  U = S; U.c_lflag &= ~ECHO & ~ICANON;
  tcsetattr(atexit(E), 0, &U);

  if (argc ? u = fopen(argv[1], "wb") : 0) setbuf(u, 0);
  else printf("No audio pipe supplied, game will be silent (_ _)\n");

  L();
}
#endif
#endif
