#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/savastio
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

read -r -n 1 -p "Press any key to run: echo 42 | ./savastio: "
echo 1>&2
echo 42 | ./savastio
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 24 | ./savastio: "
echo 1>&2
echo 24 | ./savastio
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 6 | ./savastio: "
echo 1>&2
echo 6 | ./savastio
echo 1>&2

rm -f foo.txt
read -r -n 1 -p "Press any key to run: echo foo | ./savastio | tee foo.txt: "
echo 1>&2
echo foo | ./savastio | tee foo.txt
echo 1>&2

rm -f bar.txt
read -r -n 1 -p "Press any key to run: echo bar | ./savastio | tee bar.txt: "
echo 1>&2
echo bar | ./savastio | tee bar.txt
echo 1>&2

read -r -n 1 -p "Press any key to show the diff of foo.txt and bar.txt: "
echo 1>&2
diff -s foo.txt bar.txt
echo 1>&2
rm foo.txt bar.txt
