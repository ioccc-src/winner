#!/usr/bin/env bash
#
# SCRIPT TO PLAY PRESET GAMEPLAY MODES
#
# The easiest way to see what this script does is to simply run it; however you
# can pass in variables but depending on what mode you select it might be
# overridden so that the variable you pass in doesn't take effect. You can of
# course modify this script otherwise.
#
# This script first runs make and then termcaps (the terminal capability test
# utility); if any problems are detected it prompts if you wish to proceed.
# Assuming no problems or you proceed anyway it then asks you if you want to
# configure the colours of the walls, snake head and body as well as the bug.
# Then it gives you a menu of gameplay modes.
#
# Let's say you want to enable cannibalism but don't want to be able to go
# through walls in hypnotic mode. Just type:
#
#	CANNIBAL=1 WALLS=0 ./play.sh
#
# And you would then choose mode 5.
#
# This script could be further improved to prompt the different variables but
# that would complicate it much further and I'm not sure what should be done
# about variables that would cancel the mode requested.
#
# As for drawing mode what if you don't want to ever end up 'winning'? In this
# case you'll probably want to set the initial size to be rather high and growth
# to 0. You could also play with the idea of setting a growth value but setting
# negative shedding (or the other way round). For example:
#
#	SIZE=400 SHED=100 SHEDS=-5 ./play.sh
#
# This is actually option 1 since this seemed like a good addition to the script
# (added 16 August 2020). This will start you at 400 and every 100 movements you
# would lose 5 in length; when you eat a bug you would grow by 5 (default).
#
# BTW: did you know that some people believe in snake human hybrids? It's true! See
# http://www.macroevolution.net/snake-human-hybrids.html and have a laugh, shock
# or an exercise in sibilance!
#
# Last updated: 01 March 2024
#
COLOUR[0]="BLACK"
COLOUR[1]="RED"
COLOUR[2]="GREEN"
COLOUR[3]="YELLOW"
COLOUR[4]="BLUE"
COLOUR[5]="MAGENTA"
COLOUR[6]="CYAN"
COLOUR[7]="WHITE"
DFLT[0]="-DWALL=COLOR_CYAN"	# Wall foreground: cyan	    (WALL)
DFLT[1]="-DWB=COLOR_BLACK"	# Wall background: black    (WB)
DFLT[2]="-DHEAD=COLOR_RED"	# Head foreground: red	    (HEAD)
DFLT[3]="-DHB=COLOR_BLACK"	# Head background: black    (HB)
DFLT[4]="-DBODY=COLOR_GREEN"	# Body foreground: green    (BODY)
DFLT[5]="-DBS=COLOR_BLACK"	# Body background: black    (BS)
DFLT[6]="-DBG=COLOR_WHITE"	# Bug foreground: white    (BG)
DFLT[7]="-DBB=COLOR_BLACK"	# Bug background: black    (BB)
COLOURS[0]="-DWALL=COLOR_"
COLOURS[1]="-DWB=COLOR_"
COLOURS[2]="-DHEAD=COLOR_"
COLOURS[3]="-DHB=COLOR_"
COLOURS[4]="-DBODY=COLOR_"
COLOURS[5]="-DBS=COLOR_"
COLOURS[6]="-DBG=COLOR_"
COLOURS[7]="-DBB=COLOR_"

function show_colours()
{
    echo "Colour selection for ${*} (enter for default)"
    for i in 0 1 2 3 4 5 6 7; do
	printf "(%d) %s\n" "${i}" "${COLOUR[${i}]}"
    done
    read -rp "Make selection (1 - 7): " colour

    case "${colour}" in
	0|1|2|3|4|5|6|7)
	    return "${colour}"
	    ;;
	*)
	    return 255
	    ;;
    esac
}
function configure_colours()
{
    j=0
    for i in "WALL" "WALL (BACKGROUND)" "HEAD" "HEAD (BACKGROUND)" "BODY" "BODY (BACKGROUND)" "BUG" "BUG (BACKGROUND)"; do
	show_colours "${i}"
	x="${?}"
	if [[ "${x}" != 255 ]]; then
	    COLOURS[j]="${COLOURS[$j]}${COLOUR[$x]}"
	else
	    COLOURS[j]=${DFLT[$j]}
	fi
	j=$j+1
    done

    echo cc -o prog.alt prog.alt.c -D'f(a,b)'='((a)<(b)?(a):(b))' "${COLOURS[0]}" "${COLOURS[1]}" \
	"${COLOURS[2]}" "${COLOURS[3]}" "${COLOURS[4]}" "${COLOURS[5]}" "${COLOURS[6]}" "${COLOURS[7]}" -lncurses

    cc -o prog.alt prog.alt.c -D'f(a,b)'='((a)<(b)?(a):(b))' "${COLOURS[0]}" "${COLOURS[1]}" \
	"${COLOURS[2]}" "${COLOURS[3]}" "${COLOURS[4]}" "${COLOURS[5]}" "${COLOURS[6]}" "${COLOURS[7]}" -lncurses || exit 1

}
function just_compile()
{
    echo cc -o prog.alt prog.alt.c -D'f(a,b)'='((a)<(b)?(a):(b))' "${DFLT[0]}" "${DFLT[1]}" \
	"${DFLT[2]}" "${DFLT[3]}" "${DFLT[4]}" "${DFLT[5]}" "${DFLT[6]}" "${DFLT[7]}" -lncurses

    cc -o prog.alt prog.alt.c -D'f(a,b)'='((a)<(b)?(a):(b))' "${DFLT[0]}" "${DFLT[1]}" \
	"${DFLT[2]}" "${DFLT[3]}" "${DFLT[4]}" "${DFLT[5]}" "${DFLT[6]}" "${DFLT[7]}" -lncurses || exit 1
}
function testcaps()
{
    make || exit 1
    ./termcaps
    T="${?}"
    if [[ "${T}" -ne 0 ]]; then
	read -rp  "Terminal issues detected; do you wish to continue anyway (Y/N) ? " ans
	[[ "${ans}" != "y" ]] && [[ "${ans}" != "Y" ]] && exit 1
    fi
}
function menu()
{
    echo
    printf "** GAME MODE SELECTION MENU **\n\n"

    echo "(0)  Drawing mode"
    echo "(1)  Drawing mode #2 (start at 400 and shrink by 5 every 100 moves)"
    echo "(2)  Computer plays by itself (EPILEPSY / STIMULATION OVERLOAD TRIGGER)"
    echo "(3)  Computer plays by itself #2 (EPILEPSY / STIMULATION OVERLOAD TRIGGER)"
    echo "(4)  Grow / Shrink mode"
    echo "(5)  Grow / Shrink mode #2"
    echo "(6)  Hypnotic mode (EPILEPSY / STIMULATION OVERLOAD TRIGGER)"
    echo "(7)  Stimulation / Calming mode"
    echo "(8)  Normal mode (aka Judges' Normal)"
    echo "(9)  100ms w/o cheat modes (Judges' Zeroth)"
    echo "(10) 75ms w/both cheat modes (Judges' First)"
    echo "(11) Immediately win (Judges' Second)"
    echo "(12) 50ms w/both cheat modes, evade at 200 moves (Judges' Third)"
    echo "(13) 75ms w/both cheat modes, shrink mode (win with six bugs) (Judges' Fourth)"
    echo "(14) Let computer win by itself very quickly (Judges' Fifth)"
    echo "(15) Start at 400, shrink by 5 every 100 moves, cannibalism, max size possible"
    echo "(16) Start at 400, shrink by 5 every 100 moves, max size possible"
    echo ""
}
PROG="./prog.alt"
function judges0()
{
    clear && WAIT=100 WALLS=0 CANNIBAL=0 ${PROG}
}
function judges1()
{
    clear && WAIT=75 WALLS=1 CANNIBAL=1 ${PROG}
}
function judges2()
{
    clear && SIZE=-1 ${PROG}
}
function judges3()
{
    clear && CANNIBAL=1 WALLS=1 WAIT=50 EVADE=200 ${PROG}
}
function judges4()
{
    clear && WAIT=75 GROW=-1 SIZE=5 CANNIBAL=1 ${PROG}
}
function judges5()
{
    clear && CANNIBAL=1 WALLS=1 WAIT=0 EVADE=1 MAXSIZE=10 ${PROG}
}
function draw0()
{
    clear && MAXSIZE=-1 WAIT=-1 CANNIBAL=1 ${PROG}
}
function draw1()
{
    clear && MAXSIZE=-1 WAIT=-1 CANNIBAL=1 SIZE=400 SHED=100 SHEDS=-5 ${PROG}
}
function growshrink3()
{
    clear && MAXSIZE=-1 CANNIBAL=1 SIZE=400 SHED=100 SHEDS=-5 ${PROG}
}
function growshrink4()
{
    clear && MAXSIZE=-1 SIZE=400 SHED=100 SHEDS=-5 ${PROG}
}
function auto0()
{
    clear && WAIT=0 EVADE=1 CANNIBAL=1 MAXSIZE=20 ${PROG}
}
function auto1()
{
    clear && WAIT=0 EVADE=1 GROW=-1 SIZE=9 MAXSIZE=10 CANNIBAL=1 ${PROG}
}
function growshrink0()
{
    clear && SIZE=150 SHEDS=-5 GROW=10 SHED=50 MAXSIZE=250 ${PROG}
}
function growshrink1()
{
    clear && SIZE=100 SHEDS=5 GROW=-10 SHED=50 MAXSIZE=250 ${PROG}
}
function hypno()
{
    clear && EVADE=1 CANNIBAL=1 ${PROG}
}
function stim()
{
    clear && GROW=0 CANNIBAL=1 ${PROG}
}
function norm()
{
    clear && ${PROG}
}
function play()
{
    testcaps

    read -rp "Do you want to configure colours (Y/N) ? " colours

    case "${colours}" in
	y|Y)
	    configure_colours
	    ;;
	*)
	    just_compile
	    ;;
    esac


    while true; do
	menu
	read -rp "Make your selection (0 - 16 or any other key to exit): " mode

	case "${mode}" in
	    0)  # Drawing mode 0
		draw0
		;;
	    1)  # Drawing mode 1
		draw1
		;;
	    2)  # Automatic mode (computer plays by itself) (photosensitive epilepsy/stimulation overload trigger)
		auto0
		;;
	    3)  # Automatic mode variation 0 (photosensitive epilepsy/stimulation overload trigger)
		auto1
		;;
	    4)  # grow shrink mode
		growshrink0
		;;
	    5)  # grow shrink mode variation 0
		growshrink1
		;;
	    6)  # hypnotic mode (photosensitive epilepsy/stimulation overload trigger)
		hypno
		;;
	    7)  # stimulation / calming mode
		stim
		;;
	    8)  # normal mode (aka Judges' Normal)
		norm
		;;
	    9)  # 100ms w/o cheat modes (Judges' Zeroth)
		judges0
		;;
	    10) # 75ms w/both cheat modes (Judges' First)
		judges1
		;;
	    11) # Immediately win (Judges' Second)
		judges2
		;;
	    12) # 50ms w/both cheat modes, evade at 200 moves (Judges' Third)
		judges3
		;;
	    13) # 75ms w/both cheat modes, shrink mode (win with six bugs) (Judges' Fourth)
		judges4
		;;
	    14) # Let computer win by itself very quickly (Judges' Fifth)
		judges5
		;;
	    15) # Start at 400, shrink by 5 every 100 moves, cannibalism and max size possible
		growshrink3
		;;
	    16) # Start at 400, shrink by 5 every 100 moves and max size possible
		growshrink4
		;;
	    *)
		exit 0
	esac
	read -rp "Do you want to continue? " ans

	if [[ "$ans" != "y" && "$ans" != "Y" ]]; then
	    break;
	fi
    done
}
play
