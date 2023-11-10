#!/usr/bin/env sh
#
# garry.alt.test.sh - example of how to use garry.alt

EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
export EXAMPLEON EXAMPLEOFF DOLLAR

# make sure alt code is built, first
make alt || exit 1

./garry.alt <garry.data
