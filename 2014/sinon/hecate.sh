#!/usr/bin/env bash
cp -f prog.c run.c && cc -O2 run.c -o run > /dev/null && ./run | tee run.c
