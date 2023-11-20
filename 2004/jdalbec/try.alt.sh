#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 2004/jdalbec alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# start out with default 11
make clobber CC="$CC" alt >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ ./jdalbec.alt 11 | head" 1>&2
./jdalbec.alt 11 | head
echo 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo "$ ./jdalbec.alt 47 | grep : | head -n 52572 | grep :" 1>&2
./jdalbec.alt 47 | head -n 52572 | grep :
echo 1>&2

read -r -n 1 -p "Press any key to set 7 numbers per line: "
make clobber CC="$CC" CDEFINE="-DAg=7" alt >/dev/null || exit 1

echo "$ ./jdalbec.alt 101 | head" 1>&2
./jdalbec.alt 101 | head
echo 1>&2
read -r -n 1 -p "Press any key to continue: "

echo 1>&2
echo "$ ./jdalbec.alt 7 | grep : | head -n 47 | grep :" 1>&2
./jdalbec.alt 7 | head -n 47 | grep :
