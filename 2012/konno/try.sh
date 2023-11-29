#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/konno
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

echo "$ ./konno 30" 1>&2
./konno 30
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 90" 1>&2
./konno 90
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 102" 1>&2
./konno 102
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 109" 1>&2
./konno 109
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 165" 1>&2
./konno 165
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 42" 1>&2
./konno 42 
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 37" 1>&2
./konno 37 
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./konno 255" 1>&2
./konno 255 
