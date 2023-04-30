#!/usr/bin/env bash

while :; do
    clear
    rm -f sykes2
    make sykes2 2>/dev/null 1>&2
    ./sykes2
    sleep 1
done
