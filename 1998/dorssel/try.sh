#!/usr/bin/env bash
# 
# script to show 1998/dorssel

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

