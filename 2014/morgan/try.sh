#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/morgan
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

read -r -n 1 -p "Press any key to run: cp -f prog morgan: "
echo 1>&2
cp -f prog morgan
echo 1>&2

read -r -n 1 -p "Press any key to run: rm -vf prog: "
echo 1>&2
rm -vf prog
echo 1>&2
read -r -n 1 -p "Press any key to run: ./morgan prog: "
echo 1>&2
./morgan prog
echo 1>&2

read -r -n 1 -p "Press any key to compare prog and morgan: "
echo 1>&2
diff -s prog morgan
echo 1>&2

read -r -n 1 -p "Press any key to run: ./morgan all install: "
echo 1>&2
./morgan all install
echo 1>&2

read -r -n 1 -p "Press any key to run: ./morgan love haste waste supernova: "
echo 1>&2
./morgan love haste waste supernova
echo 1>&2

read -r -n 1 -p "Press any key to run: ./morgan magic: "
echo 1>&2
./morgan magic
