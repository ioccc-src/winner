#!/usr/bin/env bash

make all || exit 1

echo "$ cp -f schweikh3 file1"
cp -f schweikh3 file1
echo "$ cp -f schweikh3 file2"
cp -f schweikh3 file2
echo "$ cp -f schweikh3.c file3"
cp -f schweikh3.c file3
echo "$ ln -f file3 file4"
ln -f file3 file4
echo "$ find . -type f -name 'file?' | ./samefile"
find . -type f -name 'file?' | ./samefile

echo "find . -type f -print | ./samefile" 1>&2
find . -type f -print | ./samefile
