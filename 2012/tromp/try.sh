#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/tromp
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

read -r -n 1 -p "Press any key to run: (cat hilbert.Blc; echo -n \"1\") | ./tromp: "
echo 1>&2
(cat hilbert.Blc; echo -n "1") | ./tromp
echo 1>&2

read -r -n 1 -p "Press any key to run: (cat hilbert.Blc; echo -n \"12\") | ./tromp: "
echo 1>&2
(cat hilbert.Blc; echo -n "12") | ./tromp
echo 1>&2

# There's no such thing as a useless cat so we silence. Well okay it's also
# because it's easier to verify that it works as this form was given by the
# author.
#
# SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# https://www.shellcheck.net/wiki/SC2002
# shellcheck disable=SC2002
read -r -n 1 -p "Press any key to run: (cat hilbert.Blc; echo -n \"123\") | ./tromp: "
echo 1>&2
(cat hilbert.Blc; echo -n "123") | ./tromp
echo 1>&2

read -r -n 1 -p "Press any key to run: (cat hilbert.Blc; echo -n 1234) | ./tromp: "
echo 1>&2
# There's no such thing as a useless cat so we silence. Well okay it's also
# because it's easier to verify that it works as this form was given by the
# author.
#
# SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# https://www.shellcheck.net/wiki/SC2002
# shellcheck disable=SC2002
(cat hilbert.Blc; echo -n 1234) | ./tromp
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \" Hello, world\" | ./tromp: "
echo 1>&2
echo " Hello, world" | ./tromp
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"*Hello, world\" | ./tromp: "
echo 1>&2
echo "*Hello, world" | ./tromp
echo 1>&2

read -r -n 1 -p "Press any key to run: (cat uni8.Blc; echo \" Ni hao\") | ./tromp: "
echo 1>&2
(cat uni8.Blc; echo " Ni hao") | ./tromp
echo 1>&2

echo "$ cat primes.blc | ./tromp -b | head -c 70" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
# There's no such thing as a useless cat so we silence. Well okay it's also
# because it's easier to verify that it works as this form was given by the
# author.
#
# SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# https://www.shellcheck.net/wiki/SC2002
# shellcheck disable=SC2002
cat primes.blc | ./tromp -b | head -c 70
echo 1>&2

echo "$ (cat oddindices.Blc; echo -n " "; cat primes.blc | ./tromp -b) | ./tromp | head -c 70" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

# There's no such thing as a useless cat so we silence. Well okay it's also
# because it's easier to verify that it works as this form was given by the
# author.
#
# SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# https://www.shellcheck.net/wiki/SC2002
# shellcheck disable=SC2002
(cat oddindices.Blc; echo -n " "; cat primes.blc | ./tromp -b) | ./tromp | head -c 70
echo 1>&2

read -r -n 1 -p "Press any key to run: cat hw.bf: "
echo 1>&2
cat hw.bf
echo 1>&2


read -r -n 1 -p "Press any key to run: cat bf.Blc hw.bf | ./tromp: "
echo 1>&2
# There's no such thing as a useless cat so we silence. Well okay it's also
# because it's easier to verify that it works as this form was given by the
# author.
#
# SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# https://www.shellcheck.net/wiki/SC2002
# shellcheck disable=SC2002
cat bf.Blc hw.bf | ./tromp

echo 1>&2
echo "We also recommend that you check the author's remarks for more examples." 1>&2
