#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/howe

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
echo 'Press TAB to aim' 1>&2
echo 1>&2
echo '    Cycles through target choices before firing' 1>&2
echo 1>&2
echo 'Press ENTRY to Fire' 1>&2
echo 1>&2
echo '    Kill lowest matching invader' 1>&2
echo 1>&2
echo 'Press ^C to quit early' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog: "
echo 1>&2
echo 1>&2
./prog
echo 1>&2
