#!/usr/bin/env bash
#
# gen-top-html.sh - generate all or select top level HTML files from markdown
# files
#
# We also generate the bin/index.html file from the bin/README.md file.
#
# We also generate the inc/index.html file from the inc/README.md file.
#
# We also generate the archive/historic/index.html file from the
# archive/historic/README.md file.
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
export VERSION="2.0.1 2025-07-25"
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
export DOCROOT_SLASH="./"
export TAGLINE="bin/$NAME"
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://www.ioccc.org"
#
unset TOP_MD_SET
declare -ag TOP_MD_SET
TOP_MD_SET+=("about")
TOP_MD_SET+=("archive/historic/README")
TOP_MD_SET+=("author/README")
TOP_MD_SET+=("bin/README")
TOP_MD_SET+=("bugs")
TOP_MD_SET+=("CODE_OF_CONDUCT")
TOP_MD_SET+=("contact")
TOP_MD_SET+=("faq")
TOP_MD_SET+=("inc/README")
TOP_MD_SET+=("index")
TOP_MD_SET+=("judges")
TOP_MD_SET+=("license")
TOP_MD_SET+=("markdown")
TOP_MD_SET+=("news")
TOP_MD_SET+=("next/guidelines")
TOP_MD_SET+=("next/pw-change")
TOP_MD_SET+=("next/README")
TOP_MD_SET+=("next/register")
TOP_MD_SET+=("next/remarks")
TOP_MD_SET+=("next/rules")
TOP_MD_SET+=("next/submit")
TOP_MD_SET+=("nojs-menu")
TOP_MD_SET+=("quick-start")
TOP_MD_SET+=("README")
TOP_MD_SET+=("SECURITY")
TOP_MD_SET+=("social")
TOP_MD_SET+=("status")
TOP_MD_SET+=("thanks-for-help")
declare -ag TOP_MD_SELECT_SET
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"


# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-t tagline] [file...]

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
     8	       markdown file(s) not a non-empty readable file
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd:D:nNt:w: flag; do
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
# allow specifying specific files to generate
#
FILE_COUNT="$#"
while [[ $# -ne 0 ]]; do
    for (( index=0; index < ${#TOP_MD_SET[@]}; index++ )); do
	if [[ "${TOP_MD_SET[$index]}" = "$1" ]]; then
	    TOP_MD_SELECT_SET+=("$1")
	fi
    done
    shift 1
done
if [[ "$FILE_COUNT" != 0 && ${#TOP_MD_SELECT_SET[@]} = 0 ]]; then
    echo "$0: ERROR: no select files specified are in allowed set" 1>&2
    exit 3
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


# always add the '-D docroot/' for the top level files
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


# verify that the bin/pandoc-wrapper.sh tool is executable
#
export PANDOC_WRAPPER="$BIN_DIR/pandoc-wrapper.sh"
if [[ ! -e $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh does not exist: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -f $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not a regular file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -x $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not an executable file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi


# find the location tool
#
LOCATION_TOOL=$(type -P location)
if [[ ! -x $LOCATION_TOOL ]]; then
    echo "$0: ERROR: cannot find the location executable" 1>&2
    echo "$0: notice: location tool comes from this repo: https://github.com/ioccc-src/mkiocccentry" 1>&2
    exit 5
fi


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
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
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: TAGLINE=$TAGLINE" 1>&2
    echo "$0: debug[3]: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    if (( ${#TOP_MD_SELECT_SET[@]} )); then
	for index in "${!TOP_MD_SELECT_SET[@]}"; do
	    echo "$0: debug[3]: TOP_MD_SELECT_SET[$index]=${TOP_MD_SELECT_SET[$index]}" 1>&2
	done
    fi
    for index in "${!TOP_MD_SET[@]}"; do
	echo "$0: debug[3]: TOP_MD_SET[$index]=${TOP_MD_SET[$index]}" 1>&2
    done
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
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
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# process the entire markdown set
#
if (( ${#TOP_MD_SELECT_SET[@]} )); then
    for name in "${TOP_MD_SELECT_SET[@]}"; do

	# verify that the markdown file exists at the topdir
	#
	export MD_FILE="$name.md"
	if [[ ! -e $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file does not exist: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -f $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a regular file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -r $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a readable file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -s $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a non-empty readable file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	export HTML_FILE="$name.html"
	# bin/README is a special case
	if [[ $name == bin/README ]]; then
	    HTML_FILE="bin/index.html"
	fi
	# inc/README is a special case
	if [[ $name == inc/README ]]; then
	    HTML_FILE="inc/index.html"
	fi
	# next/README is a special case
	if [[ $name == next/README ]]; then
	    HTML_FILE="next/index.html"
	fi
	# author/README is a special case
	if [[ $name == author/README ]]; then
	    HTML_FILE="author/index.html"
	fi
	# archive/historic/README is a special case
	if [[ $name == archive/historic/README ]]; then
	    HTML_FILE="archive/historic/index.html"
	fi

	# use the md2html.sh tool to form the HTML file, unless -n
	#
	if [[ -z $NOOP ]]; then
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: about to run: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		     "-m $MD_FILE -- $MD_FILE $HTML_FILE" 1>&2
	    fi
	    "$MD2HTML_SH" -U "$SITE_URL/$HTML_FILE" "${TOOL_OPTION[@]}" \
		-m "$MD_FILE" -- "$MD_FILE" "$HTML_FILE"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: md2html.sh: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		     "-m $MD_FILE -- $MD_FILE $HTML_FILE" \
		     "failed, error: $status" 1>&2
		EXIT_CODE="1"  # exit 1
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    elif [[ $V_FLAG -ge 3 ]]; then
		echo "$0: debug[3]: now up to date: $HTML_FILE" 1>&2
	    fi

	# report disabled by -n
	#
	elif [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		 "-m $MD_FILE -- $MD_FILE $HTML_FILE" 1>&2
	fi
    done
else
    for name in "${TOP_MD_SET[@]}"; do

	# verify that the markdown file exists at the topdir
	#
	export MD_FILE="$name.md"
	if [[ ! -e $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file does not exist: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -f $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a regular file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -r $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a readable file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	if [[ ! -s $MD_FILE ]]; then
	    echo  "$0: ERROR: markdown file is not a non-empty readable file: $MD_FILE" 1>&2
	    EXIT_CODE=8 # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    continue
	fi
	export HTML_FILE="$name.html"
	# bin/README is a special case
	if [[ $name == bin/README ]]; then
	    HTML_FILE="bin/index.html"
	fi
	# inc/README is a special case
	if [[ $name == inc/README ]]; then
	    HTML_FILE="inc/index.html"
	fi
	# next/README is a special case
	if [[ $name == next/README ]]; then
	    HTML_FILE="next/index.html"
	fi
	# author/README is a special case
	if [[ $name == author/README ]]; then
	    HTML_FILE="author/index.html"
	fi
	# archive/historic/README is a special case
	if [[ $name == archive/historic/README ]]; then
	    HTML_FILE="archive/historic/index.html"
	fi

	# use the md2html.sh tool to form the HTML file, unless -n
	#
	if [[ -z $NOOP ]]; then
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: about to run: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		     "-m $MD_FILE -- $MD_FILE $HTML_FILE" 1>&2
	    fi
	    "$MD2HTML_SH" -U "$SITE_URL/$HTML_FILE" "${TOOL_OPTION[@]}" \
		-m "$MD_FILE" -- "$MD_FILE" "$HTML_FILE"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: md2html.sh: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		     "-m $MD_FILE -- $MD_FILE $HTML_FILE" \
		     "failed, error: $status" 1>&2
		EXIT_CODE="1"  # exit 1
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    elif [[ $V_FLAG -ge 3 ]]; then
		echo "$0: debug[3]: now up to date: $HTML_FILE" 1>&2
	    fi

	# report disabled by -n
	#
	elif [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH -U $SITE_URL/$HTML_FILE ${TOOL_OPTION[*]}" \
		 "-m $MD_FILE -- $MD_FILE $HTML_FILE" 1>&2
	fi
    done
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
