#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2004/kopczynski
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

for f in kopczynski-{8{a,b,c},a,9{,-rev},10{,-rev},11{,-rev}}; do
    read -r -n 1 -p "Press any key to run: cat $f: "
    echo 1>&2
    cat "$f"
    echo 1>&2
    read -r -n 1 -p "Press any key to run: ./kopczynski < $f: "
    echo 1>&2
    ./kopczynski < "$f"
    echo 1>&2
done
