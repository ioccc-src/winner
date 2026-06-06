#!/usr/bin/env bash
#
# try.alt.sh - alternative demonstration of 2025/ferguson

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" alt >/dev/null || exit 1

# clear the screen
#
clear

# try the program
#
echo "NOTE: this version randomises the coordinates, showing first the source and" 1>&2
echo "then on another line the antipode coordinates. If two args are specified they" 1>&2
echo "should PPM: though obviously only the in.ppm has to be an actual PPM file." 1>&2
echo "What we'll do here is show you a couple random coordinate<->antipodal pairs" 1>&2
echo "and then run the program a few times in the normal way and then reading in from" 1>&2
echo "the last output file, prompting you to look at the image in between each run." 1>&2
echo 1>&2

# We disable this because in some cases ShellCheck complains about 'i' being
# unused. We do not need it as it's just a side effect (probably better ways in
# bash but this is what came to my mind first).
#
# ^-^ SC2034 (warning): i appears unused. Verify use (or export if used externally).
#
# shellcheck disable=SC2034
#
for i in {0..3}; do
    read -r -n 1 -p "Press any key to run: ./prog.alt: "
    echo 1>&2
    echo 1>&2
    ./prog.alt
    echo 1>&2
done

# We disable this because in some cases ShellCheck complains about 'i' being
# unused. We do not need it as it's just a side effect (probably better ways in
# bash but this is what came to my mind first).
#
# ^-^ SC2034 (warning): i appears unused. Verify use (or export if used externally).
#
# shellcheck disable=SC2034
#
for i in {0..3}; do
    read -r -n 1 -p "Press any key to run: ./prog.alt earth.ppm mars.ppm: "
    echo 1>&2
    echo 1>&2
    ./prog.alt earth.ppm mars.ppm
    echo 1>&2
    echo "Now open mars.ppm and look at where the arrows are!" 1>&2
    echo 1>&2
done

echo "Now we will make it so the alt code reads from and writes to mars.ppm, so you" 1>&2
echo "can see what happens but random locations." 1>&2
echo 1>&2

# We disable this because in some cases ShellCheck complains about 'i' being
# unused. We do not need it as it's just a side effect (probably better ways in
# bash but this is what came to my mind first).
#
# ^-^ SC2034 (warning): i appears unused. Verify use (or export if used externally).
#
# shellcheck disable=SC2034
#
for i in {0..3}; do
    read -r -n 1 -p "Press any key to run: ./prog.alt mars.ppm mars.ppm: "
    echo 1>&2
    echo 1>&2
    ./prog.alt mars.ppm mars.ppm
    echo 1>&2
    echo "Now open mars.ppm and look at where the arrows are!" 1>&2
    echo 1>&2
done

echo "Safe travels and do not get too lost!" 1>&2
echo 1>&2
exit 0
