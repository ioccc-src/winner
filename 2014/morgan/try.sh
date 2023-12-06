#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2014/morgan
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


echo "$ cp -f prog morgan" 1>&2
cp -f prog morgan
echo "$ ls" 1>&2
ls

read -r -n 1 -p "Press any key to run: ./morgan all install: "
echo 1>&2
./morgan all install
echo 1>&2
echo "$ ls" 1>&2
ls
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog love haste waste supernova: "
echo 1>&2
./prog love haste waste supernova
echo 1>&2
echo "$ ls" 1>&2
ls
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog magic: "
echo 1>&2
./prog magic
echo 1>&2
echo "$ ls" 1>&2
ls
