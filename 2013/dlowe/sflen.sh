#!/usr/bin/env bash

make all || exit 1
ln -sf dlowe sparkl
echo "sparkline of file lengths: $(wc -c ./* | awk '{print $1}' | xargs ./sparkl)"
