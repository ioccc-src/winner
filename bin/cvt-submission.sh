#!/usr/bin/env bash
#
# cvt-submission.sh - convert a submission into an entry
#
# Given a submission (that has won the IOCCC), with a `.auth.json`
# and `.info.json` and NO `.entry.json` file, we convert the
# `.auth.json` and `.info.json` into a new `.entry.json` file.
#
# We will form, as needed, new `author/author_handle.json`
# files for new authors, and update `author/author_handle.json`
# for authors who won previously.
#
# There are functions that this tool will NOT do:
#
#   * This tool will not remove `.auth.json`
#   * This tool will not remove `.info.json`
#   * This tool will not remove `remarks.md`
#   * This tool will not verify that Makefile has the required rules
#   * This will will not form `README.md` author notes from `remarks.md`
#   * This will will not add this entry to the year level Makefile
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
export VERSION="1.0.2 2024-08-05"
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
#
CHKENTRY_TOOL=$(type -P chkentry)
export CHKENTRY_TOOL
if [[ -z "$CHKENTRY_TOOL" ]]; then
    echo "$0: FATAL: chkentry tool is not installed or not in \$PATH" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
#
JSTRENCODE_TOOL=$(type -P jstrencode)
export JSTRENCODE_TOOL
if [[ -z "$JSTRENCODE_TOOL" ]]; then
    echo "$0: FATAL: jstrencode tool is not installed or not in \$PATH" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
#
export TOPDIR
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export MKIOCCCENTRY_REPO="https://github.com/ioccc-src/mkiocccentry"
export INPUT_DATA_FILE
#
export NO_COMMENT="mandatory comment: because comments were removed from the original JSON spec"
export ENTRY_JSON_FORMAT_VERSION="1.1 2024-02-11"
#
export NOOP=
export DO_NOT_PROCESS=

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]
	[-c chkeckentry] [-j jstrencode] [-s jstrencode]
	[-i input_data] [-n] [-N] YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-c chkeckentry	path to the chkentry tool (def: $CHKENTRY_TOOL)
	-s jstrencode	path to the jstrencode tool (def: $JSTRENCODE_TOOL)

	-i input_data	read data from file (def: from stdin)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	YYYY/dir	path from topdir to entry directory

Exit codes:
     0         all OK
     1	       invalid user input
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       invalid or missing .info.json and/or .auth.json files
 >= 10         internal error

$NAME version: $VERSION"

# prompt_string
#
# Prompt the user for a string and output as an encoded JSON string
#
# usage:
#       prompt_string item_name
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function prompt_string
{
    local INPUT;		# user input
    local ENCODED;		# INPUT encoded as JSON string
    local Y_OR_N;		# y or n
    local ITEM_NAME;		# name of the item being prompted for

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in prompt_string: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ITEM_NAME="$1"
    if [[ -z $ITEM_NAME ]]; then
        echo "$0: ERROR: in prompt_string: 1st arg is empty" 1>&2
	return 2
    fi

    # obtain for the award
    #
    while :; do

	# prompt for value
	#
	echo -n "Enter $ITEM_NAME: "
	read -r INPUT
	if [[ -z "$INPUT" ]]; then
	    echo "$0: Warning: in prompt_string: $ITEM_NAME cannot be empty, try again" 1>&2
	    echo 1>&2
	    continue
	fi

	# JSON encode value
	#
	ENCODED=$("$JSTRENCODE_TOOL" -q -n -- "$INPUT")
	status="$?"
	if [[ $status -ne 0 || -z $ENCODED ]]; then
	    echo "$0: ERROR: in prompt_string: $JSTRENCODE_TOOL -q -n -- $INPUT failed," \
		 "error code: $status" 1>&2
	    exit 1
	fi

	# verify JSON encoded value
	#
	echo
	echo "Verify encoded $ITEM_NAME: $ENCODED" 1>&2
	echo
	echo -n 'Is that correct? [y,N]: '
	read -r Y_OR_N
	if [[ $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
	    break
	fi
	echo
    done
    echo

    # set VALUE to the JSON encoded string
    #
    VALUE="$ENCODED"
    return 0
}

# parse command line
#
while getopts :hv:Vd:c:s:i:nN flag; do
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
    c) CHKENTRY_TOOL="$OPTARG"
	;;
    s) JSTRENCODE_TOOL="$OPTARG"
	;;
    i) INPUT_DATA_FILE="$OPTARG"
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

# remove the options
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
#
# verify arg count and parse args
#
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
export ENTRY_PATH="$1"

# if -i input_data, replace stdin with the input data file
#
if [[ -n $INPUT_DATA_FILE ]]; then
    if [[ ! -e $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data file does not exist: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -f $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not a regular file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -r $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not an readable file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -s $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not a non-empty readable file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    exec 0<"$INPUT_DATA_FILE"
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


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"
#
export JVAL_WRAPPER="$BIN_DIR/jval-wrapper.sh"
if [[ ! -e $JVAL_WRAPPER ]]; then
    echo "$0: ERROR: bin/jval-wrapper.sh file does not exist: $JVAL_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -f $JVAL_WRAPPER ]]; then
    echo "$0: ERROR: bin/jval-wrapper.sh is not a file: $JVAL_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -x $JVAL_WRAPPER ]]; then
    echo "$0: ERROR: cannot find an executable bin/jval-wrapper.sh tool: $JVAL_WRAPPER" 1>&2
    exit 5
fi


# verify that ENTRY_PATH is a entry directory
#
if [[ ! -d $ENTRY_PATH ]]; then
    echo "$0: ERROR: arg is not a directory: $ENTRY_PATH" 1>&2
    exit 3
fi
if [[ ! -w $ENTRY_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $ENTRY_PATH" 1>&2
    exit 3
fi
export YEAR_DIR=${ENTRY_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in YYYY/dir form: $ENTRY_PATH" 1>&2
    exit 3
fi
export ENTRY_DIR=${ENTRY_PATH#*/}
if [[ -z $ENTRY_DIR ]]; then
    echo "$0: ERROR: arg: $ENTRY_PATH not in $YEAR_DIR/dir form: $ENTRY_PATH" 1>&2
    exit 3
fi
if [[ $ENTRY_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $ENTRY_PATH contains a /: $ENTRY_DIR" 1>&2
    exit 3
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: YYYY from arg: $ENTRY_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 3
fi
export ENTRY_ID="${YEAR_DIR}_${ENTRY_DIR}"
export DOT_YEAR="$YEAR_DIR/.year"
# Now that we have moved to topdir, form and verify YYYY_DIR is a writable directory
export YYYY_DIR="$YEAR_DIR/$ENTRY_DIR"
if [[ ! -e $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH does not exist: $YYYY_DIR" 1>&2
    exit 6
fi
if [[ ! -d $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a directory: $YYYY_DIR" 1>&2
    exit 6
fi
if [[ ! -w $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a writable directory: $YYYY_DIR" 1>&2
    exit 6
fi
export INFO_JSON="$YYYY_DIR/.info.json"
export AUTH_JSON="$YYYY_DIR/.auth.json"
export ENTRY_JSON="$YYYY_DIR/.entry.json"


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
    echo "$0: debug[3]: CHKENTRY_TOOL=$CHKENTRY_TOOL" 1>&2
    echo "$0: debug[3]: JSTRENCODE_TOOL=$JSTRENCODE_TOOL" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: MKIOCCCENTRY_REPO=$MKIOCCCENTRY_REPO" 1>&2
    echo "$0: debug[3]: INPUT_DATA_FILE=$INPUT_DATA_FILE" 1>&2
    echo "$0: debug[3]: NO_COMMENT=$NO_COMMENT" 1>&2
    echo "$0: debug[3]: ENTRY_JSON_FORMAT_VERSION=$ENTRY_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: INFO_JSON=$INFO_JSON" 1>&2
    echo "$0: debug[3]: AUTH_JSON=$AUTH_JSON" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
fi


# verify that YEAR is already in .top
#
if ! grep -E -q "^$YEAR_DIR$" "$TOP_FILE"; then
    echo "$0: ERROR: YEAR_DIR: $YEAR_DIR not found in: $TOP_FILE" 1>&2
    echo "$0: notice: consider running: bin/new-year.sh $YEAR_DIR -v 1" 1>&2
    exit 6
fi


# firewall - verify chkentry tool
#
if [[ ! -e $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: chkentry file does not exist: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -f $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: chkentry is not a file: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -x $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: cannot find an executable chkentry tool: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi


# firewall - verify jstrencode tool
#
if [[ ! -e $JSTRENCODE_TOOL ]]; then
    echo "$0: ERROR: jstrencode file does not exist: $JSTRENCODE_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -f $JSTRENCODE_TOOL ]]; then
    echo "$0: ERROR: jstrencode is not a file: $JSTRENCODE_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -x $JSTRENCODE_TOOL ]]; then
    echo "$0: ERROR: cannot find an executable jstrencode tool: $JSTRENCODE_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi


# verify .info.json and .auth.json are readable non-empty files
#
if [[ ! -e $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json does not exist: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -f $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not a regular file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -r $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not an readable file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -s $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not a non-empty readable file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -e $AUTH_JSON ]]; then
    echo  "$0: ERROR: .auth.json does not exist: $AUTH_JSON" 1>&2
    exit 6
fi
if [[ ! -f $AUTH_JSON ]]; then
    echo  "$0: ERROR: .auth.json is not a regular file: $AUTH_JSON" 1>&2
    exit 6
fi
if [[ ! -r $AUTH_JSON ]]; then
    echo  "$0: ERROR: .auth.json is not an readable file: $AUTH_JSON" 1>&2
    exit 6
fi
if [[ ! -s $AUTH_JSON ]]; then
    echo  "$0: ERROR: .auth.json is not a non-empty readable file: $AUTH_JSON" 1>&2
    exit 6
fi


# perform the semantic check on .info.json and .auth.json
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to run: $CHKENTRY_TOOL -v 1 -- $INFO_JSON $AUTH_JSON" 1>&2
    "$CHKENTRY_TOOL" -v 1 -- "$INFO_JSON" "$AUTH_JSON"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: $CHKENTRY_TOOL -v 1 -- $INFO_JSON $AUTH_JSON failed," \
	      "error code: $status" 1>&2
	exit 7
    fi
else
    "$CHKENTRY_TOOL" -- "$INFO_JSON" "$AUTH_JSON"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: $CHKENTRY_TOOL -- $INFO_JSON $AUTH_JSON failed," \
	      "error code: $status" 1>&2
	exit 7
    fi
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# create a temporary .entry.json file
#
export TMP_ENTRY_JSON=".tmp.$NAME.ENTRY_JSON.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_ENTRY_JSON; exit' 0 1 2 3 15
    rm -f "$TMP_ENTRY_JSON"
    if [[ -e $TMP_ENTRY_JSON ]]; then
	echo "$0: ERROR: cannot remove temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
	exit 10
    fi
    :> "$TMP_ENTRY_JSON"
    if [[ ! -e $TMP_ENTRY_JSON ]]; then
	echo "$0: ERROR: cannot create temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary .entry.json file is not used: $TMP_ENTRY_JSON" 1>&2
fi


# create a temporary author_handle set file
#
export TMP_AUTHOR_HANDLE=".tmp.$NAME.AUTHOR_HANDLE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary author_handle set file: $TMP_AUTHOR_HANDLE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_ENTRY_JSON $TMP_AUTHOR_HANDLE; exit' 0 1 2 3 15
    rm -f "$TMP_AUTHOR_HANDLE"
    if [[ -e $TMP_AUTHOR_HANDLE ]]; then
	echo "$0: ERROR: cannot remove temporary author_handle set file: $TMP_AUTHOR_HANDLE" 1>&2
	exit 12
    fi
    :> "$TMP_AUTHOR_HANDLE"
    if [[ ! -e $TMP_AUTHOR_HANDLE ]]; then
	echo "$0: ERROR: cannot create temporary author_handle set file: $TMP_AUTHOR_HANDLE" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary author_handle set is not used: $TMP_AUTHOR_HANDLE" 1>&2
fi


# case: without -n
#
export VALUE
if [[ -z $NOOP ]]; then

    # form the start of the temporary .entry.json file
    #
    {
	echo '{'
	echo '    "no_comment" : "'"$NO_COMMENT"'",'
	echo '    "entry_JSON_format_version" : "'"$ENTRY_JSON_FORMAT_VERSION"'",'
    } >> "$TMP_ENTRY_JSON"

    # write the award to the temporary .entry.json file
    #
    VALUE=
    prompt_string "award"
    status="$?"
    if [[ $status -ne 0 || -z $VALUE ]]; then
	echo "$0: ERROR: prompt_string award failed," \
		 "error code: $status" 1>&2
	exit 1
    fi
    {
	echo "    \"award\" : \"${VALUE}\","

	# write IOCCC year to the temporary .entry.json file
	#
	echo "    \"year\" : ${YEAR_DIR},"

	# write entry directory to the temporary .entry.json file
	#
	echo "    \"dir\" : \"${ENTRY_DIR}\","

	# write entry_id to the temporary .entry.json file
	#
	echo "    \"entry_id\" : \"${ENTRY_ID}\","

	# start the author_set JSON array
	#
	echo "    \"author_set\" : ["
    } >> "$TMP_ENTRY_JSON"

    # process each author_handle
    #
    export PATTERN="\$authors..author_handle"
    if [[ $V_FLAG -ge 3 ]]; then
	echo  "$0: debug[3]: about to run: $JVAL_WRAPPER -b -- $AUTH_JSON $PATTERN > $TMP_AUTHOR_HANDLE" 1>&2
    fi
    "$JVAL_WRAPPER" -b -- "$AUTH_JSON" "$PATTERN" > "$TMP_AUTHOR_HANDLE"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JVAL_WRAPPER -b -- $AUTH_JSON $PATTERN > $TMP_AUTHOR_HANDLE failed," \
		 "error code: $status" 1>&2
	exit 1
    fi
    if [[ ! -s $TMP_AUTHOR_HANDLE ]]; then
	echo "$0: ERROR: temporary author_handle set file is empty or missing: $TMP_AUTHOR_HANDLE" 1>&2
	exit 1
    fi
    AUTHOR_COUNT=$(wc -l < "$TMP_AUTHOR_HANDLE")
    export AUTHOR_COUNT
    ((i=0))
    while read -r AUTHOR_HANDLE; do
	((++i))
	if [[ $i -lt $AUTHOR_COUNT ]]; then
	    printf "\t { \"author_handle\" : \"%s\" },\n" "$AUTHOR_HANDLE"
	else
	    printf "\t { \"author_handle\" : \"%s\" }\n" "$AUTHOR_HANDLE"
	fi
    done >> "$TMP_ENTRY_JSON" < "$TMP_AUTHOR_HANDLE"
    echo "    ],"  >> "$TMP_ENTRY_JSON"

    # process the manifest
    #

    : # XXX - add code here - XXX #

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled adding YYYY_DIR: $YYYY_DIR to $DOT_YEAR" 1>&2
fi


cat "$TMP_ENTRY_JSON" # XXX


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
