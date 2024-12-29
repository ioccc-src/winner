#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/schnitzi
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

read -r -n 1 -p "Press any key to run: ./schnitzi 3 > sort.c: "
echo 1>&2
./schnitzi 3 > sort.c
echo 1>&2

read -r -n 1 -p "Press any key to run: make sort >/dev/null || exit 1: "
echo 1>&2
make sort >/dev/null || exit 1

echo 1>&2
echo "...built sort." 1>&2
echo 1>&2

echo "Creating data:" 1>&2

read -r -n 1 -p "Press any key to run: printf \"234\n413\n123\" > data: "
echo 1>&2
printf "234\n413\n123" > data
echo 1>&2

echo "Sorting data:" 1>&2
read -r -n 1 -p "Press any key to run: ./sort < data: "
echo 1>&2
./sort < data
echo 1>&2

echo "Using stdin/stdout:" 1>&2
read -r -n 1 -p "Press any key to run: echo \"10 7 9\" | ./sort: "
echo 1>&2
echo "10 7 9" | ./sort
echo 1>&2

read -r -n 1 -p "Press any key to run: ./schnitzi 5 | tee sort.c (space = next page, q = quit): "
echo 1>&2
./schnitzi 5 | tee sort.c | less -rEXF

echo "Compiling sort.c:" 1>&2
make sort >/dev/null || exit 1
echo 1>&2
echo "...built sort." 1>&2

echo "Creating data:" 1>&2

read -r -n 1 -p "Press any key to run: printf \"124\n422\n120\n100\n777\" > data: "
echo 1>&2
printf "124\n422\n120\n100\n777" > data

echo "Sorting data:" 1>&2
read -r -n 1 -p "Press any key to run: ./sort < data: "
echo 1>&2
./sort < data

echo 1>&2

echo "Using stdin/stdout:" 1>&2
read -r -n 1 -p "Press any key to run: echo "5 10 7 9 1" | ./sort: "
echo 1>&2
echo "5 10 7 9 1" | ./sort
echo 1>&2
