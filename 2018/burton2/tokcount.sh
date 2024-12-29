#!/usr/bin/env bash

cat "$@" | ./prog -t | sort | uniq -c | sort -k1nr
