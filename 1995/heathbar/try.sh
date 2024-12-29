#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC entry 1995/heathbar
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

heathbar()
{
    if [[ "$#" -ne 2 ]]; then
	echo "$0: heathbar() expects two args, got $#" 1>&2
	return
    elif [[ "$1" -lt 0 || "$2" -lt 0 ]]; then
	echo "$0: heathbar() expects two positive digits, got $1 $2" 1>&2
	return
    fi

    read -r -n 1 -p "Press any key to run: ./heathbar $1 $2: "
    echo 1>&2
    ./heathbar "$1" "$2"
    echo 1>&2

    read -r -n 1 -p "Press any key to run: echo \$(($1 + $2)): "
    echo 1>&2
    echo "$(("$1" + "$2"))"
    echo 1>&2

    if [[ $(("$1"+"$2")) == "$(./heathbar "$1" "$2")" ]]; then
	echo "\$(($1+$2)) == ./heathbar $1 $2: $(./heathbar "$1" "$2")" 1>&2
    else
	echo "ERROR: \$(($1+$2)) != ./heathbar $1 $2: $(($1+$2)) != $(./heathbar "$1" "$2")" 1>&2
    fi

    echo 1>&2
}
heathbar 4253 2281
heathbar 1 2
heathbar 3 5
heathbar 1234 999
read -r -n 1 -p "Press any key to try non-numbers: "
echo 1>&2
heathbar foo bar
