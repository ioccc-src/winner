#!/usr/bin/env bash
#
# demo.sh - script to demonstrate IOCCC entry 1991/fine
#

make all || exit 1

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
echo -n "The rug gary lenT <-> "
echo "The rug gary lenT" | ./fine
