#!/usr/bin/env bash

if [[ "$#" -lt 1 ]]; then
    exit 1
fi

make >/dev/null 2>&1

if [[ -f "$1" ]]; then
    ./anonymous "$1"
    ./"$1"
fi

