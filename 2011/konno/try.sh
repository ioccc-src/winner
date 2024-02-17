#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/konno
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


read -r -n 1 -p "Press any key to run: ./konno qwerty: "
echo 1>&2
./konno qwerty
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno ioccc: "
echo 1>&2
./konno ioccc
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno 'the quick brown fox jumps over the lazy dog': "
echo 1>&2
./konno 'the quick brown fox jumps over the lazy dog'
echo 1>&2

read -r -n 1 -p "Press any key to run: ./konno \"\": "
echo 1>&2
./konno ""
echo 1>&2

read -r -n 1 -p "Press key to run: ./konno: "
echo 1>&2
./konno
