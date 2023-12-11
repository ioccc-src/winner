#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2000/dhyang
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


echo "$ make saitou >/dev/null" 1>&2
make saitou >/dev/null

echo "$ ./saitou > aku.c" 1>&2
./saitou > aku.c

read -r -n 1 -p "Press any key to run: cat aku.c (space = next page, q = quit): "
echo 1>&2
cat aku.c | less -EXF

echo "$ make soku >/dev/null" 1>&2
make soku >/dev/null

echo "$ ./soku > soku.c" 1>&2
./soku > soku.c

read -r -n 1 -p "Press any key to run: cat soku.c (space = next page, q = quit): "
echo 1>&2
cat soku.c | less -EXF

echo "$ make zan >/dev/null" 1>&2
make zan >/dev/null

echo "$ ./zan > zan.c" 1>&2
./zan > zan.c

read -r -n 1 -p "Press any key to run: cat zan.c (space = next page, q = quit): "
echo 1>&2
cat zan.c | less -EXF

echo "$ make aku >/dev/null" 1>&2
make aku >/dev/null

echo "$ ./aku | diff - aku.c" 1>&2
./aku | diff - aku.c
