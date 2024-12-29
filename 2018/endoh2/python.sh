#!/usr/bin/env bash
#
# python.sh - make python rule script of 2018/endoh2 so one can use this in
# other scripts, allowing one to interrupt it but continue to the next script
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

CFLAGS="-Wno-strict-prototypes"
LDFLAGS=

# set up trap so one can go on to next script after interrupting this one in
# case this script is being run from another
EXIT=0
trap 'EXIT=1' INT

rm -f prog_next.c prog_next
${CC} "${CFLAGS}" prog.c -o prog "${LDFLAGS}"
while [[ "$EXIT" != 1 ]]; do
    ./prog | tee prog_next.c;
    cc prog_next.c -o ./prog "$CFLAGS" "$LDFLAGS"
    sleep 1;
done
exit 0
