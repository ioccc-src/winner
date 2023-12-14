#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2018/burton1
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

for i in prog scripthd.sh; do
    echo "$ ./$i < prog.c" 1>&2
    ./"$i" < prog.c
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$i < prog (space = next page, q = quit): "
    echo 1>&2
    ./"$i" < prog | less -EXF
    echo 1>&2

    read -r -n 1 -p "Press any key to run: ./$i < scripthd.sh (space = next page, q = quit): "
    echo 1>&2
    ./"$i" < scripthd.sh | less -EXF
    echo 1>&2


    read -r -n 1 -p "Press any key to run: head $0 | ./$i: "
    echo 1>&2
    head "$0" | ./"$i"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: tail -n 15 Makefile | ./$i: "
    echo 1>&2
    tail -n 15 Makefile | ./"$i"
done
