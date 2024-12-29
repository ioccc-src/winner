#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2005/klausler
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

read -r -n 1 -p "Press any key to run: ./klausler peter klausler | head -n 10: "
echo 1>&2
./klausler peter klausler | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler abc def ghi jkl mno | head -n 10: "
echo 1>&2
./klausler abc def ghi jkl mno | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler foo bar baz | head -n 10: "
echo 1>&2
./klausler foo bar baz | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler zebra elephant bear fox | head -n 10: "
echo 1>&2
./klausler zebra elephant bear fox | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler the lion king | head -n 10: "
echo 1>&2
./klausler the lion king | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler fire breathing dragon | head -n 10: "
echo 1>&2
./klausler fire breathing dragon | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler lord of the rings | head -n 10: "
echo 1>&2
./klausler lord of the rings | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler fawlty towers | head -n 10: "
echo 1>&2
./klausler fawlty towers | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler carrion fowl | head -n 10: "
echo 1>&2
./klausler carrion fowl | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler werewolf vampire dragon | head -n 10: "
echo 1>&2
./klausler werewolf vampire dragon | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler werewolf vampire elf dragon | head -n 10: "
echo 1>&2
./klausler werewolf vampire elf dragon | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler werewolf vampire | head -n 10: "
echo 1>&2
./klausler werewolf vampire | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler dennis ritchie | head -n 10: "
echo 1>&2
./klausler dennis ritchie | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler ken thompson | head -n 10: "
echo 1>&2
./klausler ken thompson | head -n 10
echo 1>&2

read -r -n 1 -p "Press any key to run: ./klausler Linus Torvalds | head -n 10: "
echo 1>&2
./klausler linus torvalds | head -n 10
echo 1>&2
