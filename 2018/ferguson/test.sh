#!/bin/bash

# Make sure the program has been compiled
make weasel 1> /dev/null|| exit 1

while read f; do
    ./weasel $* "${f}" # full line because of quotes
    # ./weasel $* $f would just be the final word
    sleep 2
done < test-strings.txt || exit 1
echo "All done. Goodbye."
