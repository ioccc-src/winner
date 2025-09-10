#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 1989/ovdluhe.alt alternate code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# user may also reconfigure P
if [[ -n "$P" ]]; then
    make clobber CC="$CC" P="$P" alt >/dev/null || exit 1
else
    make clobber CC="$CC" alt >/dev/null || exit 1
fi

# clear screen after compilation so that only the entry is shown
clear

i=0
for ((i=0; i<3; ++i)); do
    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < ovdluhe.alt.c: "
    echo 1>&2
    echo 1>&2
    ./ovdluhe.alt < ovdluhe.alt.c
    echo 1>&2
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < README.md: "
    echo 1>&2
    echo 1>&2
    ./ovdluhe.alt < README.md
    echo 1>&2
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < Makefile: "
    echo 1>&2
    echo 1>&2
    ./ovdluhe.alt < Makefile
    echo 1>&2
    echo 1>&2
done

echo "Now we will redefine P from 2 through 10, running the program on three files" 1>&2
echo "three times. If you wish to stop at any point just send intr (usually ctrl-c)." 1>&2
echo "To quit the script." 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2
for ((P=2; P<=10; ++P)); do
    echo "Recompiling with P=$P ..." 1>&2
    make clobber CC="$CC" P="$P" alt >/dev/null 2>&1|| exit 1
    for ((i=0; i<3; ++i)); do
        read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < ovdluhe.alt.c: "
        echo 1>&2
        echo 1>&2
        ./ovdluhe.alt < ovdluhe.alt.c
        echo 1>&2
        echo 1>&2

        read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < README.md: "
        echo 1>&2
        echo 1>&2
        ./ovdluhe.alt < README.md
        echo 1>&2
        echo 1>&2

        read -r -n 1 -p "Press any key to run: ./ovdluhe.alt < Makefile: "
        echo 1>&2
        echo 1>&2
        ./ovdluhe.alt < Makefile
        echo 1>&2
        echo 1>&2
    done
done


