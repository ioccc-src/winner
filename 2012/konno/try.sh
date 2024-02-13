#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/konno
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

# let user specify args to run on program too
while [[ "$#" -ge 1 ]]; do
    read -r -n 1 -p "Press any key to run: ./konno $1: "
    echo 1>&2
    ./konno "$1"
    echo 1>&2
    shift 1
done

# use ten random values (in range $((RANDOM % 101)))
i=0
# we do it this way to prevent the annoying shellcheck warning that 'i' appears
# to be unused (as it would be if 'for i in {0..9}; do .. done').
while [[ "$i" -lt 10 ]]; do
    NUM="$((RANDOM % 101))"
    read -r -n 1 -p "Press any key to run: ./konno $NUM: "
    echo 1>&2
    ./konno "$NUM"
    echo 1>&2
    ((i++))
done


# finally use some preselected values
read -r -n 1 -p "Press any key to run: ./konno 30: "
echo 1>&2
./konno 30
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 90: "
echo 1>&2
./konno 90
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 102: "
echo 1>&2
./konno 102
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 109: "
echo 1>&2
./konno 109
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 165: "
echo 1>&2
./konno 165
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 42: "
echo 1>&2
./konno 42 
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 37: "
echo 1>&2
./konno 37 
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 255: "
echo 1>&2
./konno 255 
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 10000: "
echo 1>&2
./konno 10000
echo 1>&2
