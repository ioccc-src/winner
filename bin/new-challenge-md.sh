#!/usr/bin/env bash
#
# new-challenge-md.sh - generate an initial challenge.md for an IOCCC year
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
export VERSION="2.0.0 2026-06-12"
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


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N] [-w site_url] YYYY

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	This option is ignored

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-w site_url	This option is ignored

	YYYY		IOCCC year

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:Vd:D:nNU:w: flag; do
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
    D)  ;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    U)  ;;
    w)  ;;
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
export YYYY="$1"


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


# verify that YYYY is an IOCCC year directory
#
if [[ ! -e $YYYY ]]; then
    echo "$0: ERROR: arg does not exist: $YYYY" 1>&2
    exit 6
fi
if [[ ! -d $YYYY ]]; then
    echo "$0: ERROR: arg is not a directory: $YYYY" 1>&2
    exit 6
fi
if [[ ! -r $YYYY ]]; then
    echo "$0: ERROR: arg is not a readable directory: $YYYY" 1>&2
    exit 6
fi


# verify that YYYY has a non-empty readable .year file
#
export DOT_YEAR="$YYYY/.year"
if [[ ! -e $DOT_YEAR ]]; then
    echo  "$0: ERROR: YYYY/.year does not exist: $DOT_YEAR" 1>&2
    exit 6
fi
if [[ ! -f $DOT_YEAR ]]; then
    echo  "$0: ERROR: YYYY/.year is not a regular file: $DOT_YEAR" 1>&2
    exit 6
fi
if [[ ! -r $DOT_YEAR ]]; then
    echo  "$0: ERROR: YYYY/.year is not an readable file: $DOT_YEAR" 1>&2
    exit 6
fi
if [[ ! -s $DOT_YEAR ]]; then
    echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $DOT_YEAR" 1>&2
    exit 6
fi


# verify that we have an inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 6
fi
export INC_DIR="inc"


# verify was have a readable challenge.md.start file
#
export CHALLENGE_MD_START="$INC_DIR/challenge.md.start"
if [[ ! -e $CHALLENGE_MD_START ]]; then
    echo  "$0: ERROR: inc/cchallenge.md.start does not exist: $CHALLENGE_MD_START" 1>&2
    exit 6
fi
if [[ ! -f $CHALLENGE_MD_START ]]; then
    echo  "$0: ERROR: inc/cchallenge.md.start is not a regular file: $CHALLENGE_MD_START" 1>&2
    exit 6
fi
if [[ ! -r $CHALLENGE_MD_START ]]; then
    echo  "$0: ERROR: inc/cchallenge.md.start is not an readable file: $CHALLENGE_MD_START" 1>&2
    exit 6
fi


# determine the name of our challenge.md file
#
export CHALLENGE_MD="$YYYY/challenge.md"


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
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: YYYY=$YYYY" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: CHALLENGE_MD_START=$CHALLENGE_MD_START" 1>&2
    echo "$0: debug[3]: CHALLENGE_MD=$CHALLENGE_MD" 1>&2
fi


# Do nothing if the challenge.md file exits
#
if [[ -e $CHALLENGE_MD ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: challenge.md already exists: $CHALLENGE_MD" 1>&2
    fi
    exit 0
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# create a temporary challenge.md file by loading it with the start challenge.md.start file
#
export TMP_CHALLENGE_MD=".tmp.$NAME.challenge.md.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown challenge.md file: $TMP_CHALLENGE_MD" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_CHALLENGE_MD; exit' 0 1 2 3 15
    rm -f "$TMP_CHALLENGE_MD"
    if [[ -e $TMP_CHALLENGE_MD ]]; then
	echo "$0: ERROR: cannot remove temporary challenge.md file: $TMP_CHALLENGE_MD" 1>&2
	exit 10
    fi
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to: cp -f -v -- $CHALLENGE_MD_START $TMP_CHALLENGE_MD" 1>&2
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	cp -f -v -- "$CHALLENGE_MD_START" "$TMP_CHALLENGE_MD"
	status="$?"
    else
	cp -f -- "$CHALLENGE_MD_START" "$TMP_CHALLENGE_MD"
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: cp -f -v -- $CHALLENGE_MD_START $TMP_CHALLENGE_MD filed," \
	     "error code: $status" 1>&2
	exit 11
    fi
    if [[ ! -e $TMP_CHALLENGE_MD ]]; then
	echo "$0: ERROR: cannot create temporary challenge.md file: $TMP_CHALLENGE_MD" 1>&2
	exit 12
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary challenge.md file is not used: $TMP_CHALLENGE_MD" 1>&2
fi


# form an initial challenge.md file
#
if [[ -z $NOOP ]]; then

    # add a section for each winning entry listed in .year
    #
    LC_ALL=C sort -d "$DOT_YEAR" | while read -r YYYY_DIR; do

	# determine entry directory name
	#
	export ENTRY_DIR=${YYYY_DIR#*/}

	# echo heading
	#
	echo
	echo
	echo "<div id=\"$ENTRY_DIR\">"
	echo "## Fun challenge for [$YYYY_DIR]($ENTRY_DIR/index.html)"
	echo '</div>'

	# output placeholder for Judges to modify
	#
	echo
	echo 'XXX - The IOCCC Judges will write stuff here - XXX'

	# report that the fun challenge is open
	#
	echo
	echo "This fun challenge for **$YYYY_DIR** is still **OPEN**."

	# Add FAQ info
	#
	echo
	echo 'See also the'
	echo 'FAQ on "[submit a fun challenge solution](../faq.html#solve_fun_challenge)".'

    done >> "$TMP_CHALLENGE_MD"

    # case: temporary challenge.md file created, move it in plave
    #
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to: mv -f -- $TMP_CHALLENGE_MD $CHALLENGE_MD" 1>&2
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	mv -f -v -- "$TMP_CHALLENGE_MD" "$CHALLENGE_MD" 1>&2
	status="$?"
    else
	mv -f -- "$TMP_CHALLENGE_MD" "$CHALLENGE_MD" 1>&2
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -- $TMP_CHALLENGE_MD $CHALLENGE_MD filed," \
	     "error code: $status" 1>&2
	exit 13
    elif [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: created initial challenge.md file: $CHALLENGE_MD" 1>&2
    fi
    if [[ ! -s $CHALLENGE_MD ]]; then
	echo "$0: ERROR: not a non-empty initial challenge.md file: $CHALLENGE_MD" 1>&2
	exit 14
    fi

# case: -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, "
	     "did not create an initial challenge.md file:  $CHALLENGE_MD" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
