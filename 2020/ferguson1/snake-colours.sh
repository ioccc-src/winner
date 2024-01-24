#!/usr/bin/env bash
#
# Snake script that prompts for the colours desired for the colours for the
# walls, the head and body of the snake and the bug, and then proceeds to
# compile Snake with that profile and then start the game. If there's an input
# error it uses the default colour for the specific item.
#
# I don't disable any colours in the script even those that will probably be
# hard to see; interestingly although maybe not as easy to see black on black is
# not impossible to see. It's more like a grey on black. White background will
# probably be a problem but then again maybe not.
#
# Usage:
#
#   [VAR=VAL ...] ./snake-colours
#
# Examples:
#
#   WALLS=0 ./snake-colours
#   ./snake-colours
#
# Why did I choose the colours I did? Because there are snakes with red heads
# and although the one I am aware of has a blue body it's easier to see (for my
# eyes at least) the green. At first I had red bugs but I thought white is
# easier to see and the red head with a green body also easier to see.
# Unfortunately blue on black doesn't turn out so great and the cyan for the
# snake body with a different colour for the wall didn't quite do it for me. But
# I explain how you can change these anyway. Anyway I love redheads and the
# snake in question Red-headed krait
# (https://en.wikipedia.org/wiki/Red-headed_krait) is stunningly beautiful too.
#
# Last updated: 13 May 2020
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
DFLT[6]="-DBG=COLOR_WHITE"	#  Bug foreground: white    (BG)
DFLT[7]="-DBB=COLOR_BLACK"	#  Bug background: black    (BB)
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

make

./termcaps
T="${?}"
if [[ "${T}" -ne 0 ]]; then
    read -rp  "Terminal issues detected; do you wish to continue anyway (Y/N) ? " ans
    [[ "${ans}" != "y" ]] && [[ "${ans}" != "Y" ]] && exit 1
fi

configure_colours

clear && ./prog.alt
