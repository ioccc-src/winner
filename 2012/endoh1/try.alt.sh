#!/usr/bin/env bash
#
# try.alt.sh - demonstrate IOCCC winner 2012/endoh1 alt code
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi


# unlike other try.sh/try.alt.sh scripts this one has two compiled binaries: one
# which sets the gravity factor to I and the other that does not.
make clobber CC="$CC" TIMER=10 GRAVITY=I SLEEP=39000 alt >/dev/null || exit 1
# we have to move the endoh1_color.alt to endoh1_color.alt3, not alt2, because
# we have to use make clobber which would wipe out endoh1_color.alt2.
mv endoh1_color.alt endoh1_color.alt3
make clobber CC="$CC" TIMER=10 SLEEP=39000 alt >/dev/null || exit 1
read -r -n 1 -p "Press any key run run slower fluid on endoh1_color.alt.c: "
mv endoh1_color.alt3 endoh1_color.alt2
# clear screen before continuing
clear


# now that we have both binaries we can run each one on the data files, first
# the source file.
./endoh1_color.alt < endoh1_color.alt.c 2>/dev/null
./endoh1_color.alt2 < endoh1_color.alt.c 2>/dev/null
clear

# for each of the supplied text files we will run both 'versions' on them, in
# succession, prompting the user for each text file so they know the name.
for i in clock.txt column.txt column2.txt column3.txt corners.txt \
    dripping-pan.txt evaporation.txt flat.txt fountain.txt funnel.txt \
    funnel2.txt funnel3.txt glass-half-empty.txt leidenfrost.txt logo.txt \
    pour-out.txt tanada.txt; do

    # to make it more 'fluid' :-) we only prompt once per file even though the
    # second command is a different file in that the gravity factor is set to I.
    read -r -n 1 -p "Press any key to run: ./endoh1_color.alt < $i: "
    ./endoh1_color.alt < "$i" 2>/dev/null
    clear
    ./endoh1_color.alt2 < "$i" 2>/dev/null
    clear
done
