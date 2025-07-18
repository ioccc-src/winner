#!/usr/bin/env bash
#
# gen-year-index.sh - create year level index.html, rules.html, guidelines.html
#
# Create an index.html file for a given IOCCC year.
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
export VERSION="2.1.0 2025-07-05"
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
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://www.ioccc.org"


# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-Q] [-t tagline] [-w site_url]
			YYYY [more_options]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-Q	        quick mode, do not run $MD2HTML_SH unless markdown is out of date (def: do)

	-t tagline	string to write about the tool that formed the markdown content (def: $TAGLINE)

	-w site_url	Base URL of the website (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on tool command lines.

	YYYY		path from topdir to year directory: must contain the files: README.md, .path and .entry.json
	[more_options]	additional tool command line options to use before the YYYY argument

NOTE: Any '-D docroot/', '-t tagline', '-w site_url' are passed to 'md2html.sh' tool.

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


# setup
#
export NOOP=
export DO_NOT_PROCESS=
export QUICK_MODE=


# parse command line
#
while getopts :hv:Vd:D:nNQt:w: flag; do
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
	TOOL_OPTION+=("-D")
	TOOL_OPTION+=("$DOCROOT_SLASH")
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    Q) QUICK_MODE="-Q"
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
	# -t tagline is always added further down
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
# parse the command line arguments
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
# verify arg count and parse args
#
export YYYY
case "$#" in
0) echo "$0: ERROR: expected 1 or more args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
1) YYYY="$1"
   ;;
*) YYYY="$1"
   shift
   while [[ $# -gt 0 ]]; do
	TOOL_OPTION+=("$1")
	shift
   done
   ;;
esac
#
if [[ -z $YYYY ]]; then
    echo "$0: ERROR: YYYY arg is empty" 1>&2
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


# verify that YYYY/README.md is a non-empty readable file
#
export README_FILE="$YYYY/README.md"
if [[ ! -e $README_FILE ]]; then
    echo "$0: ERROR: year $YYYY README.md does not exist: $README_FILE" 1>&2
    exit 6
fi
if [[ ! -f $README_FILE ]]; then
    echo "$0: ERROR: year $YYYY README.md is not a file: $README_FILE" 1>&2
    exit 6
fi
if [[ ! -r $README_FILE ]]; then
    echo "$0: ERROR: year $YYYY README.md is not a readable file: $README_FILE" 1>&2
    exit 6
fi
if [[ ! -s $README_FILE ]]; then
    echo "$0: ERROR: year $YYYY README.md is not a non-empty readable file: $README_FILE" 1>&2
    exit 6
fi


# always add -t tagline
#
TOOL_OPTION+=("-t")
TOOL_OPTION+=("$TAGLINE")


# Determine if and what we need to update.
#
export UPDATE_INDEX=""
export UPDATE_RULES=""
export UPDATE_GUIDELINES=""
export NEEDS_UPDATE=""
if [[ -s $YYYY/rules.md ]]; then
    if [[ ! -s $YYYY/rules.html || $YYYY/rules.md -nt $YYYY/rules.html ]]; then
	NEEDS_UPDATE="true"
	UPDATE_RULES="true"
    fi
fi
if [[ -s $YYYY/guidelines.md ]]; then
    if [[ ! -s $YYYY/guidelines.html || $YYYY/guidelines.md -nt $YYYY/guidelines.html ]]; then
	NEEDS_UPDATE="true"
	UPDATE_GUIDELINES="true"
    fi
fi
if [[ ! -s $YYYY/index.html || $YYYY/README.md -nt $YYYY/index.html ]]; then
    NEEDS_UPDATE="true"
    UPDATE_INDEX="true"
fi


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
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: TAGLINE=$TAGLINE" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: QUICK_MODE=$QUICK_MODE" 1>&2
    echo "$0: debug[3]: YYYY=$YYYY" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: MD2HTML_SH=$MD2HTML_SH" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: README_FILE=$README_FILE" 1>&2
    echo "$0: debug[3]: UPDATE_INDEX=$UPDATE_INDEX" 1>&2
    echo "$0: debug[3]: UPDATE_RULES=$UPDATE_RULES" 1>&2
    echo "$0: debug[3]: UPDATE_GUIDELINES=$UPDATE_GUIDELINES" 1>&2
    echo "$0: debug[3]: NEEDS_UPDATE=$NEEDS_UPDATE" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# case: -Q (quick mode)
#
# Do nothing if we do not need to update anything.
#
if [[ -n $QUICK_MODE ]]; then
    if [[ -z $NEEDS_UPDATE ]]; then
	exit 0
    fi
fi


# form the YYYY index.html from YYYY/README.md unless -n
#
if [[ -z $NOOP ]]; then

    # possibly update YYYY index.html
    #
    if [[ -n $UPDATE_INDEX ]]; then

	# update YYYY index.html
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: about to run: $MD2HTML_SH -U $SITE_URL/$YYYY/index.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/README.md -- $YYYY/README.md $YYYY/index.html" 1>&2
	fi
	"$MD2HTML_SH" -U "$SITE_URL/$YYYY/index.html" "${TOOL_OPTION[@]}" \
	    -m "$YYYY/README.md" -- "$YYYY/README.md" "$YYYY/index.html"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: tool: $MD2HTML_SH -U $SITE_URL/$YYYY/index.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/README.md -- $YYYY/README.md $YYYY/index.html failed, error: $status" 1>&2
	    exit 1
	fi

	# case -Q: (quick mode)
	#
	# If we are here, then the early quick mode test indicated that the prerequisite files are newer.
	# We will force the authors.html file to be touched so that a later run with -Q will quickly exit.
	# We do this because by default, the md2html.sh tool does not modify the target HTML unless it was modified.
	#
	if [[ -n $QUICK_MODE ]]; then
	    touch "$YYYY/index.html"
	fi

    # case: YYYY index.html does not need to be updated
    #
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: does not need to be updated: $YYYY/README.html" 1>&2
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    if [[ -n $UPDATE_INDEX ]]; then
	echo "$0: debug[3]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} -m $YYYY/README.md --" \
	     "$YYYY/README.md $YYYY/index.html" 1>&2
    else
	echo "$0: debug[3]: no need to be update: $YYYY/README.html" 1>&2
    fi
fi


# form the YYYY rules.html from YYYY/rules.md, if it exists, unless -n
#
if [[ -z $NOOP ]]; then

    # possibly update YYYY rules.html
    #
    if [[ -n $UPDATE_RULES ]]; then

	# update YYYY rules.html
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: about to run: $MD2HTML_SH -U $SITE_URL/$YYYY/rules.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/rules.md -- $YYYY/rules.md $YYYY/rules.html" 1>&2
	fi
	"$MD2HTML_SH" -U "$SITE_URL/$YYYY/rules.html" "${TOOL_OPTION[@]}" \
	    -m "$YYYY/rules.md" -- "$YYYY/rules.md" "$YYYY/rules.html"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: tool: $MD2HTML_SH -U $SITE_URL/$YYYY/rules.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/rules.md -- $YYYY/rules.md $YYYY/rules.html failed, error: $status" 1>&2
	    exit 1
	fi

	# case -Q: (quick mode)
	#
	# If we are here, then the early quick mode test indicated that the prerequisite files are newer.
	# We will force the authors.html file to be touched so that a later run with -Q will quickly exit.
	# We do this because by default, the md2html.sh tool does not modify the target HTML unless it was modified.
	#
	if [[ -n $QUICK_MODE ]]; then
	    touch "$YYYY/rules.html"
	fi

    # case: YYYY index.html does not need to be updated
    #
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: no need to be update: $YYYY/rules.html" 1>&2
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    if [[ -n $UPDATE_RULES ]]; then
	echo "$0: debug[3]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} -m $YYYY/rules.md --" \
	     "$YYYY/rules.md $YYYY/rules.html" 1>&2
    else
	echo "$0: debug[3]: does not need to be updated: $YYYY/rules.html" 1>&2
    fi
fi


# form the YYYY guidelines.html from YYYY/guidelines.md, if it exists, unless -n
#
if [[ -z $NOOP ]]; then

    # possibly update YYYY guidelines.html
    #
    if [[ -n $UPDATE_GUIDELINES ]]; then

	# update YYYY guidelines.html
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: about to run: $MD2HTML_SH -U $SITE_URL/$YYYY/guidelines.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/guidelines.md -- $YYYY/guidelines.md $YYYY/guidelines.html" 1>&2
	fi
	"$MD2HTML_SH" -U "$SITE_URL/$YYYY/guidelines.html" "${TOOL_OPTION[@]}" \
	    -m "$YYYY/guidelines.md" -- "$YYYY/guidelines.md" "$YYYY/guidelines.html"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: tool: $MD2HTML_SH -U $SITE_URL/$YYYY/guidelines.html ${TOOL_OPTION[*]}" \
		 "-m $YYYY/guidelines.md -- $YYYY/guidelines.md $YYYY/guidelines.html failed, error: $status" 1>&2
	    exit 1
	fi

	# case -Q: (quick mode)
	#
	# If we are here, then the early quick mode test indicated that the prerequisite files are newer.
	# We will force the authors.html file to be touched so that a later run with -Q will quickly exit.
	# We do this because by default, the md2html.sh tool does not modify the target HTML unless it was modified.
	#
	if [[ -n $QUICK_MODE ]]; then
	    touch "$YYYY/guidelines.html"
	fi

    # case: YYYY index.html does not need to be updated
    #
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: does not need to be updated: $YYYY/guidelines.html" 1>&2
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    if [[ -n $UPDATE_GUIDELINES ]]; then
	echo "$0: debug[3]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} -m $YYYY/guidelines.md --" \
	     "$YYYY/guidelines.md $YYYY/guidelines.html" 1>&2
    else
	echo "$0: debug[3]: no need to be update: $YYYY/guidelines.html" 1>&2
    fi
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
