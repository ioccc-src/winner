#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/endoh2
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

echo "$ cat prog.c" 1>&2
cat prog.c
echo 1>&2

echo "$ ./prog | diff -s - prog.c"
./prog | diff -s - prog.c
echo 1>&2

echo "$ less -EXF prog.c" 1>&2
read -r -n 1 -p "Press any key to continue: "
less -EXF prog.c
echo 1>&2

echo "$ wc -c prog.c" 1>&2
wc -c prog.c
echo 1>&2
echo "Can you figure out the inconsistencies?" 1>&2
echo "If you can't or you're still confused try" 1>&2
echo "opening prog.c in an editor like vim." 1>&2
