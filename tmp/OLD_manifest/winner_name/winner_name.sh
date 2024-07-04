#!/usr/bin/env bash
#
# winner_name - extract NAME tags from winners.html
#
# Print NAME tags from a winners.html. By default print just the winner_id renamed NAME tags.
#
# Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

# setup
#
export VERSION="1.0 2023-05-15"
NAME=$(basename "$0")
export NAME
#
export A_FLAG=
export V_FLAG=0
export WINNERS_HTML="./winners.html"

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-a] [winners.html]

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-V		print version string and exit
	-a		print all NAME tags (def: print just winner_id NAME tags)

	winners.html	path of winners.html (def: ./winners.html)

Exit codes:
     0	    all OK
     1	    winners.html does not exist, not a file, not readable
     2	    -h and help string printed or -V and version string printed
     3	    command line error
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:Va flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    a) A_FLAG="true"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    :) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
  esac
done
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
# remove the options
#
shift $(( OPTIND - 1 ));
#
# verify arg count
#
if [[ $# -gt 1 ]]; then
    echo "$0: ERROR: expected 0 or 1 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
#
# parse args
#
if [[ $# -gt 0 ]]; then
    export WINNERS_HTML="$1"
fi

# firewall WINNERS_HTML must be a readable file
#
if [[ ! -e $WINNERS_HTML ]]; then
    echo "$0: ERROR: winners.html does not exist: $WINNERS_HTML" 1>&2
    exit 1
fi
if [[ ! -f $WINNERS_HTML ]]; then
    echo "$0: ERROR: winners.html not a file: $WINNERS_HTML" 1>&2
    exit 1
fi
if [[ ! -r $WINNERS_HTML ]]; then
    echo "$0: ERROR: winners.html not a readable file: $WINNERS_HTML" 1>&2
    exit 1
fi

# case: print only winner_id NAME tags
#
if [[ -z $A_FLAG ]]; then

    grep -o -i '<a[[:space:]][[:space:]]*name[[:space:]]*=[[:space:]]*"[^"][^"]*"' "$WINNERS_HTML" |
      sed -e 's/^.*<[Aa][[:space:]][[:space:]]*[Nn][Aa][Mm][Ee][[:space:]]*=[[:space:]]*"//' -e 's/".*//' |
      grep '^[0-9A-Za-z][0-9A-Za-z]*_[0-9A-Za-z][0-9A-Za-z]*$'

# case: print all NAME tags
#
else

    grep -o -i '<a[[:space:]][[:space:]]*name[[:space:]]*=[[:space:]]*"[^"][^"]*"' "$WINNERS_HTML" |
      sed -e 's/^.*<[Aa][[:space:]][[:space:]]*[Nn][Aa][Mm][Ee][[:space:]]*=[[:space:]]*"//' -e 's/".*//'
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
