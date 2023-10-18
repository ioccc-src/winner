#!/usr/bin/env bash

clear
echo "$ cat westley.c"
cat westley.c

sleep 1

echo "$ cc westley.c -o westley"
cc -std=gnu89 -Wno-error -Wno-implicit-function-declaration -Wno-return-type    -O3 westley.c -o westley || exit 1

echo "$ ./westley"
./westley

echo
