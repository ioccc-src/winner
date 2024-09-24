#!/usr/bin/env bash
#
# unicode-chk.sh - verify all \\u[[:xdigit:]]{4} in entry and author JSON files
#
# Pass entry and author JSON files thru the following sed script and
# flag any \\u[[:xdigit:]]{4} that we might find as problems.
#
#   bin/unicode-fix.sed
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have fixed jstrdecode, we must sed out \u[0-0A-fa-f]{4} from JSON  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
# Until this bug is the jparse repo is fixed, we need to avoid
# using \\u[[:xdigit:]]{4} within JSON encoded strings.
#
#   https://github.com/xexyl/jparse/issues/13
#
# The above mentioned bug results in certain tools that are based on the
# jparse repo:
#
#   https://github.com/xexyl/jparse
#
# including code from the mkiocccentry repo's jparse sub-directory:
#
#   https://github.com/ioccc-src/mkiocccentry/tree/master/jparse
#
# We need to avoid using \\u[[:xdigit:]]{4} within JSON encoded strings.
# Sorry (tm Canada :-)).
#
# The following sed script converts known problematic \\u[[:xdigit:]]{4}
# combinations into their RAW character form:
#
#   bin/unicode-fix.sed
#
# Use of that sed script serves as a work-a-round to avoid to avoid any
# problematic \\u[[:xdigit:]]{4} combinations in JSON encoded strings.
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
export VERSION="1.0 2024-09-23"
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
export DOCROOT_SLASH="../../"
export TAGLINE="unspecified"
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N] [file.json ..]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: The '-D docroot/' is passed as leading options on tool command lines.
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	[file.json ...]	check file.json files (def: check all entry and author JSON files)

Exit codes:
     0         all OK
     1	       found unexpected \\uHexHexHexHex strings in JSON files
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
     8	       file.json not a readable file
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd:D:j:nN flag; do
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
    D) # parse -D docroot/
	case "$OPTARG" in
	*/) ;;
	*) echo "$0: ERROR: in -D docroot/, the docroot must end in /" 1>&2
	   echo 1>&2
	   print_usage 1>&2
	   exit 3
	   ;;
	esac
	DOCROOT_SLASH="$OPTARG"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	print_usage 1>&2
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
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
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


# verify that we have an author subdirectory
#
export AUTHOR_PATH="$TOPDIR/author"
if [[ ! -d $AUTHOR_PATH ]]; then
    echo "$0: ERROR: author is not a directory under topdir: $AUTHOR_PATH" 1>&2
    exit 6
fi
export AUTHOR_DIR="author"


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


# verify that the bin/unicode-fix.sed tool is executable
#
export UNICODE_FIX_SED="$BIN_DIR/unicode-fix.sed"
if [[ ! -e $UNICODE_FIX_SED ]]; then
    echo  "$0: ERROR: bin/unicode-fix.sed does not exist: $UNICODE_FIX_SED" 1>&2
    exit 5
fi
if [[ ! -f $UNICODE_FIX_SED ]]; then
    echo  "$0: ERROR: bin/unicode-fix.sed is not a regular file: $UNICODE_FIX_SED" 1>&2
    exit 5
fi
if [[ ! -r $UNICODE_FIX_SED ]]; then
    echo  "$0: ERROR: bin/unicode-fix.sed is not an readable file: $UNICODE_FIX_SED" 1>&2
    exit 5
fi


# verify we have a non-empty readable .top file
#
export TOP_FILE=".top"
if [[ ! -e $TOP_FILE ]]; then
    echo  "$0: ERROR: .top does not exist: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -f $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not a regular file: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -r $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not an readable file: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -s $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not a non-empty readable file: $TOP_FILE" 1>&2
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
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: TAGLINE=$TAGLINE" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: UNICODE_FIX_SED=$UNICODE_FIX_SED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# create a JSON problem file
#
export TMP_JSON_PROBLEM=".tmp.$NAME.JSON_PROBLEM.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: JSON problem inventory file: $TMP_JSON_PROBLEM" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_HANDLE_INVENTORY; exit' 0 1 2 3 15
rm -f "$TMP_JSON_PROBLEM"
if [[ -e $TMP_JSON_PROBLEM ]]; then
    echo "$0: ERROR: cannot remove JSON problem inventory file: $TMP_JSON_PROBLEM" 1>&2
    exit 10
fi
: > "$TMP_JSON_PROBLEM"
if [[ ! -e $TMP_JSON_PROBLEM ]]; then
    echo "$0: ERROR: cannot create JSON problem inventory file: $TMP_JSON_PROBLEM" 1>&2
    exit 11
fi


# case: check only file given as args
#
if [[ $# -gt 0 ]]; then

    # check specific JSON files
    #
    for JSON_FILE in "$@"; do

	# just be a readable file
	#
	if [[ ! -e $JSON_FILE ]]; then
	    echo  "$0: ERROR: does not exist: $JSON_FILE" 1>&2
	    exit 8
	fi
	if [[ ! -f $JSON_FILE ]]; then
	    echo  "$0: ERROR: is not a regular file: $JSON_FILE" 1>&2
	    exit 8
	fi
	if [[ ! -r $JSON_FILE ]]; then
	    echo  "$0: ERROR: is not an readable file: $JSON_FILE" 1>&2
	    exit 8
	fi

	# scan the author/author_handle.json file for unexpected \\u[[:xdigit:]]{4} strings
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: about to run: sed -f $UNICODE_FIX_SED -- $JSON_FILE 2>&1 | grep -E ..." 1>&2
	fi
	FOUND_UHEX=$(sed -f "$UNICODE_FIX_SED" -- "$JSON_FILE" 2>&1 | grep -E '\\u[[:xdigit:]]{4}')
	if [[ -n $FOUND_UHEX ]]; then
	    echo "$JSON_FILE"
	fi

    done >> "$TMP_JSON_PROBLEM"


# case: check all .entry.json files and author JSON files
#
else

    # check all .entry.json files
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: starting to check .entry.json files under: $TOPDIR" 1>&2
    fi
    export YYYY
    for YYYY in $(< "$TOP_FILE"); do

	# debug YYYY
	#
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: starting to check year: $YYYY" 1>&2
	fi

	# verify that YYYY is a readable directory
	#
	if [[ ! -e $YYYY ]]; then
	    echo  "$0: ERROR: YYYY does not exist: $YYYY" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -d $YYYY ]]; then
	    echo  "$0: ERROR: YYYY is not a directory: $YYYY" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -r $YYYY ]]; then
	    echo  "$0: ERROR: YYYY is not an readable directory: $YYYY" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi

	# verify that YYYY has a non-empty readable .year file
	#
	export YEAR_FILE="$YYYY/.year"
	if [[ ! -e $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year does not exist: $YEAR_FILE" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -f $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not a regular file: $YEAR_FILE" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -r $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not an readable file: $YEAR_FILE" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -s $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $YEAR_FILE" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi

	# process each entry directory under YYYY
	#
	export YYYY_DIR
	for YYYY_DIR in $(< "$YEAR_FILE"); do

	    # debug YYYY
	    #
	    if [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: starting to check year/dir: $YYYY_DIR" 1>&2
	    fi

	    # parse YYYY_DIR
	    #
	    if [[ ! -d $YYYY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
		EXIT_CODE="6"  # exit 6
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -w $YYYY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR is not a writable directory: $YYYY_DIR" 1>&2
		EXIT_CODE="6"  # exit 6
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    export YEAR_DIR=${YYYY_DIR%%/*}
	    if [[ -z $YEAR_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR not in YYYY/dir form: $YYYY_DIR" 1>&2
		EXIT_CODE="6"  # exit 6
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    export ENTRY_DIR=${YYYY_DIR#*/}
	    if [[ -z $ENTRY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR not in $YEAR_DIR/dir form: $YYYY_DIR" 1>&2
		EXIT_CODE="6"  # exit 6
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ $ENTRY_DIR = */* ]]; then
		echo "$0: ERROR: YYYY_DIR: $YYYY_DIR dir contains a /: $ENTRY_DIR" 1>&2
		EXIT_CODE="6"  # exit 6
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # verify that YYYY_DIR is a writable directory
	    #
	    if [[ ! -e $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR does not exist: $YYYY_DIR" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -d $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -w $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR is not an writable directory: $YYYY_DIR" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # verify YYYY/dir/.path
	    #
	    export DOT_PATH="$YYYY_DIR/.path"
	    if [[ ! -s $DOT_PATH ]]; then
		echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    DOT_PATH_CONTENT=$(< "$DOT_PATH")
	    if [[ $YYYY_DIR != "$DOT_PATH_CONTENT" ]]; then
		echo "$0: ERROR: arg: $YYYY_DIR does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # verify the YYYY/dir/.entry.json
	    #
	    export ENTRY_JSON="$YYYY_DIR/.entry.json"
	    if [[ ! -e $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -f $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -r $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
		EXIT_CODE="7"  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # scan the .entry.json file for unexpected \\u[[:xdigit:]]{4} strings
	    #
	    if [[ -z $NOOP ]]; then
		if [[ $V_FLAG -ge 5 ]]; then
		    echo "$0: debug[5]: about to run: sed -f $UNICODE_FIX_SED -- $YYYY_DIR/.entry.json 2>&1 | grep -E ..." 1>&2
		fi
		FOUND_UHEX=$(sed -f "$UNICODE_FIX_SED" -- "$YYYY_DIR/.entry.json" 2>&1 | grep -E '\\u[[:xdigit:]]{4}' 2>&1)
		export FOUND_UHEX
		if [[ -n $FOUND_UHEX ]]; then
		    echo "$YYYY_DIR/.entry.json"
		fi
	    fi
	done
    done >> "$TMP_JSON_PROBLEM"


    # create a temporary author_handle inventory file
    #
    export TMP_AUTHOR_HANDLE_INVENTORY=".tmp.$NAME.AUTHOR_HANDLE_INVENTORY.$$.tmp"
    if [[ $V_FLAG -ge 3 ]]; then
	echo  "$0: debug[3]: temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
    fi
    trap 'rm -f $TMP_AUTHOR_HANDLE_INVENTORY $TMP_AUTHOR_HANDLE_INVENTORY; exit' 0 1 2 3 15
    rm -f "$TMP_AUTHOR_HANDLE_INVENTORY"
    if [[ -e $TMP_AUTHOR_HANDLE_INVENTORY ]]; then
	echo "$0: ERROR: cannot remove temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
	exit 12
    fi
    : > "$TMP_AUTHOR_HANDLE_INVENTORY"
    if [[ ! -e $TMP_AUTHOR_HANDLE_INVENTORY ]]; then
	echo "$0: ERROR: cannot create temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
	exit 13
    fi

    # check author/author_handle.json files
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: starting to check author_handle.json files under: $AUTHOR_DIR" 1>&2
    fi
    find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' 2>/dev/null |
      LC_ALL=C sort -d -u > "$TMP_AUTHOR_HANDLE_INVENTORY"
    while read -r AUTHOR_HANDLE_JSON; do

	# scan the author/author_handle.json file for unexpected \\u[[:xdigit:]]{4} strings
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to run: sed -f $UNICODE_FIX_SED -- $AUTHOR_HANDLE_JSON 2>&1 | grep -E ..." 1>&2
	fi
	FOUND_UHEX=$(sed -f "$UNICODE_FIX_SED" -- "$AUTHOR_HANDLE_JSON" 2>&1 | grep -E '\\u[[:xdigit:]]{4}')
	if [[ -n $FOUND_UHEX ]]; then
	    echo "$AUTHOR_HANDLE_JSON"
	fi

    done < "$TMP_AUTHOR_HANDLE_INVENTORY" >> "$TMP_JSON_PROBLEM"
fi


# report any problems
#
if [[ -s $TMP_JSON_PROBLEM ]]; then
    echo "$0: ERROR: found unexpected \\uHexHexHexHex strings in JSON files" 1>&2
    echo "$0: debug[5]: list of JSON files with unexpected \\uHexHexHexHex strings, starts below" 1>&2
    cat "$TMP_JSON_PROBLEM" 1>&2
    echo "$0: debug[5]: list of JSON files with unexpected \\uHexHexHexHex strings, ends above" 1>&2
    if [[ $EXIT_CODE -eq 0 ]]; then
	EXIT_CODE="1"  # exit 1
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit non-zero: $EXIT_CODE" 1>&2
elif [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
