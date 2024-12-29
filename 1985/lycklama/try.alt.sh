#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1985/lycklama alternate code
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

read -r -n 1 -p "Press any key to run: ./lycklama.alt < lycklama.c: "
echo 1>&2
./lycklama.alt < lycklama.c
echo 1>&2

# notice the difference between the above and this one:
echo "Notice the difference with the above and this next one." 1>&2
read -r -n 1 -p "Press any key to run: ./lycklama.alt < lycklama.alt.c: "
echo 1>&2
./lycklama.alt < lycklama.alt.c
echo 1>&2

# also try:
read -r -n 1 -p "Press any key to run: ./lycklama.alt < lycklama.orig.c: "
echo 1>&2
./lycklama.alt < lycklama.orig.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./lycklama.alt < README.md: "
echo 1>&2
./lycklama.alt < README.md
echo 1>&2

read -r -n 1 -p "Press any key to run: ./lycklama.alt < Makefile: "
echo 1>&2
./lycklama.alt < Makefile
