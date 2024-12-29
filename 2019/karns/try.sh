#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/karns
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
read -r -n 1 -p "Press any key to show prog.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK prog.c

# run the program on its own source code
read -r -n 1 -p "Press any key to run: ./prog < prog.c: "
echo 1>&2
./prog < prog.c

# reset terminal for colours
reset

# display maze
read -r -n 1 -p "Press any key to run: cat maze: "
echo 1>&2
# Role swap: cat in maze instead of mice
cat maze

# run the program on maze
read -r -n 1 -p "Press any key to run: ./prog < maze: "
echo 1>&2
./prog < maze

read -r -n 1 -p "Press any key to exit: "
# reset terminal
reset
