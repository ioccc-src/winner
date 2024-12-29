#!/usr/bin/env bash

make -B clock.alt || exit 1
while true; do
    cc -std=c11 -Wall -Wextra -pedantic -O3 clock.alt.c -o clock.alt
    clear
    ./clock.alt | tee clock.alt.c
    sleep 5
done
