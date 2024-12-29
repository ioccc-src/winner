#!/usr/bin/env bash
#
# try.alt.bw.sh - demonstrate IOCCC entry 2012/endoh1 alternate code w/o colour
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
[[ -z "$CC" ]] && CC="cc"

# We will use a timer (alarm(3) value) of 10 (the default) but we will allow the
# user to redefine it. The code protects against negative values and values > 60
# (arbitrary) but if the user is silly enough to specify a value that is not a
# number that's on them.
[[ -z "$TIMER" ]] && TIMER=10

# We will use a sleep value of 39000 but just like the others we will let the
# user override it if they so wish. The code protects against values < 0 but if
# someone chooses a value that's not a number that's on them.
[[ -z "$SLEEP" ]] && SLEEP=39000

# We will let users redefine GRAVITY but only for the version that is NOT I
# (letter I not digit 1). Just like the others we do not protect against input
# that is not a number and in the case of GRAVITY it is even documented that
# some non number values (I) are good to try.
[[ -z "$GRAVITY" ]] && GRAVITY=1

# We will use the default 8 for VISCOSITY but we'll allow the user to redefine
# it. We don't protect against < 0 as it doesn't seem to break the program to
# have < 0 but if they set it to a non number value that's on them.
[[ -z "$VISCOSITY" ]] && VISCOSITY=8

# We will use the default PRESSURE of 4 but like the other variables we will let
# the user redefine it. We do not protect against any value, even non-numbers.
# If someone wants to set it to something else that's on them.
[[ -z "$PRESSURE" ]] && PRESSURE=4

# unlike other try.sh/try.alt.sh scripts this one has two compiled binaries: one
# which sets the gravity factor to I (letter I, not digit 1) and the other that
# does not. Thus we do not compile it like the others.
echo "$ make clobber CC=$CC TIMER=$TIMER SLEEP=$SLEEP GRAVITY=I VISCOSITY=$VISCOSITY PRESSURE=$PRESSURE alt" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
make clobber CC="$CC" TIMER="$TIMER" SLEEP="$SLEEP" GRAVITY=I VISCOSITY="$VISCOSITY" PRESSURE="$PRESSURE" alt >/dev/null || exit 1
# we have to move the endoh1.alt to endoh1.alt3, not alt2, because
# we have to use make clobber which would wipe out endoh1.alt2.
read -r -n 1 -p "Press any key to move endoh1.alt to endoh1.alt3: "
echo 1>&2
mv -v endoh1.alt endoh1.alt3
echo 1>&2
echo "$ make clobber CC=$CC TIMER=$TIMER SLEEP=$SLEEP GRAVITY=$GRAVITY VISCOSITY=$VISCOSITY PRESSURE=$PRESSURE alt" 1>&2
read -r -n 1 -p "Press any key to continue: "
echo 1>&2
make clobber CC="$CC" TIMER="$TIMER" SLEEP="$SLEEP" GRAVITY="$GRAVITY" VISCOSITY="$VISCOSITY" PRESSURE="$PRESSURE" alt >/dev/null || exit 1
read -r -n 1 -p "Press any key to move endoh1.alt3 to endoh1.alt2: "
echo 1>&2
mv -v endoh1.alt3 endoh1.alt2
# clear screen before continuing
clear

# now that we have both binaries we can run each one on the data files, first
# the source file.
read -r -n 1 -p "Press any key to run: ./endoh1.alt < endoh1.alt.c 2>/dev/null: "
echo 1>&2
./endoh1.alt < endoh1.alt.c 2>/dev/null
echo 1>&2
# reset terminal sanity
reset
read -r -n 1 -p "Press any key to run: ./endoh1.alt2 < endoh1.alt.c 2>/dev/null: "
echo 1>&2
./endoh1.alt2 < endoh1.alt.c 2>/dev/null
# reset terminal sanity
reset

# for each of the supplied text files we will run both 'versions' on them, in
# succession, prompting the user for each text file so they know the name.
for i in clock.txt column.txt column2.txt column3.txt corners.txt \
    dripping-pan.txt evaporation.txt flat.txt fountain.txt funnel.txt \
    funnel2.txt funnel3.txt glass-half-empty.txt leidenfrost.txt logo.txt \
    pour-out.txt tanada.txt; do

    # to make it more 'fluid' :-) we only prompt once per file even though the
    # second command is a different file in that the gravity factor is set to I.
    read -r -n 1 -p "Press any key to run: ./endoh1.alt < $i: "
    clear
    ./endoh1.alt < "$i" 2>/dev/null
    clear
    ./endoh1.alt2 < "$i" 2>/dev/null
    # reset terminal sanity
    reset
done
