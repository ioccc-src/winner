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

echo "$ cat aku.c"
cat aku.c

echo "$ make soku >/dev/null" 1>&2
make soku >/dev/null

echo "$ ./soku > soku.c" 1>&2
./soku > soku.c

echo "$ cat soku.c" 1>&2
cat soku.c

echo "$ make zan >/dev/null" 1>&2
make zan >/dev/null

echo "$ ./zan > zan.c" 1>&2
./zan > zan.c

echo "$ cat zan.c" 1>&2
cat zan.c

echo "$ make aku >/dev/null" 1>&2
make aku >/dev/null

echo "$ ./aku | diff - aku.c" 1>&2
./aku | diff - aku.c
