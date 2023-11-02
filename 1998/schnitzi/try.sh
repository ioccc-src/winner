#!/usr/bin/env bash

make all || exit 1

echo "$ ./schnitzi 3 > sort.c" 1>&2
./schnitzi 3 > sort.c

echo "Compiling sort.c:" 1>&2
make sort >/dev/null || exit 1

echo "...built sort." 1>&2

echo "Creating data:" 1>&2

echo "$ echo 234 > data" 1>&2
echo 234 > data

echo "$ echo 413 >> data" 1>&2
echo 413 >> data

echo "$ echo 123 >> data" 1>&2
echo 123 >> data

echo "Sorting data:" 1>&2
echo "$ ./sort < data" 1>&2
./sort < data

echo 1>&2

echo "Using stdin/stdout:" 1>&2
echo "$ echo 10 7 9 | ./sort" 1>&2
echo "10 7 9" | ./sort

echo "$ ./schnitzi 5 > sort.c" 1>&2
./schnitzi 5 > sort.c

echo "Compiling sort.c:" 1>&2
make sort >/dev/null || exit 1

echo "...built sort." 1>&2

echo "Creating data:" 1>&2

echo "$ echo 124 > data" 1>&2
echo 124 > data

echo "$ echo 422 >> data" 1>&2
echo 422 >> data

echo "$ echo 120 >> data" 1>&2
echo 120 >> data

echo "$ echo 100 >> data" 1>&2
echo 100 >> data

echo "$ echo 777 >> data" 1>&2
echo 777 >> data

echo "Sorting data:" 1>&2
echo "$ ./sort < data" 1>&2
./sort < data

echo 1>&2

echo "Using stdin/stdout:" 1>&2
echo "$ echo 5 10 7 9 1 | ./sort" 1>&2
echo "5 10 7 9 1" | ./sort
