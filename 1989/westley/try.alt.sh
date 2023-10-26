#!/usr/bin/env bash

make alt || exit 1


echo "$ echo IOCCC | ./westley.alt"
echo IOCCC | ./westley.alt
echo

echo "$ echo IOCCC | ./westley.alt 1"
echo IOCCC | ./westley.alt 1
echo

echo "$ echo IOCCC | ./westley.alt 1 2"
echo IOCCC | ./westley.alt 1 2
echo

echo "$ echo IOCCC | ./westley.alt 1 2 3"
echo IOCCC | ./westley.alt 1 2 3
echo

echo "$ echo IOCCC | ./alt.ver0"
echo IOCCC | ./alt.ver0
echo

echo "$ echo Version 1 | ./alt.ver1"
echo Version 1 | ./alt.ver1
echo

echo "$ echo Version 1 | ./alt.ver1 1"
echo Version 1 | ./alt.ver1 1
echo

echo "$ echo Version 1 | ./alt.ver1 1 2"
echo Version 1 | ./alt.ver1 1 2
echo

echo "$ echo Version 1 | ./alt.ver1 1 2 3"
echo Version 1 | ./alt.ver1 1 2 3
