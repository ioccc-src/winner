#!/usr/bin/env bash
#
# subst.year-index.sh - print substitutions for a year's index.html
#
# This tool is intended to be used as a "output tool" during getopt phases 1 and 3.
# In particular, lines in the bin/md2html.cfg configuration file of the form:
#
#	-o
#	bin/subst.year-index.sh
#
# will cause tools such as gen-year-index.sh to execute this code.
#
# The final arg will be in YYYY form, and will be called from
# the topdir directory under which the YYYY directory must be found.
# Tools such as bin/gen-year-index.sh, when run via bin/all-run.sh:
#
#	bin/all-years.sh -v 1 bin/gen-year-index.sh -v 1
#
# will supply the YYYY arg.  This may be more easily done via make:
#
#	make gen_year_index
#
# IMPORTANT: Each command line option / argument MUST be printed on a separate line!
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
export VERSION="1.1.5 2024-08-05"
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
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://www.ioccc.org"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-U URL] [-w site_url] [-e string ..] [-E exitcode]
			YYYY

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-U url		URL of HTML file being formed (def: $URL)
	-w site_url	Base URL of the website (def: $SITE_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	YYYY		path from topdir to year directory: must contain the files: README.md, .path and .entry.json

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
 >= 10         internal error

$NAME version: $VERSION"


# output_ordinal
#
# Write the numerical ordinal form of a non-negative integer to standard output (stdout)
#
# usage:
#       output_ordinal integer
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function output_ordinal
{
    local INTEGER;	# integer argument

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_ordinal: expected 1 arg, found $#" 1>&2
        return 1
    fi
    INTEGER="$1"
    if [[ $INTEGER =~ ^-?[0-9]+$ ]]; then
	:
    else
	echo "$0: ERROR: argument is not an integer: $INTEGER" 1>&2
	return 2
    fi
    if [[ $INTEGER -lt 0 ]]; then
	echo "$0: ERROR: integer is negative: $INTEGER" 1>&2
	return 3
    fi

    # case: 11, 12, 13 are N-th
    #
    if [[ $INTEGER -ge 11 && $INTEGER -le 13 ]]; then
	echo "${INTEGER}th"

    # case: 1 mod 10 is N-st
    #
    elif [[ $((INTEGER % 10)) -eq 1 ]]; then
	echo "${INTEGER}st"

    # case: 2 mod 10 is N-nd
    #
    elif [[ $((INTEGER % 10)) -eq 2 ]]; then
	echo "${INTEGER}nd"

    # case: 3 mod 10 is N-rd
    #
    elif [[ $((INTEGER % 10)) -eq 3 ]]; then
	echo "${INTEGER}rd"

    # case: everything else is N-th
    #
    else
	echo "${INTEGER}th"
    fi
    return 0
}


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:Vd:D:nNU:w:e:E: flag; do
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
	   echo "$USAGE" 1>&2
	   exit 3
	   ;;
	esac
	DOCROOT_SLASH="$OPTARG"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    U) URL="$OPTARG"
	;;
    w) SITE_URL="$OPTARG"
	;;
    e) echo "$OPTARG" 1>&2
	;;
    E) exit "$OPTARG"
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
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
    exit 3
fi
#
export YEAR_ARG="$1"


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


# verify that we have an author subdirectory
#
export AUTHOR_PATH="$TOPDIR/author"
if [[ ! -d $AUTHOR_PATH ]]; then
    echo "$0: ERROR: author is not a directory under topdir: $AUTHOR_PATH" 1>&2
    exit 6
fi
export AUTHOR_DIR="author"


# verify that we have an inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 6
fi
export INC_DIR="inc"


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


# verify we have our awk script
#
export YEAR_NAVBAR_AWK="$BIN_DIR/subst.year-navbar.awk"
if [[ ! -e $YEAR_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.year-navbar.awk does not exist: $YEAR_NAVBAR_AWK" 1>&2
    exit 5
fi
if [[ ! -f $YEAR_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.year-navbar.awk is not a file: $YEAR_NAVBAR_AWK" 1>&2
    exit 5
fi
if [[ ! -r $YEAR_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.year-navbar.awk is not a readable file: $YEAR_NAVBAR_AWK" 1>&2
    exit 5
fi


# verify that YEAR_ARG is a entry directory
#
if [[ ! -d $YEAR_ARG ]]; then
    echo "$0: ERROR: arg is not a directory: $YEAR_ARG" 1>&2
    exit 3
fi
if [[ ! -w $YEAR_ARG ]]; then
    echo "$0: ERROR: arg is not a writable directory: $YEAR_ARG" 1>&2
    exit 3
fi
export YEAR_DIR=${YEAR_ARG%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in YYYY/dir form: $YEAR_ARG" 1>&2
    exit 3
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


# determine The N-th IOCCC string
#
LINE_NUM=$(sed -n "/$YEAR_DIR/=" "$TOP_FILE" | head -1)
export LINE_NUM
if [[ -z $LINE_NUM ]]; then
    echo '-e'
    echo "cannot determine line number in $TOP_FILE for year: $YEAR_DIR"
    echo '-E'
    echo 210
    exit 210
fi
ORDINAL=$(output_ordinal "$LINE_NUM")
export ORDINAL
if [[ -z $ORDINAL ]]; then
    echo '-e'
    echo "cannot determine ordinal for: $LINE_NUM"
    echo '-E'
    echo 211
    exit 211
fi


# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: YEAR_ARG=$YEAR_ARG" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: YEAR_NAVBAR_AWK=$YEAR_NAVBAR_AWK" 1>&2
    echo "$0: debug[3]: LINE_NUM=$LINE_NUM" 1>&2
    echo "$0: debug[3]: ORDINAL=$ORDINAL" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# output TITLE substitution
#
echo "-s"
echo "TITLE=$YEAR_DIR - The $ORDINAL IOCCC"


# output DESCRIPTION substitution
#
echo "-s"
echo "DESCRIPTION=IOCCC Year $YEAR_DIR"


# output KEYWORDS substitution
#
echo "-s"
echo "KEYWORDS=IOCCC, $YEAR_DIR, IOCCC $YEAR_DIR, IOCCC entry, The $ORDINAL IOCCC"


# output HEADER_2 substitution
#
echo "-s"
echo "HEADER_2=$YEAR_DIR - The $ORDINAL IOCCC"


# output navbar left hand side links
#
awk -v year_arg="$YEAR_DIR" -f "$YEAR_NAVBAR_AWK" "$TOP_FILE"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: subst.year-navbar.awk failed, error: $status" 1>&2
    exit 1
fi


# output navbar right hand side links
#
echo "-s"
echo "INVENTORY_LINK=#inventory"
echo "-s"
echo "INVENTORY_TEXT=Inventory"


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
