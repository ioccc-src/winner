#!/usr/bin/env bash
#
# run_all.sh - run a command for all entries
#
# XXX - This is a temporary utility that will be replaced when
#	the .entry.json files are built
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
export VERSION="1.0.1 2023-11-06"
NAME=$(basename "$0"); export NAME
EXIT_CODE=0
#
export V_FLAG=0
export CAP_D_FLAG=0
export DOMAIN="ioccc-src.github.io"
export DOCPATH="/temp-test-ioccc"
export GITHUB_REPO="https://github.com/ioccc-src/temp-test-ioccc/blob/master"
export TOPDIR=".."
export ENTRY_DIR_TXT="entry_dir.txt"

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-D level]
    [-d www.domain.org] [-p /path/to/docroot] [-g github_url ] [-t topdir] [-w entry_dir.txt]
    tool

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-D level	set verbosity level (via -v level) in tool: (def level: $CAP_D_FLAG)

	-d www.domain.org	change domain (def: $DOMAIN)
	-p /path/to/docroot	use path under domain to document root (def: $DOCPATH)
	-g github_url		path to the GitHub repo (def: $GITHUB_REPO)
	-t topdir		path to top of the local GitHub repo tree (def: $TOPDIR)

	-w entry_dir.txt

	tool			the tool to run over all entries

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find writable entry directory
     5	    tool is not an executable file
     6	    missing entry directory as found in entry_dir.txt
     7	    tool exited non-zero
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:D:d:p:g:t:w: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    D) CAP_D_FLAG="$OPTARG"
	;;
    d) DOMAIN="$OPTARG"
    	;;
    p) DOCPATH="$OPTARG"
    	;;
    g) GITHUB_REPO="$OPTARG"
    	;;
    t) TOPDIR="$OPTARG"
    	;;
    w) ENTRY_DIR_TXT="$OPTARG"
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
    echo "$0: debug[3]: CAP_D_FLAG=$CAP_D_FLAG" 1>&2
    echo "$0: debug[3]: DOMAIN=$DOMAIN" 1>&2
    echo "$0: debug[3]: DOCPATH=$DOCPATH" 1>&2
    echo "$0: debug[3]: GITHUB_REPO=$GITHUB_REPO" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: TOOL=$TOOL" 1>&2
    echo "$0: debug[3]: ENTRY_DIR_TXT=$ENTRY_DIR_TXT" 1>&2
fi

# make it easier to process CSV files
#
IFS="$IFS,"

# verify entry_dir.txt is readable
#
if [[ ! -e $ENTRY_DIR_TXT ]]; then
    echo  "$0: ERROR: ENTRY_DIR_TXT does not exist: $ENTRY_DIR_TXT" 1>&2
    exit 4
fi
if [[ ! -f $ENTRY_DIR_TXT ]]; then
    echo  "$0: ERROR: ENTRY_DIR_TXT is not a regular file: $ENTRY_DIR_TXT" 1>&2
    exit 4
fi
if [[ ! -r $ENTRY_DIR_TXT ]]; then
    echo  "$0: ERROR: ENTRY_DIR_TXT is not a readable file: $ENTRY_DIR_TXT" 1>&2
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

# verify that the entry directories exist
#
for d in $(< "$ENTRY_DIR_TXT"); do
    dir="$TOPDIR/$d"
    if [[ ! -e $dir ]]; then
	echo  "$0: ERROR: entry directory does not exist: $dir" 1>&2
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

# process tool for each entry
#
for dir in $(< "$ENTRY_DIR_TXT"); do
    if [[ $V_FLAG -ge 1 ]]; then
        echo "$0: debug[1]: $TOOL -d $DOMAIN -p $DOCPATH -g $GITHUB_REPO -t $TOPDIR -v $CAP_D_FLAG -- $dir" 1>&2
    fi
    $TOOL -d "$DOMAIN" -p "$DOCPATH" -g "$GITHUB_REPO" -t "$TOPDIR" -v "$CAP_D_FLAG" -- "$dir"
    status="$?"
    if [[ $status -ne 0 ]]; then
        echo "$0: Warning: $TOOL -d $DOMAIN -p $DOCPATH -g $GITHUB_REPO -t $TOPDIR -v $CAP_D_FLAG -- $dir exit code: $status" 1>&2
	EXIT_CODE="7"	# exit 7
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: success" 1>&2
    fi
done

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[0]: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
