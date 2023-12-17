#!/usr/bin/env bash
# 
# try.sh - try out 1998/dlowe pootifier alt code
#

make everything || exit 1

CAT="$(type -P cat)"
MAN="$(type -P man)"
COL="$(type -P col)"

if [[ -z "$CAT" || ! -e "$CAT" ]]; then
    echo "$0: no cat found" 1>&2
    exit 1
elif [[ -z "$COL" || ! -e "$COL" ]]; then
    echo "$0: col not found" 1>&2
    exit 1
elif [[ -z "$MAN" || ! -e "$MAN" ]]; then
    echo "$0: can't execute man" 1>&2
    exit 1
fi

rm -f make.1
read -r -n 1 -p "Press any key to pootify make(1): "
"$MAN" make | "$COL" -b | ./dlowe.alt > make.1
"$MAN" ./make.1

read -r -n 1 -p "Press any key to pootify dlowe.c: "
echo 1>&2
./dlowe.alt < dlowe.c
echo 1>&2

read -r -n 1 -p "Press any key to pootify dlowe.alt.c: "
echo 1>&2
./dlowe.alt < dlowe.alt.c
echo 1>&2
