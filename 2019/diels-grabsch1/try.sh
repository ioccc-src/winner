#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2019/diels-grabsch1
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

echo "$ dd bs=1024 count=2048 < /dev/zero | compress > ref.Z" 1>&2
dd bs=1024 count=2048 < /dev/zero | compress > ref.Z
echo 1>&2

echo "$ dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z" 1>&2
dd bs=1024 count=2048 < /dev/zero | ./prog > dg1.Z
echo 1>&2

echo "$ cmp ref.Z dg1.Z" 1>&2
cmp ref.Z dg1.Z
echo "Exit code of: cmp ref.Z dg1.Z: $?" 1>&2
echo 1>&2

echo "$ compress < Shakespeare.txt > ref.Z" 1>&2
compress < Shakespeare.txt > ref.Z
echo 1>&2

echo "$ ./prog < Shakespeare.txt > dg1.Z" 1>&2
./prog < Shakespeare.txt > dg1.Z
echo 1>&2

echo "Notice how the files differ:" 1>&2
echo "$ cmp ref.Z dg1.Z" 1>&2
cmp ref.Z dg1.Z # Oops, the files differ
echo "Exit code of: cmp ref.Z dg1.Z: $?" 1>&2
echo 1>&2

echo "... and notice how this works fine:" 1>&2
echo "$ zcat < dg1.Z | cmp - Shakespeare.txt" 1>&2
zcat < dg1.Z | cmp - Shakespeare.txt
echo "What happened?"
