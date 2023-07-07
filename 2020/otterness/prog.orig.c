#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define P(a, b) fwrite(a, b, !!a, stdout)
typedef uint8_t u1;
typedef uint16_t u2;
typedef uint32_t u4;
u4 k, l, n;
u1 m, o, p, q, r, s, *t, *u;

u2 A(u1 *c) { return *(c + !!c) | (u2)(*c) << l; }

void B(u1 *c, u2 a) {
  *c++ = a >> l;
  *c = a;
}

int C(u1 *c, u4 *a) {
  u1 b, d = k;
  s = l--;
  *a = k++;
  for (; d<s>> k; d++) {
    b = d[c];
    *a |= b & p;
    if (!(b >> l)) {
      d += k--;
      l = s;
      return d;
    }
    *a = *a << l;
  }
  exit(!k);
  return p;
}

u1 D(u4 a) {
  u1 b = k++;
  u1 c = l - k;
  if (a) {
    b = k;
    while (a >>= k) b++;
  }
  k = k ? !k : k;
  return b / c + !!(b % c);
}

int F(u4 a, u1 *c) {
  u1 b = D(a);
  *c = s - l--;
  r = q / n;
  if (!a) return b;
  if (b > r) exit(o);
  c += b;
  c--;
  while (a) {
    *c = a & p;
    a = a >> l;
    c--;
  }
  l = s;
  return b;
}

u1 *G(u1 *c, u1 *a) {
  u4 d;
  u1 b, e;
  m = m < p ? p << q : m;
  q = q < n + o ? p >> q : q;
  e = *c;
  if (e == m || e == m + q) {
    *a = k;
    c++;
    c += C(c, &d);
    return c + d;
  }
  if (e == (m | p)) {
    *a = k;
    c++;
    c++;
    c += C(c, &d);
    return c + d;
  }
  l /= o;
  if (e >> q) {
    b = *c;
    c++;
    *a = b;
  } else {
    b = *a;
  }
  e = b >> l;
  if (e < s || e > l + s) exit(n);
  if (e != l + s && e != l + o) c++;
  c++;
  l = s;
  return c;
}

u1 *H(u1 *c, u4 *a) {
  u4 b, e, h = q, i = m;
  u1 *d, f = k;
  *a = k;
  q = q / n;
  m = p - m + p / m;
  if (n[c] != m) exit(q);
  b = (u4)A(c + q) << q * q | A(c + (m >> q));
  c += l;
  d = c + b;
  while (c < d) {
    c += C(c, &e);
    *a += e;
    c = G(c, &f);
  }
  q = h;
  m = i;
  return c;
}

u4 I(u1 *c, u4 a) {
  u4 e, b, d = k;
  for (e = k; e < a; e++) {
    c = H(c, &b);
    if (b > d) d = b;
  }
  return d;
}

u1 *J(u1 *c, u4 a, u4 b) {
  u1 d, e;
  if (l > o) {
    o = (--s - o) << r;
    l = p % (s + o);
    r = o / l;
    n = l / r;
    m = o / n;
  }
  d = l + r;
  e = o;
  if (!(a % m)) {
    d = l - m;
    e = o + l;
  } else if ((a % m) == r) {
    d = l;
    e = n + o;
  }
  k[t] = d;
  r[t] = e;
  *u = d;
  memcpy(c, t, b);
  return c + b;
}

void K(u1 *c, u4 a) {
  u1 *b, *d;
  u2 e, f;
  u4 g, h, i, j;
  o = n ^ k;
  m = l;
  l = o << o;
  f = A(c + l + o);
  e = A(c + l + o + o) >> k--;
  p = ~k++;
  p >>= k--;
  q = p >> n;
  if (e >> q--) exit(n + o);
  g = I(c + q--, f) / e;
  i = n + o + D(e);
  if (!(t = malloc(i))) exit(n * o);
  j = g * i + q;
  b = malloc(j);
  r = --l;
  l++;
  if (!b) exit(r);
  *b = l << n | q;
  *(!k + b) = *b + r;
  n[b] = (*b << n) + n;
  o[b] = n[b] + r--;
  B(b + n * o, j - l);
  B(b + o * o, (j - l) >> o * l);
  d = t;
  *d++ = k;
  *d++ = r * r;
  m = p / (n + o);
  *d++ = p - m - o;
  d += F(e, d);
  u = d;
  *d++ = r * r;
  *d = k;
  d = b + l;
  *d++ = k++;
  *d++ = p + q + q;
  memcpy(d, t + k, i - k);
  d += i - k;
  for (h = k; h < g; h++) d = J(d, h, i);
  l = (o + m) / s - m;
  o = r;
  *d++ = --k;
  *d++ = ~k;
  *d++ = p / o - o * l;
  *d = k++;
  *(l + p + c) = k;
  B(c + l + o, f + k);
  P(c, a);
  P(b, j);
}

int main() {
  u4 a, b;
  u1 *c;
  k = !!stdin;
  n = k + k + k;
  l = k << n;
  m = l;
  l = (l | l >> (k + k)) << k;
  b = k << l;
  c = malloc(b);
  if (!c) exit(m);
  a = fread(c, k, b, stdin);
  l = (m << k) + m + k;
  if (a >= b) exit(l / n + k);
  if ((n[c] != l << (k + k)) || ((m - k)[c] != n + n))
    exit((m << k) - (n << k));
  K(c, a);
  return !b;
}
