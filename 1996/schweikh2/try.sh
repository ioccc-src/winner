#!/usr/bin/env bash

make all >/dev/null || exit 1


read -r -n 1 -p "Press any key to to run ./schweikh2: " 1>&2
./schweikh2
echo >&2

read -r -n 1 -p "Press any key to run: ./schweikh2 15 1 0 0/0 | head -n 15: " 1>&2
./schweikh2 15 1 0 0/0 | head -n 15
echo >&2

read -r -n 1 -p "Press any key one more time: " 1>&2
i=0
while ((i++<15)); do
    grep -v '#' schweikh2.c
done
