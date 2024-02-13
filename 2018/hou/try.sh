#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2018/hou
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

read -r -n 1 -p "Press any key to run: grep -e '[-?+*/^&|.<>=]' prog.c (space = next page, q = quit): "
echo 1>&2
grep -e '[-?+*/^&|.<>=]' prog.c | less -rEXFK
echo 1>&2

# remove temp files
rm -f ioccc.html ioccc.json

echo "$ (cd ..; ls -lS -- */prog.c) | \
awk 'BEGIN { print \"[\"; } { print \"{\"winner\":\"\",\$9,\"\", \"size\":\",\$5,\"},\"} END { print \"]\"}' \
| tee ioccc.json"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

(cd ..; ls -lS -- */prog.c) | \
awk 'BEGIN { print "["; } { print "{\"winner\":\"",$9,"\", \"size\":",$5,"},"} END { print "]"}' \
| tee ioccc.json

echo "NOTE: for the next step you should get an assertion failure" 1>&2
read -r -n 1 -p "Press any key to run: ./prog < ioccc.json > ioccc.html: "
echo 1>&2
./prog < ioccc.json > ioccc.html

echo 1>&2
echo "Now open ioccc.html in your browser." 1>&2
