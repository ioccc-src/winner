#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2018/hou
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
grep -e '[-?+*/^&|.<>=]' prog.c | less -EXF
echo 1>&2

# ^-- SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
# ^-- SC1083 (warning): This { is literal. Check expression (missing ;/\n?) or quote it.
# ^-- SC1083 (warning): This } is literal. Check expression (missing ;/\n?) or quote it.
# ^-- SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
# shellcheck disable=SC2140
# shellcheck disable=SC1083
echo "(cd ..; ls -lS -- */prog.c) | \
awk 'BEGIN { print "["; } { print "{\"winner\":\"",\$9,"\", \"size\":",\$5,"},"} END { print "]"}' \
> ioccc.json"

(cd ..; ls -lS -- */prog.c) | \
awk 'BEGIN { print "["; } { print "{\"winner\":\"",$9,"\", \"size\":",$5,"},"} END { print "]"}' \
> ioccc.json
./prog < ioccc.json > ioccc.html

echo 1>&2
echo "Now open ioccc.html in your browser." 1>&2

exit 0
