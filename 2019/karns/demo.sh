#!/usr/bin/env bash
#
# Demo of IOCCC 26 (2019) 'Most in need of whitespace' entry by Joshua Karns.
#
# Doesn't run the program on README.md as it's longer and slower.
#

# make prog first and exit if failure
make || exit

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
