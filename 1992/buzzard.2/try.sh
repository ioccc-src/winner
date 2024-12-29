#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1992/buzzard.2
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

echo "$ echo help | cat third help.th - | ./first" 1>&2
read -r -n 1 -p "Press any key to read help (space = next page, q = quit): "
echo 1>&2
echo help | cat third help.th - | ./first | less -rEXF

for i in demo[1-6].th; do
    # try out each demo
    #
    read -r -n 1 -p "Press any key to show $i (space = next page, q = quit): "
    echo 1>&2
    less -rEXF "$i"
    echo 1>&2
    read -r -n 1 -p "Press any key to run cat third $i | ./first (demo $i): "
    echo 1>&2
    cat third "$i" | ./first
    echo 1>&2
done
