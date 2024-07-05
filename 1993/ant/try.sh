#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1993/ant
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

read -r -n 1 -p "Press any key to run: ./ant ant README.md: "
echo 1>&2
./ant ant README.md
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ant '\[' ant.txt: "
echo 1>&2
./ant '\[' ant.txt
echo 1>&2

echo "Note: the next one should show: ag: Pattern too long." 1>&2
read -r -n 1 -p "Press any key to run: ./ant '[' ant.txt: "
echo 1>&2
./ant '[' ant.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ant ant ants.txt | cut -d: -f2 (space = next page, q = quit): "
echo 1>&2
./ant ant ants.txt | cut -d: -f2 | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run the test suite (make -f ant.test.mk): "
echo 1>&2
make -f ant.test.mk
