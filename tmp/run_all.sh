#!/usr/bin/env bash
#
# run_all.sh - run a command for all winners
#
# XXX - This is a temporary utility that will be replaced when
#	the .winner.json files are built
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
export VERSION="1.0 2023-10-31"
NAME=$(basename "$0"); export NAME
EXIT_CODE=0
#
export V_FLAG=0
export DOMAIN="ioccc-src.github.io"
export DOCPATH="/temp-test-ioccc"
export GITHUB_REPO="https://github.com/ioccc-src/temp-test-ioccc"
export TOPDIR=".."
export WINNER_DIR_TXT="winner_dir.txt"

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-d www.domain.org] [-p /path/to/docroot] [-g github_url ] [-t topdir]
    [-w winner_dir.txt]
    tool

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)

	-d www.domain.org	change domain (def: $DOMAIN)
	-p /path/to/docroot	use path under domain to document root (def: $DOCPATH)
	-g github_url		path to the GitHub repo (def: $GITHUB_REPO)
	-t topdir		path to top of the local GitHub repo tree (def: $TOPDIR)

	-w winner_dir.txt

	tool			the tool to run over all winners

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find writable winner directory
     5	    tool is not an executable file
     6	    missing winner directory as found in winner_dir.txt
     7	    a tool run faoled
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:d:p:g:t:w: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    d) DOMAIN="$OPTARG"
    	;;
    p) DOCPATH="$OPTARG"
    	;;
    g) GITHUB_REPO="$OPTARG"
    	;;
    t) TOPDIR="$OPTARG"
    	;;
    w) WINNER_DIR_TXT="$OPTARG"
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
#
# remove the options
#
shift $(( OPTIND - 1 ));
#
# verify arg count and parse args
#
export TOOL
case "$#" in
1) TOOL="$1"
   ;;
*) echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac

# print running info if verbose
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: DOMAIN=$DOMAIN" 1>&2
    echo "$0: debug[3]: DOCPATH=$DOCPATH" 1>&2
    echo "$0: debug[3]: GITHUB_REPO=$GITHUB_REPO" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: TOOL=$TOOL" 1>&2
    echo "$0: debug[3]: WINNER_DIR_TXT=$WINNER_DIR_TXT" 1>&2
fi

# make it easier to process CSV files
#
IFS="$IFS,"

# verify winner_dir.txt is readable
#
if [[ ! -e $WINNER_DIR_TXT ]]; then
    echo  "$0: ERROR: WINNER_DIR_TXT does not exist: $WINNER_DIR_TXT" 1>&2
    exit 4
fi
if [[ ! -f $WINNER_DIR_TXT ]]; then
    echo  "$0: ERROR: WINNER_DIR_TXT is not a file: $WINNER_DIR_TXT" 1>&2
    exit 4
fi
if [[ ! -r $WINNER_DIR_TXT ]]; then
    echo  "$0: ERROR: WINNER_DIR_TXT is not a readable file: $WINNER_DIR_TXT" 1>&2
    exit 4
fi

# verify tool is executable
#
if [[ ! -e $TOOL ]]; then
    echo  "$0: ERROR: TOOL does not exist: $TOOL" 1>&2
    exit 5
fi
if [[ ! -f $TOOL ]]; then
    echo  "$0: ERROR: TOOL is not a regular file: $TOOL" 1>&2
    exit 5
fi
if [[ ! -x $TOOL ]]; then
    echo  "$0: ERROR: TOOL is not an executable file: $TOOL" 1>&2
    exit 5
fi

# verify that the winner directories exist
#
for d in $(< "$WINNER_DIR_TXT"); do
    dir="$TOPDIR/$d"
    if [[ ! -e $dir ]]; then
	echo  "$0: ERROR: winner directory does not exist: $dir" 1>&2
	exit 6
    fi
    if [[ ! -d $dir ]]; then
	echo  "$0: ERROR: not a directory: $dir" 1>&2
	exit 6
    fi
    if [[ ! -x $dir ]]; then
	echo  "$0: ERROR: not a writable directory: $dir" 1>&2
	exit 6
    fi
done

# process tool for each winner
#
for dir in $(< "$WINNER_DIR_TXT"); do
    if [[ $V_FLAG -ge 1 ]]; then
        echo "$0: debug[1]: $TOOL -d $DOMAIN -p $DOCPATH -g $GITHUB_REPO -t $TOPDIR -- $dir" 1>&2
    fi
    $TOOL -d "$DOMAIN" -p "$DOCPATH" -g "$GITHUB_REPO" -t "$TOPDIR" -- "$dir"
    status="$?"
    if [[ $status -ne 0 ]]; then
        echo "$0: Warning: $TOOL -d $DOMAIN -p $DOCPATH -g $GITHUB_REPO -t $TOPDIR -- $dir exit code: $status" 1>&2
	EXIT_CODE="7"
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: success" 1>&2
    fi
done

# All Done!!! -- Jessica Noll, Age 2
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[0]: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
