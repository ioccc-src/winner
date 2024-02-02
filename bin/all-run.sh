#!/usr/bin/env bash
#
# all-run.sh - run a command for all winners
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
export VERSION="1.1.2 2024-01-20"
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
     1	       some execution of tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       tool is not an executable
     6	       topdir is not in proper form
     7	       topdir/YYYY is not in proper form
     8	       topdir/YYYY/dir is not in proper form
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
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
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
export TOOL TOOL_OPTIONS
case "$#" in
0) echo "$0: ERROR: expected 1 or more args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
1) TOOL="$1"
   ;;
*) TOOL="$1"
   shift
   TOOL_OPTIONS="$*"
   ;;
esac

# clear options we will add to tools
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

# verify we have a non-empty readable .top file
#
TOP_FILE=".top"
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

# print running info if verbose
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: TOP_URL=$TOP_URL" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: OPTSTR=$OPTSTR" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
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
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
    if [[ ! -d $YYYY ]]; then
	echo  "$0: ERROR: YYYY is not a directory: $YYYY" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
    if [[ ! -r $YYYY ]]; then
	echo  "$0: ERROR: YYYY is not an readable directory: $YYYY" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi

    # verify that YYYY has a non-empty readable .year file
    #
    export YEAR_FILE="$YYYY/.year"
    if [[ ! -e $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year does not exist: $YEAR_FILE" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
    if [[ ! -f $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not a regular file: $YEAR_FILE" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
    if [[ ! -r $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not an readable file: $YEAR_FILE" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi
    if [[ ! -s $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $YEAR_FILE" 1>&2
	EXIT_CODE="7"  # exit 7
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    fi

    # process each winner under YYYY
    #
    export WINNER_PATH
    for WINNER_PATH in $(< "$YEAR_FILE"); do

	# debug YYYY
	#
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: starting to process year/dir: $WINNER_PATH" 1>&2
	fi

	# parse WINNER_PATH
	#
	if [[ ! -d $WINNER_PATH ]]; then
	    echo "$0: ERROR: WINNER_PATH is not a directory: $WINNER_PATH" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ ! -w $WINNER_PATH ]]; then
	    echo "$0: ERROR: WINNER_PATH is not a writable directory: $WINNER_PATH" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	export YEAR_DIR=${WINNER_PATH%%/*}
	if [[ -z $YEAR_DIR ]]; then
	    echo "$0: ERROR: WINNER_PATH not in yyyy/dir form: $WINNER_PATH" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	export WINNER_DIR=${WINNER_PATH#*/}
	if [[ -z $WINNER_DIR ]]; then
	    echo "$0: ERROR: WINNER_PATH not in $YEAR_DIR/dir form: $WINNER_PATH" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ $WINNER_DIR = */* ]]; then
	    echo "$0: ERROR: WINNER_PATH: $WINNER_PATH dir contains a /: $WINNER_DIR" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi

	# verify that WINNER_PATH is a writable directory
	#
	if [[ ! -e $WINNER_PATH ]]; then
	    echo  "$0: ERROR: WINNER_PATH does not exist: $WINNER_PATH" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ ! -d $WINNER_PATH ]]; then
	    echo  "$0: ERROR: WINNER_PATH is not a directory: $WINNER_PATH" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ ! -w $WINNER_PATH ]]; then
	    echo  "$0: ERROR: WINNER_PATH is not an writable directory: $WINNER_PATH" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi

	# verify YYYY/dir/.path
	#
	export DOT_PATH="$WINNER_PATH/.path"
	if [[ ! -s $DOT_PATH ]]; then
	    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	DOT_PATH_CONTENT=$(< "$DOT_PATH")
	if [[ $WINNER_PATH != "$DOT_PATH_CONTENT" ]]; then
	    echo "$0: ERROR: arg: $WINNER_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	export WINNER_JSON="$WINNER_PATH/.winner.json"
	if [[ ! -e $WINNER_JSON ]]; then
	    echo "$0: ERROR: .winner.json does not exist: $WINNER_JSON" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ ! -f $WINNER_JSON ]]; then
	    echo "$0: ERROR: .winner.json is not a file: $WINNER_JSON" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi
	if [[ ! -r $WINNER_JSON ]]; then
	    echo "$0: ERROR: .winner.json is not a readable file: $WINNER_JSON" 1>&2
	    EXIT_CODE="8"  # exit 8
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	fi

	# run the tool
	#
	if [[ -z $DO_NOT_PROCESS ]]; then

	    # run the tool
	    #
	    if [[ -z $NOOP ]]; then
		if [[ $V_FLAG -ge 5 ]]; then
		    echo "$0: debug[5]: about to run: $TOOL $OPTSTR $TOOL_OPTIONS \"$WINNER_PATH\"" 1>&2
		fi
		eval "$TOOL" "$OPTSTR" "$TOOL_OPTIONS" '"'"$WINNER_PATH"'"'
		status="$?"
		if [[ $status -ne 0 ]]; then
		    echo "$0: ERROR: tool: $TOOL failed, error: $status" 1>&2
		    EXIT_CODE="1"  # exit 1
		    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		fi

	    # report disabled by -n
	    #
	    elif [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: because of -n, did not run: $TOOL $OPTSTR $TOOL_OPTIONS \"$WINNER_PATH\"" 1>&2
	    fi

	# report disabled by -N
	#
	else
	    if [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: arguments parsed, -N given, not running tool" 1>&2
	    fi
	fi
    done
done

# All Done!!! -- Jessica Noll, Age 2
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to exit $EXIT_CODE" 1>&2
fi
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit non-zero: $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
