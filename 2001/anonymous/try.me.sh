#!/usr/bin/env bash

make clobber alt all >/dev/null 2>&1


TARGET="anonymous.ten"
if [[ -f "$TARGET" ]]; then
    echo "$ cp $TARGET anonymous.ten.bak" 1>&2
    cp "$TARGET" anonymous.ten.bak
    echo "$ ./anonymous $TARGET" 1>&2
    ./anonymous "$TARGET"
    echo "$ ./$TARGET" 1>&2
    ./"$TARGET"
    echo "$ diff -s $TARGET anonymous.ten.bak" 1>&2
    diff -s "$TARGET" anonymous.ten.bak
    echo "$ od -t x1 $TARGET > ten.od" 1>&2
    od -t x1 "$TARGET" > ten.od
    echo "$ od -t x1 anonymous.ten.bak > ten.bak.od" 1>&2
    od -t x1 anonymous.ten.bak > ten.bak.od
    echo "$ diff ten.bak.od ten.od" 1>&2
    diff ten.bak.od ten.od
    echo "$ ./$TARGET > ten.txt" 1>&2
    ./"$TARGET" > ten.txt
    echo "$ ./anonymous.ten.bak > ten.bak.txt" 1>&2
    ./anonymous.ten.bak > ten.bak.txt
    echo "$ diff -s ten.txt ten.bak.txt" 1>&2
    diff -s ten.txt ten.bak.txt
else
    echo "cannot compile anonymous.ten.c as 32-bit, sorry."
    echo "will run 64-bit version directly."
    sleep 3
    echo "$ ./$TARGET.64"
    ./"$TARGET".64
fi
