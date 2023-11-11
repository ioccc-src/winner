#!/usr/bin/env bash

make everything 1>/dev/null || exit 1

echo "Showing grandfather clock:" 1>&2
WESTLEY=./westley ./clock1.sh
read -r -n 1 -p "Press any key to continue: " 1>&2

echo "Showing mantle clock that runs backwards:" 1>&2
WESTLEY=./westley ./clock2.sh
read -r -n 1 -p "Press any key to continue: " 1>&2

echo "Showing linear style clock:" 1>&2
WESTLEY=./westley ./clock3.sh
