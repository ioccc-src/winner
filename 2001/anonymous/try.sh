#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/anonymous
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
    read -r -n 1 -p "Press any key to run: cp -vf $TARGET anonymous.ten.bak: "
    echo 1>&2
    cp -vf "$TARGET" anonymous.ten.bak
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./anonymous $TARGET (space = next page, q = quit): "
    echo 1>&2
    ./anonymous "$TARGET" | less -rEXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$TARGET (space = next page, q = quit): "
    echo 1>&2
    ./"$TARGET" | less -rEXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: diff -s $TARGET anonymous.ten.bak: "
    echo 1>&2
    diff -s "$TARGET" anonymous.ten.bak
    echo 1>&2

    read -r -n 1 -p "Press any key to run: od -t x1 $TARGET > ten.od: "
    echo 1>&2
    od -t x1 "$TARGET" > ten.od
    echo 1>&2

    read -r -n 1 -p "Press any key to run: od -t x1 anonymous.ten.bak > ten.bak.od: "
    echo 1>&2
    od -t x1 anonymous.ten.bak > ten.bak.od
    echo 1>&2

    read -r -n 1 -p "Press any key to run: diff ten.bak.od ten.od: "
    echo 1>&2
    diff ten.bak.od ten.od
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$TARGET | tee ten.txt (space = next page, q = quit): "
    echo 1>&2
    ./"$TARGET" | tee ten.txt | less -rEXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./anonymous.ten.bak | tee ten.bak.txt (space = next page, q = quit): "
    echo 1>&2
    ./anonymous.ten.bak | tee ten.bak.txt | less -rEXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: diff -s ten.txt ten.bak.txt: "
    echo 1>&2
    diff -s ten.txt ten.bak.txt
    echo 1>&2
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
