#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2012/kang

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: echo Nineteen hundred and eighty-four | ./kang # 1984: "
echo 1>&2
echo Nineteen hundred and eighty-four | ./kang
echo 1>&2

read -r -n 1 -p "Press any key to run: echo uno | ./kang # 1: "
echo 1>&2
echo uno | ./kang
echo 1>&2

read -r -n 1 -p "Press any key to run: echo trois | ./kang # 3: "
echo 1>&2
echo trois | ./kang
echo 1>&2

read -r -n 1 -p "Press any key to run: echo fier | ./kang # 4, should be vier: "
echo 1>&2
echo fier | ./kang # notice the issue here, see alternate code instead
echo 1>&2

read -r -n 1 -p "Press any key to run: echo vier | ./kang # 4: "
echo 1>&2
echo vier | ./kang # notice the issue here, see alternate code instead
echo 1>&2
echo "Note: for a version that gets this one right (breaking others" 1>&2
echo "including fier), see the alternate code." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"shest'\" | ./kang # 6: "
echo 1>&2
echo "shest'" | ./kang
echo 1>&2

read -r -n 1 -p "Press any key to run: echo dos | ./kang # 2: "
echo 1>&2
echo dos | ./kang
echo 1>&2
