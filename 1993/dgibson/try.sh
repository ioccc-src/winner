#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1993/dgibson
#

# we make use of the script dgibson.sh so we don't need to compile it. In any
# event that script rebuilds the program.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

for f in dgibson.data[1-5]; do
    read -r -n 1 -p "Press any key to run: CC=$CC ./dgibson.sh $f: "
    echo 1>&2
    CC="$CC" ./dgibson.sh "$f"
    echo 1>&2
done
