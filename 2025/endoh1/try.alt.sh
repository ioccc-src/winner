#!/usr/bin/env bash
#
# try.alt.sh - alternative demonstration of 2025/endoh1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" alt >/dev/null || exit 1

# clear the screen
#
clear

# show no differences
#
read -r -n 1 -p "Press any key to run: diff -w prog.c prog.alt.c: "
echo 1>&2
echo 1>&2
diff -w prog.c prog.alt.c
echo 'Observe that prog.c and prog.alt.c are identical except for whitespace.' 1>&2
echo 1>&2

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog.alt '*' < prog.alt.c: "
echo 1>&2
echo 1>&2
./prog.alt '*' < prog.alt.c
echo 'For the rest of the fun, run ./try.sh' 1>&2
echo 1>&2
