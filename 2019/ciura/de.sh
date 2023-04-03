#!/usr/bin/env bash
set -x
LC_ALL=C ./getwords.sh de | LC_ALL=C tr '[:lower:]' '[:upper:]'  | LC_ALL=C grep .. | LC_ALL=C ./prog aäbcdefghijklmnoöpqrsßtuüvwxyz
