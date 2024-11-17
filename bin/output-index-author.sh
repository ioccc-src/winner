#!/usr/bin/env bash
#
# output-index-author.sh - output author(s) related HTML for an entry's index.html page
#
# This tool is intended to be used as a "before tool" during HTML phase number 20.
# In particular, lines in the bin/md2html.cfg configuration file of the form:
#
#	-b
#	bin/output-index-author.sh
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
# Copyright (c) 2023,2024 by Landon Curt Noll.  All Rights Reserved.
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
export VERSION="1.10.2 2024-11-16"
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
export DOCROOT_SLASH="../../"
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
export URL="#"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-U url] [-w site_url] [-e string ..] [-E exitcode]
			YYYY/dir

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
     8	       error in author/author_handle.json file
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# output_author_handles
#
# Write the author handle(s) for the YYYY/dir entry to standard output (stdout)
#
# usage:
#	output_author_handles YYYY/dir/.entry.json
#
# returns:
#	0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_author_handles
{
    local ENTRY_JSON_PATH;	# the .entry.json path
    local PATTERN;		# XPath for JSON pattern

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in output_author_handles: expected 1 arg, found $#" 1>&2
	return 1
    fi
    ENTRY_JSON_PATH="$1"
    if [[ ! -e $ENTRY_JSON_PATH ]]; then
	echo "$0: ERROR: in output_author_handles: .entry.json does not exist: $ENTRY_JSON_PATH" 1>&2
	return 2
    fi
    if [[ ! -f $ENTRY_JSON_PATH ]]; then
	echo "$0: ERROR: in output_author_handles: .entry.json is not a file: $ENTRY_JSON_PATH" 1>&2
	return 3
    fi
    if [[ ! -r $ENTRY_JSON_PATH ]]; then
	echo "$0: ERROR: in output_author_handles: .entry.json is not a readable file: $ENTRY_JSON_PATH" 1>&2
	return 4
    fi

    # extract author handles from .entry.json
    #
    PATTERN='$..author_handle'
    "$JVAL_WRAPPER" -b -q "$ENTRY_JSON_PATH" "$PATTERN"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo  "$0: ERROR: in output_author_handles: $JVAL_WRAPPER -b -q $ENTRY_JSON_PATH '$PATTERN' failed," \
	      "error: $status" 1>&2
	return 5
    fi
    return 0
}


# output_entry_ids
#
# Write the entry ids from an author/author_handle.json file to standard output (stdout)
#
# usage:
#	output_entry_ids author/author_handle.json
#
# returns:
#	0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_entry_ids
{
    local AUTHOR_HANDLE_JSON_PATH;	# the .entry.json path
    local PATTERN;		# XPath for JSON pattern

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in output_entry_ids: expected 1 arg, found $#" 1>&2
	return 1
    fi
    AUTHOR_HANDLE_JSON_PATH="$1"
    if [[ ! -e $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_entry_ids: author_handle.json does not exist: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 2
    fi
    if [[ ! -f $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_entry_ids: author_handle.json is not a file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 3
    fi
    if [[ ! -r $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_entry_ids: author_handle.json is not a readable file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 4
    fi

    # extract entry ids from the author/author_handle.json file
    #
    PATTERN='$..entry_id'
    "$JVAL_WRAPPER" -b -q "$AUTHOR_HANDLE_JSON_PATH" "$PATTERN"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo  "$0: ERROR: in output_entry_ids: $JVAL_WRAPPER -b -q $AUTHOR_HANDLE_JSON_PATH '$PATTERN' failed," \
	      "error: $status" 1>&2
	return 5
    fi
    return 0
}

# output_full_name
#
# Write the Full Name from an author/author_handle.json file to standard output (stdout)
#
# usage:
#	output_full_name author/author_handle.json
#
# returns:
#	0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_full_name
{
    local AUTHOR_HANDLE_JSON_PATH;	# the .entry.json path
    local PATTERN;		# XPath for JSON pattern

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in output_full_name: expected 1 arg, found $#" 1>&2
	return 1
    fi
    AUTHOR_HANDLE_JSON_PATH="$1"
    if [[ ! -e $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_full_name: author_handle.json does not exist: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 2
    fi
    if [[ ! -f $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_full_name: author_handle.json is not a file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 3
    fi
    if [[ ! -r $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_full_name: author_handle.json is not a readable file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 4
    fi

    # extract Full Name from the author/author_handle.json file
    #
    PATTERN='$..full_name'
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $AUTHOR_HANDLE_JSON_PATH '$PATTERN' | $JSTRDECODE -d -q -N -" 1>&2
    fi
    "$JVAL_WRAPPER" -b -q "$AUTHOR_HANDLE_JSON_PATH" "$PATTERN" | "$JSTRDECODE" -d -q -N -
    status_codes=("${PIPESTATUS[@]}")
    if [[ ${status_codes[*]} =~ [1-9] ]]; then
	echo  "$0: ERROR: in output_full_name: $JVAL_WRAPPER -b -q $AUTHOR_HANDLE_JSON_PATH '$PATTERN' | $JSTRDECODE -d -q -N - failed," \
	      "error codes: ${status_codes[*]}" 1>&2
	return 5
    fi
    return 0
}


# output_location_code
#
# Write the Location Code from an author/author_handle.json file to standard output (stdout)
#
# usage:
#	output_location_code author/author_handle.json
#
# returns:
#	0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_location_code
{
    local AUTHOR_HANDLE_JSON_PATH;	# the .entry.json path
    local PATTERN;		# XPath for JSON pattern

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in output_location_code: expected 1 arg, found $#" 1>&2
	return 1
    fi
    AUTHOR_HANDLE_JSON_PATH="$1"
    if [[ ! -e $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_location_code: author_handle.json does not exist: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 2
    fi
    if [[ ! -f $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_location_code: author_handle.json is not a file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 3
    fi
    if [[ ! -r $AUTHOR_HANDLE_JSON_PATH ]]; then
	echo "$0: ERROR: in output_location_code: author_handle.json is not a readable file: $AUTHOR_HANDLE_JSON_PATH" 1>&2
	return 4
    fi

    # extract Location Code from the author/author_handle.json file
    #
    PATTERN='$..location_code'
    "$JVAL_WRAPPER" -b -q "$AUTHOR_HANDLE_JSON_PATH" "$PATTERN"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo  "$0: ERROR: in output_location_code: $JVAL_WRAPPER -b -q $ENTRY_JSON_PATH '$PATTERN' failed," \
	      "error: $status" 1>&2
	return 5
    fi
    return 0
}


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


# find the location tool
#
LOCATION_TOOL=$(type -P location)
export LOCATION_TOOL
if [[ -z $LOCATION_TOOL ]]; then
    # guess we have a location tool in bin
    #
    LOCATION_TOOL="$BIN_DIR/location"
fi
if [[ ! -x $LOCATION_TOOL ]]; then
    echo "$0: ERROR: cannot find the location executable" 1>&2
    echo "$0: notice: location tool comes from this repo: https://github.com/ioccc-src/mkiocccentry" 1>&2
    exit 5
fi


# parameter debugging
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
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: URL=$URL" 1>&2
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
    echo "$0: debug[3]: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: DOT_PATH_CONTENT=$DOT_PATH_CONTENT" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
    echo "$0: debug[3]: LOCATION_TOOL=$LOCATION_TOOL" 1>&2
fi


# Set AUTHOR_HANDLE_SET with author handles from .entry.json
#
AUTHOR_HANDLE_SET=$(output_author_handles "$ENTRY_JSON")
status="$?"
export AUTHOR_HANDLE_SET
if [[ $status -ne 0 || -z $AUTHOR_HANDLE_SET ]]; then
    echo "$0: ERROR: unable to obtain any author handles from: $ENTRY_JSON" 1>&2
    exit 7
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: author handles found in $ENTRY_JSON start below" 1>&2
    echo "$AUTHOR_HANDLE_SET" 1>&2
    echo "$0: debug[3]: author handles found in $ENTRY_JSON end above" 1>&2
fi


# verify each author handle has a readable author/author_handle.json file
#
for author_handle in $AUTHOR_HANDLE_SET; do

    # determine the author handle JSON path
    #
    export AUTHOR_HANDLE_JSON="$AUTHOR_DIR/$author_handle.json"

    # verify that author/author_handle.json exists as a readable file
    #
    if [[ ! -e $AUTHOR_HANDLE_JSON ]]; then
	echo "$0: ERROR: for author handle: $author_handle author JSON file not found: $AUTHOR_HANDLE_JSON" 1>&2
	exit 8
    fi
    if [[ ! -f $ENTRY_JSON ]]; then
	echo "$0: ERROR: for author handle: $author_handle author JSON is not a file: $AUTHOR_HANDLE_JSON" 1>&2
	exit 8
    fi
    if [[ ! -r $ENTRY_JSON ]]; then
	echo "$0: ERROR: for author handle: $author_handle author JSON is not a readable file: $AUTHOR_HANDLE_JSON" 1>&2
	exit 8
    fi
    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: for author handle: $author_handle found a readable author JSON file: $AUTHOR_HANDLE_JSON" 1>&2
    fi

    # verify that the author/author_handle.json file lists the ENTRY_ID as one of their wins
    #
    ENTRY_ID_FOUND=$(output_entry_ids "$AUTHOR_HANDLE_JSON" | grep -F -- "$ENTRY_ID")
    status="$?"
    export ENTRY_ID_FOUND
    if [[ $status -ne 0 || -z $ENTRY_ID_FOUND ]]; then
	echo "$0: ERROR: entry id: $ENTRY_ID not found in author JSON file: $AUTHOR_HANDLE_JSON, status: $status" 1>&2
	exit 8
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: readable author JSON file: $AUTHOR_HANDLE_JSON mentions entry id: $ENTRY_ID" 1>&2
    fi

    # verify that we have a Full Name in the author/author_handle.json file
    #
    FULL_NAME=$(output_full_name "$AUTHOR_HANDLE_JSON")
    status="$?"
    export FULL_NAME
    if [[ $status -ne 0 || -z $FULL_NAME ]]; then
	echo "$0: ERROR: author JSON file: $AUTHOR_HANDLE_JSON as no FULL NAME, status: $status" 1>&2
	exit 8
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: author JSON file: $AUTHOR_HANDLE_JSON Full Name: $FULL_NAME" 1>&2
    fi

    # verify that we have a Location Code in the author/author_handle.json file
    #
    LOCATION_CODE=$(output_location_code "$AUTHOR_HANDLE_JSON")
    status="$?"
    export LOCATION_CODE
    if [[ $status -ne 0 || -z $LOCATION_CODE ]]; then
	echo "$0: ERROR: author JSON file: $AUTHOR_HANDLE_JSON as no Location Code, status: $status" 1>&2
	exit 8
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: author JSON file: $AUTHOR_HANDLE_JSON Location Code: $LOCATION_CODE" 1>&2
    fi
done


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
export TMP_FILE=".tmp.$NAME.FILE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
    rm -f "$TMP_FILE"
    if [[ -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_FILE" 1>&2
	exit 10
    fi
    :> "$TMP_FILE"
    if [[ ! -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_FILE" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_FILE" 1>&2
fi


# write author header to temporary markdown file
#
{
    AUTHOR_COUNT=$(echo "$AUTHOR_HANDLE_SET" | wc -l)
    export AUTHOR_COUNT
    echo '<div id="author">'
    if [[ $AUTHOR_COUNT -gt 1 ]]; then
	echo '## Authors:'
    else
	echo '## Author:'
    fi
    echo '</div>'
} | if [[ -z $NOOP ]]; then
    cat >> "$TMP_FILE"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: -n disabled write of author header into: $TMP_FILE" 1>&2
    fi
fi


# write each author's information to temporary markdown file
#
export NOT_FIRST_AUTHOR
for author_handle in $AUTHOR_HANDLE_SET; do

    # determine the author handle JSON path
    #
    export AUTHOR_HANDLE_JSON="$AUTHOR_DIR/$author_handle.json"

    # obtain the Full Name from the author handle JSON file
    #
    FULL_NAME=$(output_full_name "$AUTHOR_HANDLE_JSON")
    status="$?"
    export FULL_NAME
    if [[ $status -ne 0 || -z $FULL_NAME ]]; then
	echo "$0: ERROR: author JSON file: $AUTHOR_HANDLE_JSON as no FULL NAME, status: $status" 1>&2
	exit 12
    fi

    # obtain the Location Code from the author handle JSON file
    #
    LOCATION_CODE=$(output_location_code "$AUTHOR_HANDLE_JSON")
    status="$?"
    export LOCATION_CODE
    if [[ $status -ne 0 || -z $LOCATION_CODE ]]; then
	echo "$0: ERROR: author JSON file: $AUTHOR_HANDLE_JSON as no Location Code, status: $status" 1>&2
	exit 13
    fi

    # use the location tool to obtain the location_name
    #
    LOCATION_NAME=$("$LOCATION_TOOL" "$LOCATION_CODE" 2>/dev/null)
    status="$?"
    export LOCATION_NAME
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: cannot determine location name for location ISO 3166 code: $LOCATION_CODE" 1>&2
	exit 14
    fi

    # use the location tool to obtain the location common name
    #
    LOCATION_COMMON_NAME=$("$LOCATION_TOOL" -c "$LOCATION_CODE" 2>/dev/null)
    status="$?"
    export LOCATION_COMMON_NAME
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: cannot determine location common name" \
	     "for location ISO 3166 code: $LOCATION_CODE" 1>&2
	exit 15
    fi

    # write this author's information
    #
    {
	# If not the first author, add a line break
	#
	if [[ -n $NOT_FIRST_AUTHOR ]]; then
	    echo "<br><br>"
	fi

	# Output this author's information
	#
	echo "* Name: [$FULL_NAME](${DOCROOT_SLASH}authors.html#$author_handle)<br>"
	if [[ $LOCATION_CODE == null ]]; then
	    echo "Location: [unknown](${DOCROOT_SLASH}location.html#$LOCATION_CODE) - _${LOCATION_NAME}_"
	else
	    if [[ $LOCATION_NAME == "$LOCATION_COMMON_NAME" ]]; then
		echo "Location: [$LOCATION_CODE](${DOCROOT_SLASH}location.html#$LOCATION_CODE) -" \
		     "_${LOCATION_NAME}_"
	    else
		echo "Location: [$LOCATION_CODE](${DOCROOT_SLASH}location.html#$LOCATION_CODE) -" \
		     "_${LOCATION_NAME}_ (_${LOCATION_COMMON_NAME}_)"
	    fi
	fi
    } | if [[ -z $NOOP ]]; then
	cat >> "$TMP_FILE"
    else
	cat > /dev/null
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: -n disabled write of author's information into: $TMP_FILE" 1>&2
	fi
    fi
    NOT_FIRST_AUTHOR="true"
done


# convert temporary markdown file into HTML
#
if [[ -z $NOOP ]]; then
    echo "<!-- START: this line starts content generated by: bin/$NAME -->"
    echo
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: about to execute: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
    fi
    "$PANDOC_WRAPPER" "$TMP_FILE" -
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc failed, error: $status" 1>&2
	exit 1
    fi
    echo
    echo "<!-- END: next line ends content generated by: bin/$NAME -->"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_FILE"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_FILE" 1>&2
fi
exit 0
