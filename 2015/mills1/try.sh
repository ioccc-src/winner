#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/mills1 - make it much easier
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi


# clear screen after compilation so that only the entry is shown
clear

make CC="${CC}" clobber all DW=199999 DW=22 DH=16 DA=50 DI=-150 || exit 1

read -r -n 1 -p "Press any key to play (send EOF to quit game): "
./prog
exit 0
