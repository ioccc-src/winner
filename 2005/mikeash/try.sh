#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2005/mikeash
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


read -r -n 1 -p "Press any key to run: ./mikeash < mikeash.c (space = next page, q = quit): "
echo 1>&2
./mikeash < mikeash.c
echo 1>&2

echo 1>&2
echo "The next command should print nothing." 1>&2
read -r -n 1 -p "Press any key to run: ./mikeash < mikeash.c | diff - mikeash.c: "
echo 1>&2
# ShellCheck is incorrect here:
#
#   SC2094 (info): Make sure not to read and write the same file in the same pipeline.
#
# so we disable it.
#
# shellcheck disable=SC2094
./mikeash < mikeash.c | diff - mikeash.c
echo 1>&2

echo "For the next two commands we will add a newline after the command's output" 1>&2
echo "for your convenience as they will not print a newline themselves." 1>&2
echo 1>&2
echo "The next command should show: \"4." 1>&2
read -r -n 1 -p "Press any key to run: echo '(format t \"~s\" (+ 2 2 ))' | ./mikeash: "
echo 1>&2
echo '(format t "~s" (+ 2 2 ))' | ./mikeash
echo 1>&2

echo "The next command will evaluate the expression: (2+2) * (5 - 9/3), giving 8\"." 1>&2

# ShellCheck warns:
#
#   SC2140 (warning): Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?
#
# ShellCheck is wrong.
#
# shellcheck disable=SC2140
read -r -n 1 -p "Press any key to run: echo '(format t "~s" (* (+ 2 2 ) (- 5 (/ 9 3 ))))' | ./mikeash: "
echo 1>&2
echo '(format t "~s" (* (+ 2 2 ) (- 5 (/ 9 3 ))))' | ./mikeash
echo 1>&2
