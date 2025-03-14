#!/usr/bin/env bash
#
# gen-location.sh - create the top level location.html page
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


# IOCCC requires use of C locale
#
export LC_ALL="C"
export LANG="C"
export LC_NUMERIC="C"


# set variables referenced in the usage message
#
export VERSION="2.0.0 2025-03-13"
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
JSTRDECODE=$(type -P jstrdecode)
export JSTRDECODE
if [[ -z $JSTRDECODE ]]; then
    echo "$0: FATAL: jstrdecode is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install jstrdecode:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
export MIN_JSTRDECODE_VERSION="2.1.2"
JSTRDECODE_VERSION=$("$JSTRDECODE" -V | head -1 | awk '{print $3;}')
if ! "$VERGE" "$JSTRDECODE_VERSION" "$MIN_JSTRDECODE_VERSION"; then
    echo "$0: FATAL: jstrdecode version: $JSTRDECODE_VERSION < minimum version: $MIN_JSTRDECODE_VERSION" 1>&2
    echo "$0: notice: consider updating jstrdecode from mkiocccentry repo" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
#
export DOCROOT_SLASH="./"
export TAGLINE="bin/$NAME"
export PANDOC_WRAPPER="bin/pandoc-wrapper.sh"
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://www.ioccc.org"
#
export NOOP=
export DO_NOT_PROCESS=
export QUICK_MODE=


# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-t tagline] [-Q] [-w site_url]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
			NOTE: The '-d topdir' is passed as leading options on tool command lines.
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: The '-D docroot/' is passed as leading options on tool command lines.
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
			NOTE: -n is passed to tool
	-N		do not process anything, just parse arguments (def: process something)

	-t tagline	string to write about the tool that formed the markdown content (def: $TAGLINE)
			NOTE: 'tagline' may be enclosed within, but may NOT contain an internal single-quote, or double-quote.

	-Q	        quick mode, do not run $MD2HTML_SH unless markdown is out of date (def: do)

	-w site_url	Base URL of the website (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on tool command lines.

NOTE: Any '-D docroot/', '-t tagline', '-v level', '-w site_url' are passed to 'md2html.sh' tool.

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
while getopts :hv:Vd:D:nNt:Qw: flag; do
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
	TOOL_OPTION+=("-d")
	TOOL_OPTION+=("$TOPDIR")
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
	# -D docroot/ always added after arg parsing
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
	    echo "$USAGE" 1>&2
	    exit 3
	    ;;
	*'"'*)
	    echo "$0: ERROR: in -t tagline, the tagline may not contain a double-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    echo "$USAGE" 1>&2
	    exit 3
	    ;;
	*) ;;
	esac
	TAGLINE="$OPTARG"
	# -t tagline always added after arg parsing
	;;
    Q) QUICK_MODE="-Q"
	;;
    w) SITE_URL="$OPTARG"
	TOOL_OPTION+=("-w")
	TOOL_OPTION+=("$SITE_URL")
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
# remove the options
#
shift $(( OPTIND - 1 ));
#
# verify arg count and parse args
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
#
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: expected 0 args, found: $#" 1>&2
    exit 3
fi


# always add the '-v level' option, unless level is empty, to the set of options passed to the md2html.sh tool
#
if [[ -n $V_FLAG ]]; then
    TOOL_OPTION+=("-v")
    TOOL_OPTION+=("$V_FLAG")
fi


# always add the '-t tagline' option, unless tagline is empty, to the set of options passed to the md2html.sh tool
#
if [[ -n $TAGLINE ]]; then
    TOOL_OPTION+=("-t")
    TOOL_OPTION+=("$TAGLINE")
fi


# always add the '-U URL' for the top level location.html file
#
TOOL_OPTION+=("-U")
TOOL_OPTION+=("$SITE_URL/location.html")


# always add the '-D docroot/' for the top level location.html file
#
TOOL_OPTION+=("-D")
TOOL_OPTION+=("$DOCROOT_SLASH")


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


# verify that the bin/md2html.sh tool is executable
#
export MD2HTML_SH="$BIN_DIR/md2html.sh"
if [[ ! -e $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh does not exist: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -f $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not a regular file: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -x $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not an executable file: $MD2HTML_SH" 1>&2
    exit 5
fi


# verify that the bin/jval-wrapper.sh tool is executable
#
JVAL_WRAPPER="$BIN_DIR/jval-wrapper.sh"
if [[ ! -e $JVAL_WRAPPER ]]; then
    echo  "$0: ERROR: bin/jval-wrapper.sh does not exist: $JVAL_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -f $JVAL_WRAPPER ]]; then
    echo  "$0: ERROR: bin/jval-wrapper.sh is not a regular file: $JVAL_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -x $JVAL_WRAPPER ]]; then
    echo  "$0: ERROR: bin/jval-wrapper.sh is not an executable file: $JVAL_WRAPPER" 1>&2
    exit 5
fi


# find the location tool
#
LOCATION_TOOL=$(type -P location)
export LOCATION_TOOL
if [[ ! -x $LOCATION_TOOL ]]; then
    echo "$0: ERROR: cannot find the location executable along \$PATH" 1>&2
    echo "$0: notice: location tool comes from this repo: https://github.com/ioccc-src/mkiocccentry" 1>&2
    exit 5
fi


# note location.html file
#
export LOCATION_HTML="location.html"


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: LC_ALL=$LC_ALL" 1>&2
    echo "$0: debug[3]: LANG=$LANG" 1>&2
    echo "$0: debug[3]: LC_NUMERIC=$LC_NUMERIC" 1>&2
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: VERGE=$VERGE" 1>&2
    echo "$0: debug[3]: JSTRDECODE=$JSTRDECODE" 1>&2
    echo "$0: debug[3]: MIN_JSTRDECODE_VERSION=$MIN_JSTRDECODE_VERSION" 1>&2
    echo "$0: debug[3]: JSTRDECODE_VERSION=$JSTRDECODE_VERSION" 1>&2
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
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: MD2HTML_SH=$MD2HTML_SH" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: LOCATION_TOOL=$LOCATION_TOOL" 1>&2
    echo "$0: debug[3]: LOCATION_HTML=$LOCATION_HTML" 1>&2
fi

# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# case: -Q (quick mode)
#
# Do nothing if authors.html is newer than all author/author_handle.json files.
#
if [[ -n $QUICK_MODE ]]; then
    NEWER=$(find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' -newer "$LOCATION_HTML" 2>/dev/null)
    if [[ -z $NEWER ]]; then
	exit 0
    fi
fi


# create a temporary location markdown file
#
export TMP_LOC_MD=".tmp.$NAME.LOC_MD.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary location markdown file: $TMP_LOC_MD" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_LOC_MD; exit' 0 1 2 3 15
    rm -f "$TMP_LOC_MD"
    if [[ -e $TMP_LOC_MD ]]; then
	echo "$0: ERROR: cannot remove temporary location markdown file: $TMP_LOC_MD" 1>&2
	exit 10
    fi
    :> "$TMP_LOC_MD"
    if [[ ! -e $TMP_LOC_MD ]]; then
	echo "$0: ERROR: cannot create temporary location markdown file: $TMP_LOC_MD" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary location markdown file is not used: $TMP_LOC_MD" 1>&2
fi


# create a temporary location sort_word handle name set
#
export TMP_LOC_WORD_HANDLE_NAME_SET=".tmp.$NAME.LOC_AUTHOR_HANDLE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary location sort_word handle name set: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_LOC_MD $TMP_LOC_WORD_HANDLE_NAME_SET; exit' 0 1 2 3 15
    rm -f "$TMP_LOC_WORD_HANDLE_NAME_SET"
    if [[ -e $TMP_LOC_WORD_HANDLE_NAME_SET ]]; then
	echo "$0: ERROR: cannot remove temporary location sort_word handle name set: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
	exit 12
    fi
    :> "$TMP_LOC_WORD_HANDLE_NAME_SET"
    if [[ ! -e $TMP_LOC_WORD_HANDLE_NAME_SET ]]; then
	echo "$0: ERROR: cannot create temporary location sort_word handle name set: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary location sort_word handle name set is not used: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
fi


# create a temporary location count set
#
export TMP_LOC_COUNT=".tmp.$NAME.LOC_COUNT.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary location count set: $TMP_LOC_COUNT" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_LOC_MD $TMP_LOC_WORD_HANDLE_NAME_SET $TMP_LOC_COUNT; exit' 0 1 2 3 15
    rm -f "$TMP_LOC_COUNT"
    if [[ -e $TMP_LOC_COUNT ]]; then
	echo "$0: ERROR: cannot remove temporary location count set: $TMP_LOC_COUNT" 1>&2
	exit 14
    fi
    :> "$TMP_LOC_COUNT"
    if [[ ! -e $TMP_LOC_COUNT ]]; then
	echo "$0: ERROR: cannot create temporary location count set: $TMP_LOC_COUNT" 1>&2
	exit 15
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary location count set is not used: $TMP_LOC_COUNT" 1>&2
fi


# generate location sort_word author_handle author name set
#
if [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: about to obtain location codes from author_handle JSON files" 1>&2
fi
export AUTHOR_COUNT=0
export AUTHOR_COUNT_CYCLE=10
export AUTHOR_COUNT_COUNT
AUTHOR_COUNT_COUNT=$(find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' -print | wc -l)
find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' -print |
    while read -r AUTHOR_HANDLE_JSON; do

	# collect location_code
	#
	PATTERN='$..location_code'
	LOCATION_CODE=$("$JVAL_WRAPPER" -b -q "$AUTHOR_HANDLE_JSON" "$PATTERN")
	status="$?"
	if [[ $status -ne 0 || -z $LOCATION_CODE ]]; then
	    echo "$0: ERROR: cannot obtain location_code from: $AUTHOR_HANDLE_JSON" 1>&2
	    exit 1
	fi

	# obtain author_handle from author_handle file
	#
	AUTHOR_HANDLE=$(basename "$AUTHOR_HANDLE_JSON" .json)
	if [[ -z $AUTHOR_HANDLE ]]; then
	    echo "$0: ERROR: cannot obtain author_handle from this filename: $AUTHOR_HANDLE" 1>&2
	    exit 16
	fi

	# obtain the author full name
	#
	PATTERN='$..full_name'
	if [[ $V_FLAG -ge 5 ]]; then
	    echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $AUTHOR_HANDLE_JSON '$PATTERN' | $JSTRDECODE -d -q -N -" 1>&2
	fi
	FULL_NAME=$("$JVAL_WRAPPER" -b -q "$AUTHOR_HANDLE_JSON" "$PATTERN" | "$JSTRDECODE" -d -q -N -)
	status_codes=("${PIPESTATUS[@]}")
	if [[ ${status_codes[*]} =~ [1-9] || -z $FULL_NAME ]]; then
	    echo "$0: ERROR: cannot full name from: $AUTHOR_HANDLE" 1>&2
	    exit 1
	fi

	# obtain the sort word from the author full name
	#
	SORT_WORD=$(echo "$FULL_NAME" | sed -e 's/^.* //' | tr '[:upper:]' '[:lower:]' | tr -d -c 'a-z0-9')
	if [[ -z $SORT_WORD ]]; then
	    echo "$0: ERROR: cannot sort word from author full name: $FULL_NAME" 1>&2
	    exit 17
	fi

	# print location sort_word author_handle author name
	#
	echo "$LOCATION_CODE" "$SORT_WORD" "$AUTHOR_HANDLE" "$FULL_NAME"

	# report process every so often if debugging
	#
	((++AUTHOR_COUNT))
	if [[ $V_FLAG -ge 1 && $((AUTHOR_COUNT % AUTHOR_COUNT_CYCLE)) -eq 0 ]]; then
	    echo "$0: debug[1]: cycle $AUTHOR_COUNT out of $AUTHOR_COUNT_COUNT" \
		 "finished processing: $AUTHOR_HANDLE_JSON" 1>&2
	fi

done | LC_ALL=C sort -d -u > "$TMP_LOC_WORD_HANDLE_NAME_SET"
status_codes=("${PIPESTATUS[@]}")
if [[ ${status_codes[*]} =~ [1-9] ]]; then
    echo "$0: ERROR: done find | while .. done | LC_ALL=C sort -d -u failed," \
	     "error code: ${status_codes[*]}" 1>&2
    exit 18
fi
#
if [[ ! -s $TMP_LOC_WORD_HANDLE_NAME_SET ]]; then
    echo "$0: ERROR: location sort_word author_handle author name set is empty: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
    exit 19
fi
AUTHOR_COUNT=$(wc -l < "$TMP_LOC_WORD_HANDLE_NAME_SET")
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: cycle $AUTHOR_COUNT" \
	 "formed location sort_word author_handle author name set: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
fi


# generate location count set
#
if [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: about to obtain author counts for each location" 1>&2
fi
awk '{print $1;}' "$TMP_LOC_WORD_HANDLE_NAME_SET" | LC_ALL=C uniq -c > "$TMP_LOC_COUNT"
status_codes=("${PIPESTATUS[@]}")
if [[ ${status_codes[*]} =~ [1-9] ]]; then
    echo "$0: ERROR: done awk .. | LC_ALL=C uniq -c > $TMP_LOC_COUNT failed," \
	     "error code: ${status_codes[*]}" 1>&2
    exit 20
fi
#
if [[ ! -s $TMP_LOC_COUNT ]]; then
    echo "$0: ERROR: location count set is empty: $TMP_LOC_COUNT" 1>&2
    exit 21
fi


# form the temporary location.md file
#
if [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: forming temporary location.md file: $TMP_LOC_MD" 1>&2
fi
export PREV_LOCATION_CODE="."
export LINE=0
while read -r LOCATION_CODE SORT_WORD AUTHOR_HANDLE FULL_NAME; do

    # firewall - paranoia
    #
    ((++LINE))
    if [[ -z $LOCATION_CODE || -z $SORT_WORD || -z $AUTHOR_HANDLE || -z $FULL_NAME ]]; then
	echo "$0: ERROR: empty field found for line: $LINE of: $TMP_LOC_WORD_HANDLE_NAME_SET" 1>&2
	echo "$0: Warning: LOCATION_CODE=$LOCATION_CODE" 1>&2
	echo "$0: Warning: SORT_WORD=$SORT_WORD" 1>&2
	echo "$0: Warning: AUTHOR_HANDLE=$AUTHOR_HANDLE" 1>&2
	echo "$0: Warning: FULL_NAME=$FULL_NAME" 1>&2
	exit 22
    fi

    # case: the location has changed
    #
    if [[ $LOCATION_CODE != "$PREV_LOCATION_CODE" ]]; then

	# case: not the first location
	#
	# Separate this location from the previous location
	#
	if [[ $LINE -gt 1 ]]; then
	    echo
	    echo '<hr style="width:10%;text-align:left;margin-left:0">'
	    echo
	    echo '<p></p>'
	    echo
	fi

	# use the location tool to obtain the location_name
	#
	LOCATION_NAME=$("$LOCATION_TOOL" "$LOCATION_CODE" 2>/dev/null)
	status="$?"
	export LOCATION_NAME
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: cannot determine location name for" \
		 "location ISO 3166 code: $LOCATION_CODE" 1>&2
	    exit 1
	fi

	# use the location tool to obtain the location common name
	#
	LOCATION_COMMON_NAME=$("$LOCATION_TOOL" -c "$LOCATION_CODE" 2>/dev/null)
	status="$?"
	export LOCATION_COMMON_NAME
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: cannot determine location common name" \
		 "for location ISO 3166 code: $LOCATION_CODE" 1>&2
	    exit 1
	fi

	# markdown entry for this location
	#
	if [[ $LOCATION_NAME == "$LOCATION_COMMON_NAME" ]]; then
	    echo "* <div id=$LOCATION_CODE>**$LOCATION_CODE** - _${LOCATION_NAME}_</div>"
	else
	    echo "* <div id=$LOCATION_CODE>**$LOCATION_CODE** - _${LOCATION_NAME}_ (_${LOCATION_COMMON_NAME}_)</div>"
	fi

	# ask for help with location code ZZ (Unknown location)
	#
	if [[ $LOCATION_CODE == 'ZZ' ]]; then
	    echo
	    echo '<p>**PLEASE HELP** us identify proper locations for these authors!</p>'
	    echo '<p>See the'
	    echo 'FAQ on "[Help with ZZ](faq.html#zz_help)"'
	    echo 'for how you can help!</p>'
	fi

	# determine author count for this location
	#
	AUTHOR_COUNT=$(grep -F " $LOCATION_CODE" "$TMP_LOC_COUNT" | awk '{print $1;}')
	if [[ -z $AUTHOR_COUNT || $AUTHOR_COUNT -le 0 ]]; then
	    echo "$0: ERROR: cannot determine author count" \
		 "for location ISO 3166 code: $LOCATION_CODE" 1>&2
	    exit 23
	fi

	# output author count for this location
	#
	echo
	echo "  Author count: **$AUTHOR_COUNT**"
	echo
    fi

    # output the author from the location
    #
    echo "  * <a class=\"normal\" href=\"authors.html#$AUTHOR_HANDLE\">$FULL_NAME</a>"
    PREV_LOCATION_CODE="$LOCATION_CODE"

done < "$TMP_LOC_WORD_HANDLE_NAME_SET" > "$TMP_LOC_MD"


# complete temporary location markdown file
#
{
    echo
    echo '<hr style="width:10%;text-align:left;margin-left:0">'
    echo '<h4>Jump to: <a href="#">top</a></h4>'
} >> "$TMP_LOC_MD"


# use the md2html.sh tool to form a location HTML file, unless -n
#
if [[ -z $NOOP ]]; then

    # possibly update location.html
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to run: $MD2HTML_SH ${TOOL_OPTION[*]} -- location.md $TMP_LOC_MD $LOCATION_HTML" 1>&2
    fi
    "$MD2HTML_SH" "${TOOL_OPTION[@]}" -- location.md "$TMP_LOC_MD" "$LOCATION_HTML"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: md2html.sh: $MD2HTML_SH ${TOOL_OPTION[*]} -- location.md $TMP_LOC_MD $LOCATION_HTML" \
	     "failed, error: $status" 1>&2
	exit 1
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: now up to date: $LOCATION_HTML" 1>&2
    fi

    # case -Q: (quick mode)
    #
    # If we are here, then the early quick mode test indicated that the prerequisite files are newer.
    # We will force the authors.html file to be touched so that a later run with -Q will quickly exit.
    # We do this because by default, the md2html.sh tool does not modify the target HTML unless it was modified.
    #
    if [[ -n $QUICK_MODE ]]; then
	touch "$LOCATION_HTML"
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} -- location.md $TMP_LOC_MD $LOCATION_HTML" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
