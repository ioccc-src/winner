#!/usr/bin/env bash

make everything 1>/dev/null || exit 1

echo "Showing alt grandfather clock:" 1>&2
WESTLEY=./westley.alt ./clock1.sh
read -r -n 1 -p "Press any key to continue: " 1>&2

echo "Showing alt mantle clock that runs backwards:" 1>&2
WESTLEY=./westley.alt ./clock2.sh
read -r -n 1 -p "Press any key to continue: " 1>&2

echo "Showing alt linear style clock:" 1>&2
WESTLEY=./westley.alt ./clock3.sh
