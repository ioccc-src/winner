#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/fredriksson
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

# remove temporary file
rm -f fredriksson.txt

echo "$ ./fredriksson -k3 cat < fredriksson.c | tee fredriksson.txt" 1>&2
read -r -n 1 -p "Press any key to have the program show its own code (space = next page, q = quit): "
echo 1>&2
./fredriksson -k3 cat < fredriksson.c | tee fredriksson.txt | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: diff -s fredriksson.c fredriksson.txt: "
echo 1>&2
diff -s fredriksson.c fredriksson.txt
echo 1>&2
rm -f fredriksson.txt

echo "$ ./fredriksson -k1 -i POOT < /etc/group" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./fredriksson -k1 -i POOT < /etc/group | less -rEXF
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fredriksson -ck0 [0-9] < fredriksson.c: "
echo 1>&2
./fredriksson -ck0 [0-9] < fredriksson.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./fredriksson -ck0 [0-9] < ag.c: "
echo 1>&2
./fredriksson -ck0 [0-9] < ag.c
echo 1>&2

if ! ulimit -s unlimited 2>/dev/null; then
    echo "Couldn't set unlimited stack space, skipping next command." 1>&2
else
    echo "Set unlimited stack space, continuing." 1>&2
    echo 1>&2
    echo "$ ./fredriksson -k2 -t -n bofuskate < /usr/share/dict/words" 1>&2
    read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
    echo 1>&2
    ./fredriksson -k2 -t -n bofuskate < /usr/share/dict/words
fi
