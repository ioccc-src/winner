#!/usr/bin/env bash
set -x
./getwords.sh pl | egrep -v '^[^aiouwz]$' | ./prog aąbcćdeęfghijklłmnńoóprsśtuwyzźż
