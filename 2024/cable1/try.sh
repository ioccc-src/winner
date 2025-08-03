#!/usr/bin/env bash
#
# try.sh - demonstrate 2024/cable1

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# clear the screen
#
clear

# Verify we have the model
#
if [[ ! -s model ]]; then
    echo 'ERROR: model not found!' 1>&2
    echo 1>&2
    echo 'You must successfully run ./get_model.sh and download the model to run this program.' 1>&2
    echo 1>&2
    exit 1
fi

# make sure the program has been built
#
read -r -n 1 -p "Press any key to when ready: "
echo 1>&2
MAKE=$(which gmake)
${MAKE:=make} CC="$CC" all >/dev/null || exit 1

# select a game
#
export SELECT=""
while [[ -z $SELECT ]]; do

    export NAME=""
    export Z3=""
    export SAVE=""
    echo 1>&2
    echo 'Select a personality (if in doubt try 0):' 1>&2
    echo 1>&2
    echo '    0    prog - Common ChatIOCCC' 1<&2
    echo '    1    linux - As an imaginary Linux-based compiler' 1>&2
    echo '    2    eeyore - The old grey donkey from the Winnie-the-Pooh books' 1>&2
    echo '    3    rainman - In the style of Raymond, from the movie "Rain Man"' 1>&2
    echo '    4    snoop - Attempts to answer in the style of Snoop Dogg' 1>&2
    echo 1>&2
    echo '    q    Quit without running a personality' 1>&2
    echo 1>&2
    read -r -n 1 -p "Enter your selection: " SELECT
    echo 1>&2
    echo 1>&2

    # validate prompt
    #
    case "$SELECT" in
    0) NAME="prog" ;;
    1) NAME="linux" ;;
    2) NAME="eeyore" ;;
    3) NAME="rainman" ;;
    4) NAME="snoop" ;;
    q) exit 0 ;;
    Q) exit 0 ;;
    *) echo 'ERROR: invalid selection, try again' 1>&2
       SELECT=""    # ask for a different selection
       continue ;;
    esac
    export PROG="./$NAME"

    # See if we can compile an openmp version
    #
    if [[ ! -x ${NAME}_openmp ]]; then
	make CC="$CC" "${NAME}_openmp" >/dev/null 2>&1 < /dev/null
    fi
    if [[ -x ${NAME}_openmp ]]; then
	# we have an openmp version, so use it
	#
	PROG="./${NAME}_openmp"
    fi
done

# try the program
#
echo 'NOTE: Please be patient.  This is not the fastest LLM agent.' 1>&2
echo 1>&2
echo 'NOTE: To exit, press CTRL+C' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: $PROG: "
echo 1>&2
echo 1>&2
"$PROG"
echo 1>&2
