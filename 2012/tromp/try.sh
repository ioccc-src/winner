#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/tromp
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

# ^-- SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
# shellcheck disable=SC2140 
echo "$ (cat hilbert.Blc; echo -n "1") | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
(cat hilbert.Blc; echo -n "1") | ./tromp
echo 1>&2

# ^-- SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
# shellcheck disable=SC2140 
echo "$ (cat hilbert.Blc; echo -n "12") | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
(cat hilbert.Blc; echo -n "12") | ./tromp
echo 1>&2

# ^-- SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
# shellcheck disable=SC2140 
echo "$ (cat hilbert.Blc; echo -n "123") | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002
(cat hilbert.Blc; echo -n "123") | ./tromp
echo 1>&2

echo "$ (cat hilbert.Blc; echo -n 1234) | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002

(cat hilbert.Blc; echo -n 1234) | ./tromp
echo 1>&2

echo "$ echo " Hello, world" | ./tromp"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo " Hello, world" | ./tromp
echo 1>&2

echo "$ echo "*Hello, world" | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "*Hello, world" | ./tromp
echo 1>&2

echo "$ (cat uni8.Blc; echo " Ni hao") | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002
(cat uni8.Blc; echo " Ni hao") | ./tromp
echo 1>&2

echo "$ cat primes.blc | ./tromp -b | head -c 70" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002
cat primes.blc | ./tromp -b | head -c 70
echo 1>&2

echo "$ (cat oddindices.Blc; echo -n " "; cat primes.blc | ./tromp -b) | ./tromp | head -c 70" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002
(cat oddindices.Blc; echo -n " "; cat primes.blc | ./tromp -b) | ./tromp | head -c 70
echo 1>&2

echo "$ cat hw.bf" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
cat hw.bf
echo 1>&2
echo "$ cat bf.Blc hw.bf | ./tromp" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence:
#
#   SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
#
# shellcheck disable=SC2002
cat bf.Blc hw.bf | ./tromp

echo 1>&2
echo "We also recommend that you check the author's remarks for more examples." 1>&2
