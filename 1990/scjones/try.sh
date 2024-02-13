#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/scjones
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

read -r -n 1 -p "Press any key to show scjones.c: "
echo 1>&2
less -rEXF scjones.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./scjones (space = next page, q = quit): "
echo 1>&2
./scjones | less -rEXF

read -r -n 1 -p "Press any key to run: ./scjones > scjones.tmp.c: "
echo 1>&2
./scjones > scjones.tmp.c
echo 1>&2

read -r -n 1 -p "Press any key to compare scjones.c and scjones.tmp.c: "
echo 1>&2
diff -s scjones.c scjones.tmp.c
rm scjones.tmp.c
