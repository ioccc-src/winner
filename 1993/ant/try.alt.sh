#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1993/ant alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./ant.alt ant.alt README.md: "
echo 1>&2
./ant.alt ant.alt README.md
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ant.alt '\[' ant.txt: "
echo 1>&2
./ant.alt '\[' ant.txt
echo 1>&2

echo "Note: the next one should show: ag: Pattern too long." 1>&2
read -r -n 1 -p "Press any key to run: ./ant.alt '[' ant.txt: "
echo 1>&2
./ant.alt '[' ant.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ant.alt ant ants.txt | cut -d: -f2 (space = next page, q = quit): "
echo 1>&2
./ant.alt ant ants.txt | cut -d: -f2 | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run the test suite (make -f ant.alt.test.mk): "
echo 1>&2
make -f ant.alt.test.mk
