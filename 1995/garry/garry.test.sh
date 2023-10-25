#!/usr/bin/env sh
#
# garry.test.sh - example of how to use garry

EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
export EXAMPLEON EXAMPLEOFF DOLLAR

# make sure code is built, first
make all || exit 1

./garry <garry.data
