#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2000/rince
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" everything >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: ./rince: "
echo 1>&2
./rince
echo 1>&2

read -r -n 1 -p "Press any key to run: ./rince 0.001 $(./dmy2jd 7.8 1 1610): "
echo 1>&2

# We actually need word splitting here so we disable the shellcheck warning
# SC2046.
#
# SC2046 (warning): Quote this to prevent word splitting.
# https://www.shellcheck.net/wiki/SC2046
# shellcheck disable=SC2046
./rince 0.001 $(./dmy2jd 7.8 1 1610)
echo 1>&2

read -r -n 1 -p "Press any key to run: ./rince 0.01: "
echo 1>&2
./rince 0.01
echo 1>&2

read -r -n 1 -p "Press any key to run: ./rince 0 2441193.6: "
echo 1>&2
./rince 0 2441193.6
echo 1>&2

read -r -n 1 -p "Press any key to run: ./rince 0.01 2441193.6: "
echo 1>&2
./rince 0.01 2441193.6
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dmy2jd 7.8 1 1610: "
echo 1>&2
./dmy2jd 7.8 1 1610
echo 1>&2
read -r -n 1 -p "Press any key to run: ./rince 0 \$(./dmy2jd 7.8 1 1610): "
echo 1>&2
# We actually need word splitting here so we disable the shellcheck warning
# SC2046.
#
# SC2046 (warning): Quote this to prevent word splitting.
# https://www.shellcheck.net/wiki/SC2046
# shellcheck disable=SC2046
./rince 0 $(./dmy2jd 7.8 1 1610)
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dmy2jd 8.8 1 1610: "
echo 1>&2
./dmy2jd 8.8 1 1610
echo 1>&2
read -r -n 1 -p "Press any key to run: ./rince 0 \$(./dmy2jd 8.8 1 1610): "
echo 1>&2
# We actually need word splitting here so we disable the shellcheck warning
# SC2046.
#
# SC2046 (warning): Quote this to prevent word splitting.
# https://www.shellcheck.net/wiki/SC2046
# shellcheck disable=SC2046
./rince 0 $(./dmy2jd 8.8 1 1610)
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dmy2jd 10.8 1 1610: "
echo 1>&2
./dmy2jd 10.8 1 1610
echo 1>&2
read -r -n 1 -p "Press any key to run: ./rince 0 \$(./dmy2jd 10.8 1 1610): "
echo 1>&2
# We actually need word splitting here so we disable the shellcheck warning
# SC2046.
#
# SC2046 (warning): Quote this to prevent word splitting.
# https://www.shellcheck.net/wiki/SC2046
# shellcheck disable=SC2046
./rince 0 $(./dmy2jd 10.8 1 1610)
echo 1>&2
