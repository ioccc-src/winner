#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2015/mills2
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


echo "$ printf '000I\236\f\31H\260\240\301\203' > ioccc.Z" 1>&2
printf '000I\236\f\31H\260\240\301\203' > ioccc.Z
echo 1>&2

echo "$ ./prog ioccc.Z" 1>&2
./prog ioccc.Z
echo 1>&2

echo "$ dd bs=512 count=128 < /dev/urandom > test1" 1>&2
dd bs=512 count=128 < /dev/urandom > test1
echo 1>&2

echo "$ compress < test1 > test1.Z" 1>&2
compress < test1 > test1.Z
echo 1>&2

echo "$ time ./prog test1.Z | cmp - test1" 1>&2
time ./prog test1.Z | cmp - test1
echo 1>&2

echo "$ dd bs=512 count=128 < /dev/zero > test2" 1>&2
dd bs=512 count=128 < /dev/zero > test2
echo 1>&2

echo "$ compress < test2 > test2.Z" 1>&2
compress < test2 > test2.Z
echo 1>&2

echo "$ time ./prog test2.Z | cmp - test2" 1>&2
time ./prog test2.Z | cmp - test2
echo 1>&2


echo "$ ./prog ioccc_guidelines.txt.Z" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog ioccc_guidelines.txt.Z | less -EXF

echo 1>&2
echo "$ ./prog ioccc_rules.txt.Z" 1>&2
read -r -n 1 -p "Press any key to continue (space = next page, q = quit): "
echo 1>&2
./prog ioccc_rules.txt.Z | less -EXF
