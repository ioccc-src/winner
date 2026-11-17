#!/usr/bin/env bash
#
# jfmt-wrapper.sh - canonically format a JSON file
#
# We form a wrapper for the `bin/jprint-wrapper.sh` a tool that will format a JSON
# file in IOCCC JSON style.
#
# If the JSON file is already on canonical form, the file is not modified.
#
# Copyright (c) 2024-2026 by Landon Curt Noll.  All Rights Reserved.
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


# set variables referenced in the usage message
#
export VERSION="2.1.0 2026-11-16"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
#
QUICK_CHECK=""
#
PYTHON3_TOOL=$(type -P python3 2>/dev/null || true)
export PYTHON3_TOOL
#
JPRINT_WRAPPER=$(type -P jprint-wrapper.sh 2>/dev/null || true)
if [[ -z $JPRINT_WRAPPER ]]; then
    JPRINT_WRAPPER="bin/jprint-wrapper.sh"
fi


# clear options we will add to the jfmt-wrapper.sh tool
#
unset TOOL_OPTION
declare -ag TOOL_OPTION


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N] [-j jprint] [-p python3] [-P] [-Q] [-s] file.json

    -h              print help message and exit
    -v level        set verbosity level (def level: 0)
    -V              print version string and exit

    -n              do not modify file.json (def: reformat file.json if needed)
    -N              do not process file, just parse arguments and ignore the file (def: process the file)

    -j jprint       path to jprint-wrapper.sh tool (def: $JPRINT_WRAPPER)
    -p python3      path to the python3 tool (def: $PYTHON3_TOOL)
    -P              preserve literal UTF-8 output (def: non-ASCII characters are re-encoded as ASCII escape sequences)
    -Q              quick check jprint-wrapper.sh tool using trivial input and exit, ignore file.json (def: do not)
    -s              canonical key sorting as per RFC 8785 (def: print JSON in the IOCCC JSON style)

    file.json       JSON file to read, ignored if -Q or -N

NOTE: file.json is not touched if it is already in canonical form

Exit codes:
     0         all OK
     1         some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5         some internal tool not found
     6         file.json does not exist or is not readable
     7         file.json is not valid JSON
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:VnNj:p:PQs flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	TOOL_OPTION+=("-v")
	TOOL_OPTION+=("$V_FLAG")
	;;
    V) echo "$VERSION"
	exit 2
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    j) JPRINT_WRAPPER="$OPTARG"
	;;
    p) PYTHON3_TOOL=$(type -P "$OPTARG" 2>/dev/null || echo "$OPTARG")
	TOOL_OPTION+=("-p")
	TOOL_OPTION+=("$PYTHON3_TOOL")
        ;;
    P) TOOL_OPTION+=("-P")
	;;
    Q) QUICK_CHECK="-Q"
	;;
    s) TOOL_OPTION+=("-s")
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
0) if [[ -z $QUICK_CHECK && -z $DO_NOT_PROCESS ]]; then
        echo "$0: ERROR: 0 args allowed only with -Q or -N" 1>&2
	echo "$USAGE" 1>&2
	exit 3
   fi
   ;;
1) JSON_FILE="$1" ;;
*) echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
   echo 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac


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
    echo "$0: debug[3]: QUICK_CHECK=$QUICK_CHECK" 1>&2
    echo "$0: debug[3]: PYTHON3_TOOL=$PYTHON3_TOOL" 1>&2
    echo "$0: debug[3]: JPRINT_WRAPPER=$JPRINT_WRAPPER" 1>&2
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
fi


# Validate JPRINT_WRAPPER executable
#
JPRINT_TOOL=$(type -P "$JPRINT_WRAPPER" 2>/dev/null || true)
if [[ -z "$JPRINT_TOOL" || ! -x "$JPRINT_TOOL" ]]; then
    if [[ ! -x "$JPRINT_WRAPPER" ]]; then
        echo "$0: ERROR: jprint-wrapper.sh tool not found or not executable: $JPRINT_WRAPPER" 1>&2
        exit 5
    fi
fi


# -Q just performs a quick check on the bin/jprint-wrapper.sh tool
#
if [[ -n $QUICK_CHECK ]]; then

    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to: $JPRINT_WRAPPER -Q ${TOOL_OPTION[*]}" 1>&2
    fi
    "$JPRINT_WRAPPER" -Q "${TOOL_OPTION[@]}"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JPRINT_WRAPPER -Q ${TOOL_OPTION[*]} failed," \
	     "error code: $status" 1>&2
	exit 1
    fi
    exit 0
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# Verify $JSON_FILE existence, readability, and writability
#
if [[ -n "$JSON_FILE" ]]; then
    if [[ ! -f "$JSON_FILE" ]]; then
        echo "$0: ERROR: JSON_FILE is not a regular file: $JSON_FILE" 1>&2
        exit 6
    fi
    if [[ ! -r "$JSON_FILE" ]]; then
        echo "$0: ERROR: JSON_FILE is not a readable file: $JSON_FILE" 1>&2
        exit 6
    fi
    if [[ -z "$NOOP" && ! -w "$JSON_FILE" ]]; then
        echo "$0: ERROR: JSON_FILE is not a writable file: $JSON_FILE" 1>&2
        exit 6
    fi
fi


# create a temporary entry JSON file
#
JSON_DIR=$(dirname "$JSON_FILE")
TMP_JSON_FILE="$JSON_DIR/.tmp.$NAME.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary JSON file: $TMP_JSON_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_JSON_FILE' EXIT
    trap 'rm -f $TMP_JSON_FILE; exit 1' 1 2 3 15
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
    echo "$0: debug[3]: about to: $JPRINT_WRAPPER ${TOOL_OPTION[*]} $JSON_FILE > $TMP_JSON_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    "$JPRINT_WRAPPER" "${TOOL_OPTION[@]}" "$JSON_FILE" > "$TMP_JSON_FILE"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JPRINT_WRAPPER ${TOOL_OPTION[*]} $JSON_FILE > $TMP_JSON_FILE failed," \
	     "error code: $status" 1>&2
	if [[ $status -eq 1 ]]; then
	    exit 7
	elif [[ $status -eq 6 ]]; then
	    exit 6
	fi
	exit 1
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, did not run: $JPRINT_WRAPPER ${TOOL_OPTION[*]} $JSON_FILE > $TMP_JSON_FILE" 1>&2
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
            echo "$0: ERROR: mv -f -- $TMP_JSON_FILE $JSON_FILE failed," \
	         "error code: $status" 1>&2
            exit 13
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: replaced JSON_FILE file: $JSON_FILE" 1>&2
        fi
        if [[ ! -s $JSON_FILE ]]; then
            echo "$0: ERROR: not a non-empty canonical JSON_FILE file: $JSON_FILE" 1>&2
            exit 14
        fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not update $JSON_FILE" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
