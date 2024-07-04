#!/usr/bin/env bash
#
# gen_path_list.found.sh - generate tmp/path_list.found.txt for entry
# directories under a year
#
# XXX - This is a temporary utility that will be replaced when
#	the .entry.json files are built.
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
export VERSION="1.1 2024-01-14"
NAME=$(basename "$0"); export NAME
TOPDIR=".."
#
export V_FLAG=0

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-t topdir]

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-V		print version string and exit

	-t topdir	top directory under which year dirs are found (def: ..)

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:Vt: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    t) TOPDIR="$OPTARG"
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
# verify arg count
#
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: expected 0 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
#
# verify TOPDIR
#
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is empty" 1>&2
    exit 3
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR: $TOPDIR is not directory" 1>&2
    exit 3
fi
if [[ ! -d $TOPDIR/1984 ]]; then
    echo "$0: ERROR: TOPDIR: $TOPDIR is missing the 1984 sub-directory" 1>&2
    exit 3
fi
if [[ ! -d $TOPDIR/tmp ]]; then
    echo "$0: ERROR: TOPDIR: $TOPDIR is missing the tmp sub-directory" 1>&2
    exit 3
fi
if [[ ! -f $TOPDIR/Makefile ]]; then
    echo "$0: ERROR: TOPDIR: $TOPDIR is missing the top level Makefile" 1>&2
    exit 3
fi

# move to TOPDIR
#
cd "$TOPDIR" || echo "$0: ERROR: cd $TOPDIR failed" 1>&2 || exit 10
export PATH_LIST="tmp/path_list.found.txt"

# make clobber
#
make clobber >/dev/null 2>&1
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: make clobber failed, error code: $status" 1>&2
    exit 11
fi

# find files under 4 character dirs that aren't .DS_Store or *.dSYM with a depth of at least 2
#
TMPFILE="tmp/tmp.path_list.found.txt.$$"
trap 'rm -f $TMPFILE; exit' 0 1 2 3 15
find -- ???? -mindepth 2 ! -name .DS_Store ! -name '.*.swp' -type f -print | sort -t/ > "$TMPFILE"
if [[ ! -s $TMPFILE ]]; then
    echo "$0: ERROR: TMPFILE: $TMPFILE is empty" 1>&2
    exit 12
fi
if ! cmp -s "$TMPFILE" "$PATH_LIST"; then

    # replace the file list
    #
    echo "$0: updating $PATH_LIST"
    mv -f -v "$TMPFILE" "$PATH_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMPFILE $PATH_LIST failed, error: $status" 1>&2
	exit 13
    fi
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
