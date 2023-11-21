#!/usr/bin/env bash

# try.sh - demonstrate IOCCC winner 2005/sykes
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

while true; do
    echo "(0) Run demo" 1>&2
    echo "(1) Show Easter egg" 1>&2
    echo "(2) Play chess" 1>&2
    echo "(3) Run test-suite" 1>&2
    echo "(4) Run pet.rom with -1" 1>&2

    echo "NOTE: you have to hit ctrl-c or whatever your interrupt combination is to" 1>&2
    echo "exit the program to continue here." 1>&2

    read -rp "Make your selection (0 - 4 or any other key to exit): " mode

    echo 1>&2

    case "${mode}" in
	0)  # demo
	    printf "LOAD \"DEMO\"\nRUN\n" | ./sykes pet.rom 6
	    ;;
	1)  # show old Easter egg
	    echo "WAIT 6502,12" | ./sykes pet.rom 6
	    ;;
	2)  # chess
	    ./sykes chess 6
	    ;;
	3)  # test mode
	    make test
	    ;;
	4)  # -1
	    ./sykes pet.rom -1
	    ;;
	*)
	    exit 0
    esac
    read -r -n 1 -p "Do you want to continue? " ans

    if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
	break;
    fi
    echo 1>&2
done
