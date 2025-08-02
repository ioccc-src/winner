#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/stedolan

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
make CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo 'NOTE: Type halt at the prompt to terminate the program.' 1>&2
echo 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
./prog
echo 1>&2
