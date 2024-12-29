#!/usr/bin/env bash
#
# lush.sh - run IOCCC entry 1992/lush
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make clobber all
"$CC" -include stdio.h -o lush lush.c|& ./lush
