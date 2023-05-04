#!/usr/bin/env bash

make clobber akari || exit 1

./akari < example.ppm > odd_output.ppm
./akari - - even < example.ppm > even_output.ppm
./akari example.ppm odd_output.ppm

make akari2 || exit 1
cat akari2.c

./akari2 < akari2.c
./akari2 rot13 < akari2.c

make akari3 || exit 1
cat akari3.c

./akari3

make akari4 || exit 1
cat akari4.c

./akari4
