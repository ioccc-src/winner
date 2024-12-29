#!/usr/bin/env bash

prog="$1"
: "${prog:=./prog_be}"

check_code() {
    /bin/echo -n "$1 "; $prog "$1" | rev
}

seq 0 255 | while read -r a; do
    check_code "$a"
done | pr -t -w120 -8
