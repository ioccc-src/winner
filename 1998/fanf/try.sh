#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/fanf
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: echo '((\a(\b(\c(d)))) e)' | ./fanf: "
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo '((\a(\b(\c(d)))) e)' | ./fanf
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ echo '
(\f\g\x
  (
    (g x) (f x)
  ) K K z
)'|./fanf" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo '
(\f\g\x
  (
    (g x) (f x)
  ) K K z
)'|./fanf
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ echo '(\f(\f\g\x( (f((\a(g(b))) e)) (g x) ) K K z))' | ./fanf" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo '(\f(\f\g\x( (f((\a(g(b))) e)) (g x) ) K K z))' | ./fanf
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo "$ echo '
(Y\f\n
  ((= n 0)
   1
   (* n (f (- n 1)))
  )
)' | ./fanf" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

# This warning from ShellCheck is incorrect because we don't want to expand escape sequences.
# Thus this does show correct output.
#
# SC2028 (info): echo may not expand escape sequences. Use printf.
# https://www.shellcheck.net/wiki/SC2028
# shellcheck disable=SC2028
echo '(Y\f\n
  ((= n 0)
   1
   (* n (f (- n 1)))
  )
)' | ./fanf

exit 0
