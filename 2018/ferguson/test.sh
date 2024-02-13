#!/usr/bin/env bash
#
# test.sh - make test script for IOCCC entry 2018/ferguson

# Make sure the program has been compiled
make everything 1> /dev/null|| exit 1

read -r -n 1 -p "Press any key to run tests (space = next page, G = end, q = quit): "
echo 1>&2

while read -r f; do
    # NOTE: ./weasel $* $f would just be the final word. We quote it for the
    # full line:
    ./weasel "$@" "${f}" | less -rEXFK
done < test-strings.txt || exit 1

echo "All done. Goodbye, you old monkeying weasel!"
