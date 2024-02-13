#!/usr/bin/env bash
# 
# try.sh - demonstrate IOCCC entry 1998/dorssel
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

read -r -n 1 -p "Press any key to run: echo 'Simple as 123' | ./dorssel: "
echo 1>&2
echo 'Simple as 123' | ./dorssel
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'Binary as simple as 1, 10 11.' | ./dorssel: " 1>&2
echo 1>&2
echo 'Binary as simple as 1, 10 11.' | ./dorssel
echo 1>&2

echo "$ echo '.... --- .--  -.. --- . ...  .. -  -.. ---  - .... .- -' | ./dorssel" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo '.... --- .--  -.. --- . ...  .. -  -.. ---  - .... .- -' | ./dorssel
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'HOW DOES IT DO THAT' | ./dorssel: "
echo 1>&2
echo 'HOW DOES IT DO THAT' | ./dorssel
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'HOW DOES IT DO THAT' | ./dorssel | ./dorssel: "
echo 1>&2
echo 'HOW DOES IT DO THAT' | ./dorssel | ./dorssel
echo 1>&2

read -r -n 1 -p "Press any key to run: ./dorssel < dorssel.c | ./dorssel: "
echo 1>&2
./dorssel < dorssel.c | ./dorssel
echo 1>&2


echo "$ echo '
..  - .... .. -. -.-  - .... .. ...  ... .--. --- .. .-.. . .-.  .. ...  -- --- .-. .  --- -... ..-. ..- ... -.-. .- - . -..  - .... .- -.  - .... .  .--. .-. --- --. .-. .- --

. -..- . .-. -.-. .. ... .
-.-. .... .- -. --. .  - .... .  .--. .-. --- --. .-. .- --  ... ---  .. -  -.. --- . ...  -. --- -  ... .... --- ..- -' | ./dorssel" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2

echo "
..  - .... .. -. -.-  - .... .. ...  ... .--. --- .. .-.. . .-.  .. ...  -- --- .-. .  --- -... ..-. ..- ... -.-. .- - . -..  - .... .- -.  - .... .  .--. .-. --- --. .-. .- --

. -..- . .-. -.-. .. ... .
-.-. .... .- -. --. .  - .... .  .--. .-. --- --. .-. .- --  ... ---  .. -  -.. --- . ...  -. --- -  ... .... --- ..- -" | ./dorssel

read -r -n 1 -p "Press any key to run: ./dorssel < dorssel.md (space = next page, q = quit): "
echo 1>&2
./dorssel < dorssel.md | less -rEXF
echo 1>&2
