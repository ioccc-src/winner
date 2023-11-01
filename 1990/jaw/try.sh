#!/usr/bin/env bash

echo "Running shark.sh:"
sh shark.sh shark.sh README.md jaw.c > receive || exit 1
echo "Done."

echo "Attempting to extract files:"

mkdir -p test
cd test
sh ../receive
