#!/usr/bin/env bash
#
# subst.entry-index.sh - print substitutions for a entry's index.html
#
# This tool is intended to be used as a "output tool" during getopt phases 1 and 3.
# In particular, lines in the bin/md2html.cfg configuration file of the form:
#
#	-o
#	bin/subst.entry-index.sh
#
# will cause tools such as bin/md2html.sh to execute this code.
#
# The final arg will be in YYYY/dir form, and will be called from
# the topdir directory under which the YYYY/dir entry directory must be found.
# Tools such as bin/readme2index.sh, when run via bin/all-run.sh:
#
#	bin/all-run.sh -v 3 bin/readme2index.sh -v 1
#
# will supply the YYYY/dir arg.  This may be more easily done via make:
#
#	make entry_index
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
export VERSION="1.3.4 2024-07-28"
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
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-u repo_top_url] [-U URL] [-w site_url] [-e string ..] [-E exitcode]
			YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-u repo_top_url	Top level URL of target git repo (def: $REPO_TOP_URL)
	-U url		URL of HTML file being formed (def: $URL)
	-w site_url	Base URL of the website (def: $SITE_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	YYYY/dir	path from topdir to entry directory: must contain the files: README.md, .path and .entry.json

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

# Write the award name to standard output (stdout)
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the .entry.json file  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
# usage:
#       output_award YYYY/dir/.entry.json
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_award
{
    local ENTRY_JSON_PATH;	# the .entry.json path
    local AWARD_STRING;		# winning entry award string

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_award: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ENTRY_JSON_PATH="$1"
    if [[ ! -e $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json does not exist: $ENTRY_JSON_PATH" 1>&2
        return 2
    fi
    if [[ ! -f $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json is not a file: $ENTRY_JSON_PATH" 1>&2
        return 3
    fi
    if [[ ! -r $ENTRY_JSON_PATH ]]; then
        echo "$0: ERROR: in output_award: .entry.json is not a readable file: $ENTRY_JSON_PATH" 1>&2
        return 4
    fi

    # obtain the award string
    #
    AWARD_STRING=$(grep -F '"award" : "'  "$ENTRY_JSON_PATH" | sed -e 's/^.*"award" : "//' -e 's/",//')
    if [[ -z $AWARD_STRING ]]; then
        echo "$0: ERROR: in output_award: no award found in .entry.json file: $ENTRY_JSON_PATH" 1>&2
        return 5
    fi
    echo "$AWARD_STRING"
    return 0
}

# setup
#
export NOOP=
export DO_NOT_PROCESS=

# parse command line
#
while getopts :hv:Vd:D:nNu:U:w:e:E: flag; do
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
    u) REPO_TOP_URL="$OPTARG"
	# GitHub puts individual files under the "blob/master" sub-directory.
	export REPO_URL="$REPO_TOP_URL/blob/master"
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

# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"

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
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 6
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
export DOT_PATH="$YYYY_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 7
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
export DOT_PATH_CONTENT
if [[ $ENTRY_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $ENTRY_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 7
fi
export ENTRY_JSON="$YYYY_DIR/.entry.json"
if [[ ! -e $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
    exit 7
fi
if [[ ! -f $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
    exit 7
fi
if [[ ! -r $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
    exit 7
fi

# verify we have our awk script
#
export ENTRY_NAVBAR_AWK="$BIN_DIR/subst.entry-navbar.awk"
if [[ ! -e $ENTRY_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.entry-navbar.awk does not exist: $ENTRY_NAVBAR_AWK" 1>&2
    exit 5
fi
if [[ ! -f $ENTRY_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.entry-navbar.awk is not a file: $ENTRY_NAVBAR_AWK" 1>&2
    exit 5
fi
if [[ ! -r $ENTRY_NAVBAR_AWK ]]; then
    echo "$0: ERROR: bin/subst.entry-navbar.awk is not a readable file: $ENTRY_NAVBAR_AWK" 1>&2
    exit 5
fi

# determine award
#
AWARD=$(output_award "$ENTRY_JSON")
export AWARD
if [[ -z $AWARD ]]; then
    echo "$0: ERROR: cannot determine award for $YEAR_DIR from: $ENTRY_JSON" 1>&2
    exit 1
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
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: DOT_PATH_CONTENT=$DOT_PATH_CONTENT" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
    echo "$0: debug[3]: ENTRY_NAVBAR_AWK=$ENTRY_NAVBAR_AWK" 1>&2
    echo "$0: debug[3]: AWARD=$AWARD" 1>&2
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
echo "TITLE=$YYYY_DIR - $AWARD"

# output DESCRIPTION substitution
#
echo "-s"
echo "DESCRIPTION=$YEAR_DIR IOCCC entry $ENTRY_DIR - $AWARD"

# output KEYWORDS substitution
#
echo "-s"
echo "KEYWORDS=IOCCC, $YEAR_DIR, IOCCC $YEAR_DIR, IOCCC entry, $ENTRY_DIR, $AWARD"

# output HEADER_2 substitution
#
echo "-s"
echo "HEADER_2=$YYYY_DIR - $AWARD"

# output navbar left hand side links
#
awk -v entry_path="$YYYY_DIR" -f "$ENTRY_NAVBAR_AWK" "$DOT_YEAR"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: subst.entry-navbar.awk failed, error: $status" 1>&2
    exit 1
fi

# output navbar right hand side links
#
echo "-s"
if [[ -f $YYYY_DIR/$ENTRY_DIR.c ]]; then
    echo "PROG_LINK=$REPO_URL/$YYYY_DIR/$ENTRY_DIR.c"
elif [[ -f $YYYY_DIR/prog.c ]]; then
    echo "PROG_LINK=$REPO_URL/$YYYY_DIR/prog.c"
else
    echo "$0: ERROR: cannot determine source code file for: $YYYY_DIR" 1>&2
    exit 7
fi
echo "-s"
echo "PROG_TEXT=C code"
echo "-s"
echo "MAKEFILE_LINK=$REPO_URL/$YYYY_DIR/Makefile"
echo "-s"
echo "MAKEFILE_TEXT=Makefile"
echo "-s"
echo "INVENTORY_LINK=#inventory"
echo "-s"
echo "INVENTORY_TEXT=Inventory"

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
