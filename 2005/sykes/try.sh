#!/usr/bin/env bash

# try.sh - demonstrate IOCCC entry 2005/sykes
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

mode=0
# menu - show menu and prompt for input
menu()
{
    echo "(0) Run demo" 1>&2
    echo "(1) Show Easter egg" 1>&2
    echo "(2) Play chess" 1>&2
    echo "(3) Run test-suite" 1>&2
    echo "(4) Run pet.rom with -1" 1>&2
    echo "(5) Run IOCCC best emulator" 1>&2
    echo "(Q) Quit" 1>&2

    echo "NOTE: you have to hit ctrl-c or whatever your interrupt combination is to" 1>&2
    echo "exit the program to continue here." 1>&2

    read -rp "Make your selection: " mode
}
while true; do

    # print menu and get item to run
    menu
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
	5)  # best emulator of IOCCC 2005
	    printf "LOAD \"PET\"\nRUN\n" | ./sykes pet.rom 6
	    ;;
	q|Q)
	    exit 0
	    ;;
	*)  continue
	    ;;
    esac

    # this echo is for a quirk when pressing ctrl-c and showing the menu again
    echo 1>&2
done
