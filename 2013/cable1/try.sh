#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2013/cable1
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

read -r -n 1 -p "Press any key to run: ./cable1 obama republican democrat: "
echo 1>&2
./cable1 obama republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 nixon republican democrat: "
echo 1>&2
./cable1 nixon republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 bush republican democrat: "
echo 1>&2
./cable1 bush republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 kennedy republican democrat: "
echo 1>&2
./cable1 kennedy republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 lincoln republican democrat: "
echo 1>&2
./cable1 lincoln republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 roosevelt republican democrat: "
echo 1>&2
./cable1 roosevelt republican democrat
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cable1 fdr republican democrat: "
echo 1>&2
./cable1 fdr republican democrat
echo 1>&2

read -r -n 1 -p "Press any key: ./cable1 microsoft alive dead: "
echo 1>&2
./cable1 microsoft alive dead
echo 1>&2
