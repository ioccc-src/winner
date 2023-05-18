#!/usr/bin/env bash

make clobber all >/dev/null 2>&1

if [[ -f "anonymous.ten" ]]; then

    make anonymous 2>/dev/null
    echo "$ cp anonymous.ten anonymous.ten.bak" 1>&2
    cp anonymous.ten anonymous.ten.bak
    echo "$ ./anonymous anonymous.ten" 1>&2
    ./anonymous anonymous.ten
    echo "$ ./anonymous.ten" 1>&2
    ./anonymous.ten
    echo "$ diff -s anonymous.ten anonymous.ten.bak" 1>&2
    diff -s anonymous.ten anonymous.ten.bak
    echo "$ od -t x1 anonymous.ten > ten.od" 1>&2
    od -t x1 anonymous.ten > ten.od
    echo "$ od -t x1 anonymous.ten.bak > ten.bak.od" 1>&2
    od -t x1 anonymous.ten.bak > ten.bak.od
    echo "$ diff ten.bak.od ten.od" 1>&2
    diff ten.bak.od ten.od
    echo "$ ./anonymous.ten > ten.txt" 1>&2
    ./anonymous.ten > ten.txt
    echo "$ ./anonymous.ten.bak > ten.bak.txt" 1>&2
    ./anonymous.ten.bak > ten.bak.txt
    echo "$ diff -s ten.txt ten.bak.txt" 1>&2
    diff -s ten.txt ten.bak.txt
else
    echo "cannot compile anonymous.ten.c as 32-bit, sorry."
    exit 1
fi
