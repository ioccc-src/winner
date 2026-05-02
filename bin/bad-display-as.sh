#!/usr/bin/env bash
#
# bad-display-as.sh - report on .entry.json files with "display_as" with wrong "display_via_github"
#
# Copyright (c) 2026 by Landon Curt Noll.  All Rights Reserved.
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


# other required bash options
#
# Requires bash with a version 4.2 or later
#
shopt -s lastpipe	# run last command of a pipeline not executed in the background in the current shell environment


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
export VERSION="2.1.0 2026-05-01"
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
#
export JP_REPO="https://github.com/davidhoo/jsonpath"
export JP_TOOL=""
JP_TOOL=$(type -P jp)
#
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
#
JPARSE_TOOL=$(type -P jparse)
export JPARSE_TOOL
if [[ -z "$JPARSE_TOOL" ]]; then
    echo "$0: FATAL: jparse tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install jparse:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
export MIN_JPARSE_VERSION="2.0.3"
JPARSE_VERSION=$("$JPARSE_TOOL" -V | head -1 | awk '{print $3;}')
if ! "$VERGE" "$JPARSE_VERSION" "$MIN_JPARSE_VERSION"; then
    echo "$0: FATAL: jparse version: $JPARSE_VERSION < minimum version: $MIN_JPARSE_VERSION" 1>&2
    echo "$0: notice: consider updating jparse from mkiocccentry repo" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	YYYY/dir	path from topdir to entry directory: must have the file: .entry.json

Exit codes:
     0         all OK
     1	       .entry.json is invalid JSON, or manifest has display_as with an invalid display_via_github
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
     8	       jp tool error
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd: flag; do
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
# parse the command line arguments
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
    exit 3
fi
#
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


# verify we have a jp tool
#
if [[ -z $JP_TOOL || ! -x $JP_TOOL ]]; then
    echo "$0: ERROR: jp tool is not installed, is not executable, or not in \$PATH" 1>&2
    echo 1>&2
    echo "$0: notice: obtain jp from: $JP_REPO" 1>&2
    echo 1>&2
    echo "$0: notice: If on macOS, using homebrew, install via: brew tap davidhoo/tap ; brew install jsonpath" 1>&2
    echo 1>&2
    echo "$0: notice: or via go install: github.com/davidhoo/jsonpath/cmd/jp@latest" 1>&2
    exit 5
fi


# determine files that are found in and/or will be created in an entry
#
export ENTRY_JSON="$YYYY_DIR/.entry.json"


# parameter debugging
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
    echo "$0: debug[3]: JP_REPO=$JP_REPO" 1>&2
    echo "$0: debug[3]: JP_TOOL=$JP_TOOL" 1>&2
    echo "$0: debug[3]: VERGE=$VERGE" 1>&2
    echo "$0: debug[3]: JPARSE_TOOL=$JPARSE_TOOL" 1>&2
    echo "$0: debug[3]: MIN_JPARSE_VERSION=$MIN_JPARSE_VERSION" 1>&2
    echo "$0: debug[3]: JPARSE_VERSION=$JPARSE_VERSION" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# verify .entry.json is readable non-empty files
#
if [[ ! -e $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
    exit 1
fi
if [[ ! -f $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a regular file: $ENTRY_JSON" 1>&2
    exit 1
fi
if [[ ! -r $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
    exit 1
fi
if [[ ! -s $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a non-empty readable file: $ENTRY_JSON" 1>&2
    exit 1
fi



# verify that .entry.json is valid JSON
#
if [[ -z $NOOP ]]; then
    "$JPARSE_TOOL" -q -- "$ENTRY_JSON" 1>&2
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JPARSE_TOOL -q -- $ENTRY_JSON filed," \
	     "error code: $status" 1>&2
	exit 1
    fi

# case: -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, did not execute:" \
		"$JPARSE_TOOL -q -- $ENTRY_JSON" 1>&2
fi


# ####################################################################################### #
#                                                                                         #
# SYNC: The effect of the following code block that assigns $DISPLAY_VIA_GITHUB based on  #
#       the value of $FILE_PATH or $DISPLAY_AS must be synced with equivalent code blocks #
#       from the following (look for this comment block:                                  #
#                                                                                         #
#           bin/bad-display-as.sh                                                         #
#           bin/cvt-submission.sh                                                         #
#           bin/update-entry.sh                                                           #
#                                                                                         #
# ####################################################################################### #

# determine the types of "display_as" values in the manifest of the .entry.json file
#
export PATTERN='$.manifest[*].display_as'
unset DISPLAY_AS_SET
DISPLAY_AS_SET=()
readarray -t DISPLAY_AS_SET < <("$JP_TOOL" --no-color -p "$PATTERN" -f "$ENTRY_JSON" 2>/dev/null |
				grep -E -v '^[][]|^null$' |
				sed -e 's;^\s*";;' -e 's;",*$;;' |
				LC_ALL=C sort |
				uniq)
status0="${PIPESTATUS[0]}"
if [[ $status0 -ne 0 ]]; then
    echo "$0: ERROR: $JP_TOOL --no-color -p $PATTERN -f $ENTRY_JSON failed," \
	 "error code: $status" 1>&2
    exit 1
fi
if [[ ${#DISPLAY_AS_SET[@]} -le 0 ]]; then
    echo "$0: ERROR: no display_as members found in manifest array in: $ENTRY_JSON" 1>&2
    exit 1
fi

export GITHUB_VIEW_REQUIRED=""
for DISPLAY_AS in "${DISPLAY_AS_SET[@]}"; do

    case "$DISPLAY_AS" in

    # determine if GitHub is required for known "display_as" value
    #
    # If $GITHUB_VIEW_REQUIRED == "true",  then "display_via_github" just be true
    # If $GITHUB_VIEW_REQUIRED == "false", then "display_via_github" just be false
    #
    agrep)	GITHUB_VIEW_REQUIRED="true" ;;
    asm)	GITHUB_VIEW_REQUIRED="true" ;;
    basic)	GITHUB_VIEW_REQUIRED="true" ;;
    bf)		GITHUB_VIEW_REQUIRED="true" ;;
    binary)	GITHUB_VIEW_REQUIRED="false" ;;
    bootimg)	GITHUB_VIEW_REQUIRED="false" ;;
    bz2)	GITHUB_VIEW_REQUIRED="false" ;;
    bzip2)	GITHUB_VIEW_REQUIRED="false" ;;
    c)		GITHUB_VIEW_REQUIRED="true" ;;
    cabbage)	GITHUB_VIEW_REQUIRED="true" ;;
    css)	GITHUB_VIEW_REQUIRED="true" ;;
    forth)	GITHUB_VIEW_REQUIRED="true" ;;
    gitignore)	GITHUB_VIEW_REQUIRED="true" ;;
    gzip)	GITHUB_VIEW_REQUIRED="false" ;;
    haskell)	GITHUB_VIEW_REQUIRED="true" ;;
    html)	GITHUB_VIEW_REQUIRED="false" ;;
    image)	GITHUB_VIEW_REQUIRED="false" ;;
    java)	GITHUB_VIEW_REQUIRED="true" ;;
    javascript)	GITHUB_VIEW_REQUIRED="true" ;;
    json)	GITHUB_VIEW_REQUIRED="true" ;;
    lisp)	GITHUB_VIEW_REQUIRED="true" ;;
    makefile)	GITHUB_VIEW_REQUIRED="true" ;;
    man)	GITHUB_VIEW_REQUIRED="true" ;;
    markdown)	GITHUB_VIEW_REQUIRED="true" ;;
    midi)	GITHUB_VIEW_REQUIRED="false" ;;
    mod)	GITHUB_VIEW_REQUIRED="false" ;;
    mp3)	GITHUB_VIEW_REQUIRED="false" ;;
    oc)		GITHUB_VIEW_REQUIRED="true" ;;
    patch)	GITHUB_VIEW_REQUIRED="true" ;;
    path)	GITHUB_VIEW_REQUIRED="true" ;;
    pdf)	GITHUB_VIEW_REQUIRED="false" ;;
    perl)	GITHUB_VIEW_REQUIRED="true" ;;
    php)	GITHUB_VIEW_REQUIRED="true" ;;
    python)	GITHUB_VIEW_REQUIRED="true" ;;
    rgb)	GITHUB_VIEW_REQUIRED="false" ;;
    ruby)	GITHUB_VIEW_REQUIRED="true" ;;
    sed)	GITHUB_VIEW_REQUIRED="true" ;;
    shellscript)GITHUB_VIEW_REQUIRED="true" ;;
    sorta)	GITHUB_VIEW_REQUIRED="true" ;;
    spec)	GITHUB_VIEW_REQUIRED="true" ;;
    spreadsheet)GITHUB_VIEW_REQUIRED="false" ;;
    tarball)	GITHUB_VIEW_REQUIRED="false" ;;
    tbz2)	GITHUB_VIEW_REQUIRED="false" ;;
    tex)	GITHUB_VIEW_REQUIRED="true" ;;
    text)	GITHUB_VIEW_REQUIRED="true" ;;
    wav)	GITHUB_VIEW_REQUIRED="false" ;;
    xml)	GITHUB_VIEW_REQUIRED="true" ;;
    zip)	GITHUB_VIEW_REQUIRED="false" ;;

    *)  echo "$0: Warning: unknown display_as value: \"$DISPLAY_AS\" found in: $ENTRY_JSON" 1>&2
	EXIT_CODE=1 # exit 1
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	;;
    esac

    # determine pattern that shouldn't be found
    #
    # If $GITHUB_VIEW_REQUIRED == "true",  then "display_via_github" just be true
    # If $GITHUB_VIEW_REQUIRED == "false", then "display_via_github" just be false
    #
    if [[ $GITHUB_VIEW_REQUIRED == "true" ]]; then
	PATTERN='$.manifest[?(@.display_as=="'"$DISPLAY_AS"'" && @.display_via_github==false)]'
    else
	PATTERN='$.manifest[?(@.display_as=="'"$DISPLAY_AS"'" && @.display_via_github==true)]'
    fi

    # look for invalid "display_as" / "display_via_github" combos
    #
    if [[ -z $NOOP ]]; then
	FOUND=$("$JP_TOOL" --no-color -p "$PATTERN" -f "$ENTRY_JSON" 2>&1)
	status="$?"

    # case: -n
    #
    else
	FOUND=""
	status=0
    fi
    #
    if [[ $FOUND == "null" ]]; then
	FOUND=""
    fi

    # report on test if needed
    #
    if [[ $status -ne 0 ]]; then
	echo "$0: Warning:" \
	    "$JP_TOOL --no-color -p $PATTERN -f $ENTRY_JSON failed, error: $status" 1>&2
	EXIT_CODE=8 # exit 8
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	continue
    fi
    if [[ -n $FOUND ]]; then
	if [[ $GITHUB_VIEW_REQUIRED == "true" ]]; then
	    echo "$0: Warning: found display_as \"$DISPLAY_AS\" with display_via_github false in: $ENTRY_JSON" 1>&2
	else
	    echo "$0: Warning: found display_as \"$DISPLAY_AS\" with display_via_github true in: $ENTRY_JSON" 1>&2
	fi
	EXIT_CODE=1 # exit 1
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	continue
    fi
done


# process exit code
#
case "$EXIT_CODE" in
0)
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: display_as / display_via_github combos OK in: $ENTRY_JSON" 1>&2
    fi
    ;;
1)
    echo "$0: ERROR: invalid display_as / display_via_github combo(s) found in: $ENTRY_JSON" 1>&2
    ;;
8)
    echo "$0: ERROR: jp: $JP_TOOL tool failed processing: $ENTRY_JSON" 1>&2
    ;;
*)
    echo "$0: ERROR: unexpected EXIT_CODE value: $EXIT_CODE for $ENTRY_JSON" 1>&2
    exit 10
    ;;
esac


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit "$EXIT_CODE"
