#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/kurdyukov

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
read -r -n 1 -p "Press any key to run: ./prog 7 77 777 0 2025 2026 2027 2028 2029: "
echo 1>&2
echo 1>&2
./prog 7 77 777 0 2025 2026 2027 2028 2029
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run: ./prog 1 2 3 4 5 6 7 8 9 0 1234 2345 3456 4567: "
echo 1>&2
echo 1>&2
./prog 1 2 3 4 5 6 7 8 9 0 1234 2345 3456 4567
echo 1>&2

# try the program again
#
read -r -n 1 -p "Press any key to run: ./prog 3 31 314 3141 0 19937 21701 23209: "
echo 1>&2
echo 1>&2
./prog 3 31 314 3141 0 19937 21701 23209
echo 1>&2
