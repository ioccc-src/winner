#!/usr/bin/env bash
#
# gen-other-html.sh - generate entry HTML files from markdown other than README.md to index.html HTML files
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
export VERSION="1.3 2024-08-11"
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
export TAGLINE="bin/$NAME"
export MD2HTML_SH="bin/md2html.sh"
export PANDOC_WRAPPER="bin/pandoc-wrapper.sh"
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
#
export NOOP=
export DO_NOT_PROCESS=
export QUICK_MODE=
export EXIT_CODE="0"

# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-t tagline] [-T md2html.sh] [-Q] [-p tool] [-w site_url]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: The '-D docroot/' is passed as leading options on tool command lines.
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	-t tagline	string to write about the tool that formed the markdown content (def: $TAGLINE)
			NOTE: The '-t tagline' is passed as leading options on tool command lines.
	-T md2html.sh	run 'markdown to html tool' to convert markdown into HTML (def: $MD2HTML_SH)
			NOTE: The '-T md2html.sh' is passed as leading options on tool command lines.
	-Q	        quick mode, do not run $MD2HTML_SH unless markdown is out of date (def: do)

	-p tool		run 'pandoc wrapper tool' (not pandoc path) during HTML phase number 21 (def: use $PANDOC_WRAPPER)

	-w site_url	Base URL of the website (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on tool command lines.

NOTE: Any '-D docroot/', '-t tagline', '-T md2html.sh', '-p tool', '-w site_url'
      are passed to the 'tool' at the beginning of the command line, and
      before any optional 'more_options' and before the final YYYY/dir argument.

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


# parse command line
#
while getopts :hv:Vd:D:nNt:T:Qp:w: flag; do
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
	TOOL_OPTION+=("-D")
	TOOL_OPTION+=("$DOCROOT_SLASH")
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    t) # parse -t tagline
	case "$OPTARG" in
	*"'"*)
	    echo "$0: ERROR: in -t tagline, the tagline may not contain a single-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*'"'*)
	    echo "$0: ERROR: in -t tagline, the tagline may not contain a double-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*) ;;
	esac
	TAGLINE="$OPTARG"
	;;
    T) MD2HTML_SH="$OPTARG"
	TOOL_OPTION+=("-T")
	TOOL_OPTION+=("$MD2HTML_SH")
	;;
    Q) QUICK_MODE="-Q"
	;;
    p) PANDOC_WRAPPER="$OPTARG"
	TOOL_OPTION+=("-p")
	TOOL_OPTION+=("$PANDOC_WRAPPER")
	;;
    w) SITE_URL="$OPTARG"
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
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: expected 0 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
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

# verify that the md2html.sh is an executable file
#
if [[ ! -e $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh does not exist: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -f $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh is not a regular file: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -x $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh is not an executable file: $MD2HTML_SH" 1>&2
    exit 5
fi

# always set the tagline
#
TOOL_OPTION+=("-t")
TOOL_OPTION+=("$TAGLINE")
TOOL_OPTION+=("-w")
TOOL_OPTION+=("$SITE_URL")

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
    echo "$0: debug[3]: MD2HTML_SH=$MD2HTML_SH" 1>&2
    echo "$0: debug[3]: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: QUICK_MODE=$QUICK_MODE" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
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

# create a temporary exit code
#
# It is a pain to set the EXIT_CODE deep inside a loop, so we write the EXIT_CODE into a file
# and read the file (setting EXIT_CODE again) after the loop.  A hack, but good enough for our needs.
#
export TMP_EXIT_CODE=".tmp.$NAME.EXIT_CODE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary exit code: $TMP_EXIT_CODE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_EXIT_CODE; exit' 0 1 2 3 15
    rm -f "$TMP_EXIT_CODE"
    if [[ -e $TMP_EXIT_CODE ]]; then
	echo "$0: ERROR: cannot remove temporary exit code: $TMP_EXIT_CODE" 1>&2
	exit 10
    fi
    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
    if [[ ! -e $TMP_EXIT_CODE ]]; then
	echo "$0: ERROR: cannot create temporary exit code: $TMP_EXIT_CODE" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary exit code is not used: $TMP_EXIT_CODE" 1>&2
fi

# process each year
#
export YYYY
for YYYY in $(< "$TOP_FILE"); do

    # debug YYYY
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: starting to process year: $YYYY" 1>&2
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
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: starting to process year/dir: $YYYY_DIR" 1>&2
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

	# process all markdown files that are NOT README.md for this entry
	#
	find "$YYYY_DIR" -type f -name '*.md' ! -name README.md | while read -r MD_FILE; do

	    # basename of MD_FILE
	    #
	    MD_BASENAME=$(basename "$MD_FILE")
	    export MD_BASENAME

	    # determine the HTML file
	    #
	    export HTML_FILE=${MD_FILE//\.md/.html}
	    HTML_BASENAME=$(basename "$HTML_FILE")
	    export HTML_BASENAME

	    # determine if we need to run the tool
	    #
	    # Check if the non-empty foo.html is newer than foo.md.
	    #
	    if [[ -n $QUICK_MODE ]]; then
		if [[ $V_FLAG -ge 5 ]]; then
		    echo "$0: debug[5]: listing of important files, if they exist, starts below" 1>&2
		    ls -lRt -- "$HTML_FILE" "$MD_FILE" 2>/dev/null
		    echo "$0: debug[5]: listing of important files, if they exist, ends above" 1>&2
		fi
		if [[ -s $HTML_FILE && $HTML_FILE -nt $MD_FILE ]]; then
		    if [[ $V_FLAG -ge 3 ]]; then
			echo "$0: debug[3]: does not need to be updated: $HTML_FILE" 1>&2
		    fi
		    continue
		fi
	    fi

	    # determine the description arg
	    #
	    export DESCRIPTION="DESCRIPTION=$MD_BASENAME for $YYYY_DIR"

	    # determine the keywords arg
	    #
	    KEYWORDS="KEYWORDS=IOCCC, $YYYY_DIR, $MD_BASENAME"
	    export KEYWORDS

	    # determine the HEADER_2 arg
	    #
	    export HEADER_2="HEADER_2=$HTML_BASENAME for $YYYY_DIR"

	    # determine the number of levels in path of MD_FILE from topdir
	    #
	    export NO_SLASH=${MD_FILE///}
	    LEVEL_CNT=$((${#MD_FILE} - ${#NO_SLASH}))
	    export LEVEL_CNT
	    if [[ $LEVEL_CNT -lt 2 ]]; then
		echo "$0: ERROR: expected at least 2 level from topdir: $TOPDIR to MD_FILE: $MD_FILE, found $LEVEL_CNT" 1>&2
		echo 12 > "$TMP_EXIT_CODE" # exit 12
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    ((SUB_LEVEL_CNT=LEVEL_CNT-2))
	    export SUB_LEVEL_CNT

	    # determine -D option string and path to entry index.html file
	    #
	    export D_OPTION="../../"
	    export INDEX_PATH="index.html"
	    for ((n=0; n<SUB_LEVEL_CNT; ++n)); do
		D_OPTION="../$D_OPTION"
		INDEX_PATH="../$INDEX_PATH"
	    done

	    # determine the UP_LINK
	    #
	    export UP_LINK="UP_LINK=$INDEX_PATH"

	    # determine UP_TEXT
	    #
	    export UP_TEXT="UP_TEXT=jump to index.html"

	    # run the MD2HTML_SH tool unless -n
	    #
	    if [[ -z $NOOP ]]; then

		if [[ $V_FLAG -ge 3 ]]; then
		    echo "$0: debug[3]: about to run: $MD2HTML_SH ${TOOL_OPTION[*]}" \
			 "-U $SITE_URL/$HTML_FILE" \
			 "-s $DESCRIPTION -s $KEYWORDS -s $HEADER_2" \
			 "-s REPO_URL=$REPO_URL -s SITE_URL=$SITE_URL" \
			 "-s $UP_LINK -s $UP_TEXT -D $D_OPTION -m $MD_FILE -v $V_FLAG --" \
			 "$MD_FILE $HTML_FILE" 1>&2
		fi
		"$MD2HTML_SH" "${TOOL_OPTION[@]}" \
		    -U "$SITE_URL/$HTML_FILE" \
		    -s "$DESCRIPTION" -s "$KEYWORDS" -s "$HEADER_2" \
		    -s "REPO_URL=$REPO_URL" -s "SITE_URL=$SITE_URL" \
		    -s "$UP_LINK" -s "$UP_TEXT" -D "$D_OPTION" -m "$MD_FILE" -v "$V_FLAG" -- \
		    "$MD_FILE" "$HTML_FILE"
		status="$?"
		if [[ $status -ne 0 ]]; then
		    echo "$0: ERROR: tool: $MD2HTML_SH ${TOOL_OPTION[*]}" \
			 "-U $SITE_URL/$HTML_FILE" \
			 "-s $DESCRIPTION -s $KEYWORDS -s $HEADER_2" \
			 "-s REPO_URL=$REPO_URL -s SITE_URL=$SITE_URL" \
			 "-s $UP_LINK -s $UP_TEXT -D $D_OPTION -m $MD_FILE -v $V_FLAG --" \
			 "$MD_FILE $HTML_FILE failed, error: $status" 1>&2
		    echo 1 > "$TMP_EXIT_CODE" # exit 1
		    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		    continue
		fi

	    # report disabled by -n
	    #
	    elif [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]}" \
		     "-s $DESCRIPTION -s $KEYWORDS -s $HEADER_2" \
		     "-s $UP_LINK -s $UP_TEXT -D $D_OPTION -m $MD_FILE -v $V_FLAG --" \
		     "$MD_FILE $HTML_FILE" 1>&2
	    fi
	done
    done
done
if [[ -z $NOOP ]]; then
    EXIT_CODE=$(< "$TMP_EXIT_CODE")
    if [[ -z $EXIT_CODE ]]; then
	echo "$0: ERROR: temporary exit file has no contents: $TMP_EXIT_CODE" 1>&2
	exit 13
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
