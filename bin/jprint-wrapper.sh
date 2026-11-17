#!/usr/bin/env bash
#
# jprint-wrapper.sh - format JSON to stdout using python3
#
# Print JSON in the IOCCC JSON style.
#
# NOTE: IOCCC canonical format specifically dictates preserving the source file's
#       original member order, contrary to RFC 8785 and standard canonical formatters.
#       Use '-s' to override this default.
#
# NOTE: By default, IOCCC will Unicode ASCII Escapes in JSON.
#       Use '-P' to override this default.
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
VERSION="2.1.0 2026-11-16"
NAME=$(basename "$0")
V_FLAG=0
#
QUICK_CHECK=""
SORT_KEYS=""
PRESERVE_UTF8=""


# Locate python3 without aborting under 'set -e'
#
PYTHON3_TOOL=$(type -P python3 2>/dev/null || true)
export PYTHON3_TOOL


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N] [-p python3] [-P] [-Q] [-s] [file.json]

    -h              print help message and exit
    -v level        set verbosity level (def level: 0)
    -V              print version string and exit

    -n              do nothing (same as -N) (def: do the action)
    -N              do not process file, just parse arguments and ignore the file (def: process the file)

    -p python3      path to the python3 tool (def: $PYTHON3_TOOL)
    -P              preserve literal UTF-8 output (def: non-ASCII characters are re-encoded as ASCII escape sequences)
    -Q              quick check python3 using trivial input and exit, ignore file.json (def: do not)
    -s              canonical key sorting as per RFC 8785 (def: print JSON in the IOCCC JSON style)

    file.json       The JSON file to write, in canonical form, to stdout (def: read stdin) (ignored if -Q)

Exit codes:
     0         all OK
     1         file or stdin not valid JSON
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5         python3 not found
     6         file.json does not exist or is not readable
     7         -Q used, and python3 failed quick check
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
NOOP=
DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:VnNp:QsP flag; do
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
    p) PYTHON3_TOOL=$(type -P "$OPTARG" 2>/dev/null || echo "$OPTARG")
        ;;
    Q) QUICK_CHECK="-Q"
	;;
    s) SORT_KEYS=', sort_keys=True'
	;;
    P) PRESERVE_UTF8=', ensure_ascii=False'
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
JSON_FILE=
case "$#" in
0) ;;
1) JSON_FILE="$1" ;;
*) echo "$0: ERROR: expected 0 or 1 arg, found: $#" 1>&2
   echo 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
#
# Canonicalize $JSON_FILE to an absolute path
#
if [[ -n "$JSON_FILE" && "$JSON_FILE" != /* ]]; then
    JSON_FILE="$PWD/$JSON_FILE"
fi
#
# Verify $JSON_FILE readability
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
fi


# verify a python3 tool
#
if [[ -z "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
fi
if [[ ! -f "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 is not a file: $PYTHON3_TOOL" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
fi
if [[ ! -x "$PYTHON3_TOOL" ]]; then
    echo "$0: FATAL: python3 is not an executable file: $PYTHON3_TOOL" 1>&2
    echo "$0: notice: install python3, or set \$PATH to find it, or use -p python3_path" 1>&2
    exit 5
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
    echo "$0: debug[3]: QUICK_CHECK=$QUICK_CHECK" 1>&2
    echo "$0: debug[3]: SORT_KEYS=$SORT_KEYS" 1>&2
    echo "$0: debug[3]: PRESERVE_UTF8=$PRESERVE_UTF8" 1>&2
    echo "$0: debug[3]: PYTHON3_TOOL=$PYTHON3_TOOL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
fi


# if -Q, verify we have a functional python3 tool that can format JSON
#
if [[ -n $QUICK_CHECK ]]; then

    # try python3 tool on a trivial JSON check
    #
    CANARY_CHECK=$("$PYTHON3_TOOL" -c '
import sys, json
d = json.loads("{\"status\":\"ok\",\"curds\":\"whey²\"}")
json.dump(d, sys.stdout, indent=4, separators=(",", " : ")'"$SORT_KEYS$PRESERVE_UTF8"')
print()
' 2>&1)
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: FATAL: python3 failed standard library validation for json: $PYTHON3_TOOL" 1>&2
	echo "$0: CANARY_CHECK starts below" 1>&2
	echo "$CANARY_CHECK" 1>&2
	echo "$0: CANARY_CHECK ends above" 1>&2
	echo "$0: notice: perhaps python3 import sys or json failed?" 1>&2
	exit 7
    fi

    # report success if verbose
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: python3 tool on a trivial JSON check passed" 1>&2
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: CANARY_CHECK starts below" 1>&2
	    echo "$CANARY_CHECK" 1>&2
	    echo "$0: debug[3]: CANARY_CHECK ends above" 1>&2
	fi
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


# -n means we have nothing to do
#
if [[ -n $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[3]: -n given, nothing to do, exiting 0" 1>&2
    fi
    exit 0
fi


# format JSON on stdin or from a file
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: executing python3 serializer (file: ${JSON_FILE:-stdin})" 1>&2
fi
"$PYTHON3_TOOL" -c '
import sys, json

if len(sys.argv) > 1 and sys.argv[1]:
    with open(sys.argv[1], "r", encoding="utf-8") as f:
        data = json.load(f)
else:
    data = json.load(sys.stdin)

json.dump(data, sys.stdout, indent=4, separators=(",", " : ")'"$SORT_KEYS$PRESERVE_UTF8"')
print()
' "$JSON_FILE" 2>/dev/null

status="$?"
if [[ $status -ne 0 ]]; then
    if [[ -n "$JSON_FILE" ]]; then
        echo "$0: ERROR: not valid JSON: $JSON_FILE" 1>&2
    else
        echo "$0: ERROR: stdin appears to not be valid JSON" 1>&2
    fi
    exit 1
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
