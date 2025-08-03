#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/kramer

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program and the alt program have been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" everything >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
read -r -n 1 -p "Press any key to run: ./prog two: "
echo 1>&2
echo 1>&2
./prog two
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run: ./prog two plus two minus one: "
echo 1>&2
echo 1>&2
./prog two plus two minus one
echo 1>&2

# try the program yet again
#
read -r -n 1 -p "Press any key to run: ./prog eight trillion divided by fourteen million and seven plus one hundred fifty six: "
echo 1>&2
echo 1>&2
./prog eight trillion divided by fourteen million and seven plus one hundred fifty six
echo 1>&2
