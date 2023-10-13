#!/usr/bin/env bash

make all || exit 1
echo "$ ./dlowe 0 1 2 3 4 5 6 7"
./dlowe 0 1 2 3 4 5 6 7
echo
echo "$ ./dlowe 16 32 64 128"
./dlowe 16 32 64 128
echo
echo "$ ./dlowe 16 32 64 128 256"
./dlowe 16 32 64 128 256
echo
echo "$ ./dlowe 16 32 64 128 256 512"
./dlowe 16 32 64 128 256 512
echo
echo "$ ./dlowe 0"
./dlowe 0
echo
echo "$ ./sflen.sh"
./sflen.sh
