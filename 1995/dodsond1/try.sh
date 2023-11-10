#!/usr/bin/env bash

make all >/dev/null || exit 1

echo "$ cat try.this.txt"
cat try.this.txt

echo "$ ./dodsond1 < try.this.txt"
./dodsond1 < try.this.txt
