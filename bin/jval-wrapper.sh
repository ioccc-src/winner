#!/usr/bin/env bash
#
# jval-wrapper.sh - print JSON values to stdout
#
# We form a wrapper for the `jval(1)`, a tool that allow the printing of JSON values.
#
# We propose that the grammar used by JSONPath.sh(1):
#
#   https://github.com/lcn2/JSONPath.sh
#
# becomes the model for how `jval(1)` prints JSON values.  Consider, for, example:
#
#   JSONPath.sh -w -f 1984/mullender/.entry.json '$author_set..author_handle'
#
# and in particular:
#
#   JSONPath.sh -w -b -f 1984/mullender/.entry.json '$author_set..author_handle'
#
# as a model of printing the `author_handle` values from the JSON `author_set` array.
#
# See the following URL for more information.
#
#   https://github.com/lcn2/JSONPath.sh?tab=readme-ov-file#jsonpath-patterns-and-extensions
#
# Copyright (c) 2024 by Landon Curt Noll.  All Rights Reserved.
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


# firewall - run only with a bash that is version 5.1.8 or later
#
# The "/usr/bin/env bash" command must result in using a bash that
# is version 5.1.8 or later.
#
# We could relax this version and insist on version 4.2 or later.  Versions
# of bash between 4.2 and 5.1.7 might work.  However, to be safe, we will require
# bash version 5.1.8 or later.
#
# WHY 5.1.8 and not 4.2?  This safely is done because macOS Homebrew bash we
# often use is "version 5.2.26(1)-release" or later, and the RHEL Linux bash we
# use often use is "version 5.1.8(1)-release" or later.  These versions are what
# we initially tested.  We recommend you either upgrade bash or install a newer
# version of bash and adjust your $PATH so that "/usr/bin/env bash" finds a bash
# that is version 5.1.8 or later.
#
# NOTE: The macOS shipped, as of 2024 March 15, a version of bash is something like
#	bash "version 3.2.57(1)-release".  That macOS shipped version of bash
#	will NOT work.  For users of macOS we recommend you install Homebrew,
#	(see https://brew.sh), and then run "brew install bash" which will
#	typically install it into /opt/homebrew/bin/bash, and then arrange your $PATH
#	so that "/usr/bin/env bash" finds "/opt/homebrew/bin" (or whatever the
#	Homebrew bash is).
#
# NOTE: And while MacPorts might work, we noticed a number of subtle differences
#	with some of their ported tools to suggest you might be better off
#	with installing Homebrew (see https://brew.sh).  No disrespect is intended
#	to the MacPorts team as they do a commendable job.  Nevertheless we ran
#	into enough differences with MacPorts environments to suggest you
#	might find a better experience with this tool under Homebrew instead.
#
if [[ -z ${BASH_VERSINFO[0]} ||
	 ${BASH_VERSINFO[0]} -lt 5 ||
	 ${BASH_VERSINFO[0]} -eq 5 && ${BASH_VERSINFO[1]} -lt 1 ||
	 ${BASH_VERSINFO[0]} -eq 5 && ${BASH_VERSINFO[1]} -eq 1 && ${BASH_VERSINFO[2]} -lt 8 ]]; then
    echo "$0: ERROR: bash version needs to be >= 5.1.8: $BASH_VERSION" 1>&2
    echo "$0: Warning: bash version >= 4.2 might work but 5.1.8 was the minimum we tested" 1>&2
    echo "$0: Notice: For macOS users: install Homebrew (see https://brew.sh), then run" \
	 ""brew install bash" and then modify your \$PATH so that \"#!/usr/bin/env bash\"" \
	 "finds the Homebrew installed (usually /opt/homebrew/bin/bash) version of bash" 1>&2
    exit 4
fi


# setup bash file matching
#
# We must declare arrays with -ag or -Ag, and we need loops to "export" modified variables.
# This requires a bash with a version 4.2 or later.  See the larger comment above about bash versions.
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories


# set variables referenced in the usage message
#
export VERSION="1.0.3 2024-08-11"
NAME=$(basename "$0")
export NAME
export V_FLAG=0


# Until we have a true jval tool, we will use the modified JSONPath.sh
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jval command, we must FAKE PARSE IOCCC JSON files       - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
export JSONPATH_REPO="https://github.com/lcn2/JSONPath.sh"
JSONPATH_SH=$(type -P JSONPath.sh)
export JSONPATH_SH
if [[ -z $JSONPATH_SH ]]; then
    echo "$0: FATAL: JSONPath.sh tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: obtain JSONPath.sh from: $JSONPATH_REPO" 1>&2
    exit 5
fi
# verify JSONPath.sh supports -S -A -T
export FIZZBIN_JSON='"fizzbin"'
if ! "$JSONPATH_SH" -S -A -T -p >/dev/null 2>&1; then
    echo "$0: FATAL: JSONPath.sh tool does not support -S -A -T: $FIZZBIN_JSON" 1>&2
    echo "$0: notice: we recommend you obntain and install JSONPath.sh from: $JSONPATH_REPO" 1>&2
    exit 5
fi <<< "$FIZZBIN_JSON"
export JSONPATH_ARG
export PATTERN='$*'
#
unset OPTION
declare -ag OPTION


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N]
	[-w] [-b] [-i] [-u]
	[-j JSONPath.sh] file.json [pattern]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-n		do nothing (same as -N) (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-w		match whole words only for filter script expression (def: match substrings)
	-b		only print values (def: print both JSON member and JSON value)
	-i		match insensitive (def: match case)
	-u		strip unnecessary leading path element (def: print the entire element path)

	-j JSONPath.sh	path to the JSONPath.sh tool (not the wrapper) (def: $JSONPATH_SH)

	file.json	JSON file to read, - ==> read stdin
	pattern		JSONPath query (def: $PATTERN}

Exit codes:
     0         all OK
     1	       JSONPath.sh exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       internal tool not found
     6	       file.json does not exist or is not readable
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:VnNwbiuj: flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    j) JSONPATH_SH="$OPTARG"
	;;
    w) OPTION+=("-w")
	;;
    b) OPTION+=("-b")
	;;
    i) OPTION+=("-i")
	;;
    u) OPTION+=("-u")
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
# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[5]: argument count: $#" 1>&2
fi
case "$#" in
1) JSON_FILE="$1"
   ;;
2) JSON_FILE="$1"
    PATTERN="$2"
    ;;
*) echo "$0: ERROR: expected i or 2 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
    ;;
esac
#
if [[ -n $JSON_FILE ]]; then
    if [[ ! -e $JSON_FILE ]]; then
	echo  "$0: ERROR: JSON_FILE does not exist: $JSON_FILE" 1>&2
	exit 6
    fi
    if [[ ! -f $JSON_FILE ]]; then
	echo  "$0: ERROR: JSON_FILE is not a regular file: $JSON_FILE" 1>&2
	exit 6
    fi
    if [[ ! -r $JSON_FILE ]]; then
	echo  "$0: ERROR: JSON_FILE is not an readable file: $JSON_FILE" 1>&2
	exit 6
    fi
fi


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: JSONPATH_REPO=$JSONPATH_REPO" 1>&2
    echo "$0: debug[3]: JSONPATH_SH=$JSONPATH_SH" 1>&2
    echo "$0: debug[3]: FIZZBIN_JSON=$FIZZBIN_JSON" 1>&2
    echo "$0: debug[3]: JSONPATH_ARG=$JSONPATH_ARG" 1>&2
    for index in "${!OPTION[@]}"; do
        echo "$0: debug[$V_FLAG]: $V_FLAG: OPTION[$index]=${OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
    echo "$0: debug[3]: PATTERN=$PATTERN" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# -n means we have nothing to do
#
if [[ -n $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[3]: -n given, nothing to do, exiting 0" 1>&2
    fi
    exit 0
fi


# case: processing JSON from standard input
#
if [[ -z $JSON_FILE ]]; then

    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: $JSONPATH_SH ${OPTION[*]} -- $PATTERN" 1>&2
    fi
    "$JSONPATH_SH" "${OPTION[@]}" -- "$PATTERN"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JSONPATH_SH ${OPTION[*]} -- $PATTERN failed," \
	     "error code: $status" 1>&2
	exit 1
    fi

# case: processing JSON from a file
#
else

    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: $JSONPATH_SH ${OPTION[*]} -f $JSON_FILE -- $PATTERN" 1>&2
    fi
    "$JSONPATH_SH" "${OPTION[@]}" -f "$JSON_FILE" -- "$PATTERN"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JSONPATH_SH ${OPTION[*]} -f $JSON_FILE -- $PATTERN failed," \
	     "error code: $status" 1>&2
	exit 1
    fi
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
