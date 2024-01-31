#!/usr/bin/env bash
#
# monkey-words.sh - try and get Eric the monkey to type 'words'.
#
echo 1>&2
make -B MAX_ATTEMPTS=SIZE_MAX-1 >/dev/null || exit 1
echo 1>&2
read -r -n 1 -p "Do you want to see how long it might take the monkey Eric to type 'words'? (Y/N)? "
if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    echo 1>&2
    echo "Will let Eric try until he succeeds, gives up or he falls asleep." 1>&2
    echo "Hit ctrl-c/intr to let him nap early." 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key to continue: "
    echo 1>&2
    time ./weasel -m words
fi
