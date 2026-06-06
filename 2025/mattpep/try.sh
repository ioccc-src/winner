#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/mattpep

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

read -r -n 1 -p "Press any key to run: ./prog encode < test-4k.bin | tee test-4k.b64 : "
echo 1>&2
echo 1>&2
./prog encode < test-4k.bin | tee test-4k.b64
echo 1>&2

echo 1>&2
echo "We expect diff to report identical output" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog decode < test-4k.b64 | diff -s - test-4k.bin : "
echo 1>&2
echo 1>&2
./prog decode < test-4k.b64 | diff -s - test-4k.bin
echo 1>&2

read -r -n 1 -p "Press any key to view A not-to-secret message: ./prog decode < secret.txt : "
echo 1>&2
echo 1>&2
./prog decode < secret.txt
echo 1>&2

read -r -n 1 -p "Press any key to clean up - will run: rm -f test-4k.b64 : "
echo 1>&2
echo 1>&2
rm -f test-4k.b64
