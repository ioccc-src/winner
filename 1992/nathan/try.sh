#!/usr/bin/env bash


echo "$ ./nathan obfuscate < nathan.c > foobarf.c" 1>&2
./nathan obfuscate < nathan.c > foobarf.c

echo "$ ./nathan - obfuscate < foobarf.c > barfoof.c" 1>&2
./nathan - obfuscate < foobarf.c > barfoof.c

echo "$ diff nathan.c barfoof.c" 1>&2
diff -s nathan.c barfoof.c

echo "$ echo 'IOCCC 1992 winner nathan' | ./nathan" 1>&2
echo 'IOCCC 1992 winner nathan' | ./nathan
