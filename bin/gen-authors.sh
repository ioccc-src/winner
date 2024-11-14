#!/usr/bin/env bash
#
# gen-authors.sh - create the top level authors.html page
#
# This script was written in 2024 by:
#
#   chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# with improvements by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# "Because sometimes even the IOCCC Judges need some help." :-)
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
export VERSION="1.14.1 2024-10-10"
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
export MIN_JSTRDECODE_VERSION="2.0.2"
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


# Letter "is for" text
#
unset IS_FOR
declare -Ag IS_FOR
IS_FOR[a]="<i>a</i> is for <code>atoi</code>"
IS_FOR[b]="<i>b</i> is for <code>break</code>"
IS_FOR[c]="<i>c</i> is for <code>const</code>"
IS_FOR[d]="<i>d</i> is for <code>do</code>"
IS_FOR[e]="<i>e</i> is for <code>else</code>"
IS_FOR[f]="<i>f</i> is for <code>float</code>"
IS_FOR[g]="<i>g</i> is for <code>getc</code>"
IS_FOR[h]="<i>h</i> is for <code>hypot</code>"
IS_FOR[i]="<i>i</i> is for <code>int</code>"
IS_FOR[j]="<i>j</i> is for <code>jmp_buf</code>"
IS_FOR[k]="<i>k</i> is for <code>killchar</code>"
IS_FOR[l]="<i>l</i> is for <code>long</code>"
IS_FOR[m]="<i>m</i> is for <code>malloc</code>"
IS_FOR[n]="<i>n</i> is for <code>nullptr</code>"
IS_FOR[o]="<i>o</i> is for <code>open</code>"
IS_FOR[p]="<i>p</i> is for <code>printf</code>"
IS_FOR[q]="<i>q</i> is for <code>qsort</code>"
IS_FOR[r]="<i>r</i> is for <code>return</code>"
IS_FOR[s]="<i>s</i> is for <code>switch</code>"
IS_FOR[t]="<i>t</i> is for <code>true</code>"
IS_FOR[u]="<i>u</i> is for <code>union</code>"
IS_FOR[v]="<i>v</i> is for <code>volatile</code>"
IS_FOR[w]="<i>w</i> is for <code>while</code>"
IS_FOR[x]="<i>x</i> is for <code>xor</code>"
IS_FOR[y]="<i>y</i> is for <code>y0</code>"
IS_FOR[z]="<i>z</i> is for <code>zlib</code>"


# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-t tagline] [-Q]

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


# output_award
#
# Write the award name to standard output (stdout)
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
    local PATTERN;		# XPath for JSON pattern

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
    PATTERN='$..award'
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $ENTRY_JSON_PATH '$PATTERN' | $JSTRDECODE -N -" 1>&2
    fi
    "$JVAL_WRAPPER" -b -q "$ENTRY_JSON_PATH" "$PATTERN" | "$JSTRDECODE" -N -
    status_codes=("${PIPESTATUS[@]}")
    if [[ ${status_codes[*]} =~ [1-9] ]]; then
	echo "$0: ERROR: in output_award: $JVAL_WRAPPER -b -q -- $ENTRY_JSON_PATH '$PATTERN' | $JSTRDECODE -N - failed," \
	     "error codes: ${status_codes[*]}" 1>&2
	return 5
    fi
    return 0
}


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


# always add the '-U URL' for the top level authors.html file
#
TOOL_OPTION+=("-U")
TOOL_OPTION+=("$SITE_URL/authors.html")


# always add the '-D docroot/' for the top level authors.html file
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


# verify that the md2html tool is executable
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


# note authors.html file
#
export AUTHORS_HTML="authors.html"


# verify that the bin/combine_author_handle.sh tool is executable
#
export COMBINE_AUTHOR="$BIN_DIR/combine_author_handle.sh"
if [[ ! -e $COMBINE_AUTHOR ]]; then
    echo  "$0: ERROR: combine_author_handle.sh does not exist: $COMBINE_AUTHOR" 1>&2
    exit 5
fi
if [[ ! -f $COMBINE_AUTHOR ]]; then
    echo  "$0: ERROR: combine_author_handle.sh is not a regular file: $COMBINE_AUTHOR" 1>&2
    exit 5
fi
if [[ ! -x $COMBINE_AUTHOR ]]; then
    echo  "$0: ERROR: combine_author_handle.sh is not an executable file: $COMBINE_AUTHOR" 1>&2
    exit 5
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
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    for index in "${!IS_FOR[@]}"; do
	echo "$0: debug[3]: IS_FOR[$index]=${IS_FOR[$index]}" 1>&2
    done
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: LOCATION_TOOL=$LOCATION_TOOL" 1>&2
    echo "$0: debug[3]: AUTHORS_HTML=$AUTHORS_HTML" 1>&2
    echo "$0: debug[3]: COMBINE_AUTHOR=$COMBINE_AUTHOR" 1>&2
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
    NEWER=$(find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' -newer "$AUTHORS_HTML" 2>/dev/null)
    if [[ -z $NEWER ]]; then
	exit 0
    fi
fi


# create a temporary entry markdown file
#
export TMP_AUTHORS_MD=".tmp.$NAME.AUTHORS_MD.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary entry markdown file: $TMP_AUTHORS_MD" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_AUTHORS_MD; exit' 0 1 2 3 15
    rm -f "$TMP_AUTHORS_MD"
    if [[ -e $TMP_AUTHORS_MD ]]; then
	echo "$0: ERROR: cannot remove temporary entry markdown file: $TMP_AUTHORS_MD" 1>&2
	exit 10
    fi
    :> "$TMP_AUTHORS_MD"
    if [[ ! -e $TMP_AUTHORS_MD ]]; then
	echo "$0: ERROR: cannot create temporary entry markdown file: $TMP_AUTHORS_MD" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary entry markdown file is not used: $TMP_AUTHORS_MD" 1>&2
fi


# create a temporary sort word list file
#
export TMP_SORT_WORD=".tmp.$NAME.SORT_WORD.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary sort word list file: $TMP_SORT_WORD" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_AUTHORS_MD $TMP_SORT_WORD; exit' 0 1 2 3 15
    rm -f "$TMP_SORT_WORD"
    if [[ -e $TMP_SORT_WORD ]]; then
	echo "$0: ERROR: cannot remove temporary sort word list file: $TMP_SORT_WORD" 1>&2
	exit 12
    fi
    :> "$TMP_SORT_WORD"
    if [[ ! -e $TMP_SORT_WORD ]]; then
	echo "$0: ERROR: cannot create temporary sort word list file: $TMP_SORT_WORD" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary sort word list file is not used: $TMP_SORT_WORD" 1>&2
fi




# add author sort_word filename to the temporary sort word list file
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: Forming temporary sort word list file: $TMP_SORT_WORD"
fi
export PATTERN='$..sort_word'
{
    # load initial letter . lines
    #
    for letter in "${!IS_FOR[@]}"; do
	echo "$letter ."
    done

    # add sort_word filenames lines
    #
    "$COMBINE_AUTHOR" | "$JVAL_WRAPPER" -b -q -- - "$PATTERN"
    status_codes=("${PIPESTATUS[@]}")
    if [[ ${status_codes[*]} =~ [1-9] ]]; then
	echo "$0: ERROR: $COMBINE_AUTHOR | $JVAL_WRAPPER -b -q -- - '$PATTERN' |" \
	     "LC_ALL=C sort -f -d > $TMP_SORT_WORD failed," \
	     "error codes: ${status_codes[*]}" 1>&2
	exit 14
    fi
} | LC_ALL=C sort -f -d > "$TMP_SORT_WORD"


# generate the temporary entry markdown file
#
{
    # output top of content
    #
    cat << EOF
<p style="text-align:center;">Jump to authors sorted by: [
<a href="#a">a</a>&nbsp;&nbsp;
<a href="#b">b</a>&nbsp;&nbsp;
<a href="#c">c</a>&nbsp;&nbsp;
<a href="#d">d</a>&nbsp;&nbsp;
<a href="#e">e</a>&nbsp;&nbsp;
<a href="#f">f</a>&nbsp;&nbsp;
<a href="#g">g</a>&nbsp;&nbsp;
<a href="#h">h</a>&nbsp;&nbsp;
<a href="#i">i</a>&nbsp;&nbsp;
<a href="#j">j</a>&nbsp;&nbsp;
<a href="#k">k</a>&nbsp;&nbsp;
<a href="#l">l</a>&nbsp;&nbsp;
<a href="#m">m</a>&nbsp;&nbsp;
<a href="#n">n</a>&nbsp;&nbsp;
<a href="#o">o</a>&nbsp;&nbsp;
<a href="#p">p</a>&nbsp;&nbsp;
<a href="#q">q</a>&nbsp;&nbsp;
<a href="#r">r</a>&nbsp;&nbsp;
<a href="#s">s</a>&nbsp;&nbsp;
<a href="#t">t</a>&nbsp;&nbsp;
<a href="#u">u</a>&nbsp;&nbsp;
<a href="#v">v</a>&nbsp;&nbsp;
<a href="#w">w</a>&nbsp;&nbsp;
<a href="#x">x</a>&nbsp;&nbsp;
<a href="#y">y</a>&nbsp;&nbsp;
<a href="#z">z</a>
]</p>
<hr>

EOF

    # process each line in the temporary sort word list file
    #
    export PREV_FILENAME="."
    while read -r sort_word filename; do

	# case: we have a "letter ." line
	#
	if [[ $filename == "." ]]; then

	    # output the letter header
	    #
	    l="$sort_word"
	    echo "<!-- $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  -->"
	    if [[ $PREV_FILENAME != '.' ]]; then
		echo '<hr style="width:10%;text-align:left;margin-left:0">'
	    fi
	    echo "<div id=\"$l\">"
	    echo "## ${IS_FOR[$l]}"
	    echo "<!-- $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  $l  -->"
	    echo "</div>"
	    echo '<hr style="width:10%;text-align:left;margin-left:0">'
	    echo
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: Processing author_handles that begin with \"$l\" for: $AUTHORS_HTML" 1>&2
	    fi

	# case: we have a "sort_word file" line
	#
	else

	    # collect scalar information from the author/author_handle.json file
	    #
	    if [[ -z $sort_word ]]; then
		echo "$0: ERROR: sort_word is empty" 1>&2
		exit 15
	    fi

	    # parse an element value of the this particular author in the authors JSON array
	    #
	    if [[ $V_FLAG -ge 5 ]]; then
		echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -q -- - | sed ... | LC_ALL=C sort -d)" 1>&2
	    fi
	    export AUTHOR_DATA
	    AUTHOR_DATA=$("$JVAL_WRAPPER" -q -- "$filename" |
			  LC_ALL=C sort -d)
	    status_codes=("${PIPESTATUS[@]}")
	    if [[ ${status_codes[*]} =~ [1-9] ]]; then
		echo "$0: ERROR: $JVAL_WRAPPER -q -- $filename | sed ... | LC_ALL=C sort -d failed," \
		     "error codes: ${status_codes[*]}" 1>&2
		exit 16
	    fi
	    if [[ -z $AUTHOR_DATA ]]; then
		echo "$0: ERROR: found nothing for author in: $filename" 1>&2
		exit 17
	    fi
	    export FULL_NAME=
	    export LOCATION_CODE=
	    export AUTHOR_URL=
	    export AUTHOR_ALT_URL=
	    export AUTHOR_MASTODON_HANDLE=
	    export AUTHOR_MASTODON_URL=
	    export AUTHOR_GITHUB=
	    export AUTHOR_AFFILIATION=
	    export AUTHOR_HANDLE=
	    unset ENTRY_ID_SET
	    declare -ag ENTRY_ID_SET
	    while read -r NAME VALUE; do

		# parse name value
		#
		case "$NAME" in
		full_name)
		    FULL_NAME=$("$JSTRDECODE" "$VALUE")
		    ;;
		location_code)
		    LOCATION_CODE="$VALUE"
		    ;;
		url)
		    AUTHOR_URL="$VALUE"
		    ;;
		alt_url)
		    AUTHOR_ALT_URL="$VALUE"
		    ;;
		mastodon)
		    AUTHOR_MASTODON_HANDLE="$VALUE"
		    ;;
		mastodon_url)
		    AUTHOR_MASTODON_URL="$VALUE"
		    ;;
		github)
		    AUTHOR_GITHUB="$VALUE"
		    ;;
		affiliation)
		    AUTHOR_AFFILIATION=$("$JSTRDECODE" "$VALUE")
		    ;;
		author_handle)
		    AUTHOR_HANDLE="$VALUE"
		    ;;
		entry_id)
		    ENTRY_ID_SET+=("$VALUE")
		    ;;
		*)  # ignore all other fields
		    ;;
		esac
	    done <<< "$AUTHOR_DATA"

	    # validate fields values
	    #
	    if [[ -z $FULL_NAME ]]; then
		echo "$0: ERROR: cannot find name in: $filename" 1>&2
		exit 18
	    fi
	    if [[ -z $LOCATION_CODE ]]; then
		echo "$0: ERROR: cannot find location_code in: $filename" 1>&2
		exit 19
	    fi
	    if [[ -z $AUTHOR_URL ]]; then
		echo "$0: ERROR: cannot find url in: $filename" 1>&2
		exit 20
	    fi
	    if [[ -z $AUTHOR_ALT_URL ]]; then
		echo "$0: ERROR: cannot find alt_url in: $filename" 1>&2
		exit 21
	    fi
	    if [[ -z $AUTHOR_MASTODON_HANDLE ]]; then
		echo "$0: ERROR: cannot find mastodon in: $filename" 1>&2
		exit 22
	    fi
	    if [[ -z $AUTHOR_MASTODON_URL ]]; then
		echo "$0: ERROR: cannot find mastodon_url in: $filename" 1>&2
		exit 23
	    fi
	    if [[ -z $AUTHOR_GITHUB ]]; then
		echo "$0: ERROR: cannot find github in: $filename" 1>&2
		exit 24
	    fi
	    if [[ -z $AUTHOR_AFFILIATION ]]; then
		echo "$0: ERROR: cannot find affiliation in: $filename" 1>&2
		exit 25
	    fi
	    if [[ -z $AUTHOR_HANDLE ]]; then
		echo "$0: ERROR: cannot find author_handle in: $filename" 1>&2
		exit 26
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

	    # form github username
	    #
	    AUTHOR_GITHUB_USERNAME=${AUTHOR_GITHUB#@}
            export AUTHOR_GITHUB_USERNAME
	    if [[ -z $AUTHOR_GITHUB_USERNAME ]]; then
		echo "$0: ERROR: cannot determine github username from: $AUTHOR_GITHUB" 1>&2
		exit 27
	    fi

	    # output author information
	    #
	    echo "<p></p>"
	    echo "<div id=\"$AUTHOR_HANDLE\">**$FULL_NAME**</div>"
	    echo "<p></p>"
	    if [[ $LOCATION_NAME == "$LOCATION_COMMON_NAME" ]]; then
		echo "Location: <a class=\"normal\" href=\"location.html#$LOCATION_CODE\">$LOCATION_CODE</a> -" \
		     "_${LOCATION_NAME}_"
	    else
		echo "Location: <a class=\"normal\" href=\"location.html#$LOCATION_CODE\">$LOCATION_CODE</a> -" \
		     "_${LOCATION_COMMON_NAME}_"
	    fi
	    if [[ -n $AUTHOR_AFFILIATION && $AUTHOR_AFFILIATION != null ]]; then
		echo "<br>"
	        echo "Affiliation: $AUTHOR_AFFILIATION"
	    fi
	    if [[ -n $AUTHOR_URL && $AUTHOR_URL != null ]]; then
		echo "<br>"
	        echo "URL: <a class=\"normal\" href=\"$AUTHOR_URL\">$AUTHOR_URL</a>"
	    fi
	    if [[ -n $AUTHOR_ALT_URL && $AUTHOR_ALT_URL != null ]]; then
		echo "<br>"
	        echo "Alternate URL: <a class=\"normal\" href=\"$AUTHOR_ALT_URL\">$AUTHOR_ALT_URL</a>"
	    fi
	    if [[ -n $AUTHOR_MASTODON_HANDLE && $AUTHOR_MASTODON_HANDLE != null &&
		  -n $AUTHOR_MASTODON_URL && $AUTHOR_MASTODON_URL != null ]]; then
		echo "<br>"
		echo "Mastodon: <a class=\"normal\" href=\"$AUTHOR_MASTODON_URL\">$AUTHOR_MASTODON_HANDLE</a>"
	    fi
	    if [[ -n $AUTHOR_GITHUB && $AUTHOR_GITHUB != null ]]; then
		echo "<br>"
	        echo "GitHub: <a class=\"normal\" href=\"https://github.com/$AUTHOR_GITHUB_USERNAME\">$AUTHOR_GITHUB</a>"
	    fi
	    echo "<br>"
	    echo "author_handle: <a class=\"normal\" href=\"%%REPO_URL%%/author/$AUTHOR_HANDLE.json\">$AUTHOR_HANDLE</a>"
	    echo "<p></p>"

	    # output YYYY/dir set made by this author
	    #
	    for ENTRY_ID in "${ENTRY_ID_SET[@]}"; do

		# verify the entry id
		#
		if [[ $ENTRY_ID =~ ^[^_][^_]*_[^_][^_]*$ ]]; then
		    if [[ $V_FLAG -ge 7 ]]; then
			echo "$0: debug[7]: entry_id: $ENTRY_ID" 1>&2
		    fi
		else
		    echo "$0: ERROR: entry_id is not in YYYY_dir formmat: $ENTRY_ID" 1>&2
		    exit 28
		fi
		YYYY_DIR=$(echo "$ENTRY_ID" | tr _ /)
		export YYYY_DIR
		if [[ ! -d $YYYY_DIR ]]; then
		    echo "$0: ERROR: YYYY/dir is not a directory" 1>&2
		    exit 29
		fi

		# verify that the .entry.json file is a non-empty readable file
		#
		ENTRY_JSON="$YYYY_DIR/.entry.json"
		export ENTRY_JSON
		if [[ ! -e $ENTRY_JSON ]]; then
		    echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
		    exit 30
		fi
		if [[ ! -f $ENTRY_JSON ]]; then
		    echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
		    exit 31
		fi
		if [[ ! -r $ENTRY_JSON ]]; then
		    echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
		    exit 32
		fi
		if [[ ! -s $ENTRY_JSON ]]; then
		    echo "$0: ERROR: .entry.json is not a non-empty readable file: $ENTRY_JSON" 1>&2
		    exit 33
		fi
		if [[ $V_FLAG -ge 7 ]]; then
		    echo "$0: debug[7]: .entry.json: $ENTRY_JSON" 1>&2
		fi

		# collect the award for this entry id
		#
		AWARD=$(output_award "$ENTRY_JSON")
		export AWARD
		if [[ -z $AWARD ]]; then
		    echo "$0: ERROR: award not found in .entry.json: $ENTRY_JSON" 1>&2
		    exit 34
		fi

		# output the YYYY/dir entry for this author
		#
		echo "* <a class=\"normal\" href=\"$YYYY_DIR/index.html\">$YYYY_DIR</a> - $AWARD"
	    done
	    echo
	fi
	PREV_FILENAME="$filename"
    done < "$TMP_SORT_WORD"
    echo '<hr style="width:10%;text-align:left;margin-left:0">'
    echo '<h4>Jump to: <a href="#">top</a></h4>'
} | if [[ -z $NOOP ]]; then
    cat >> "$TMP_AUTHORS_MD"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
        echo "$0: debug[3]: because of -n, temporary entry markdown file is NOT written into: $TMP_AUTHORS_MD" 1>&2
    fi
fi


# use the md2html.sh tool to update authors.html, unless -n
#
if [[ -z $NOOP ]]; then

    # possibly update authors.html
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to run: $MD2HTML_SH ${TOOL_OPTION[*]} -- authors.md $TMP_AUTHORS_MD $AUTHORS_HTML" 1>&2
    fi
    "$MD2HTML_SH" "${TOOL_OPTION[@]}" -- authors.md "$TMP_AUTHORS_MD" "$AUTHORS_HTML"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: md2html.sh: $MD2HTML_SH ${TOOL_OPTION[*]} -- authors.md $TMP_AUTHORS_MD $AUTHORS_HTML" \
	     "failed, error: $status" 1>&2
	EXIT_CODE="1"  # exit 1
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: now up to date: $AUTHORS_HTML" 1>&2
    fi

    # case -Q: (quick mode)
    #
    # If we are here, then the early quick mode test indicated that the prerequisite files are newer.
    # We will force the authors.html file to be touched so that a later run with -Q will quickly exit.
    # We do this because by default, the md2html.sh tool does not modify the target HTML unless it was modified.
    #
    if [[ -n $QUICK_MODE ]]; then
	touch "$AUTHORS_HTML"
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} -- authors.md $TMP_AUTHORS_MD $AUTHORS_HTML" 1>&2
fi


# file cleanup
#
if [[ -z $NOOP ]]; then
    rm -f -- "$TMP_AUTHORS_MD"
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: rm -f -- $TMP_AUTHORS_MD" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
