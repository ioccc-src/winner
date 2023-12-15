#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/burton
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

echo "$ cat prog.c" 1>&2
cat prog.c
echo 1>&2

for i in prog.c Makefile README.md; do
    echo "$ ./prog < $i && wc < $i" 1>&2
    printf "prog: %s\n%4s: %s\n\n" "$(./prog < "$i"|tr -s ' ')" "wc" "$(wc "$i" | tr -s ' ')"
done
echo 1>&2

echo "$ make test" 1>&2
make test
