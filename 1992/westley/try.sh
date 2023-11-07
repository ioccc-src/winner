#!/usr/bin/env bash

make everything || exit 1

echo "New York:" 1>&2
echo 1>&2
./westley.alt 41 -74
echo 1>&2

echo "London:" 1>&2
echo 1>&2
./westley 52 0
echo 1>&2

echo "Moscow:" 1>&2
echo 1>&2
./westley 56 38
echo 1>&2

echo "New Delhi:" 1>&2
echo 1>&2
./westley 29 77
echo 1>&2

echo "Sydney:" 1>&2
echo 1>&2
./westley -34 151
echo 1>&2

echo "Los Angeles:" 1>&2
echo 1>&2
./westley.alt 34 -118
echo 1>&2

echo "Paris:" 1>&2
echo 1>&2
./westley 45 2
echo 1>&2

echo "Rio de Janeiro:" 1>&2
echo 1>&2
./westley -23 -43
echo 1>&2

echo "Beijing:" 1>&2
echo 1>&2
./westley 40 116
echo 1>&2

echo "Tokyo:" 1>&2
echo 1>&2
./westley 36 140
echo 1>&2

echo "Approximate judging location:" 1>&2
echo 1>&2
./westley.alt 37 -122
