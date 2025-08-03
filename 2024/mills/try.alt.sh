#!/usr/bin/env bash
#
# try.alt.sh - demonstrate alternate 2024/mills

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

# admire the source
#
read -r -n 1 -p "Press any key to admire the source code: "
echo 1>&2
echo 1>&2
cat prog.alt.c 1>&2
echo 1>&2

# select a game
#
read -r -n 1 -p "Press any key to when ready: "
export SELECT=""
while [[ -z $SELECT ]]; do

    export NAME=""
    export Z3=""
    export SAVE=""
    echo 1>&2
    echo 'Select a game (if in doubt try 0 or 1 first):' 1>&2
    echo 1>&2
    echo '    0    minizork - Demo version of the original Zork' 1<&2
    echo '    1    advent - Colossal Cave Adventure' 1>&2
    echo '    2    curses - Hunting about in the attic of your family home' 1>&2
    echo '    3    fantasydimension - Fantasy world adventure via an enigmatic airlock' 1>&2
    echo '    4    moonglow - Spacecraft lands in a nearby corn field' 1>&2
    echo '    5    submarine-sabotage - Serving aboard top-secret Puny class submarine' 1>&2
    echo '    6    tristam - Surviving on Tristam island after a crash' 1>&2
    echo '    7    sampler1_R55 - 1984 Infocom interactive fiction tutorial with 4 game samples' 1>&2
    echo '    8    sampler2 - 1997 Infocom interactive fiction tutorial with 3 game samples' 1>&2
    echo '    9    ((Enter a z3 filename))' 1>&2
    # *.z3
    echo 1>&2
    echo '         NOTE: For 9: Search and download a .z3 file from: https://ifdb.org/#games' 1>&2
    echo '               After entering 9, give the path to the .z3 file you downloaded.' 1>&2
    echo 1>&2
    echo '    q    Quit without running a game' 1>&2
    echo 1>&2
    read -r -n 1 -p "Enter your selection: " SELECT
    echo 1>&2
    echo 1>&2

    # validate prompt
    #
    case "$SELECT" in
    0) NAME="minizork" ;;
    1) NAME="advent" ;;
    2) NAME="curses-r10" ;;
    3) NAME="fantasydimension" ;;
    4) NAME="submarine-sabotage" ;;
    5) NAME="moonglow" ;;
    6) NAME="tristam" ;;
    7) NAME="sampler1_R55" ;;
    8) NAME="sampler2" ;;
    9) NAME="//tbd//" ;;
    q) exit 0 ;;
    Q) exit 0 ;;
    *) echo 'ERROR: invalid selection, try again' 1>&2
       SELECT=""    # ask for a different selection
       continue ;;
    esac

    # case: enter z3 file path
    #
    if [[ $NAME == "//tbd//" ]]; then

	read -r -p "Enter path to a z3 file: " Z3
	echo 1>&2
	echo 1>&2
	NAME=$(basename "$Z3" .z3)
	SAVE="$NAME.sav"

    # else: form save filename and Z3 filename
    #
    else
	Z3="$NAME.z3"
	SAVE="$NAME.sav"
    fi

    # Z3 file must be a readable non-empty z3 file
    #
    if [[ ! -e $Z3 ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: z3 file does not exist: $Z3" 1>&2
	echo 1>&2
	continue
    fi
    if [[ ! -f $Z3 ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: z3 is not a file: $Z3" 1>&2
	echo 1>&2
	continue
    fi
    if [[ ! -r $Z3 ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: z3 is not a readable file: $Z3" 1>&2
	echo 1>&2
	continue
    fi
    if [[ ! -s $Z3 ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: z3 is not a non-empty readable file: $Z3" 1>&2
	echo 1>&2
	continue
    fi

    # SAVE must be a writable file
    #
    if [[ ! -e $SAVE ]]; then
	touch "$SAVE"
	select="$?"
	if [[ $select -ne 0 || ! -f $SAVE ]]; then
	    SELECT=""	# ask for a different selection
	    echo "ERROR: cannot create save file: $SAVE" 1>&2
	    echo 1>&2
	    continue
	fi
    fi
    if [[ ! -f $SAVE ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: save is not a file: $SAVE" 1>&2
	echo 1>&2
	continue
    fi
    if [[ ! -w $SAVE ]]; then
	SELECT=""   # ask for a different selection
	echo "ERROR: z3 is not a writble file: $SAVE" 1>&2
	echo 1>&2
	continue
    fi
done

# run the game
#
echo 'Please note these general commands:' 1>&2
echo 1>&2
echo '    quit      exit the game (be sure to save first!)' 1>&2
echo '    save      save game state to file (2nd arg)' 1>&2
echo '    restore   restore game state from file (2nd arg)' 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run ./prog.alt $Z3 $SAVE: "
clear
./prog.alt "$Z3" "$SAVE"
echo 1>&2
