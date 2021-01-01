#!/bin/sh

prog="$1"
: ${prog:=./prog}

check_prog() {
    /bin/echo -n "$1 "; $prog $1
}

seq 0 255 | while read a; do
    check_prog "$a"
done | pr -t -w120 -8
