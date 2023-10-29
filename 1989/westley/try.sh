#!/usr/bin/env bash

# first compile everything or at least try to
./compile.sh

if [[ -e "./westley" ]]; then
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
fi

if [[ -e "./ver0" ]]; then
    echo "$ echo IOCCC | ./ver0"
    echo IOCCC | ./ver0
    echo

    echo "$ echo IOCCC | ./ver0 1"
    echo IOCCC | ./ver0 1
    echo

    echo "$ echo IOCCC | ./ver0 1 2"
    echo IOCCC | ./ver0 1 2
    echo

    echo "$ echo IOCCC | ./ver0 1 2 3"
    echo IOCCC | ./ver0 1 2 3
    echo
fi

if [[ -e "./ver1" ]]; then
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
fi

if [[ -e "./ver2" ]]; then
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
fi

if [[ -e "./ver3" ]]; then
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
fi
