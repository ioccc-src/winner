#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/dogon
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

show_controls()
{
    printf -- "Arrow keys\timage navigation.\n"
    printf -- "+\t\tzoom in.\n"
    printf -- "-\t\tzoom out.\n"
    printf -- "Space\t\ttoggle start/stop.\n"
    printf -- "0 (zero)\ttoggle single step/free run mode.\n"
    printf -- "Backspace\ttoggle direction for the arrow of time.\n"
    printf -- "]\t\tincrease speed (time step) by a factor of 2.\n"
    printf -- "[\t\tdecrease speed (time step) by a factor of 2.\n"
    echo 1>&2
}

for i in glider.mc infinite_5x5.mc mosquito5.mc message.mc; do
    echo "$ ./prog < $i" 1>&2
    show_controls
    echo "You might wish to press the minus key a few times, wait until you see" 1>&2
    echo "white specks and then press space and then the ] a few times." 1>&2
    echo "Or you might wish to play with it in other ways. Exit the program to" 1>&2
    echo "move on to the next one, if there is another one to view." 1>&2
    echo 1>&2
    echo "Don't forget to bring the window into focus!" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to continue (q = quit): "
    echo 1>&2
    if [[ "$REPLY" == "q" || "$REPLY" == "Q" ]]; then
	exit 0
    fi
    read -r -n 1 -p "Press any key to run: ./prog < $i: "
    echo 1>&2
    ./prog < "$i" 2>/dev/null
done
