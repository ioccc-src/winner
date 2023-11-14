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

echo "$ echo Nineteen hundred and eighty-four | ./kang"
echo Nineteen hundred and eighty-four | ./kang

echo "$ echo uno | ./kang"
echo uno | ./kang

echo "$ echo trois | ./kang"
echo trois | ./kang

echo "$ echo fier | ./kang # notice the issue here, see alternate code instead"
echo fier | ./kang # notice the issue here, see alternate code instead

echo "$ echo \"shest'\" | ./kang"
echo "shest'" | ./kang
