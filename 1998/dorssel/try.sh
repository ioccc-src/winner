#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC winner 1998/dorssel
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

echo "$ echo 'Simple as 123' | ./dorssel" 1>&2
echo 'Simple as 123' | ./dorssel

echo "$ echo 'Binary as simple as 1, 10 11.' | ./dorssel" 1>&2
echo 'Binary as simple as 1, 10 11.' | ./dorssel

echo "$ echo '.... --- .--  -.. --- . ...  .. -  -.. ---  - .... .- -' | ./dorssel" 1>&2
echo '.... --- .--  -.. --- . ...  .. -  -.. ---  - .... .- -' | ./dorssel

echo "$ echo 'HOW DOES IT DO THAT' | ./dorssel" 1>&2
echo 'HOW DOES IT DO THAT' | ./dorssel

echo "$ echo 'HOW DOES IT DO THAT' | ./dorssel | ./dorssel" 1>&2
echo 'HOW DOES IT DO THAT' | ./dorssel | ./dorssel


echo "$ ./dorssel < dorssel.c | ./dorssel" 1>&2
./dorssel < dorssel.c | ./dorssel


echo "$ echo '
..  - .... .. -. -.-  - .... .. ...  ... .--. --- .. .-.. . .-.  .. ...  -- --- .-. .  --- -... ..-. ..- ... -.-. .- - . -..  - .... .- -.  - .... .  .--. .-. --- --. .-. .- --

. -..- . .-. -.-. .. ... .
-.-. .... .- -. --. .  - .... .  .--. .-. --- --. .-. .- --  ... ---  .. -  -.. --- . ...  -. --- -  ... .... --- ..- -' | ./dorssel" 1>&2

echo "
..  - .... .. -. -.-  - .... .. ...  ... .--. --- .. .-.. . .-.  .. ...  -- --- .-. .  --- -... ..-. ..- ... -.-. .- - . -..  - .... .- -.  - .... .  .--. .-. --- --. .-. .- --

. -..- . .-. -.-. .. ... .
-.-. .... .- -. --. .  - .... .  .--. .-. --- --. .-. .- --  ... ---  .. -  -.. --- . ...  -. --- -  ... .... --- ..- -" | ./dorssel

