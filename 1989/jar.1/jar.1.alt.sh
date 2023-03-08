#!/usr/bin/env bash
# 'run' jar.1.alt

# run/compile it
rm -f jar.1.alt.o
cc jar.1.alt.c -c
cat jar.1.alt.o
rm -f jar.1.alt.o
