#!/usr/bin/env bash

prog="$1"
: "${prog:=./prog_le}"

check_prog() {
    /bin/echo -n "$1 "; $prog "$1"
}

seq 0 255 | while read -r a; do
    check_prog "$a"
done | pr -t -w120 -8
