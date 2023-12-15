#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/adamovsky
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

echo 1>&2
echo "$ ./prog spam.unl | head -n 100 | less -EXF" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./prog spam.unl | head -n 100 | less -EXF
echo 1>&2

echo "$ ./prog sierpinski.unl | head -n 200 | less -EXF" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
./prog sierpinski.unl | head -n 200 | less -EXF

echo "$ make identify" 1>&2
make identify
echo 1>&2

read -r -p "Do you want to play Colossal Cave Adventure (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    ./prog advent.unl
fi
