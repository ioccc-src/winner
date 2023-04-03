#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]; then
    echo "Usage: $0 <language code>"
    echo "Run (aspell dump dicts) to see the available codes."
    exit 2
fi

LC_ALL=C aspell --lang="$1" dump master \
  | LC_ALL=C aspell --lang="$1" expand \
  | LC_ALL=C tr ' ' '\n' \
  | LC_ALL=C sort -u
