#!/usr/bin/env bash

grep -o '<A NAME="[^"][A-Za-z_][A-Za-z_]*">' winners.html |sed -e 's,<A NAME=,,g' -e 's/"//g' -e 's/>//g'

