#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/adamovsky
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

read -r -n 1 -p "Press any key to run: ./prog spam.unl | head -n 100 (space = next page, q =quit): "
echo 1>&2
./prog spam.unl | head -n 100 | less -rEXFK
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog sierpinski.unl | head -n 200 (space = next page, q = quit): "
echo 1>&2
./prog sierpinski.unl | head -n 200 | less -rEXFK

read -r -n 1 -p "Press any key to run: make identify: "
echo 1>&2
make identify
echo 1>&2

read -r -p "Do you want to play Colossal Cave Adventure (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    ./prog advent.unl
fi
