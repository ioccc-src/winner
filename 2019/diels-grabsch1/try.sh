#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/diels-grabsch1
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

read -r -n 1 -p "Press any key to run: dd bs=1024 count=2048 < /dev/zero | compress > ref.Z: "
echo 1>&2
dd bs=1024 count=2048 < /dev/zero | compress > ref.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z: "
echo 1>&2
dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: cmp ref.Z dg1.Z: "
echo 1>&2
cmp ref.Z dg1.Z
echo "Exit code of: cmp ref.Z dg1.Z: $?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: compress < Shakespeare.txt > ref.Z: "
echo 1>&2
compress < Shakespeare.txt > ref.Z
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog < Shakespeare.txt > dg1.Z: "
echo 1>&2
./prog < Shakespeare.txt > dg1.Z
echo 1>&2

echo "Notice how the two files differ:" 1>&2
read -r -n 1 -p "Press any key to run: cmp ref.Z dg1.Z: "
echo 1>&2
cmp ref.Z dg1.Z # Oops, the files differ
echo "Exit code of: cmp ref.Z dg1.Z: $?" 1>&2
echo 1>&2

echo "... and notice how this works fine:" 1>&2
read -r -n 1 -p "Press any key to run: zcat < dg1.Z | cmp - Shakespeare.txt: "
echo 1>&2
zcat < dg1.Z | cmp - Shakespeare.txt
echo "Exit code of zcat < dg1.Z | cmp - Shakespeare.txt: ${PIPESTATUS[1]}"
echo 1>&2
echo "What happened?"
