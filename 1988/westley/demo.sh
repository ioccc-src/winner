#!/usr/bin/env bash

clear
echo "$ cat westley.c"
cat westley.c

sleep 1

echo "$ cc westley.c -o westley"
cc -std=gnu89 -Wall -Wextra -pedantic -Wno-error -Wno-implicit-function-declaration -Wno-return-type    -O3 westley.c -o westley 2>/dev/null

echo "$ ./westley"
./westley

echo
