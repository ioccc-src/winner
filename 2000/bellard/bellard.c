int m = 754974721, N, t[1 << 22], a, *p, i, e = 1 << 22, j, s, b, c, U;
f (d)
{
  for (s = 1 << 23; s; s /= 2, d = d * 1LL * d % m)
    if (s < N)
      for (p = t; p < t + N; p += s)
	for (i = s, c = 1; i; i--)
	  b = *p + p[s], p[s] = (m + *p - p[s]) *
	    1LL * c % m, *p++ = b % m, c = c * 1LL * d % m;
  for (j = 0; i < N - 1;)
    {
      for (s = N / 2; !((j ^= s) & s); s /= 2);
      if (++i < j)
	a = t[i], t[i] = t[j], t[j] = a;
    }
}

main ()
{
  *t = 2;
  U = N = 1;
  while (e /= 2)
    {
      N *= 2;
      U = U * 1LL * (m + 1) / 2 % m;
      f (362);
      for (p = t; p < t + N;)
	*p++ = (*p * 1LL ** p % m) * U % m;
      f (415027540);
      for (a = 0, p = t; p < t + N;)
	a += (6972593 & e ? 2 : 1) ** p, *p++ = a % 10, a /= 10;
    }
  while (!*--p);
  t[0]--;
  while (p >= t)
    printf ("%d", *p--);
}
