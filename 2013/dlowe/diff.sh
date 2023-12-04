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

echo "$ ./try.sh | tail -n 3 > 1.txt" 1>&2
./try.sh | tail -n 3 > 1.txt
echo "$ echo 'IOCCC winning entry 2013/dlowe' > ioccc.txt" 1>&2
echo 'IOCCC winning entry 2013/dlowe' > ioccc.txt
echo "$ ./try.sh | tail -n 3 > 2.txt" 1>&2
./try.sh | tail -n 3 > 2.txt
echo "$ diff 1.txt 2.txt" 1>&2
diff 1.txt 2.txt
rm -f 1.txt 2.txt ioccc.txt
