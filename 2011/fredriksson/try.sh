#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2011/fredriksson
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


echo "$ ./fredriksson -k3 cat < fredriksson.c" 1>&2
read -r -n 1 -p "Press any key to have the program show its source code: "
echo 1>&2
./fredriksson -k3 cat < fredriksson.c

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
read -r -n 1 -p "Press any key to run: ./fredriksson -k1 -i POOT < /etc/group: "
echo 1>&2
./fredriksson -k1 -i POOT < /etc/group
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fredriksson -ck0 [0-9] < fredriksson.c: "
echo 1>&2
./fredriksson -ck0 [0-9] < fredriksson.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fredriksson -ck0 [0-9] < ag.c: "
echo 1>&2
./fredriksson -ck0 [0-9] < ag.c

echo "Trying to set unlimited stack space for this process..." 1>&2
ulimit -s unlimited 2>/dev/null
if [[ "$?" -ne 0 ]]; then
    echo "...couldn't set unlimited stack space, will skip command." 1>&2
else
    read -r -n 1 -p "Press any key to run: ./fredriksson -k2 -t -n bofuskate < /usr/share/dict/words: "
    ./fredriksson -k2 -t -n bofuskate < /usr/share/dict/words
fi
