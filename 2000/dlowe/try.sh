#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/dlowe
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

echo "$ echo '13 14 15 16 17 + - * / p' | ./dlowe" 1>&2
echo '13 14 15 16 17 + - * / p' | ./dlowe

echo "$ echo '12 13 14 15 16 + + + + f' | ./dlowe" 1>&2
echo '12 13 14 15 16 + + + + f' | ./dlowe

echo "$ echo '12 13 14 15 16 17 + - * / p' | ./dlowe" 1>&2
echo '12 13 14 15 16 17 + - * / p' | ./dlowe

echo "$ echo '+' | ./dlowe" 1>&2
echo '+' | ./dlowe

echo "$ echo '999999999999999 1 + p' | ./dlowe" 1>&2
echo '999999999999999 1 + p' | ./dlowe

echo "$ echo '99999999999999 1 + p' | ./dlowe" 1>&2
echo '99999999999999 1 + p' | ./dlowe

echo "$ echo '12.5 9 % 10 * 15 + f' | ./dlowe" 1>&2
echo '12.5 9 % 10 * 15 + f' | ./dlowe
