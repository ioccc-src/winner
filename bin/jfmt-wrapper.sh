#!/usr/bin/env bash
#
# jfmt-wrapper.sh - canonically format a JSON file
#
# We form a wrapper for the jprint(1), a tool that will format a JSON
# file into a canonical JSON style.
#
# If the JSON file is already on canonical form, the file is not modified.
#
# NOTE: As of 2024 Sep 10 the jprint(1) tool has not been written,
#       so jfmt-wrapper.sh uses the jsp tool from:
#
#	    https://github.com/kjozsa/jsp
#
#   FYI: For macOS, use Homebrew to install pipx:
#
#	brew install pipx
#
#   Next, use pipx to install jsp:
#
#	pipx --global install jsp
#
#   ... and then be sure that ~/.local/bin is in your $PATH.
#
#   Alternately, you can use the JSONPath.sh(1) tool from:
#
#	https://github.com/lcn2/JSONPath.sh
#
# Copyright (c) 2024-2025 by Landon Curt Noll.  All Rights Reserved.
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
export VERSION="2.0.2 2025-05-04"
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
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"


# Until we have a true jfmt tool, we will use wither jsp or the modified JSONPath.sh
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jprint command, we must use external tools to parse JSON  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
export JSP_REPO="https://github.com/kjozsa/jsp"
export JSONPATH_REPO="https://github.com/lcn2/JSONPath.sh"
export FIZZBIN_JSON='"fizzbin"'
export JSP_TOOL=""
JSP_TOOL=$(type -P jsp)
export JSONPATH_SH=""
JSONPATH_SH=$(type -P JSONPath.sh)
# set the default XPath for JSON
export XPATHJSON_USE="jsp"
export QUICK_CHECK=""


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N] [-t tool] [-Q] file.json

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-n		do not modify file.json (def: modify file.json is not canonical)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-t tool		tool to use: jsp or JSONPath.sh (def: try jsp, otherwise try JSONPath.sh)
	-Q		quick check tool using trivial input and exit, ignore file.json and pattern (def: do not)

	file.json	JSON file to read, - ==> read stdin (ignored if -Q)

NOTE: file.json is not touched if it is already in canonical form

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool not found
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
while getopts :hv:VnNt:Q flag; do
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
    t) # validate -t tool
       case "$OPTARG" in
       jsp) XPATHJSON_USE="jsp" ;;
       JSONPath.sh) XPATHJSON_USE="JSONPath.sh" ;;
       *) echo "$0: ERROR: unknown -t option: $OPTARG" 1>&2
	  echo 1>&2
          echo "$USAGE" 1>&2
          exit 3
	  ;;
       esac
       ;;
    Q) QUICK_CHECK="true"
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
0) if [[ -z $QUICK_CHECK ]]; then
        echo "$0: ERROR: 0 args allowed only with -Q" 1>&2
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
#
# -Q ignores ignore file.json
#
if [[ -n $QUICK_CHECK ]]; then
    JSON_FILE=""
#
else
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


# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_TOP_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_TOP_URL; cd $REPO_NAME" 1>&2
    exit 6
fi


# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 6
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 6
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


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
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: JSP_REPO=$JSP_REPO" 1>&2
    echo "$0: debug[3]: JSONPATH_REPO=$JSONPATH_REPO" 1>&2
    echo "$0: debug[3]: FIZZBIN_JSON=$FIZZBIN_JSON" 1>&2
    echo "$0: debug[3]: JSP_TOOL=$JSP_TOOL" 1>&2
    echo "$0: debug[3]: JSONPATH_SH=$JSONPATH_SH" 1>&2
    echo "$0: debug[3]: XPATHJSON_USE=$XPATHJSON_USE" 1>&2
    echo "$0: debug[3]: QUICK_CHECK=$QUICK_CHECK" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: JSON_FILE=$JSON_FILE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# validate the XPath for JSON tool
#
case "$XPATHJSON_USE" in

    # case: we will use JSONPath.sh
    #
    JSONPath.sh)

	# try JSONPath.sh
	#
	if [[ -z $JSONPATH_SH || ! -x $JSONPATH_SH ]]; then
	    echo "$0: ERROR: JSONPath.sh tool is not installed, is not executable, or not in \$PATH" 1>&2
	    echo "$0: notice: obtain jsp from: $JSP_REPO" 1>&2
	    echo "$0: notice: or obtain jsp via \"pipx install jsp\" and placing ~/.local/bin in \$PATH" 1>&2
	    echo "$0: notice: obtain JSONPath.sh from: $JSONPATH_REPO" 1>&2
	    echo "$0: notice: if possible install jsp instead of JSONPath.sh as jsp is faster" 1>&2
	    exit 5
	fi

	# case: -Q - perform quick check
	#
	if [[ -n $QUICK_CHECK ]]; then
	    # verify JSONPath.sh supports -S -4
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: about to: $JSONPATH_SH -S -4 >/dev/null 2>&1 <<< $FIZZBIN_JSON" 1>&2
	    fi
	    if ! "$JSONPATH_SH" -S -4 >/dev/null 2>&1; then
		echo "$0: ERROR: JSONPath.sh tool does not support -S -4 $FIZZBIN_JSON" 1>&2
		echo "$0: notice: we recommend you obtain and install jsp from: $JSP_REPO" 1>&2
		echo "$0: notice: or obtain jsp via \"pipx install jsp\" and placing ~/.local/bin in \$PATH" 1>&2
		echo "$0: notice: otherwise install JSONPath.sh from: $JSONPATH_REPO" 1>&2
		echo "$0: notice: if possible install jsp instead of JSONPath.sh as jsp is faster" 1>&2
		exit 5
	    fi <<< "$FIZZBIN_JSON"
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: passed quick check: $JSONPATH_SH" 1>&2
	    fi
	    exit 0
	fi
	;;

    # case: we will use jsp
    #
    jsp)

	# try jsp
	#
	if [[ -z $JSP_TOOL || ! -x $JSP_TOOL ]]; then
	    echo "$0: ERROR: jsp tool is not installed, is not executable, or not in \$PATH" 1>&2
	    echo "$0: notice: obtain jsp from: $JSP_REPO" 1>&2
	    echo "$0: notice: or obtain jsp via \"pipx install jsp\" and placing ~/.local/bin in \$PATH" 1>&2
	    echo "$0: notice: obtain JSONPath.sh from: $JSONPATH_REPO" 1>&2
	    echo "$0: notice: if possible install jsp instead of JSONPath.sh as jsp is faster" 1>&2
	    exit 5
	fi

	# case: -Q - perform quick check
	#
	if [[ -n $QUICK_CHECK ]]; then
	    # verify jsp
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: about to: $JSP_TOOL  --indent 4 --format --no-color >/dev/null 2>&1 <<< $FIZZBIN_JSON" 1>&2
	    fi
	    if ! "$JSP_TOOL" --indent 4 --format --no-color >/dev/null 2>&1; then
		echo "$0: ERROR: jsp tool does not support --indent 4 --format --no-color: $FIZZBIN_JSON" 1>&2
		echo "$0: notice: you might need to update and reinstall jsp from: $JSP_REPO" 1>&2
		echo "$0: notice: or obtain jsp via \"pipx install jsp\" and placing ~/.local/bin in \$PATH" 1>&2
		echo "$0: notice: or you might try to obtain and install JSONPath.sh from: $JSONPATH_REPO" 1>&2
		echo "$0: notice: if possible install jsp instead of JSONPath.sh as jsp is faster" 1>&2
		exit 5
	    fi <<< "$FIZZBIN_JSON"
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: passed quick check: $JSP_TOOL" 1>&2
	    fi
	    exit 0
	fi
	;;

    # case: we do not have an XPath for JSON tool
    #
    *)
	echo "$0: ERROR: cannot find an XPath JSON tool to use" 1>&2
	echo "$0: notice: we recommend you obtain and install jsp from: $JSP_REPO" 1>&2
	echo "$0: notice: or obtain jsp via \"pipx install jsp\" and placing ~/.local/bin in \$PATH" 1>&2
	echo "$0: notice: otherwise install JSONPath.sh from: $JSONPATH_REPO" 1>&2
	echo "$0: notice: if possible install jsp instead of JSONPath.sh as jsp is faster" 1>&2
	exit 5
	;;
esac


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
case "$XPATHJSON_USE" in

    # case: use jsp
    #
    jsp)

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: $JSP_TOOL --indent 4 --format --no-color < $JSON_FILE | sed ..." 1>&2
	fi
	"$JSP_TOOL" --indent 4 --format --no-color < "$JSON_FILE" |
	    sed -e 's/\(\S\): /\1 : /' > "$TMP_JSON_FILE"
	status_codes=("${PIPESTATUS[@]}")
	if [[ ${status_codes[*]} =~ [1-9] ]]; then
	    echo "$0: ERROR: $JSP_TOOL --indent 4 --format --no-color < $JSON_FILE | sed ...  failed," \
		 "error codes: ${status_codes[*]}" 1>&2
	    exit 1
	fi
	;;

    # case: use JSONPath.sh
    #
    JSONPath.sh)

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: $JSONPATH_SH -S -4 -j -f $JSON_FILE > $TMP_JSON_FILE" 1>&2
	fi
	"$JSONPATH_SH" -S -4 -j -f "$JSON_FILE" > "$TMP_JSON_FILE"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: $JSONPATH_SH -S -4 -j -f $JSON_FILE > $TMP_JSON_FILE failed," \
		 "error code: $status" 1>&2
	    exit 1
	fi
	;;

    # case: we do not know which XPath JSON tool to use
    #
    *)

	echo "$0: ERROR: XPATHJSON_USE is neither jsp nor JSONPath.sh: $XPATHJSON_USE" 1>&2
	exit 12
	;;
esac


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
   echo "$0: debug[3]: because of -n, will not update $JSON_FILE"
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
