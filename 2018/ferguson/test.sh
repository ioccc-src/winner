#!/usr/bin/env bash

# Make sure the program has been compiled
make clobber all 1> /dev/null|| exit 1

while read -r f; do
    ./weasel "$@" "${f}" # full line because of quotes
    # NOTE: ./weasel $* $f would just be the final word
    sleep 2
done < test-strings.txt || exit 1
echo "All done. Goodbye."
