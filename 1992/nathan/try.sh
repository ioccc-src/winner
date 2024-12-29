#!/usr/bin/env bash
#
# 1992/nathan/try.sh - show IOCCC entry 1992/nathan

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./nathan obfuscate < nathan.c > foobarf.c: "
echo 1>&2
./nathan obfuscate < nathan.c > foobarf.c
echo 1>&2

read -r -n 1 -p "Press any key to show foobarf.c (space = next page, q = quit): "
echo 1>&2
less -rEXF foobarf.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./nathan - obfuscate < foobarf.c > barfoof.c: "
echo 1>&2
./nathan - obfuscate < foobarf.c > barfoof.c
echo 1>&2

read -r -n 1 -p "Press any key to show barfoof.c (space = next page, q = quit): "
echo 1>&2
less -rEXF barfoof.c
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s nathan.c barfoof.c: "
echo 1>&2
diff -s nathan.c barfoof.c
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'IOCCC 1992 winner nathan' | ./nathan: "
echo 1>&2
echo 'IOCCC 1992 winner nathan' | ./nathan
