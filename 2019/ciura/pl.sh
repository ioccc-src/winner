#!/bin/sh
set -x
./getwords.sh pl | egrep -v '^[^aiouwz]$' | ./prog aąbcćdeęfghijklłmnńoóprsśtuwyzźż
