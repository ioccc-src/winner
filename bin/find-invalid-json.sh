#!/usr/bin/env bash
#
# find-invalid-json.sh - find invalid JSON files
#
# This script was written in 2024 by Cody Boone Ferguson.
#
#   "Because sometimes even the IOCCC Judges need some help." :-)
#
# The JSON parser and its respective tools were co-developed in 2022 by:
# 
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
# and:
#	chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# "Share and Enjoy!"
#     --  Sirius Cybernetics Corporation Complaints Division, JSON spec department. :-)


# IOCCC requires use of C locale
#
export LANG="C"
export LC_CTYPE="C"
export LC_NUMERIC="C"
export LC_TIME="C"
export LC_COLLATE="C"
export LC_MONETARY="C"
export LC_MESSAGES="C"
export LC_PAPER="C"
export LC_NAME="C"
export LC_ADDRESS="C"
export LC_TELEPHONE="C"
export LC_MEASUREMENT="C"
export LC_IDENTIFICATION="C"
export LC_ALL="C"


VERGE=$(type -P verge)
export VERGE
if [[ -z $VERGE ]]; then
    echo "$0: FATAL: verge is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install verge:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
JPARSE=$(type -P jparse)
export JPARSE
if [[ -z $JPARSE ]]; then
    echo "$0: FATAL: jparse is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install jparse:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
export MIN_JPARSE_VERSION="1.2.0"
JPARSE_VERSION=$("$JPARSE" -V | head -1 | awk '{print $3;}')
if ! "$VERGE" "$JPARSE_VERSION" "$MIN_JPARSE_VERSION"; then
    echo "$0: FATAL: jparse version: $JPARSE_VERSION < minimum version: $MIN_JPARSE_VERSION" 1>&2
    echo "$0: notice: consider updating jparse from mkiocccentry repo" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi

# set variables referenced in the usage message
#
export VERSION="2.0.0 2025-03-13"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

Exit codes:
     0         all OK
     1	       invalid JSON file(s) found
     2         -h and help string printed or -V and version string printed
     3         command line error
     4	       problems found with or in the topdir or topdir/YYYY directory
     5	       problems found with or in the entry topdir/YYYY/dir directory
 >= 10         internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:Vd:nN flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    d) TOPDIR="$OPTARG"
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
0) ;;
*) echo "$0: ERROR: expected 0 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: start scan for invalid JSON files" 1>&2
fi


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: LANG=$LANG" 1>&2
    echo "$0: debug[3]: LC_CTYPE=$LC_CTYPE" 1>&2
    echo "$0: debug[3]: LC_NUMERIC=$LC_NUMERIC" 1>&2
    echo "$0: debug[3]: LC_TIME=$LC_TIME" 1>&2
    echo "$0: debug[3]: LC_COLLATE=$LC_COLLATE" 1>&2
    echo "$0: debug[3]: LC_MONETARY=$LC_MONETARY" 1>&2
    echo "$0: debug[3]: LC_MESSAGES=$LC_MESSAGES" 1>&2
    echo "$0: debug[3]: LC_PAPER=$LC_PAPER" 1>&2
    echo "$0: debug[3]: LC_NAME=$LC_NAME" 1>&2
    echo "$0: debug[3]: LC_ADDRESS=$LC_ADDRESS" 1>&2
    echo "$0: debug[3]: LC_TELEPHONE=$LC_TELEPHONE" 1>&2
    echo "$0: debug[3]: LC_MEASUREMENT=$LC_MEASUREMENT" 1>&2
    echo "$0: debug[3]: LC_IDENTIFICATION=$LC_IDENTIFICATION" 1>&2
    echo "$0: debug[3]: LC_ALL=$LC_ALL" 1>&2
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
fi


# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 4
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 4
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 5
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi


# create a temporary invalid JSON error message file
#
export TMP_INVALID_JSON=".tmp.$NAME.INVALID_JSON.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary invalid JSON error message file: $TMP_INVALID_JSON" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_INVALID_JSON; exit' 0 1 2 3 15
    rm -f "$TMP_INVALID_JSON"
    if [[ -e $TMP_INVALID_JSON ]]; then
	echo "$0: ERROR: cannot remove temporary invalid JSON error message file: $TMP_INVALID_JSON" 1>&2
	exit 12
    fi
    :> "$TMP_INVALID_JSON"
    if [[ ! -e $TMP_INVALID_JSON ]]; then
	echo "$0: ERROR: cannot create temporary invalid JSON error message file: $TMP_INVALID_JSON" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary invalid JSON error message file is not used: $TMP_INVALID_JSON" 1>&2
fi


# collect JSON files
find . -name '*.json' -print |
    # get name of each JSON file
    while read -r JSON_FILE; do
	# try parsing JSON file
	if ! "$JPARSE" "$JSON_FILE" 2>/dev/null; then
	    echo "$JSON_FILE is invalid JSON"
	fi
    # this writes the invalid JSON files to the temporary error file
    done > "$TMP_INVALID_JSON"

# count the invalid JSON files
#
INVALID_JSON_COUNT=$(wc -l < "$TMP_INVALID_JSON" | tr -d ' ')
export INVALID_JSON_COUNT


# report on any invalid JSON files
#
if [[ -s $TMP_INVALID_JSON ]]; then
    sed -e "s;^$TOPDIR/;;" "$TMP_INVALID_JSON" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -s $TMP_INVALID_JSON ]]; then
    echo "$0: ERROR: $INVALID_JSON_COUNT invalid JSON file(s) found" 1>&2
    exit 1
fi
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: $INVALID_JSON_COUNT invalid JSON files found" 1>&2
fi
exit 0
