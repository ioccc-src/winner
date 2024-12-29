#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1990/jaw
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear


echo "$ ./shark.sh atob shark.sh README.md jaw.c try.sh > receive"
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
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
read -r -n 1 -p "Press any key to run ../receive (extract files): "
echo 1>&2
../receive
echo 1>&2

read -r -n 1 -p "Press any key to run: ls -al: "
echo 1>&2
ls -al

echo 1>&2
echo "Comparing the files from the parent directory:" 1>&2
echo 1>&2
for i in *; do
    echo -n "   " 1>&2; diff -s "$i" ../"$i"
done
