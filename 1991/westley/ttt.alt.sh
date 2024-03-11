#!/usr/bin/env bash
#
# play tic-tac-toe

# parse args
#

export USAGE="usage: $0 [-h] [-e] <command>
	-h  show this help and exit
	-e  show compiler stdout

	commands:
	    ./ttt.alt [move_digit]	    play a place
	    ./ttt.alt quitgame	    quit the game
	    ./ttt.alt clobber	    clean the state of the game
"

export E_FLAG=
while getopts :he flag; do
    case "$flag" in
    h)	echo "$USAGE" 1>&2
	exit 2
	;;
    e)	E_FLAG="1"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	exit 3
	;;
    :)	echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	exit 3
	;;
   *)
	;;
    esac
done

# check args
#
shift $(( OPTIND - 1 ));
if [[ $# -gt 1 ]]; then
    echo "$USAGE" 1>&2
    exit 1
elif [[ $# -eq 1 ]]; then
    move="$1"
else
    move=
fi

# catch the clobber case
#
if [[ clobber = "$move" ]]; then
    echo "ttt.alt: rm -f ttt.alt_game ttt.alt_game.o ttt.alt_game.c ttt.alt_old.c ttt.alt_new.c" 1>&2
    rm -f ttt.alt_game ttt.alt_game.o ttt.alt_game.c ttt.alt_old.c ttt.alt_new.c
    echo "ttt.alt: rm -f merlyn.alt.c merlyn.o merlyn" 1>&2
    rm -f merlyn.alt.c merlyn.o merlyn
    echo "ttt.alt: removed all but the original source" 1>&2
    exit 0
fi

# catch the quitgame case
#
if [[ quitgame = "$move" ]]; then
    echo "ttt.alt: rm -f ttt.alt_game ttt.alt_game.o ttt.alt_game.c ttt.alt_old.c ttt.alt_new.c" 1>&2
    rm -f ttt.alt_game ttt.alt_game.o ttt.alt_game.c ttt.alt_old.c ttt.alt_new.c
    echo "ttt.alt: current game removed, perhaps you were going to lose? :-)" 1>&2
    exit 0
fi

# watch for bad args
#
if [[ $# -eq 1 ]]; then
    case "$move" in
    1|2|3|4|5|6|7|8|9) ;;
    *)  echo "ttt.alt: bad argument" 1>&2
	echo "usage: ./ttt.alt [move_digit]" 1>&2
	echo "       ./ttt.alt quitgame" 1>&2
	echo "       ./ttt.alt clobber" 1>&2
	exit 2 ;;
    esac
fi

# be sure that we have the merlyn.alt.c source
#
if [[ ! -f merlyn.alt.c ]]; then
    if [[ -f westley.alt.c ]]; then
	echo "ttt.alt: No merlyn.alt.c around these parts, using a copy of westley.alt.c" 1>&2
	cp westley.alt.c merlyn.alt.c
	chmod +w merlyn.alt.c
    else
	echo "ttt.alt: Ouch!  merlyn.alt.c and no westley.alt.c are gone!" 1>&2
	exit 3
    fi
    # check to see if the copy worked
    if [[ ! -f merlyn.alt.c ]]; then
	echo "ttt.alt: Darn, couldn't copy westley.alt.c to merlyn.alt.c" 1>&2
	exit 4
    fi
fi

# be sure we have the merlyn program
#
if [[ ! -f merlyn ]]; then
    export status=0
    if [[ -n $E_FLAG ]]; then
	echo "ttt.alt: make merlyn" 1>&2
	make merlyn
	status=$?
    else
	make merlyn 2>/dev/null
	status=$?
    fi
    if [[ "$status" -ne 0 ]]; then
	echo "ttt.alt: something is wrong, fix merlyn.alt.c and build it yourself!" 1>&2
	echo "     or maybe type:  ./ttt.alt clobber" 1>&2
	exit 5
    fi
    rm -f ttt.alt_game.c
fi

# If we don't have a ttt.alt_game.c, or we cannot write it, make a new ttt.alt_game.c
#
if [[ ! -w ttt.alt_game.c ]]; then
    rm -f ttt.alt_game.c 
    if [[ -z "$move" ]]; then
	./merlyn | tee ttt.alt_game.c
    else
	./merlyn "$move" | tee ttt.alt_game.c
    fi
    chmod +w ttt.alt_game.c

# If we have a ttt.alt_game.c, then assume that we are in the process of playing
#
else
    rm -f ttt.alt_game ttt.alt_new.c
    export status=0
    if [[ -n $E_FLAG ]]; then
	echo "ttt.alt: make ttt.alt_game" 1>&2
	make ttt.alt_game
	status=$?
    else
	make ttt.alt_game 2>/dev/null
	status=$?
    fi
    if [[ "$status" -ne 0 ]]; then
	echo "ttt.alt: something is wrong, fix ttt.alt_game.c and build it yourself!" 1>&2
	echo "     or maybe type:  ./ttt.alt quitgame" 1>&2
	exit 6
    fi
    if [[ -z "$move" ]]; then
	./ttt.alt_game | tee ttt.alt_new.c
    else
	./ttt.alt_game "$move" | tee ttt.alt_new.c
    fi
    chmod +w ttt.alt_new.c
    if [[ -s ttt.alt_new.c ]]; then
	mv ttt.alt_game.c ttt.alt_old.c
	mv ttt.alt_new.c ttt.alt_game.c

# Check for win, lose, or draw
# For a win or draw, copy merlyn.alt.c to ttt.alt_game.c
# For a loss, copy ttt.alt_game.c to merlyn.alt.c, as it is now better
# Also remove the executable for the file replaced
# For anything else, game in progress, do not do anything

	# SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
	# https://www.shellcheck.net/wiki/SC2006
	# shellcheck disable=SC2006
	if [[ -n "`grep ':-(' ttt.alt_game.c`" ]]; then
	    echo
	    echo "ttt.alt: I lose...I won't make THAT mistake again!"
	    chmod +w merlyn.alt.c
	    mv ttt.alt_game.c merlyn.alt.c
	    rm -f merlyn ttt.alt_game
	else
	    # SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
	    # https://www.shellcheck.net/wiki/SC2006
	    # shellcheck disable=SC2006
	    if [[ -n "`grep ':-)' ttt.alt_game.c`" ]]; then
		echo
		echo "ttt.alt: I win!"
		cp merlyn.alt.c ttt.alt_game.c
		rm -f ttt.alt_game
	    else
		# SC2006 (style): Use $(...) notation instead of legacy backticks `...`.
		# https://www.shellcheck.net/wiki/SC2006
		# shellcheck disable=SC2006
		if [[ -z "`grep 'X=-. ' ttt.alt_game.c`" && -z "`grep '^. ' ttt.alt_game.c`" ]]; then
		    echo
		    echo "ttt.alt: It's a draw - play again?"
		    cp merlyn.alt.c ttt.alt_game.c
		    rm -f ttt.alt_game
		fi
	    fi
	fi

    else
	echo "ttt.alt: something is wrong, maybe ttt.alt_old.c will help" 1>&2
	echo "     or maybe type:  ./ttt.alt quitgame" 1>&2
	echo "     or maybe type:  ./ttt.alt clobber" 1>&2
	exit 7
    fi
fi

