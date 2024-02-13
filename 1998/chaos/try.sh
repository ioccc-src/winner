#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/chaos
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

show_instructions()
{
    echo 1>&2
    echo "Try the keys 'y', 'u', 'i', 'h', 'j' and 'k'; 'a' and 'z' zoom in and out." 1>&2
    echo "When tired of moving it manually wait a short bit and watch what happens. You" 1>&2
    echo "might try zooming in and out and then wait for it to start moving (again or" 1>&2
    echo "initially). You can interrupt the automatic movement by pressing any key or 'q' to" 1>&2
    echo "quit. Send intr/ctrl-c to quit the script prematurely." 1>&2
    echo 1>&2
}

for f in cube.data desk.data ioccc.data pyramid.data xwing.data; do
    clear
    show_instructions
    read -r -n 1 -p "Press any key to run: ./chaos $f: "
    echo 1>&2
    ./chaos "$f"
done
