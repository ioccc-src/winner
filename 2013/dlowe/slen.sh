#!/usr/bin/env bash

echo "sparkline of file lengths: $(wc -c ./* | awk '{print $1}' | xargs ./sparkl)"
