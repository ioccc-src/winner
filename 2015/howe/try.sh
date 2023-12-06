#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/howe
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


./prog prog.alt.c prog.c

make test
./prog -d ABXYEFCD.tmp ACDBECFD.tmp
./prog ABXYEFCD.tmp ACDBECFD.tmp

rm -f curds.tmp whey.tmp
cp -f cc.1 curds.tmp
cp -f cc.1 whey.tmp
chmod 666 whey.tmp
make makeholes
./makeholes -n 1000 whey.tmp
./prog curds.tmp whey.tmp
./avgtime.sh 100 ./prog curds.tmp whey.tmp

cp -f war-and-peace.txt nuked.tmp
./makeholes -c'~' -n 1000 nuked.tmp
./prog war-and-peace.txt nuked.tmp
./avgtime.sh 100 ./prog war-and-peace.txt nuked.tmp
