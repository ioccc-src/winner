#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/endoh1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
if [[ -z "$CC" ]]; then
    CC="cc"
fi


# make sure the program has been built
#
MAKE=$(command -v gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1


# clear the screen
#
clear


# determine of make support -j2
#
make -j 2 prog.c >/dev/null 2>&1 < /dev/null
status="$?"
if [[ $status -ne 0 ]]; then
    JOBS="1"
    echo "NOTE: make dues not support -j 2, so make out.ppm will only use a single CPU job." 1>&2

else
    # determine how parallel we want to make
    #
    export RESERVE="-2"	# our best guess is to oversubscribing by 2 cores
    if [[ $RESERVE -lt 0 ]]; then
	echo "NOTE: We will oversubscribe by $((-RESERVE)) CPU cores." 1>&2
    else
	echo "NOTE: We will reserve $RESERVE CPU cores." 1>&2
    fi
    NPROC_TOOL=$(type -P nproc)
    export RESERVE NPROC_TOOL NPROC JOBS SIZE
    if [[ -z "$NPROC_TOOL" ]]; then
	NPROC="4"	    # we lack nproc so we just guess
	echo "NOTE: The nproc utility was not found so we simply guess you have $NPROC CPU cores." 1>&2
    else
	NPROC=$(nproc)
	echo "NOTE: The nproc utility found $NPROC CPU cores." 1>&2
    fi
    ((JOBS=NPROC-RESERVE))
    if [[ $JOBS -ge 2 ]]; then
	echo "NOTE: We will make out.ppm using $JOBS parallel make jobs." 1>&2
    else
	JOBS="1"
	echo "NOTE: We will make out.ppm using just a single CPU." 1>&2
    fi
fi
echo 1>&2


# build an 8x8 image
#
SIZE="8"
echo "NOTE: This next step will take a bit (about 75 seconds on a single CPU core) to build the ${SIZE}x${SIZE} image." 1>&2
if [[ $JOBS -ge 2 ]]; then
    echo 1>&2
    echo "NOTE: With $JOBS make jobs in parallel your time will be less." 1>&2
    echo "NOTE: For example, with 6 jobs in parallel, this might complete in about 20 seconds" 1>&2
fi
echo 1>&2
read -r -n 1 -p "Press any key to build an ${SIZE}x${SIZE} image: " 1>&2
echo 1>&2
rm -f "$SIZE.ppm"
rm -rf pixel
if [[ $JOBS -ge 2 ]]; then
    time make -j "$JOBS" out.ppm H="$SIZE" W="$SIZE"
else
    time make out.ppm H="$SIZE" W="$SIZE"
fi
mv -f -v out.ppm "$SIZE.ppm"
echo 1>&2
echo "Now open $SIZE.ppm in a graphics viewer in a separate window." 1>&2
echo 1>&2
echo 'NOTE: You may have to magnify it to see it: do not worry: better images will be created in the next steps.' 1>&2
echo 1>&2


# build a 32x32 image
#
SIZE="32"
echo "NOTE: This next step will take a while (about 20 minutes using a single CPU core) to build the ${SIZE}x${SIZE} image." 1>&2
if [[ $JOBS -ge 2 ]]; then
    echo 1>&2
    echo "NOTE: With $JOBS make jobs in parallel your time will be less." 1>&2
    echo "NOTE: For example, with 6 jobs in parallel, this might complete in about 5.5 minutes" 1>&2
fi
echo 1>&2
echo 'NOTE: The files, ref.32.png, ref.128.png, and ref.512.png, contains a copies of what the next 3 steps will produce,' 1>&2
echo 'NOTE: in case you wish to abort.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to build an ${SIZE}x${SIZE} image: " 1>&2
echo 1>&2
rm -f "$SIZE.ppm"
rm -rf pixel
if [[ $JOBS -ge 2 ]]; then
    time make -j "$JOBS" out.ppm H="$SIZE" W="$SIZE"
else
    time make out.ppm H="$SIZE" W="$SIZE"
fi
mv -f -v out.ppm "$SIZE.ppm"
echo 1>&2
echo "Now open $SIZE.ppm in a graphics viewer in a separate window." 1>&2
echo 1>&2
echo 'NOTE: For an even better images, complete the next 2 steps.' 1>&2
echo 1>&2


# build a 128x128 image
#
SIZE="128"
echo "NOTE: This next step will take LONG TIME (about of 5.5 hours on 1 CPU core) to build the ${SIZE}x${SIZE} image!" 1>&2
if [[ $JOBS -ge 2 ]]; then
    echo 1>&2
    echo "NOTE: With $JOBS make jobs in parallel your time will be less." 1>&2
    echo "NOTE: For example, with 6 jobs in parallel, this might complete in about 1.5 hours" 1>&2
fi
echo 1>&2
echo 'NOTE: The files, ref.128.png, and ref.512.png, contains a copies of what the next 2 steps will produce,' 1>&2
echo 'NOTE: in case you wish to abort.' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to build an ${SIZE}x${SIZE} image: " 1>&2
echo 1>&2
rm -f "$SIZE.ppm"
rm -rf pixel
if [[ $JOBS -ge 2 ]]; then
    time make -j "$JOBS" out.ppm H="$SIZE" W="$SIZE"
else
    time make out.ppm H="$SIZE" W="$SIZE"
fi
mv -f -v out.ppm "$SIZE.ppm"
echo 1>&2
echo "Now open $SIZE.ppm in a graphics viewer in a separate window." 1>&2
echo 1>&2

# build a 512x512 image
#
SIZE="512"
echo "NOTE: This next step will take VERY LONG TIME (on the order of 3.5 days using just 1 core) to build the ${SIZE}x${SIZE} image!!!" 1>&2
if [[ $JOBS -ge 2 ]]; then
    echo 1>&2
    echo "NOTE: With $JOBS make jobs in parallel your time will be less." 1>&2
    echo "NOTE: For example, with 6 jobs in parallel, this might complete in about 23.5 hours" 1>&2
fi
echo 1>&2
read -r -n 1 -p "Press any key to build an ${SIZE}x${SIZE} image: " 1>&2
echo 1>&2
rm -f "$SIZE.ppm"
rm -rf pixel
if [[ $JOBS -ge 2 ]]; then
    time make -j "$JOBS" out.ppm H="$SIZE" W="$SIZE"
else
    time make out.ppm H="$SIZE" W="$SIZE"
fi
mv -f -v out.ppm "$SIZE.ppm"
echo 1>&2
echo "Now open $SIZE.ppm in a graphics viewer in a separate window." 1>&2
echo 1>&2

# All Done !!! -- Jessica Noll, Age 2
#
exit 0
