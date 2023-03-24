#!/usr/bin/env bash
cc -O2 run.c -o run > /dev/null && ./run | tee run.c
