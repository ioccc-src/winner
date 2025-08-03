#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/tmarrec

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="clang"

# make sure the program has been built
#
MAKE=$(which gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo 'Please adjust your terminal window to be at least 65 lines by 80 columns.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2
