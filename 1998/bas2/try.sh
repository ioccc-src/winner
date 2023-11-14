#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC winner 1998/bas2
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

echo "$ ./bas2 < bas2.c" 1>&2
./bas2 < bas2.c

echo "$ ./bas2 < README.md" 1>&2
./bas2 < README.md

echo "$ ./bas2 < Makefile" 1>&2
./bas2 < Makefile

echo "$ echo foo bar baz | ./bas2" 1>&2
echo foo bar baz | ./bas2

echo "$ cat README.md Makefile bas2.c | ./bas2" 1>&2
cat README.md Makefile bas2.c | ./bas2

# while we have an arg check if it's a file. If it is a regular file that is
# readable feed it to the program; otherwise act as if it's a string.
while [[ "$#" -gt 0 ]]; do
    if [[ -f "$1" && -r "$1" ]]; then
	echo "$ ./bas2 < $1" 1>&2
	./bas2 < "$1"
    else
	echo "$ echo $1 | ./bas2" 1>&2
	echo "$1" | ./bas2
    fi
    shift 1
done
