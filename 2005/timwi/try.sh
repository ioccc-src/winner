#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2005/timwi
#
# This only does one thing and that is from the judges. This is because
# brainfuck has too much potential to knacker the brain so we don't try.sh to
# make it worse :-)
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ (echo \"20 : ,-->+.>+.<<[>[>>+>+<<<-]>[>>+>+<<<-]>"; \
    echo "[<+>-]>[<<<+>>>-]>[-]<<<<.<-]\") | ./timwi" 1>&2

read -r -n 1 -p "Press any key to continue: "
echo 1>&2
(echo "20 : ,-->+.>+.<<[>[>>+>+<<<-]>[>>+>+<<<-]>"; echo "[<+>-]>[<<<+>>>-]>[-]<<<<.<-]") | ./timwi
echo 1>&2
echo "Now please go take better care of your brain. You only get one." 1>&2
