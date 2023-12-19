#!/usr/bin/env bash
#
# Demo of IOCCC 26 (2019) 'Most in need of whitespace' entry by Joshua Karns.
#
# Doesn't run the program on README.md as it's longer and slower.
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

# display prog.c to the user
echo "$ cat prog.c"
cat prog.c

# run the program on its own source code
read -r -n 1 -p "Press any key to run: ./prog < prog.c: "
echo 1>&2
./prog < prog.c

# reset terminal for colours
reset

# display maze
echo "$ cat maze"
cat maze

# run the program on maze
read -r -n 1 -p "Press any key to run: ./prog < maze: "
echo 1>&2
./prog < maze

read -r -n 1 -p "Press any key to exit: "
# reset terminal
reset
