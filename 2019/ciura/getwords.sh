#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <language code>"
    echo "Run (aspell dump dicts) to see the available codes."
    exit 2
fi

aspell --lang=$1 dump master \
  | aspell --lang=$1 expand \
  | tr ' ' '\n' \
  | sort -u
