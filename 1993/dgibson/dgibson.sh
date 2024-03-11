#!/usr/bin/env bash
#
# dgibson.sh - run the IOCCC entry 1993/dgibson
#
# usage:
#	dgibson.sh [data_file]

# parse args
#
if [[ $# -eq 0 ]]; then
    DATA="./dgibson.data1"
else
    DATA="$1"
fi
if [[ ! -f "$DATA" ]]; then
    echo "$0: no data found in $DATA" 1>&2
    exit 1
fi

# for the initial data.name if needed
#
if [[ ! -f "data.name" ]]; then
    rm -f data.name
    echo "$DATA" > data.name
fi
if [[ ! -f life.d ]]; then
    # force a new life setup
    echo "/" > data.name
fi
rm -f data.name2
echo "$DATA" > data.name2

# note if we are running a new form
#
if cmp -s data.name data.name2; then
    :
else
    rm -f life.d
    cp "$DATA" life.d
    rm -f data.name
    echo "$DATA" > data.name
    cat life.d
fi

# build a new copy of the program
#
rm -f dgibson
# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1


# form the next generation
#
chmod +w life.d
./dgibson | tee life.d
