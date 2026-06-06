#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/yang2

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all prog++ >/dev/null || exit 1

# clear the screen
#
clear

# try a non-repetitive input
read -r -n 1 -p "Press any key to run: echo hello world | ./prog > output1.c "
echo 1>&2
echo hello world | ./prog > output1.c

read -r -n 1 -p "Press any key to run: cat output1.c "
echo 1>&2
echo 1>&2
cat output1.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} output1.c -o output1 && ./output1 "
echo 1>&2
echo 1>&2
${CC} output1.c -o output1 && ./output1
echo 1>&2

# Try a repetitive input
read -r -n 1 -p "Press any key to run: echo yeah, yeah, yeah | ./prog > output2.c "
echo 1>&2
echo 1>&2
echo yeah, yeah, yeah | ./prog > output2.c

read -r -n 1 -p "Press any key to run: cat output2.c "
echo 1>&2
echo 1>&2
cat output2.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} output2.c -o output2 && ./output2 "
echo 1>&2
echo 1>&2
${CC} output2.c -o output2 && ./output2
echo 1>&2

# Concatenate the outputs
read -r -n 1 -p "Press any key to run: cat output1.c output2.c > output_combined.c "
echo 1>&2
echo 1>&2
cat output1.c output2.c > output_combined.c

read -r -n 1 -p "Press any key to run: ${CC} output_combined.c -o output_combined && ./output_combined "
echo 1>&2
echo 1>&2
${CC} output_combined.c -o output_combined && ./output_combined
echo 1>&2

# Try C++ version
read -r -n 1 -p "Press any key to run: echo I O C C C | ./prog++ > output3.c "
echo 1>&2
echo 1>&2
echo I O C C C | ./prog++ > output3.c

read -r -n 1 -p "Press any key to run: cat output3.c "
echo 1>&2
echo 1>&2
cat output3.c
echo 1>&2

read -r -n 1 -p "Press any key to run: ${CC} output3.c -o output3 && ./output3 "
echo 1>&2
echo 1>&2
${CC} output3.c -o output3 && ./output3
echo 1>&2
