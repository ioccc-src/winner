#!/usr/bin/env bash
#
# pandoc-wrapper.sh - wrapper tool to run pandoc
#
# This tool is intended to be used as a 'pandoc wrapper tool' by bin/md2html.sh
# during HTML phase number 21.
#
# This tool is also run by other bin tools such as:
#
#	bin/output-index-author.sh
#	bin/output-index-inventory.sh
#	bin/output-year-index.sh
#	bin/quick-readme2index.sh
#	bin/readme2index.sh
#	bin/status2html.sh.
#
# The leading options will include "-p pandoc_wrapper" and -P "optstr",
# the final arg will be in YYYY/dir form, and will be called from
# the topdir directory under which the YYYY/dir entry directory must be found.
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
export VERSION="1.7 2024-06-22"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
export PANDOC_TOOL
EXPAND_TOOL=$(type -P expand)
export EXPAND_TOOL
if [[ -z "$EXPAND_TOOL" ]]; then
    echo "$0: FATAL: expand tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
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
PANDOC_TOOL=$(type -P pandoc)
export PANDOC_TOOL
if [[ -z $PANDOC_TOOL ]]; then
    PANDOC_TOOL="/opt/homebrew/bin/pandoc"
fi
unset PANDOC_OPTION
declare -ag PANDOC_OPTION
PANDOC_OPTION+=("-f")
PANDOC_OPTION+=("markdown")
PANDOC_OPTION+=("-t")
PANDOC_OPTION+=("html5")
PANDOC_OPTION+=("--wrap=preserve")
PANDOC_OPTION+=("--fail-if-warnings")
PANDOC_OPTION+=("--tab-stop=8")
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc/blob/master"

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-p pandoc_tool] [-u repo_url] [-e string ..] [-E exitcode]
			file.md output.html

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-p pandoc_tool	path to the pandoc tool (not the wrapper) (def: $PANDOC_TOOL)

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	file.md		markdown file to convert into HTML
	output.html	HTML generated by pandoc from file.md
			NOTE: Use - to write to standard output (stdout)
			NOTE: Without -n, will prepend '-o output.html' as first pandoc options
			      With -n, will append '-o /dev/null' as last pandoc options before file.md

Exit codes:
     0         all OK
     1	       pandoc exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found, version is too old, or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
 >= 10         internal error

$NAME version: $VERSION"

# setup
#
export NOOP=
export DO_NOT_PROCESS=

# parse command line
#
while getopts :hv:Vd:nNp:u:e:E: flag; do
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
    p) PANDOC_TOOL="$OPTARG"
	;;
    u) REPO_URL="$OPTARG"
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

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: argument count: $#" 1>&2
fi
if [[ $# -ne 2 ]]; then
    echo "$0: ERROR: expected 2 args, found: $#" 1>&2
    exit 3
fi
#
export MARKDOWN_INPUT="$1"
export HTML_OUTPUT="$2"

# firewall - validate args
#
if [[ ! -e $MARKDOWN_INPUT ]]; then
    echo "$0: ERROR: markdown input file does not exist: $MARKDOWN_INPUT" 1>&2
    exit 3
fi
if [[ ! -f $MARKDOWN_INPUT ]]; then
    echo "$0: ERROR: markdown input is not a file: $MARKDOWN_INPUT" 1>&2
    exit 3
fi
if [[ ! -r $MARKDOWN_INPUT ]]; then
    echo "$0: ERROR: markdown input is not a readable file: $MARKDOWN_INPUT" 1>&2
    exit 3
fi
if [[ ! -x $PANDOC_TOOL ]]; then
    echo "$0: ERROR: cannot find an executable pandoc tool: $PANDOC_TOOL" 1>&2
    exit 5
fi
PANDOC_TOOL_VERSION=$("$PANDOC_TOOL" --version | head -1 | awk '{print $2;}')
export PANDOC_TOOL_VERSION

# set the minimum pandoc version
#
# We have found that very old versions of pandoc, such as version 2.14.0.3,
# produce rather different output due to rather different default settings,
# and perhaps bugs that were fixed in more recent versions, and perhaps
# new features that were added in more recent versions of pandoc.
#
# We know that pandoc version 2.14.0.3 does not work well for our purposes
# and produces different enough output to pose a consistency problem.
# It may be possible that versions > 2.14.0.3 and < 3.1.12.2 might work.
# We tested pandoc version 3.1.12.2 and therefore set this as the minimum allowed.
#
export PANDOC_MIN_VERSION="3.1.12.2"

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
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

# verify that we have an bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: EXPAND_TOOL=$EXPAND_TOOL" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: PANDOC_TOOL=$PANDOC_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: PANDOC_TOOL=$PANDOC_TOOL" 1>&2
    for index in "${!PANDOC_OPTION[@]}"; do
	echo "$0: debug[3]: PANDOC_OPTION[$index]=${PANDOC_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: MARKDOWN_INPUT=$MARKDOWN_INPUT" 1>&2
    echo "$0: debug[3]: HTML_OUTPUT=$HTML_OUTPUT" 1>&2
    echo "$0: debug[3]: PANDOC_TOOL_VERSION=$PANDOC_TOOL_VERSION" 1>&2
    echo "$0: debug[3]: PANDOC_MIN_VERSION=$PANDOC_MIN_VERSION" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
fi

# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi

# verify that the pandoc version is >= the minimum version
#
FIRST_VERSION=$(printf "%s\n%s" "$PANDOC_TOOL_VERSION" "$PANDOC_MIN_VERSION" | LC_ALL=C sort -V | head -1)
export FIRST_VERSION
if [[ $FIRST_VERSION != "$PANDOC_MIN_VERSION" ]]; then
    echo "$0: ERROR: pandoc: $PANDOC_TOOL version: $PANDOC_TOOL_VERSION <=" \
	 "minimum allowed: $PANDOC_MIN_VERSION" 1>&2
    echo "$0: Warning: pandoc version must be >= $PANDOC_MIN_VERSION" 1>&2
    echo "$0: Warning: install a more up to date pandoc and/or use -p pandoc_tool to refer an up to date pandoc" 1>&2
    exit 5
fi

# execute pandoc
#
if [[ -z $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: will execute pandoc as: $EXPAND_TOOL -t 8 -- $MARKDOWN_INPUT | $PANDOC_TOOL ${PANDOC_OPTION[*]} -o $HTML_OUTPUT" 1>&2
    fi
    "$EXPAND_TOOL" -t 8 -- "$MARKDOWN_INPUT" | "$PANDOC_TOOL" "${PANDOC_OPTION[@]}" -o "$HTML_OUTPUT"
    status="${PIPESTATUS[1]}"
else
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[3]: will execute pandoc as: $EXPAND_TOOL -t 8 -- $MARKDOWN_INPUT | $PANDOC_TOOL ${PANDOC_OPTION[*]} -o /dev/null" 1>&2
    fi
    "$EXPAND_TOOL" -t 8 -- "$MARKDOWN_INPUT" | "$PANDOC_TOOL" "${PANDOC_OPTION[*]}" -o /dev/null "$MARKDOWN_INPUT"
    status="${PIPESTATUS[1]}"
fi
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: pandoc: $PANDOC_TOOL exited non-zero: $status" 1>&2
    if [[ -n $NOOP ]]; then
	echo "$0: Warning: forming debug.input.md from: $MARKDOWN_INPUT" 1>&2
	cp -v -f "$MARKDOWN_INPUT" debug.input.md
	echo "$0: Warning: forming debug.output.html from: $HTML_OUTPUT" 1>&2
	cp -v -f "$HTML_OUTPUT" debug.output.html
    fi
    exit 1
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
