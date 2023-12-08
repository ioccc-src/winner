#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/duble
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

echo "$ echo \"Hello, world!\" | ./prog" 1>&2
echo "Hello, world!" | ./prog

echo "$ echo \"IOCCC 2015\" | ./prog" 1>&2
echo "IOCCC 2015" | ./prog

echo "$ DRAFT=1 ./prog < prog.c" 1>&2
DRAFT=1 ./prog < prog.c

echo "$ ./prog < prog.c" 1>&2
./prog < prog.c

echo "$ ./prog < lorem-ipsum.txt" 1>&2
./prog < lorem-ipsum.txt

echo "Type in text, hitting enter after each line." 1>&2
echo "Watch the output each time and try again." 1>&2
echo "Hit ctrl-c to exit." 1>&2
echo 1>&2
echo "$ ./prog" 1>&2
./prog
