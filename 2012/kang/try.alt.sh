#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC entry 2012/kang alternate code

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: echo Nineteen hundred and eighty-four | ./kang.alt # 1984: "
echo 1>&2
echo Nineteen hundred and eighty-four | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo uno | ./kang.alt # 1: "
echo 1>&2
echo uno | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo trois | ./kang.alt # 3: "
echo 1>&2
echo trois | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo fier | ./kang.alt # 4, should be vier: "
echo 1>&2
echo fier | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo vier | ./kang.alt # 4: "
echo 1>&2
echo vier | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo \"shest'\" | ./kang.alt # 6: "
echo 1>&2
echo "shest'" | ./kang.alt
echo 1>&2

read -r -n 1 -p "Press any key to run: echo dos | ./kang.alt # 2: "
echo 1>&2
echo dos | ./kang.alt
echo 1>&2
