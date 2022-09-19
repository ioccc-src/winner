#!/bin/sh
#
# play tic-tac-toe

# parse args
#
if [ $# -gt 1 ]; then
    echo "usage: ttt [move_digit]" 1>&2
    echo "       ttt quitgame" 1>&2
    echo "       ttt clobber" 1>&2
    exit 1
elif [ $# -eq 1 ]; then
    move="$1"
else
    move=
fi

# catch the clobber case
#
if [ clobber = "$move" ]; then
    echo "ttt: rm -f ttt_game ttt_game.o ttt_game.c ttt_old.c ttt_new.c" 1>&2
    rm -f ttt_game ttt_game.o ttt_game.c ttt_old.c ttt_new.c
    echo "ttt: rm -f merlyn.c merlyn.o merlyn" 1>&2
    rm -f merlyn.c merlyn.o merlyn
    echo "ttt: removed all but the original source" 1>&2
    exit 0
fi

# catch the quitgame case
#
if [ quitgame = "$move" ]; then
    echo "ttt: rm -f ttt_game ttt_game.o ttt_game.c ttt_old.c ttt_new.c" 1>&2
    rm -f ttt_game ttt_game.o ttt_game.c ttt_old.c ttt_new.c
    echo "ttt: current game removed, perhaps you were going to lose? :-)" 1>&2
    exit 0
fi

# watch for bad args
#
if [ $# -eq 1 ]; then
    case "$move" in
    1|2|3|4|5|6|7|8|9) ;;
    *)  echo "ttt: bad argument" 1>&2
	echo "usage: ttt [move_digit]" 1>&2
	echo "       ttt quitgame" 1>&2
	echo "       ttt clobber" 1>&2
	exit 2 ;;
    esac
fi

# be sure that we have the merlyn.c source
#
if [ ! -f merlyn.c ]; then
    if [ -f westley.c ]; then
	echo "ttt: No merlyn.c around these parts, using a copy of westley.c" 1>&2
	cp westley.c merlyn.c
	chmod +w merlyn.c
    else
	echo "ttt: Ouch!  merlyn.c and no westley.c are gone!" 1>&2
	exit 3
    fi
    # check to see if the copy worked
    if [ ! -f merlyn.c ]; then
	echo "ttt: Darn, coundn't copy westley.c to merlyn.c" 1>&2
	exit 4
    fi
fi

# be sure we have the merlyn program
#
if [ ! -f merlyn ]; then
    echo "ttt: make merlyn" 1>&2
    make merlyn
    status=$?
    if [ "$status" -ne 0 ]; then
	echo "ttt: something is wrong, fix merlyn.c and build it yourself!" 1>&2
	echo "     or maybe type:  ttt clobber" 1>&2
	exit 5
    fi
    rm -f ttt_game.c
fi

# If we don't have a ttt_game.c, or we cannot write it, make a new ttt_game.c
#
if [ ! -w ttt_game.c ]; then
    rm -f ttt_game.c 
    if [ -z "$move" ]; then
	merlyn | tee ttt_game.c
    else
	merlyn "$move" | tee ttt_game.c
    fi
    chmod +w ttt_game.c

# If we have a ttt_game.c, then assume that we are in the process of playing
#
else
    rm -f ttt_game ttt_new.c
    echo "ttt: make ttt_game" 1>&2
    make ttt_game
    status=$?
    if [ "$status" -ne 0 ]; then
	echo "ttt: something is wrong, fix ttt_game.c and build it yourself!" 1>&2
	echo "     or maybe type:  ttt quitgame" 1>&2
	exit 6
    fi
    if [ -z "$move" ]; then
	ttt_game | tee ttt_new.c
    else
	ttt_game "$move" | tee ttt_new.c
    fi
    chmod +w ttt_new.c
    if [ -s ttt_new.c ]; then
	mv ttt_game.c ttt_old.c
	mv ttt_new.c ttt_game.c

# Check for win, lose, or draw
# For a win or draw, copy merlyn.c to ttt_game.c
# For a loss, copy ttt_game.c to merlyn.c, as it is now better
# Also remove the executable for the file replaced
# For anything else, game in progress, do not do anything

	if [ -n "`grep ':-(' ttt_game.c`" ]; then
	    echo
	    echo "ttt: I lose...I won't make THAT mistake again!"
	    chmod +w merlyn.c
	    mv ttt_game.c merlyn.c
	    rm -f merlyn ttt_game
	else
	    if [ -n "`grep ':-)' ttt_game.c`" ]; then
		echo
		echo "ttt: I win!"
		cp merlyn.c ttt_game.c
		rm -f ttt_game
	    else
		if [ -z "`grep 'X=-. ' ttt_game.c`" -a -z "`grep '^. ' ttt_game.c`" ]; then
		    echo
		    echo "ttt: It's a draw - play again?"
		    cp merlyn.c ttt_game.c
		    rm -f ttt_game
		fi
	    fi
	fi

    else
	echo "ttt: something is wrong, maybe ttt_old.c will help" 1>&2
	echo "     or maybe type:  ttt quitgame" 1>&2
	echo "     or maybe type:  ttt clobber" 1>&2
	exit 7
    fi
fi

