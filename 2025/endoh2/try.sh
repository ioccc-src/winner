#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/endoh2

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run, again: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2

# try the program yet again
#
read -r -n 1 -p "Press any key to run, yet again: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2
