#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2018/yang
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

read -r -n 1 -p "Press any key to run: ./left < prog.c (space = next page, q = quit): "
echo 1>&2
./left < prog.c | less -EXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./right < prog.c (space = next page, q = quit): "
echo 1>&2
./right < prog.c | less -EXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./left < prog.c | ./left (space = next page, q = quit): "
echo 1>&2
./left < prog.c | ./left | less -EXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./shift < prog.c (space = next page, q = quit): "
echo 1>&2
./shift < prog.c | less -EXF
echo 1>&2

echo "$ echo IOCCC | ./left" 1>&2
echo IOCCC | ./left
echo 1>&2
echo "$ echo IOCCC | ./right" 1>&2
echo IOCCC | ./right
echo 1>&2
echo "$ echo IOCCC | ./shift" 1>&2
echo IOCCC | ./shift
echo 1>&2

echo "$ ./msg0" 1>&2
./msg0

echo "$ ./msg1" 1>&2
./msg1

echo "$ ./msg2" 1>&2
./msg2

read -r -p "Do you wish to see some of the spoilers (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    echo "$ make spoilers" 1>&2
    make spoilers
    rm -f generated*.c msg*.c
    echo "$ make i_give_up_show_me_the_spoilers"
    make i_give_up_show_me_the_spoilers
    echo 1>&2
    for i in 0 1 2 3 4 5 6 7 8 10; do ./msg"$i"; done
    ./msg9 < prog.c
fi
