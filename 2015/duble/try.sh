#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2015/duble
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

# set it so that when program is terminated through various signals we re-enable
# the cursor
trap "tput cnorm;echo" 0 1 2 3 15

# temporarily disable cursor
tput civis

echo "If you wish to move to the next command during the output of the current" 1>&2
echo "you may send ctrl-c/intr to do so. This might be especially useful if you" 1>&2
echo "get tired of watching lorem-ipsum.txt." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"Hello, world!\" | ./prog: "
echo 1>&2
echo "Hello, world!" | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"IOCCC 2015\" | ./prog: "
echo 1>&2
echo "IOCCC 2015" | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to show prog.c (space = next page, q = quit): "
echo 1>&2
less -rEXFK prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: DRAFT=1 ./prog < prog.c: "
echo 1>&2
DRAFT=1 ./prog < prog.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < prog.c: "
echo 1>&2
./prog < prog.c
echo 1>&2

read -r -n 1 -p "Press any key to show lorem-ipsum.txt (space = next page, q = quit): "
echo 1>&2
less -rEXFK lorem-ipsum.txt
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < lorem-ipsum.txt: "
echo 1>&2
./prog < lorem-ipsum.txt
echo 1>&2

echo "Type in text, hitting enter after each line." 1>&2
echo "Watch the output each time and try again." 1>&2
echo "Hit ctrl-c to exit." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to start: "
echo 1>&2
./prog

# make sure to re-enable cursor
tput cnorm
