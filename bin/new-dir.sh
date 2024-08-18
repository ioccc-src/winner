#!/usr/bin/env bash
#
# new-dir.sh - add a new entry directory under an IOCCC year
#
# We update YYYY/.year to reference a new entry directory under
# a given IOCCC year.  We also update the to level `.allyear` too.
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
export VERSION="1.3.2 2024-08-17"
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
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
#
export NOOP=
export DO_NOT_PROCESS=


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N] YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	YYYY/dir	path from topdir to entry directory

Exit codes:
     0         all OK
     1	       invalid year
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
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
    exit 7
fi
if [[ ! -d $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a directory: $YYYY_DIR" 1>&2
    exit 7
fi
if [[ ! -w $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a writable directory: $YYYY_DIR" 1>&2
    exit 7
fi


# verify we have a non-empty readable Makefile
#
export MAKE_FILE="$YEAR_DIR/Makefile"
if [[ ! -e $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile does not exist: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -f $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not a regular file: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -r $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not an readable file: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -s $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not a non-empty readable file: $MAKE_FILE" 1>&2
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
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: MAKE_FILE=$MAKE_FILE" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# verify that YEAR is already in .top
#
if ! grep -E -q "^$YEAR_DIR$" "$TOP_FILE"; then
    echo "$0: ERROR: YEAR_DIR: $YEAR_DIR not found in: $TOP_FILE" 1>&2
    echo "$0: notice: consider running: bin/new-year.sh $YEAR_DIR -v 1" 1>&2
    exit 10
fi


# case: without -n
#
if [[ -z $NOOP ]]; then

    # append entry directory path to .year
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: making sure that YYYY_DIR: $YYYY_DIR is in: $DOT_YEAR" 1>&2
    fi
    echo "$YYYY_DIR" >> "$DOT_YEAR"

    # sort .year
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to: LC_ALL=C sort -u $DOT_YEAR -o $DOT_YEAR" 1>&2
    fi
    LC_ALL=C sort -u "$DOT_YEAR" -o "$DOT_YEAR"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: LC_ALL=C sort -u $DOT_YEAR -o $DOT_YEAR failed," \
	     "error code: $status" 1>&2
	exit 11
    fi

    # firewall - verify YYYY_DIR in .year
    #
    if grep -E -q "^$YYYY_DIR$" "$DOT_YEAR"; then
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: YYYY_DIR: $YYYY_DIR is in: $DOT_YEAR" 1>&2
	fi
    else
	echo "$0: ERROR: failed to add YYYY_DIR: $YYYY_DIR to: $DOT_YEAR" 1>&2
	exit 12
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled adding YYYY_DIR: $YYYY_DIR to $DOT_YEAR" 1>&2
fi


# create a temporary Makefile
#
export TMP_MAKEFILE=".tmp.$NAME.MAKEFILE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary Makefile: $TMP_MAKEFILE" 1>&2
fi
trap 'rm -f $TMP_MAKEFILE; exit' 0 1 2 3 15
rm -f "$TMP_MAKEFILE"
if [[ -e $TMP_MAKEFILE ]]; then
    echo "$0: ERROR: cannot remove temporary Makefile: $TMP_MAKEFILE" 1>&2
    exit 13
fi
touch "$TMP_MAKEFILE"
if [[ ! -e $TMP_MAKEFILE ]]; then
    echo "$0: ERROR: cannot create temporary Makefile: $TMP_MAKEFILE" 1>&2
    exit 14
fi


# form the temporary Makefile with the added year
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: forming temporary Makefile: $TMP_MAKEFILE" 1>&2
fi
sed -n -e '1,/^# BEGIN - DO NOT REMOVE THIS LINE - make new_entry uses this line #/p' "$MAKE_FILE" > "$TMP_MAKEFILE"
make -C "$YEAR_DIR" new_entry NEW_ENTRY="$ENTRY_DIR" >> "$TMP_MAKEFILE"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: make -C $YEAR_DIR new_entry NEW_ENTRY=\"$ENTRY_DIR\" >> \"$TMP_MAKEFILE\" failed," \
	 "error code: $status" 1>&2
    exit 15
fi
sed -n -e '/^# END - DO NOT REMOVE THIS LINE - make new_entry also uses this #/,$p' "$MAKE_FILE" >> "$TMP_MAKEFILE"


# Update Makefile if is changes and not -n
#
if [[ -z $NOOP ]]; then

    if cmp -s "$TMP_MAKEFILE" "$MAKE_FILE"; then

	# case: Makefile did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: Makefile file did not change: $MAKE_FILE" 1>&2
        fi

    else

        # case: Makefile file changed, update the file
        #
        if [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: about to: mv -f -- $TMP_MAKEFILE $MAKE_FILE" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_MAKEFILE" "$MAKE_FILE"
            status="$?"
        else
            mv -f -- "$TMP_MAKEFILE" "$MAKE_FILE"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_MAKEFILE $MAKE_FILE filed," \
	         "error code: $status" 1>&2
            exit 16
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated Makefile: $MAKE_FILE" 1>&2
        fi
        if [[ ! -s $MAKE_FILE ]]; then
            echo "$0: ERROR: not a non-empty Makefile: $MAKE_FILE" 1>&2
            exit 17
        fi
    fi

    # update genpath
    #
    # form top level .top and .allyear, YYYY level .year and winner .path files
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: make genpath" 1>&2
    fi
    make genpath >/dev/null
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: make genpath filed," \
	     "error code: $status" 1>&2
	exit 18
    fi
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: make genpath complete" 1>&2
    fi
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: ready for: bin/cvt-submission.sh -v $V_FLAG $YYYY_DIR" 1>&2
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled updating: $MAKE_FILE" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
