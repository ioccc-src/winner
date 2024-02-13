#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/endoh
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# Before we do anything we have to make sure we have GDB available
#
GDB="$(type -P gdb)"

if [[ -z "$GDB" ]]; then
    echo "No gdb found, install gdb and try again." 1>&2
    exit 1
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ $GDB -q -x prog.c ./prog | head -n 25" 1>&2
read -r -n 1 -p "Press any key to use source code as GDB command file (first 25 lines): "
echo >&2
"$GDB" -q -x prog.c ./prog | head -n 25

echo "$ $GDB -q -x prog.c ./prog | cat | grep : | cut -f 2 -d:|xargs ./ascii"
read -r -n 1 -p "Press any key to use the backtrace to reconstruct prog.c (space = next page, q = quit): "
echo 1>&2
"$GDB" -q -x prog.c ./prog | cat | grep : | cut -f 2 -d: | xargs ./ascii | less -rEXF
echo 1>&2

echo "$ $GDB -q -x prog.c ./prog | cat | grep : | cut -f 2 -d: | xargs ./ascii > prog2.c" 1>&2
read -r -n 1 -p "Press any key to compare reconstructed code with original: "
echo 1>&2
"$GDB" -q -x prog.c ./prog | cat | grep : | cut -f 2 -d: | xargs ./ascii > prog2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s prog.c prog2.c: "
echo 1>&2
diff -s prog.c prog2.c
