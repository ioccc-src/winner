#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC winner 1998/schweikh3
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

echo "$ cp -f schweikh3 file1"
cp -f schweikh3 file1
echo "$ cp -f schweikh3 file2"
cp -f schweikh3 file2
echo "$ cp -f schweikh3.c file3"
cp -f schweikh3.c file3
echo "$ ln -f file3 file4"
ln -f file3 file4
echo "$ find . -type f -name 'file?' | ./samefile"
find . -type f -name 'file?' | ./samefile

echo "find . -type f -print | ./samefile" 1>&2
find . -type f -print | ./samefile
