#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/theorem
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




read -r -n 1 -p "Press any key to run: ./theorem y 0 1 0.1 1: "
echo 1>&2
./theorem y 0 1 0.1 1
echo 1>&2

read -r -n 1 -p "Press any key to run: ./theorem x 1 2 0.1 2: "
echo 1>&2
./theorem x 1 2 0.1 2
echo 1>&2

echo "$ ./theorem -r 0 0 0 0 < theorem.c > sorter.c" 1>&2
./theorem -r 0 0 0 0 < theorem.c > sorter.c
echo "$ make sorter" 1>&2
make sorter
echo 1>&2

read -r -n 1 -p "Press any key to run: ls | ./sorter > ls.sorted.txt: "
echo 1>&2
# We do want to process the ls command output.
#
# SC2012 (info): Use find instead of ls to better handle non-alphanumeric filenames.
# https://www.shellcheck.net/wiki/SC2012
# shellcheck disable=SC2012
ls | ./sorter > ls.sorted.txt

read -r -n 1 -p "Press any key to run: ls -r > ls.txt: "
echo 1>&2
ls -r > ls.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./sorter < ls.txt: "
echo 1>&2
./sorter < ls.txt
echo 1>&2

read -r -n 1 -p "./sorter < ls.txt > ls.sorted.2.txt: "
echo 1>&2
./sorter < ls.txt > ls.sorted.2.txt
echo 1>&2

read -r -n 1 -p "Press any key to show diff between ls.sorted.2.txt and ls.sorted.txt: "
echo 1>&2
diff -s ls.sorted.2.txt ls.sorted.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./sorter 0 0 0 0 < theorem.c > fibonacci.c: "
./sorter 0 0 0 0 < theorem.c > fibonacci.c
echo "$ make fibonacci" 1>&2
make fibonacci

read -r -n 1 -p "Press any key to run: ./fibonacci 1 7: "
echo 1>&2
./fibonacci 1 7
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fibonacci 2 5: "
echo 1>&2
./fibonacci 2 5
echo 1>&2
