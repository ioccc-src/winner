#!/usr/bin/env bash
#
# check_html.sh - check if HTML is valid
#
# Using the `vnu(1)` tool, check if one or more HTML files are valid.
#
# Copyright (c) 2026 by Landon Curt Noll.  All Rights Reserved.
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
	 "\"brew install bash\" and then modify your \$PATH so that \"#!/usr/bin/env bash\"" \
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
shopt -u nocaseglob	# enable strict case matching
shopt -u extglob	# disable extended globbing patterns
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
export VERSION="1.3.0 2026-11-26"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
VNU_TOOL=$(type -P vnu)
export VNU_TOOL
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -n $GIT_TOOL ]] && "$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR
#
VERGE=$(type -P verge)
export VERGE
unset VNU_OPTION
declare -ag VNU_OPTION
# Check HTML with warnings treated as errors and retain all diagnostics.
#
VNU_OPTION+=("--html")
VNU_OPTION+=("--Werror")
export REPO_TOP_URL="https://github.com/ioccc-src/winner"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-a] [-d topdir] [-e exclude_file] [-l] [-n] [-N] [-p vnu_path] file ...

    -h              print help message and exit
    -v level        set verbosity level (def level: 0)
    -V              print version string and exit

    -a              check files regardless of their filename extension
    -d topdir       set topdir (def: $TOPDIR)
    -e exclude_file set exclusion file relative to topdir; . disables exclusions
                    (def: bin/exclude.cfg)
    -l              list failing paths on stdout instead of vnu diagnostics

    -n              select inputs, but do not run vnu on the files
    -N              check arguments and environment, but do not validate files

    -p vnu_path     path to the vnu tool (not the wrapper) (def: $VNU_TOOL)

    file ...        files or directories under topdir to validate; - reads stdin
                    directories are scanned recursively without following directory symlinks
                    default extensions: .html, .htm, .xhtml, .xht
                    exclusions apply to both explicit files and directory scans

Exit codes:
     0         all HTML file(s) are OK
     1         vnu reported a validation error, warning, or execution failure
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5         some internal tool is not found, version is too old, or not an executable file
     6         problems found with or in the topdir directory
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=
export ALL_FILES=
export LIST_FAILURES=
export EXCLUDE_FILE="bin/exclude.cfg"


# parse command line
#
while getopts :hv:Vad:e:lnNp: flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) if [[ ! $OPTARG =~ ^[0-9]+$ ]]; then
	    echo "$0: ERROR: verbosity level must be a non-negative integer: $OPTARG" 1>&2
	    exit 3
	fi
	V_FLAG=$((10#$OPTARG))
	;;
    V) echo "$VERSION"
	exit 2
	;;
    a) ALL_FILES="true"
	;;
    d) TOPDIR="$OPTARG"
	;;
    e) EXCLUDE_FILE="$OPTARG"
	;;
    l) LIST_FAILURES="true"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    p) VNU_TOOL="$OPTARG"
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
# Keep Nu's HTML extension filter unless all files were explicitly requested.
# JSON diagnostics allow list mode to identify each failing document reliably.
#
if [[ -z $ALL_FILES ]]; then
    VNU_OPTION+=("--skip-non-html")
fi
VNU_OPTION+=("--format")
if [[ -n $LIST_FAILURES ]]; then
    VNU_OPTION+=("json")
else
    VNU_OPTION+=("gnu")
fi
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
    echo "$0: debug[5]: argument count: $#" 1>&2
fi
if [[ $# -lt 1 ]]; then
    echo "$0: ERROR: expected at least 1 arg, found: $#" 1>&2
    exit 3
fi


# Verify required tools after option parsing so -h and -V work without them.
#
if [[ -z $GIT_TOOL ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
if [[ -z $VERGE ]]; then
    echo "$0: FATAL: verge is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install verge:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi


# must have an executable vnu tool
#
if [[ -n $VNU_TOOL ]]; then
    VNU_TOOL=$(type -P -- "$VNU_TOOL")
fi
if [[ -z $VNU_TOOL || ! -f $VNU_TOOL || ! -x $VNU_TOOL ]]; then
    echo "$0: FATAL: vnu tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: for information on how to install vnu, visit" 1>&2
    echo "$0: notice: https://validator.github.io/validator/" 1>&2
    echo "$0: notice: macOS using HomeBrew may install vnu with:" 1>&2
    echo "$0: notice: brew install vnu" 1>&2
    exit 5
fi
# Resolve a relative -p before changing to topdir.
#
VNU_TOOL_DIR=$(cd -- "$(dirname -- "$VNU_TOOL")" && pwd -P) || {
    echo "$0: ERROR: cannot resolve vnu tool directory: $VNU_TOOL" 1>&2
    exit 5
}
VNU_TOOL="$VNU_TOOL_DIR/$(basename -- "$VNU_TOOL")"


# set the minimum vnu version
#
# We tested vnu version 26.11.26 on 2026-11-26, which worked well.
# Therefore 26.11.26 is the minimum version of vnu that is allowed.
#
# IMPORTANT: Sync changes to $VNU_MIN_VERSION with .github/workflows/test.yml
#	     See the vnu-jar@YY.MM.DD string in .github/workflows/test.yml
#
export VNU_MIN_VERSION="26.11.26"
if ! VNU_TOOL_VERSION=$("$VNU_TOOL" --version); then
    echo "$0: ERROR: unable to obtain vnu version from: $VNU_TOOL" 1>&2
    exit 5
fi
VNU_TOOL_VERSION=${VNU_TOOL_VERSION%%[[:space:]]*}
if [[ ! $VNU_TOOL_VERSION =~ ^[0-9]+(\.[0-9]+)+$ ]]; then
    echo "$0: ERROR: invalid vnu version from $VNU_TOOL: $VNU_TOOL_VERSION" 1>&2
    exit 5
fi
export VNU_TOOL_VERSION


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
TOPDIR=$(/bin/pwd -P) || {
    echo "$0: ERROR: cannot determine topdir after changing directory" 1>&2
    exit 6
}


# verify that we have a bin subdirectory
#
export BIN_SUBDIR="$TOPDIR/bin"
if [[ ! -d $BIN_SUBDIR ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_SUBDIR" 1>&2
    exit 6
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
    echo "$0: debug[3]: VNU_TOOL=$VNU_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    for index in "${!VNU_OPTION[@]}"; do
	echo "$0: debug[3]: VNU_OPTION[$index]=${VNU_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: ALL_FILES=$ALL_FILES" 1>&2
    echo "$0: debug[3]: LIST_FAILURES=$LIST_FAILURES" 1>&2
    echo "$0: debug[3]: EXCLUDE_FILE=$EXCLUDE_FILE" 1>&2
    echo "$0: debug[3]: VNU_TOOL_VERSION=$VNU_TOOL_VERSION" 1>&2
    echo "$0: debug[3]: VNU_MIN_VERSION=$VNU_MIN_VERSION" 1>&2
    echo "$0: debug[3]: BIN_SUBDIR=$BIN_SUBDIR" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# verify that the vnu version is >= the minimum version
#
if ! "$VERGE" "$VNU_TOOL_VERSION" "$VNU_MIN_VERSION"; then
    echo "$0: ERROR: vnu: $VNU_TOOL version: $VNU_TOOL_VERSION is below" \
	 "minimum allowed: $VNU_MIN_VERSION" 1>&2
    echo "$0: Warning: vnu version must be >= $VNU_MIN_VERSION" 1>&2
    echo "$0: Warning: install a more up to date vnu and/or use -p vnu_tool to refer an up to date vnu" 1>&2
    exit 5
fi


# Select local files, apply exclusions, and invoke vnu in bounded batches.
# The helper handles stdin separately because Nu does not read it alongside files.
#
HELPER_OPTION=(--root "$TOPDIR" --validator "$VNU_TOOL" --exclude "$EXCLUDE_FILE")
for option in "${VNU_OPTION[@]}"; do
    HELPER_OPTION+=("--vnu-option=$option")
done
[[ -n $ALL_FILES ]] && HELPER_OPTION+=(--all-files)
[[ -n $LIST_FAILURES ]] && HELPER_OPTION+=(--list)
[[ -n $NOOP ]] && HELPER_OPTION+=(--dry-run)
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: selecting files for vnu: $*" 1>&2
fi
python3 -B bin/check_html.py "${HELPER_OPTION[@]}" -- "$@"
status=$?
if [[ $status -ne 0 ]]; then
    if [[ -z $LIST_FAILURES ]]; then
	echo "$0: ERROR: HTML selection or validation failed: $status" 1>&2
    fi
    exit 1
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
