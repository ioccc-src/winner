#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/cesmoak

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# clear the screen
#
clear

echo "If you want to look at prog.c first, I'll wait... " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

echo "This script runs a full chain in one go." 1>&2
echo 1>&2
echo "The author suggests viewing the output of the first two runs below," 1>&2
echo "then inspecting prog.c as a challenge to determine the intermediate " 1>&2
echo "representations before running try_rpg.sh to see each step broken apart." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to start: "
echo 1>&2

# try the program - small / render
#
echo "Tiny output." 1>&2
echo 1>&2
echo "This might take 1 - 2 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog 60 < prog.c | ./prog | ./prog -d > render_60x30.pgm: "
echo 1>&2
rm -f render_60x30.pgm
time ./prog 60 < prog.c | ./prog | ./prog -d > render_60x30.pgm
echo 1>&2
echo "You may wish to view: render_60x30.pgm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# try the program - small / print
#
echo "Small output, and will be notably different (not just larger) than the previous output." 1>&2
echo 1>&2
echo "This might take 5 - 10 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog 160 < prog.c | ./prog | ./prog | ./prog > print_160x80.pgm: "
echo 1>&2
rm -f print_160x80.pgm
time ./prog 160 < prog.c | ./prog | ./prog | ./prog > print_160x80.pgm
echo 1>&2
echo "You may wish to view: print_160x80.pgm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# try the program - medium / print
#
echo "Medium output." 1>&2
echo 1>&2
echo "This might take 15 - 30 minutes to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog 480 < prog.c | ./prog | ./prog | ./prog > print_480x240.pgm: "
echo 1>&2
rm -f print_480x240.pgm
time ./prog 480 < prog.c | ./prog | ./prog | ./prog > print_480x240.pgm
echo 1>&2
echo "You may wish to view: print_480x240.pgm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

# try the program - large / print
#
echo "Large output." 1>&2
echo 1>&2
echo "This might take 9 - 18 hours to complete: " 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: time ./prog 1200 < prog.c | ./prog | ./prog | ./prog > print_1200x600.pgm: "
echo 1>&2
rm -f print_1200x600.pgm
time ./prog 1200 < prog.c | ./prog | ./prog | ./prog > print_1200x600.pgm
echo 1>&2
echo "You may wish to view: print_1200x600.pgm" 1>&2
echo 1>&2
