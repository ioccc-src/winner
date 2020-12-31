#!/bin/sh
#
# garry.test - example of how to use garry

EXAMPLEON="\33\133\61\73\67\155"
EXAMPLEOFF="\33\133\155"
DOLLAR="$"
export EXAMPLEON EXAMPLEOFF DOLLAR

./garry <garry.data
