#!/usr/bin/env bash
#
# try.sh - script to demonstrate IOCCC winner 1991/fine
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi
make CC="$CC" all >/dev/null || exit 1

# clear screen to remove any compiler message to make the entry stand out more
clear

echo -n "Green terra <-> "
echo "Green terra" | ./fine

echo -n "Vex <-> "
echo "Vex" | ./fine

echo -n "Tang <-> "
echo "Tang" | ./fine

echo -n "Vend onyx <-> "
echo "Vend onyx" | ./fine

echo -n "Cheryl be flashy <-> "
echo "Cheryl be flashy" | ./fine

echo -n "Rail <-> "
echo "Rail" | ./fine

echo -n "Clerk <-> "
echo "Clerk" | ./fine

echo -n "Ones <-> "
echo "Ones" | ./fine

echo -n "Fur <-> "
echo "Fur" | ./fine

echo -n "Er <-> "
echo "Er" | ./fine

echo -n "IV <-> "
echo "IV" | ./fine

echo -n "NYC <-> "
echo "NYC" | ./fine

echo -n "Fubar <-> "
echo "Fubar" | ./fine

echo -n "DQ <-> "
echo "DQ" | ./fine

echo -n "Off <-> "
echo "Off" | ./fine

echo -n "Ire <-> "
echo "Ire" | ./fine

echo -n "PEP <-> "
echo "PEP" | ./fine


echo -n "The rug gary lenT <-> "
echo "The rug gary lenT" | ./fine
