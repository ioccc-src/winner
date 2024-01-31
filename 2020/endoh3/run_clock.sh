#!/usr/bin/env bash

make -B clock || exit 1
while true; do
    cc -std=c11 -Wall -Wextra -pedantic -O3 clock.c -o clock
    clear
    ./clock | tee clock.c
    sleep 5
done
