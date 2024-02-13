#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 2019/yang
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

echo "$ ./prog ioccc.txt a b c d e" 1>&2
read -r -n 1 -p "Press any key to scramble ioccc.txt into five files: "
echo 1>&2
./prog ioccc.txt a b c d e

read -r -n 1 -p "Press any key to unscramble part a with: cat a: "
clear
cat a

read -r -n 1 -p "Press any key to unscramble part b with: cat b: "
clear
cat b

read -r -n 1 -p "Press any key to unscramble part c with: cat c: "
clear
cat c

read -r -n 1 -p "Press any key to unscramble part d with: cat d: "
clear
cat d

read -r -n 1 -p "Press any key to unscramble part e with: cat e: "
clear
cat e

echo "$ cat a b c d e | ./prog" 1>&2
read -r -n 1 -p "Press any key to unscramble all parts: "
echo 1>&2
cat a b c d e | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: cat a b c d e | ./prog | diff -s - ioccc.txt: "
echo 1>&2
cat a b c d e | ./prog | diff -s - ioccc.txt

LINES="$(tput lines)"
COLS="$(tput cols)"
if [[ "$COLS" -lt 75 || "$LINES" -lt 13 ]]; then
    # if screen size < 75 x 13 then exit
    exit 0
fi

echo 1>&2
echo "$ ./prog sample_input.txt a b c d e" 1>&2
read -r -n 1 -p "Press any key to scramble sample_input.txt into five files: "
echo 1>&2
./prog sample_input.txt a b c d e

read -r -n 1 -p "Press any key to unscramble part a with: cat a: "
clear
cat a

read -r -n 1 -p "Press any key to unscramble part b with: cat b: "
clear
cat b

read -r -n 1 -p "Press any key to unscramble part c with: cat c: "
clear
cat c

read -r -n 1 -p "Press any key to unscramble part d with: cat d: "
clear
cat d

read -r -n 1 -p "Press any key to unscramble part e with: cat e: "
clear
cat e

echo "$ cat a b c d e | ./prog" 1>&2
read -r -n 1 -p "Press any key to unscramble all parts: "
echo 1>&2
cat a b c d e | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: cat a b c d e | ./prog | diff -s - sample_input.txt: "
echo 1>&2
cat a b c d e | ./prog | diff -s - sample_input.txt
echo 1>&2

if [[ "$COLS" -lt 80 || "$LINES" -lt 25 ]]; then
    # if screen size < 80 x 25 then exit
    exit 0
fi

read -r -n 1 -p "Press any key to run: cat prog.c: "
echo 1>&2
cat prog.c

echo 1>&2
echo "$ ./prog prog.c a b c d e" 1>&2
read -r -n 1 -p "Press any key to scramble prog.c into five files: "
echo 1>&2
./prog prog.c a b c d e

read -r -n 1 -p "Press any key to unscramble part a with: cat a: "
clear
cat a

read -r -n 1 -p "Press any key to unscramble part b with: cat b: "
clear
cat b

read -r -n 1 -p "Press any key to unscramble part c with: cat c: "
clear
cat c

read -r -n 1 -p "Press any key to unscramble part d with: cat d: "
clear
cat d

read -r -n 1 -p "Press any key to unscramble part e with: cat e: "
clear
cat e

echo "$ cat a b c d e | ./prog" 1>&2
read -r -n 1 -p "Press any key to unscramble all parts: "
echo 1>&2
cat a b c d e | ./prog
echo 1>&2

read -r -n 1 -p "Press any key to run: cat a b c d e | ./prog | diff -s - prog.c: "
echo 1>&2
cat a b c d e | ./prog | diff -s - prog.c
echo 1>&2

# For the next three we have to see if ruby is installed
RUBY="$(type -P ruby)"

if [[ -n "$RUBY" ]]; then
    read -r -p "Do you want to see the slow scrambling: ./prog prog.c | ruby prog.c (Y/N)? "
    echo 1>&2
    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
	echo "This may take a while, hit ctrl-c to exit script." 1>&2
	echo 1>&2
	./prog prog.c | ruby prog.c
    fi

    read -r -p "Do you want to see the slow scrambling: ./prog violet.c | ruby prog.c (Y/N)? "
    echo 1>&2
    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
	echo "This may take a while, hit ctrl-c to exit script." 1>&2
	echo 1>&2
	./prog violet.c | ruby prog.c
    fi

    read -r -p "Do you want to see the slow scrambling: ./prog violet.c | ruby violet.c (Y/N)? "
    echo 1>&2
    if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
	echo "This may take a while, hit ctrl-c to exit script." 1>&2
	echo 1>&2
	./prog violet.c | ruby violet.c
    fi
fi
