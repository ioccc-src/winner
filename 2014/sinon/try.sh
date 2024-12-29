#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2014/sinon
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

# find out if perl is installed
PERL="$(type -P perl)"
if [[ -n "$PERL" ]]; then
    read -r -n 1 -p "Press any key to play the game automatically ($PERL prog.c | bash): "
    echo 1>&2
    "$PERL" prog.c | bash
    echo 1>&2
fi

while :; do

    read -r -n 1 -p "Press any key to run: ./hecate.sh: "
    echo 1>&2
    ./hecate.sh

    read -r -n 1 -p "Press any key to run: ./glock.sh: "
    echo 1>&2
    ./glock.sh

    read -r -n 1 -p "Press any key to run: ./glock.sh: "
    echo 1>&2
    ./glock.sh

    read -r -n 1 -p "Press any key to run: ./hecate.sh: "
    echo 1>&2
    ./hecate.sh

    read -r -p "Do you want to try again (Y/N)? "
    if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
	exit 0
    fi
done

