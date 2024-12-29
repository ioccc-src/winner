#!/usr/bin/env bash
# to run fubar in the 'proper' way

# parse args
if [[ $# -ne 1 ]]; then
    echo "usage: $0 number" 1>&2
    exit 1
fi

# run/compile it
rm -f ouroboros.c x1 x
ex fubar.c <<EOF
8,9j
w ouroboros.c
EOF
chmod +x ouroboros.c
./ouroboros.c "$1"
#rm -f ouroboros.c x1 x
