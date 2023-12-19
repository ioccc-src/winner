#!/usr/bin/env bash

echo "Running shark.sh:"
./shark.sh atob shark.sh README.md jaw.c try.sh > receive || exit 1
echo "Done."


# delete directory for clean state
rm -fr test

# make sure we can make the new directory
mkdir -p test || exit 0

# make sure we can cd to the new directory
cd test || exit
chmod +x ../receive
# run the script
echo "Attempting to extract files:"
../receive

echo 1>&2
echo "$ ls -al" 1>&2
ls -al

echo 1>&2
echo "Comparing the files from the parent directory:" 1>&2
echo 1>&2
for i in *; do
    echo -n "   " 1>&2; diff -s "$i" ../"$i"
done
