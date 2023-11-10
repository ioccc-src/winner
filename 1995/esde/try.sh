#!/usr/bin/env bash

make all >/dev/null || exit 1

echo "$ ./esde esde.data Johanson"
./esde esde.data Johanson
echo

echo "$ ./esde esde.data2 read"
./esde esde.data2 read
echo

echo "$ ./esde README.md date"
./esde README.md date
