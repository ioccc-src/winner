#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1987/heckbert
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

read -r -n 1 -p "Press any key to show heckbert.c (space = next page, q = quit): "
echo 1>&2
less -rEXF heckbert.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./heckbert 40 < heckbert.c: "
echo 1>&2
./heckbert 40 < heckbert.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./heckbert 40 < heckbert.c > ph.c; make ph: "
./heckbert 40 < heckbert.c > ph.c; make ph
echo 1>&2

read -r -n 1 -p "Press any key to show ph.c (space = next page, q = quit): "
echo 1>&2
less -rEXF ph.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./ph 21 < heckbert.c > bar.c; make bar: "
echo 1>&2
./ph 21 < heckbert.c > bar.c; make bar
echo 1>&2

read -r -n 1 -p "Press any key to show bar.c (space = next page, q = quit): "
echo 1>&2
less -rEXF bar.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ./bar 79 < bar.c > foo.c: "
echo 1>&2
./bar 79 < bar.c > foo.c
echo 1>&2

read -r -n 1 -p "Press any key to show difference between foo.c and heckbert.c: "
echo 1>&2
diff -s heckbert.c foo.c

read -r -n 1 -p "Press any key to run: ./ph 40 < README.md > foo.md: "
./ph 40 < README.md > foo.md
echo 1>&2
echo "Now what happened to foo.md?"
