#!/bin/sh
set -x
./getwords.sh en | grep .. | ./prog abcdefghijklmnopqrstuvwxyz
