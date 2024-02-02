#!/usr/bin/env bash
#
# quick-readme2index.sh - quickly determine if readme2index.sh needs to be run
#
# If yyyy/dir/.winner.json exists and was modified newer than
# yyyy/dir/index.html or of yyyy/dir/index.html does not exist,
# then readme2index.sh will be run using the yyyy/dir option.
#
# If yyyy/dir/.winner.json does not exist, then an error will thrown.
#
# If yyyy/dir/.winner.json exists and was modified same or older than
# yyyy/dir/index.html, then nothing will happen.
#
# This tool has only has command line options also found in all-run.sh,
# which is a subset of the command line options available to readme2index.sh.
#
# If  `index.html` is not a non-empty file, or of either `.winner.json`
# and/or `README.md` is newer than `index.html`, only then `readme2index.sh`
# is executed.
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

# firewall - must be bash with a version 4.2 or later
#
# We must declare arrays with -ag or -Ag
#
if [[ -z ${BASH_VERSINFO[0]} || ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi
# firewall - must be bash with a version 4.2 or later
#
# We must declare arrays with -ag or -Ag
#
if [[ -z ${BASH_VERSINFO[0]} || ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi

# setup bash file matching
#
# Requires bash with a version 4.2 or later
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -s globskipdots	# enable never matching . or ..
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories

# set variables referenced in the usage message
#
export VERSION="1.0 2024-01-20"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
    exit 10
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export PANDOC_WRAPPER="bin/pandoc-wrapper.sh"
export PANDOC_WRAPPER_OPTSTR="-f markdown -t html --fail-if-warnings=true"
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
export TOP_URL="https://ioccc-src.github.io/temp-test-ioccc"
export DOCROOT_URL_SLASH="/temp-test-ioccc/"
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"
#
export V_FLAG_FOUND=
export P_FLAG_FOUND=
export CAP_P_FLAG_FOUND=
export U_FLAG_FOUND=
export CAP_U_FLAG_FOUND=

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-p tool] [-P optstr] [-u repo_url] [-U top_url] [-e string ..] [-E exitcode]
			tool [tool_options]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
			NOTE: The '-d topdir' is passed as leading options on tool command lines.

	-n		go thru the actions, but do not update any files (def: do the action)
			NOTE: -n is passed to tool
	-N		do not process file, just parse arguments and ignore the file (def: process the file)
			NOTE: -N disables running a tool

	-p tool		run 'pandoc wrapper tool' (not pandoc path) during HTML phase number 21 (def: use $PANDOC_WRAPPER)
			NOTE: The '-p tool' is passed as leading options on tool command lines.
	-P pandoc_opts	run 'pandoc wrapper tool' with options found in 'optstr' (def: $PANDOC_WRAPPER_OPTSTR)
			NOTE: The '-P pandoc_opts' is passed as leading options on tool command lines.
			NOTE: The 'pandoc_opts' may not contain a single-quote or a double-quote.

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)
			NOTE: The '-u repo_url' is passed as leading options on tool command lines.
	-U top_url	Top level URL of web site where HTML files will be viewed (def: $TOP_URL)
			NOTE: The '-U top_url' is passed as leading options on tool command lines.

	tool		the tool to run over all winners
	tool_options	tool command line options to use before YYYY/dir

Exit codes:
     0         all OK
     1	       readme2index.sh exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       readme2index.sh tool executable not found
     6	       topdir, topdir/YYYY, or topdir/YYYY/dir  is not in proper form
     7	       missing non-empty readable .winner.json file
     8	       missing non-empty readable README.md file
 >= 10 < 200   internal error
 >= 200	       ((not used))

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:Vd:nNp:P:u:U: flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
       V_FLAG_FOUND="-v"
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
    p) PANDOC_WRAPPER="$OPTARG"
	P_FLAG_FOUND="-p" ;;
    P) # parse -P optstr
	case "$OPTARG" in
	*"'"*)
	    echo "$0: ERROR: in -P optstr, the optstr may not contain a single-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*'"'*)
	    echo "$0: ERROR: in -P optstr, the optstr may not contain a double-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*) ;;
	esac
	PANDOC_WRAPPER_OPTSTR="$OPTARG"
	CAP_P_FLAG_FOUND="-P"
	;;
    u) REPO_URL="$OPTARG"
	U_FLAG_FOUND="-u"
	;;
    U) TOP_URL="$OPTARG"
	CAP_U_FLAG_FOUND="-U"
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
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: debug level: $V_FLAG" 1>&2
fi
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
export TOOL_OPTIONS
export WINNER_PATH
case "$#" in
0) echo "$0: ERROR: expected 1 or more args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
1) WINNER_PATH="$1"
   shift
   ;;
*) WINNER_PATH="$1"
   shift
   TOOL_OPTIONS="$*"
   ;;
esac

# clear options we will add to the tool
#
export OPTSTR=

# add '-p tool' options to tool arguments
#
if [[ -n $P_FLAG_FOUND && -n $PANDOC_WRAPPER ]]; then
    if [[ -z $OPTSTR ]]; then
	OPTSTR="-p \"$PANDOC_WRAPPER\""
    else
	OPTSTR="$OPTSTR -p \"$PANDOC_WRAPPER\""
    fi
fi

# add '-P optstr' options to tool arguments
#
if [[ -n $CAP_P_FLAG_FOUND && -n $PANDOC_WRAPPER_OPTSTR ]]; then
    if [[ -z $OPTSTR ]]; then
	OPTSTR="-P \"$PANDOC_WRAPPER_OPTSTR\""
    else
	OPTSTR="$OPTSTR -P \"$PANDOC_WRAPPER_OPTSTR\""
    fi
fi

# add '-u repo_url' options to tool arguments
#
if [[ -n $U_FLAG_FOUND && -n $REPO_URL ]]; then
    if [[ -z $OPTSTR ]]; then
	OPTSTR="-u \"$REPO_URL\""
    else
	OPTSTR="$OPTSTR -u \"$REPO_URL\""
    fi
fi

# add '-U top_url' options to tool arguments
#
if [[ -n $CAP_U_FLAG_FOUND && -n $TOP_URL ]]; then
    if [[ -z $OPTSTR ]]; then
	OPTSTR="-U \"$TOP_URL\""
    else
	OPTSTR="$OPTSTR -U \"$TOP_URL\""
    fi
fi

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
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

# verify that we have an bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"

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

# verify that WINNER_PATH is a winner directory
#
# WINNER_PATH must be in yyyy/dir form
# yyyy must be a directory
# yyyy must be a writable directory
# yyyy/.year must be a non-empty file
# yyyy/dir must be a directory
# yyyy/dir/.path must be a non-empty file
# WINNER_PATH must match the contents of yyyy/dir/.path
# yyyy/dir/.winner.json must be a non-empty file
#
if [[ ! -d $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a directory: $WINNER_PATH" 1>&2
    exit 6
fi
if [[ ! -w $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $WINNER_PATH" 1>&2
    exit 6
fi
export YEAR_DIR=${WINNER_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in yyyy/dir form: $WINNER_PATH" 1>&2
    exit 6
fi
export WINNER_DIR=${WINNER_PATH#*/}
if [[ -z $WINNER_DIR ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH not in $YEAR_DIR/dir form: $WINNER_PATH" 1>&2
    exit 6
fi
if [[ $WINNER_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $WINNER_PATH contains a /: $WINNER_DIR" 1>&2
    exit 6
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: yyyy from arg: $WINNER_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 6
fi
export WINNER_ID="${YEAR_DIR}_${WINNER_DIR}"
export DOT_YEAR="$YEAR_DIR/.year"
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 6
fi
if [[ ! -d $YEAR_DIR/$WINNER_DIR ]]; then
    echo "$0: ERROR: yyyy/dir from arg: $WINNER_PATH is not a directory: $YEAR_DIR/$WINNER_DIR" 1>&2
    exit 6
fi
export DOT_PATH="$YEAR_DIR/$WINNER_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 6
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
if [[ $WINNER_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 6
fi
export WINNER_JSON="$YEAR_DIR/$WINNER_DIR/.winner.json"
if [[ ! -e $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json does not exist: $WINNER_JSON" 1>&2
    exit 7
fi
if [[ ! -f $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a file: $WINNER_JSON" 1>&2
    exit 7
fi
if [[ ! -r $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a readable file: $WINNER_JSON" 1>&2
    exit 7
fi
if [[ ! -s $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a non-empty readable file: $WINNER_JSON" 1>&2
    exit 7
fi
export README_MD="$YEAR_DIR/$WINNER_DIR/README.md"
if [[ ! -e $README_MD ]]; then
    echo "$0: ERROR: README.md does not exist: $README_MD" 1>&2
    exit 8
fi
if [[ ! -f $README_MD ]]; then
    echo "$0: ERROR: README.md is not a file: $README_MD" 1>&2
    exit 8
fi
if [[ ! -r $README_MD ]]; then
    echo "$0: ERROR: README.md is not a readable file: $README_MD" 1>&2
    exit 8
fi
if [[ ! -s $README_MD ]]; then
    echo "$0: ERROR: README.md is not a non-empty readable file: $README_MD" 1>&2
    exit 8
fi
export INDEX_HTML="$YEAR_DIR/$WINNER_DIR/index.html"

# determine our readme2index.sh tool path
#
export TOOL="$BIN_DIR/readme2index.sh"

# verify tool is executable
#
if [[ ! -e $TOOL ]]; then
    echo  "$0: ERROR: TOOL does not exist: $TOOL" 1>&2
    exit 5
fi
if [[ ! -f $TOOL ]]; then
    echo  "$0: ERROR: TOOL is not a regular file: $TOOL" 1>&2
    exit 5
fi
if [[ ! -x $TOOL ]]; then
    echo  "$0: ERROR: TOOL is not an executable file: $TOOL" 1>&2
    exit 5
fi

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: WINNER_DIR=$WINNER_DIR" 1>&2
    echo "$0: debug[3]: WINNER_ID=$WINNER_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: WINNER_JSON=$WINNER_JSON" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: TOP_URL=$TOP_URL" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: PANDOC_WRAPPER_OPTSTR=$PANDOC_WRAPPER_OPTSTR" 1>&2
    echo "$0: debug[3]: WINNER_JSON=$WINNER_JSON" 1>&2
    echo "$0: debug[3]: README_MD=$README_MD" 1>&2
    echo "$0: debug[3]: INDEX_HTML=$INDEX_HTML" 1>&2
    echo "$0: debug[3]: TOOL=$TOOL" 1>&2
    echo "$0: debug[3]: OPTSTR=$OPTSTR" 1>&2
    echo "$0: debug[3]: TOOL_OPTIONS=$TOOL_OPTIONS" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
fi

# determine if we need to run the tool
#
# If the non-empty index.html is newer than the .winner.json file,
#
if [[ $V_FLAG -ge 5 ]]; then
    ls -lRt "$INDEX_HTML" "$WINNER_JSON" "$README_MD" 2>/dev/null
fi
if [[ -s $INDEX_HTML && $INDEX_HTML -nt $WINNER_JSON && $INDEX_HTML -nt $README_MD ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: does not need to be updated: $INDEX_HTML" 1>&2
    fi
    exit 0
fi

# run the tool
#
if [[ -z $NOOP ]]; then

    # run the tool
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to run: $TOOL $OPTSTR $TOOL_OPTIONS \"$WINNER_PATH\"" 1>&2
    fi
    eval "$TOOL" "$OPTSTR" "$TOOL_OPTIONS" '"'"$WINNER_PATH"'"'
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: tool: $TOOL failed, error: $status" 1>&2
	exit 1
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, did not run: $TOOL $OPTSTR $TOOL_OPTIONS \"$WINNER_PATH\"" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
