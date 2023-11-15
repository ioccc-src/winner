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
sleep 2

# run the program on itself
echo "$ ./prog < prog.c"
sleep 2
./prog < prog.c
sleep 2

# reset terminal for colours
reset

# display maze
echo "$ cat maze"
cat maze
sleep 2

# run the program on maze
echo "$ ./prog < maze"
sleep 2
./prog < maze

sleep 2
# reset terminal
reset
