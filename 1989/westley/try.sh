#!/usr/bin/env bash

make all || exit 1

echo "$ echo IOCCC | ./westley"
echo IOCCC | ./westley
echo

echo "$ echo IOCCC | ./westley 1"
echo IOCCC | ./westley 1
echo

echo "$ echo IOCCC | ./westley 1 2"
echo IOCCC | ./westley 1 2
echo

echo "$ echo IOCCC | ./westley 1 2 3"
echo IOCCC | ./westley 1 2 3
echo

echo "$ echo IOCCC | ./ver0"
echo IOCCC | ./ver0
echo

echo "$ echo Version 1 | ./ver1"
echo Version 1 | ./ver1
echo

echo "$ echo Version 1 | ./ver1 1"
echo Version 1 | ./ver1 1
echo

echo "$ echo Version 1 | ./ver1 1 2"
echo Version 1 | ./ver1 1 2
echo

echo "$ echo Version 1 | ./ver1 1 2 3"
echo Version 1 | ./ver1 1 2 3
echo

echo "$ echo Version 2 | ./ver2"
echo Version 2 | ./ver2
echo

echo "$ echo Version 2 | ./ver2 1"
echo Version 2 | ./ver2 1
echo

echo "$ echo Version 2 | ./ver2 1 2"
echo Version 2 | ./ver2 1 2
echo

echo "$ echo Version 2 | ./ver2 1 2 3"
echo Version 2 | ./ver2 1 2 3
echo

echo "$ echo Version 3 | ./ver3"
echo Version 3 | ./ver3
echo

echo "$ echo Version 3 | ./ver3 1"
echo Version 3 | ./ver3 1
echo

echo "$ echo Version 3 | ./ver3 1 2"
echo Version 3 | ./ver3 1 2
echo

echo "$ echo Version 3 | ./ver3 1 2 3"
echo Version 3 | ./ver3 1 2 3
