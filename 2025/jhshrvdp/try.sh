#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/jhshrvdp

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
echo 'A - move left' 1>&2
echo 'D - move right' 1>&2
echo 'W - move up' 1>&2
echo 'S - move down' 1>&2
echo 1>&2
echo 'T - teleport if score>=3. Lowers score with 3' 1>&2
echo 'Q - quit' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2
