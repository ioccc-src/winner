#!/usr/bin/env bash
# 
# try.sh - demonstrate 1998/bas2
#
# If any args are specified it checks if it's a readable file and if it is it
# feeds it to the program. If not it assumes it's a string and feeds that to the
# program.
#

make all || exit 1

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
