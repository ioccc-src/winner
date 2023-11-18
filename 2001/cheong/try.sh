#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2001/cheong
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

echo "$ ./cheong 1024" 1>&2
./cheong 1024

echo "$ ./cheong 0512" 1>&2
./cheong 0512

echo "$ ./cheong 12345678901234567890" 1>&2
./cheong 12345678901234567890

echo "$ ./cheong 05305265226926441255040573044986873789" 1>&2
./cheong 05305265226926441255040573044986873789

echo "$ ./cheong 1234567890" 1>&2
./cheong 1234567890

echo "$ ./cheong 0200000000000000000000000000" 1>&2
./cheong 0200000000000000000000000000

