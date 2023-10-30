#!/usr/bin/env bash

echo "Running shark.sh:"
sh shark.sh README.md jaw.c README.md > receive || exit 1
echo "Done."

echo "Attempting to extract files:"

mkdir -p test
cd test
sh ../receive
