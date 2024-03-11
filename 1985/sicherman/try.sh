#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1985/sicherman
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


read -r -n 1 -p "Press any key to run: ./sicherman  < sicherman.c: "
echo 1>&2
./sicherman  < sicherman.c
echo 1>&2

read -r -n 1 -p "Press any key to run: echo IOCCC | ./sicherman: "
echo 1>&2
echo IOCCC | ./sicherman
echo 1>&2

read -r -n 1 -p "Press any key to run: ./sicherman < sicherman.c | ./sicherman: "
echo 1>&2
./sicherman < sicherman.c | ./sicherman
echo 1>&2

read -r -n 1 -p "Press any key to run: ./sicherman < sicherman.c | ./sicherman | diff -s - sicherman.c: "
echo 1>&2

# This warning from ShellCheck is incorrect:
#
#SC2094 (info): Make sure not to read and write the same file in the same pipeline.
# https://www.shellcheck.net/wiki/SC2094
# shellcheck disable=SC2094
./sicherman < sicherman.c | ./sicherman | diff -s - sicherman.c
echo "Now explain any differences." 1>&2
