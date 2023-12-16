#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/diels-grabsch2
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

SHA512SUM="$(type -P sha512sum)"
SHASUM="$(type -P shasum)"

if [[ -z "$SHA512SUM" && -z "$SHASUM" ]]; then
    echo "$ ./prog" 1>&2
    ./prog
elif [[ -n "$SHA512SUM" ]]; then
    echo "$ $SHA512SUM prog.c" 1>&2
    "$SHA512SUM" prog.c
    echo 1>&2

    echo "$ ./prog" 1>&2
    ./prog
    echo 1>&2

    echo "$ $SHA512SUM prog.c | cut -f 1 -d' ' > sha512sum.txt" 1>&2
    "$SHA512SUM" prog.c | cut -f 1 -d' ' > sha512sum.txt
    echo "$ ./prog > prog.txt" 1>&2
    ./prog > prog.txt
    echo 1>&2

    echo "$ diff -s sha512sum.txt prog.txt" 1>&2
    diff -s sha512sum.txt prog.txt
    rm -f sha512sum prog.txt

elif [[ -n "$SHASUM" ]]; then
    # Be extra careful and don't use 'else'
    echo "$ $SHASUM -a 512 prog.c" 1>&2
    "$SHASUM" -a 512 prog.c
    echo 1>&2

    echo "$ ./prog" 1>&2
    ./prog
    echo 1>&2

    echo "$ $SHASUM -a 512 prog.c | cut -f 1 -d' ' > sha512sum.txt" 1>&2
    "$SHASUM" -a 512 prog.c | cut -f 1 -d' ' > sha512sum.txt
    echo "$ ./prog > prog.txt" 1>&2
    ./prog > prog.txt
    echo 1>&2

    echo "$ diff -s sha512sum.txt prog.txt" 1>&2
    diff -s sha512sum.txt prog.txt
    rm -f sha512sum prog.txt


fi
