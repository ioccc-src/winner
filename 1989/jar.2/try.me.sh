#!/usr/bin/env bash
# 
# demo for 1989/jar.2 - run entry with one or more files

make all || exit 1

if [[ "$#" -lt 1 ]]; then
    FILES="try.me.txt fib.lisp chocolate_cake.lisp"
else
    FILES="$*"
fi

for f in $FILES; do 
    if [[ -e "$f" && -r "$f" ]]; then
	./jar.2 < "$f"
    fi
done
