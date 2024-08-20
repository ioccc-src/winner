#!/usr/bin/env bash
#
# jfmt-wrapper.sh - - canonically format a JSON file
#
# We form a wrapper for the jfmt(1), a tool that will format a JSON
# file into a canonical style.  NOTE: As of 2024 July 28 the jfmt(1)
# tool has not been written, so jfmt-wrapper.sh uses the JSONPath.sh(1)
# tool from the recently forked and modified JSONPath.sh tool:
#
#   https://github.com/lcn2/JSONPath.sh
#
# If the JSON file is already on canonical form, the file is not modified.
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
export VERSION="1.1 2024-08-20"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
#
JPARSE_TOOL=$(type -P jparse)
export JPARSE_TOOL


# Until we have a true jfmt tool, we will use the modified JSONPath.sh
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jfmt command, we must FAKE PARSE IOCCC JSON files       - XXX
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
# verify JSONPath.sh supports -S -A
export FIZZBIN_JSON='"fizzbin"'
if ! "$JSONPATH_SH" -S -A -p >/dev/null 2>&1; then
    echo "$0: FATAL: JSONPath.sh tool does not support -S -A: $FIZZBIN_JSON" 1>&2
    echo "$0: notice: we recommend you obtain and install JSONPath.sh from: $JSONPATH_REPO" 1>&2
    exit 5
fi <<< "$FIZZBIN_JSON"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N] [-j JSONPath.sh] file.json

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-n		do not modify file.json (def: modify file.json is not canonical)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-j JSONPath.sh	path to the JSONPath.sh tool (not the wrapper) (def: $JSONPATH_SH)

	file.json	The JSON file to write, in canonical form, to stdout (def: read stdin)

Exit codes:
     0         all OK
     1	       JSONPath.sh exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       internal tool not found
     6	       file.json does not exist or is not readable
     7	       file.json is not valid JSON
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:VnNj: flag; do
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
export JSON_FILE=
case "$#" in
1) JSON_FILE="$1" ;;
*) echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
   echo 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
#
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
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
fi


# verify the JSON of JSON_FILE
#
if [[ $V_FLAG -ge 7 ]]; then
    echo "$0: debug[7]: about to run: $JPARSE_TOOL -q -- $JSON_FILE" 1>&2
fi
if "$JPARSE_TOOL" -q -- "$JSON_FILE"; then
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: valid JSON for: $JSON_FILE" 1>&2
    fi
else
    echo "$0: ERROR: not valid JSON: $JSON_FILE" 1>&2
    exit 7
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# create a temporary entry JSON file
#
export TMP_JSON_FILE=".tmp.$NAME.JSON_FILE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary JSON file: $TMP_JSON_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_JSON_FILE; exit' 0 1 2 3 15
    rm -f "$TMP_JSON_FILE"
    if [[ -e $TMP_JSON_FILE ]]; then
	echo "$0: ERROR: cannot remove temporary JSON file: $TMP_JSON_FILE" 1>&2
	exit 10
    fi
    :> "$TMP_JSON_FILE"
    if [[ ! -e $TMP_JSON_FILE ]]; then
	echo "$0: ERROR: cannot create temporary JSON file: $TMP_JSON_FILE" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary JSON file is not used: $TMP_JSON_FILE" 1>&2
fi


# canonically format the JSON file
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: about to: $JSONPATH_SH -S -A -j -f $JSON_FILE > $TMP_JSON_FILE" 1>&2
fi
"$JSONPATH_SH" -S -A -j -f "$JSON_FILE" > "$TMP_JSON_FILE"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: $JSONPATH_SH -S -A -j -f $JSON_FILE > $TMP_JSON_FILE failed," \
	 "error code: $status" 1>&2
    exit 1
fi


# replace JSON_FILE file with canonically formatted TMP_JSON_FILE if different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_JSON_FILE" "$JSON_FILE"; then

	# case: JSON_FILE was already canonical
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: JSON_FILE was already canonical: $JSON_FILE" 1>&2
        fi

    else

        # case: JSON_FILE needs to be replaced by canonically formatted TMP_JSON_FILE
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_JSON_FILE $JSON_FILE" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_JSON_FILE" "$JSON_FILE"
            status="$?"
        else
            mv -f -- "$TMP_JSON_FILE" "$JSON_FILE"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_JSON_FILE $JSON_FILE filed," \
	         "error code: $status" 1>&2
            exit 12
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: replaced JSON_FILE file: $JSON_FILE" 1>&2
        fi
        if [[ ! -s $JSON_FILE ]]; then
            echo "$0: ERROR: not a non-empty canonical JSON_FILE file: $JSON_FILE" 1>&2
            exit 13
        fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not update $JSON_FILE"
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
