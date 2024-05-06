#!/usr/bin/env bash
# 
# demo for 1989/jar.2 - run entry with one or more files
#

# if CC is not specified set to default 'cc'. CC can be a path or no path which
# makes the shell figure it out.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all || exit 1

if [[ "$#" -lt 1 ]]; then
    FILES="try.lisp fib.lisp chocolate_cake.lisp"
else
    FILES="$*"
fi

for f in $FILES; do 
    if [[ -e "$f" && -r "$f" ]]; then
	read -r -n 1 -p "Press any key to run: cat $f: "
	echo 1>&2
	cat "$f"
	echo 1>&2
	read -r -n 1 -p "Press any key to run: ./jar.2 < $f: "
	echo 1>&2
	./jar.2 < "$f"
	echo 1>&2
    fi
done
