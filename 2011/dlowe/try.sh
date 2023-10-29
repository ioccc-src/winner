#!/usr/bin/env bash

make clobber dlowe || exit 1

./dlowe dlowe.c < dlowe-aux-data/ioccc-winlose-trained.net
./dlowe dlowe < dlowe-aux-data/ioccc-winlose-trained.net

./dlowe xor-0/00 < dlowe-aux-data/xor-trained.net
./dlowe xor-0/11 < dlowe-aux-data/xor-trained.net
./dlowe xor-1/01 < dlowe-aux-data/xor-trained.net
./dlowe xor-1/10 < dlowe-aux-data/xor-trained.net

./dlowe README.html < dlowe-aux-data/english-trained.net

./dlowe dlowe-aux-data.tar.bz2 < dlowe-aux-data/png-trained.net


