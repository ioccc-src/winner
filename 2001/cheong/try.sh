#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2001/cheong
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

read -r -n 1 -p "Press any key to run: ./cheong 1024: "
echo 1>&2
./cheong 1024
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cheong 0512: "
echo 1>&2
./cheong 0512
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cheong 12345678901234567890: "
echo 1>&2
./cheong 12345678901234567890
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cheong 05305265226926441255040573044986873789: "
echo 1>&2
./cheong 05305265226926441255040573044986873789
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cheong 1234567890: "
echo 1>&2
./cheong 1234567890
echo 1>&2

read -r -n 1 -p "Press any key to run: ./cheong 0200000000000000000000000000: "
echo 1>&2
./cheong 0200000000000000000000000000
echo 1>&2

