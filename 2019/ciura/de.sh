#!/usr/bin/env bash
set -x
./getwords.sh de | tr A-ZÄÖÜ a-zäöü | grep .. | ./prog aäbcdefghijklmnoöpqrsßtuüvwxyz
