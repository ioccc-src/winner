#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2001/anonymous
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" everything >/dev/null

# clear screen after compilation so that only the entry is shown
clear

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
    echo "will run alt versions directly."
    make alt || exit 1
    read -r -n 1 -p "Press any key to run: ./anonymous.ten.alt (space = next page, q = quit): "
    echo 1>&2
    ./anonymous.ten.alt | less -rEXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./anonymous.bed.alt (space = next page, q = quit): "
    echo 1>&2
    ./anonymous.bed.alt | less -rEXF
fi
