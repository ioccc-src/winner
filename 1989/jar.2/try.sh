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
    FILES="try.txt fib.lisp chocolate_cake.lisp"
else
    FILES="$*"
fi

for f in $FILES; do 
    if [[ -e "$f" && -r "$f" ]]; then
	echo "$ ./jar.2 < $f" 1>&2
	./jar.2 < "$f"
    fi
done
