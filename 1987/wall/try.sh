#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1987/wall
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

read -r -n 1 -p "Press any key to run: echo 'x*x' | ./wall | bc: "
echo 1>&2
echo 'x*x' | ./wall | bc
echo 1>&2

read -r -n 1 -p "Press any key to run: printf \"x*x\\nc^2\\nm*m\\n\\n500\\n\" | ./wall | bc | ./wall: "
echo 1>&2
printf "x*x\nc^2\nm*m\n500\n" | ./wall | bc | ./wall
echo 1>&2

read -r -n 1 -p "Press any key to run: printf \"x*x\\n2^x\\nquit\\n\" | ./wall | cat: "
printf "x*x\n2^x\nquit\n" | ./wall | cat
echo 1>&2

read -r -n 1 -p "Press any key to run: printf \"x*x\\n2^x\\n\" | ./wall | bc: "
echo 1>&2
printf "x*x\n2^x\n" | ./wall | bc
echo 1>&2

read -r -n 1 -p "Press any key to run: printf \"500\\n\" | ./wall | bc: "
echo 1>&2
printf "500\n" | ./wall | bc
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 500 | ./wall: "
echo 1>&2
echo 500 | ./wall
echo 1>&2
