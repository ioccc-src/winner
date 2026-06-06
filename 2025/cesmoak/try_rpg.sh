#!/usr/bin/env bash
#
# try_rpg.sh - demonstrate each step in turn
#
# Usage: try_rpg.sh [WIDTH]
RES="${1:-160}"

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

echo "Welcome to the Jean-Pierre Luminet RPG." 1>&2
echo 1>&2
echo "You are Jean-Pierre Luminet. The year is 1978. You are making the first-ever" 1>&2
echo "simulated photograph of a black hole." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

echo "First, think through the math for a black hole in Schwarzschild" 1>&2
echo "spacetime. Review those papers carefully. You might need a stiff drink" 1>&2
echo "and/or chocolate while writing down your notes." 1>&2
echo 1>&2
read -n 1 -s -r -p "Press any key to run: cp -f prog.c scribbled.notes: "
echo 1>&2
echo 1>&2
cp -f prog.c scribbled.notes

echo "Now, take your notes and translate the appropriate formulas to a program" 1>&2
echo "that will calculate the light visible to an observer looking towards the" 1>&2
echo "black hole." 1>&2
echo 1>&2
echo "cp -f prog cardpunch" 1>&2
cp -f prog cardpunch
echo 1>&2
read -n 1 -s -r -p "Press any key to run: ./cardpunch $RES < scribbled.notes > prog.deck: "
echo 1>&2
echo 1>&2
rm -f prog.deck
./cardpunch "$RES" < scribbled.notes > prog.deck

echo "Next, run your program on an IBM 7040 to calculate observed flux at" 1>&2
echo "points around a black hole. This will take a while." 1>&2
echo 1>&2
echo "cp -f prog ibm7040" 1>&2
cp -f prog ibm7040
echo 1>&2
echo "If the width is 160 above: This might take 8 - 16 minutes to complete: " 1>&2
echo 1>&2
read -n 1 -s -r -p "Press any key to run: ./ibm7040 < prog.deck > flux.data: "
echo 1>&2
rm -f flux.data
time ./ibm7040 < prog.deck > flux.data

echo 1>&2
echo "Ok, now make a drawing. Use ink and draw dots more densely in areas that" 1>&2
echo "show larger observed flux." 1>&2
echo 1>&2
echo "cp -f prog pen" 1>&2
cp -f prog pen
echo 1>&2
read -n 1 -s -r -p "Press any key to run: ./pen < flux.data > paper.pgm: "
echo 1>&2
echo 1>&2
rm -f paper.pgm
./pen < flux.data > paper.pgm
echo 1>&2
echo "You may wish to view: paper.pgm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

echo "Finally, make a print from your paper negative." 1>&2
echo 1>&2
echo "cp -f prog darkroom" 1>&2
cp -f prog darkroom
echo 1>&2
read -n 1 -s -r -p "Press any key to run: ./darkroom < paper.pgm > print.pgm: " 1>&2
echo 1>&2
echo 1>&2
rm -f print.pgm
./darkroom < paper.pgm > print.pgm
echo 1>&2
echo "You may wish to view: print.pgm" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
echo 1>&2

echo "Great job, researcher! C'est magnifique! Vous êtes une vraie singularité!" 1>&2
echo 1>&2
