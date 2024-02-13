#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2011/dlowe
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

# in this case we won't fail if we can't compile the code because we can still
# run the supplementary program.
make CC="$CC" all >/dev/null

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net: "
echo 1>&2
./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe dlowe < dlowe-aux-data/ioccc-winlose-trained.net: "
echo 1>&2
./dlowe dlowe < dlowe-aux-data/ioccc-winlose-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe xor-0/00 < dlowe-aux-data/xor-trained.net: "
echo 1>&2
./dlowe xor-0/00 < dlowe-aux-data/xor-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe xor-0/11 < dlowe-aux-data/xor-trained.net: "
echo 1>&2
./dlowe xor-0/11 < dlowe-aux-data/xor-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe xor-1/01 < dlowe-aux-data/xor-trained.net: "
echo 1>&2
./dlowe xor-1/01 < dlowe-aux-data/xor-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe xor-1/10 < dlowe-aux-data/xor-trained.net: "
echo 1>&2
./dlowe xor-1/10 < dlowe-aux-data/xor-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe README.html < dlowe-aux-data/english-trained.net: "
echo 1>&2
./dlowe README.html < dlowe-aux-data/english-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe dlowe-aux-data.tar.bz2 < dlowe-aux-data/png-trained.net: "
echo 1>&2
./dlowe dlowe-aux-data.tar.bz2 < dlowe-aux-data/png-trained.net
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net: "
echo 1>&2
./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net
