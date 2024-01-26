#!/usr/bin/env bash
#
# 2013/dlowe/diff.sh - show diff of output of two commands based on different
# number of files (due to total length differing) in the directory

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

read -r -n 1 -p "Press any key to run: ./try.sh | tail -n 3 | tee 1.txt: "
./try.sh | tail -n 3 | tee 1.txt

echo "$ echo 'IOCCC winning entry 2013/dlowe' > ioccc.txt" 1>&2
read -r -n 1 -p "Press any key to run: echo 'IOCCC winning entry 2013/dlowe' | tee ioccc.txt: "
echo 1>&2
echo 'IOCCC winning entry 2013/dlowe' | tee ioccc.txt

read -r -n 1 -p "Press any key to run: ./try.sh | tail -n 3 | tee 2.txt: "
echo 1>&2
./try.sh | tail -n 3 | tee 2.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s 1.txt 2.txt: "
echo 1>&2
diff -s 1.txt 2.txt
rm -f 1.txt 2.txt ioccc.txt
