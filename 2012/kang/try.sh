#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2012/kang

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ echo Nineteen hundred and eighty-four | ./kang" 1>&2
echo Nineteen hundred and eighty-four | ./kang

echo "$ echo uno | ./kang" 1>&2
echo uno | ./kang

echo "$ echo trois | ./kang" 1>&2
echo trois | ./kang

echo "$ echo fier | ./kang # notice the issue here, see alternate code instead" 1>&2
echo fier | ./kang # notice the issue here, see alternate code instead

echo "$ echo \"shest'\" | ./kang" 1>&2
echo "shest'" | ./kang

echo "$ echo dos | ./kang" 1>&2
echo dos | ./kang
