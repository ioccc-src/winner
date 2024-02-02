#!/usr/bin/env bash
#
# gen-inventory.sh - output the inventory in HTML form for a winner index.html page
#
# This tool is intended to be used as a "before tool" during HTML phase number 22.
#
# This tool is intended to be invoked by a tool such as "readme2index.sh".
# The final arg will be in yyyy/dir form, and will be called from
# the topdir directory under which the yyyy/dir winner directory must be found.
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
shopt -s nullglob	# enable expand to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with '.'
shopt -s globskipdots	# enable never matching '.' or '..'
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable '**' to match all files and zero or more directories and subdirectories

# set variables referenced in the usage message
#
export VERSION="1.0.1 2024-01-16"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or is not in PATH" 1>&2
    exit 200
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

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-p tool] [-P optstr] [-u repo_url] [-U top_url] [-e string ..] [-E exitcode]
			yyyy/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-p tool		run 'pandoc wrapper tool' (not pandoc path) during HTML phase number 21 (def: use $PANDOC_WRAPPER)
	-P pandoc_opts	run 'pandoc wrapper tool' with options found in 'optstr' (def: $PANDOC_WRAPPER_OPTSTR)
			NOTE: The 'pandoc_opts' may not contain a single-quote or a double-quote.

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)
	-U top_url	Top level URL of web site where HTML files will be viewed (def: $TOP_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	yyyy/dir	path from topdir to winner directory: must contain the files: README.md, .path and .winner.json

Exit codes:
     0         all OK
     1	       pandoc exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       yyyy/dir is not a winner directory
     6         pandoc tool not found or not executable
 >= 10 < 200   ((not used))
 >= 200	       internal error

$NAME version: $VERSION"

# setup
#
export NOOP=
export DO_NOT_PROCESS=

# parse command line
#
while getopts :hv:Vd:nNp:P:u:U:e:E: flag; do
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
	;;
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
	;;
    u) REPO_URL="$OPTARG"
	;;
    U) TOP_URL="$OPTARG"
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
export WINNER_PATH="$1"
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: WINNER_PATH=$WINNER_PATH" 1>&2
fi

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 201
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 202
fi

# verify that we have an author subdirectory
#
export AUTHOR_PATH="$TOPDIR/author"
if [[ ! -d $AUTHOR_PATH ]]; then
    echo "$0: ERROR: author is not a directory under topdir: $AUTHOR_PATH" 1>&2
    exit 203
fi
export AUTHOR_DIR="author"

# verify that we have an inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 204
fi
export INC_DIR="inc"

# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 205
fi
export BIN_DIR="bin"

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 206
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 207
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 208
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
    exit 5
fi
if [[ ! -w $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $WINNER_PATH" 1>&2
    exit 5
fi
export YEAR_DIR=${WINNER_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in yyyy/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
export WINNER_DIR=${WINNER_PATH#*/}
if [[ -z $WINNER_DIR ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH not in $YEAR_DIR/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
if [[ $WINNER_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $WINNER_PATH contains a /: $WINNER_DIR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: yyyy from arg: $WINNER_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 5
fi
export WINNER_ID="${YEAR_DIR}_${WINNER_DIR}"
export DOT_YEAR="$YEAR_DIR/.year"
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR/$WINNER_DIR ]]; then
    echo "$0: ERROR: yyyy/dir from arg: $WINNER_PATH is not a directory: $YEAR_DIR/$WINNER_DIR" 1>&2
    exit 5
fi
export DOT_PATH="$YEAR_DIR/$WINNER_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 5
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
if [[ $WINNER_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 5
fi
export WINNER_JSON="$YEAR_DIR/$WINNER_DIR/.winner.json"
if [[ ! -e $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json does not exist: $WINNER_JSON" 1>&2
    exit 5
fi
if [[ ! -f $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a regular file: $WINNER_JSON" 1>&2
    exit 5
fi
if [[ ! -r $WINNER_JSON ]]; then
    echo "$0: ERROR: .winner.json is not a readable file: $WINNER_JSON" 1>&2
    exit 5
fi
if [[ ! -e $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool does not exist: $PANDOC_WRAPPER" 1>&2
    exit 6
fi
if [[ ! -f $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool is not a regular file: $PANDOC_WRAPPER" 1>&2
    exit 6
fi
if [[ ! -x $PANDOC_WRAPPER ]]; then
    echo "$0: ERROR: pandoc wrapper tool is not an executable file: $PANDOC_WRAPPER" 1>&2
    exit 6
fi

# verify we have our awk script
#
export MANIFEST_WINNER_JSON_AWK="$BIN_DIR/manifest.winner.json.awk"
if [[ ! -e $MANIFEST_WINNER_JSON_AWK ]]; then
    echo "$0: ERROR: bin/manifest.winner.json.awk does not exist: $MANIFEST_WINNER_JSON_AWK" 1>&2
    exit 6
fi
if [[ ! -f $MANIFEST_WINNER_JSON_AWK ]]; then
    echo "$0: ERROR: bin/manifest.winner.json.awk is not a regular file: $MANIFEST_WINNER_JSON_AWK" 1>&2
    exit 6
fi
if [[ ! -r $MANIFEST_WINNER_JSON_AWK ]]; then
    echo "$0: ERROR: bin/manifest.winner.json.awk is not a readable file: $MANIFEST_WINNER_JSON_AWK" 1>&2
    exit 6
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
    echo "$0: debug[3]: MANIFEST_WINNER_JSON_AWK=$MANIFEST_WINNER_JSON_AWK" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
fi

# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi

# create a temporary markdown for pandoc to process
#
TMP_FILE=".$NAME.$$.md"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
    rm -f "$TMP_FILE"
    if [[ -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_FILE" 1>&2
	exit 209
    fi
    :> "$TMP_FILE"
    if [[ ! -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_FILE" 1>&2
	exit 210
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_FILE" 1>&2
fi

# create a temporary manifest file
#
TMP_MANIFEST=".$NAME.$$.manifest"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary manifest file: $TMP_MANIFEST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_FILE $TMP_MANIFEST; exit' 0 1 2 3 15
    rm -f "$TMP_MANIFEST"
    if [[ -e $TMP_MANIFEST ]]; then
	echo "$0: ERROR: cannot remove temporary manifest file: $TMP_MANIFEST" 1>&2
	exit 211
    fi
    :> "$TMP_MANIFEST"
    if [[ ! -e $TMP_MANIFEST ]]; then
	echo "$0: ERROR: cannot create temporary manifest file: $TMP_MANIFEST" 1>&2
	exit 212
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary manifest file is not used: $TMP_MANIFEST" 1>&2
fi

# generate the temporary manifest file
#
if [[ -z $NOOP ]]; then
    awk -v github="$REPO_URL" -f "$MANIFEST_WINNER_JSON_AWK" "$WINNER_JSON" > "$TMP_MANIFEST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: manifest.winner.json.awk failed, error: $status" 1>&2
	exit 213
    fi

    # load numerically sorted winners_rank lines into the temporary markdown file
    #
    # Any winners_rank that is 1 to 9 decimal digits is considered a primary file.
    # Any winners_rank that is 10 or more decimal digits is considered a secondary file.
    #
    {
	echo '# <a name="inventory"></a>Inventory for' "$YEAR_DIR/$WINNER_DIR"
	echo
	echo '## Primary files'
	echo
	grep -E '^[0-9][0-9]{0,8} ' "$TMP_MANIFEST" | sort -n | sed -e 's/^[0-9][0-9]* //'
	echo
	echo '## Secondary files'
	echo
	grep -E '^[1-9][0-9]{9,} ' "$TMP_MANIFEST" | sort -n | sed -e 's/^[0-9][0-9]* //'
    } > "$TMP_FILE"

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary manifest file is NOT written into: $TMP_MANIFEST" 1>&2
fi

# convert temporary markdown file into HTML
#
if [[ -z $NOOP ]]; then
    echo "<!-- START: this line starts content generated by: bin/$NAME -->"
    echo
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: about to execute: $PANDOC_WRAPPER -P \"$PANDOC_WRAPPER_OPTSTR\" $TMP_FILE -" 1>&2
    fi
    "$PANDOC_WRAPPER" -P "$PANDOC_WRAPPER_OPTSTR" "$TMP_FILE" -
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc failed, error: $status" 1>&2
	exit 213
    fi
    echo
    echo "<!-- END: next line ends content generated by: bin/$NAME -->"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: $PANDOC_WRAPPER -P \"$PANDOC_WRAPPER_OPTSTR\" $TMP_FILE -" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_FILE" "$TMP_MANIFEST"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_FILE $TMP_MANIFEST" 1>&2
fi
exit 0
