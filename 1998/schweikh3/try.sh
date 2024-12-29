#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/schweikh3
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

read -r -n 1 -p "Press any key to run: cp -vf schweikh3 file1: "
echo 1>&2
cp -vf schweikh3 file1
echo 1>&2

read -r -n 1 -p "Press any key to run: cp -vf schweikh3 file2: "
echo 1>&2
cp -vf schweikh3 file2
echo 1>&2

read -r -n 1 -p "Press any key to run: cp -vf schweikh3.c file3: "
echo 1>&2
cp -vf schweikh3.c file3
echo 1>&2

read -r -n 1 -p "Press any key to run: ln -vf file3 file4: "
echo 1>&2
ln -vf file3 file4
read -r -n 1 -p "Press any key to run: find . -type f -name 'file?' | ./samefile: "
echo 1>&2
find . -type f -name 'file?' | ./samefile
echo 1>&2

read -r -n 1 -p "Press any key to run: find . -type f -print | ./samefile: "
echo 1>&2
find . -type f -print | ./samefile
echo 1>&2
