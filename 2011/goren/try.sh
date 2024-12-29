#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/goren
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


read -r -n 1 -p "Press any key to run: echo 'Hello, world!' | ./goren: "
echo 1>&2
echo "Hello, world!" | ./goren
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '|' | ./goren: "
echo 1>&2
echo '|' | ./goren
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '|!|!|' | ./goren: "
echo 1>&2
echo '|' | ./goren
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'This is a pipe!' | ./goren: "
echo 1>&2
echo 'This is a pipe!' | ./goren
echo 1>&2

read -r -n 1 -p "Press any key to run: echo '| is a pipe!' | ./goren: "
echo 1>&2
echo '| is a pipe!' | ./goren
echo 1>&2
