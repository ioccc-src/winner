#!/usr/bin/env bash
set -x
LC_ALL=C ./getwords.sh pl | LC_ALL=C grep -vE '^[^aiouwz]$' | LC_ALL='' ./prog aąbcćdeęfghijklłmnńoóprsśtuwyzźż
