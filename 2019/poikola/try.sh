#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/poikola
#
# 'When you are about to jump, you are all alone and have to make your own
# decisions. Up there, it's all "up yours".'
#
# -- Matti Ensio Nykänen
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./prog 512 ./prog: "
echo 1>&2
./prog 512 ./prog
echo 1>&2

echo "$ TZ=UTC24 make CC=$CC clobber prog" 1>&2
TZ=UTC24 make CC="$CC" clobber prog || exit 1
read -r -n 1 -p "Press any key to run: ./prog 512 ./prog: "
echo 1>&2
./prog 512 ./prog
echo 1>&2

echo "$ TZ=UTC48 make CC=$CC clobber prog" 1>&2
TZ=UTC48 make CC="$CC" clobber prog || exit 1
read -r -n 1 -p "Press any key to run: ./prog 512 ./prog: "
echo 1>&2
./prog 512 ./prog
echo 1>&2
