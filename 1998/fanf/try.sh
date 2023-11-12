#!/usr/bin/env bash

make all || exit 1

echo "$ echo '((\a(\b(\c(d)))) e' | ./fanf" 1>&2
echo '((\a(\b(\c(d)))) e)' | ./fanf
echo 1>&2

echo "$ echo '
(\f\g\x
  (
    (g x) (f x)
  ) K K z
)'|./fanf" 1>&2
echo '
(\f\g\x
  (
    (g x) (f x)
  ) K K z
)'|./fanf
echo 1>&2


echo "$ echo '(\f(\f\g\x( (f((\a(g(b))) e)) (g x) ) K K z))' | ./fanf" 1>&2
echo '(\f(\f\g\x( (f((\a(g(b))) e)) (g x) ) K K z))' | ./fanf
echo 1>&2

echo "$ echo '
(Y\f\n
  ((= n 0)
   1
   (* n (f (- n 1)))
  )
)' | ./fanf" 1>&2

echo '(Y\f\n
  ((= n 0)
   1
   (* n (f (- n 1)))
  )
)' | ./fanf
