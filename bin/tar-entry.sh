#!/usr/bin/env bash
#
# tar-entry.sh - tar files belonging to an entry
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
export VERSION="1.3.10 2024-08-05"
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
export REPO_TOP_URL="https://github.com/ioccc-src/temp-test-ioccc"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export CAP_W_FLAG_FOUND=
GTAR_TOOL=$(type -P gtar)
export GTAR_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: gtar (gnu tar) tool is not installed or not in \$PATH" 1>&2
    exit 8
fi


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-w site_url] [-W]
			YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	This option is ignored

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-w site_url	This option is ignored

	-W		Warn if a file in the manifest is missing: (def: error if a file is missing)

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
     8	       gnu tar is missing or execution failed or error in forming compressed tarball
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"


# parse command line
#
while getopts :hv:Vd:D:nNU:w:W flag; do
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
    D)  ;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    U)  ;;
    w)  ;;
    W) CAP_W_FLAG_FOUND="true"
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


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


# verify we have our awk tool
#
export FILELIST_ENTRY_JSON_AWK="$BIN_DIR/filelist.entry.json.awk"
if [[ ! -e $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  does not exist: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 5
fi
if [[ ! -f $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a file: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 5
fi
if [[ ! -r $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a readable file: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 5
fi
if [[ ! -s $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a not a non-empty readable file: $FILELIST_ENTRY_JSON_AWK" 1>&2
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
    exit 5
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
export DOT_PATH_CONTENT
if [[ $ENTRY_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $ENTRY_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 5
fi
export ENTRY_JSON="$YYYY_DIR/.entry.json"
if [[ ! -e $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
    exit 5
fi
if [[ ! -f $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
    exit 5
fi
if [[ ! -r $ENTRY_JSON ]]; then
    echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
    exit 5
fi


# verify we have non-empty readable ioccc.css file
#
export IOCCC_CSS="ioccc.css"
if [[ ! -e $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css does not exist: $IOCCC_CSS" 1>&2
    exit 6
fi
if [[ ! -f $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a file: $IOCCC_CSS" 1>&2
    exit 6
fi
if [[ ! -r $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a readable file: $IOCCC_CSS" 1>&2
    exit 6
fi
if [[ ! -s $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a not a non-empty readable file: $IOCCC_CSS" 1>&2
    exit 6
fi


# verify we have non-empty readable var.mk file
#
export VAR_MK="var.mk"
if [[ ! -e $VAR_MK ]]; then
    echo "$0: ERROR: var.mk does not exist: $VAR_MK" 1>&2
    exit 6
fi
if [[ ! -f $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a file: $VAR_MK" 1>&2
    exit 6
fi
if [[ ! -r $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a readable file: $VAR_MK" 1>&2
    exit 6
fi
if [[ ! -s $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a not a non-empty readable file: $VAR_MK" 1>&2
    exit 6
fi


# verify we have non-empty readable 1337.mk
#
export LEET_MK="1337.mk"
if [[ ! -e $LEET_MK ]]; then
    echo "$0: ERROR: 1337.mk does not exist: $LEET_MK" 1>&2
    exit 6
fi
if [[ ! -f $LEET_MK ]]; then
    echo "$0: ERROR: 1337.mk is not a file: $LEET_MK" 1>&2
    exit 6
fi
if [[ ! -r $LEET_MK ]]; then
    echo "$0: ERROR: 1337.mk is not a readable file: $LEET_MK" 1>&2
    exit 6
fi
if [[ ! -s $LEET_MK ]]; then
    echo "$0: ERROR: 1337.mk is not a not a non-empty readable file: $LEET_MK" 1>&2
    exit 6
fi


# determine the name of our tarball
#
# TARBALL - the same of the compressed tarball to verify and if needed re-build
# REBUILD_TARBALL - if non-empty, we need to re-build TARBALL and update tar timestamps
#
export TARBALL="$YYYY_DIR/$ENTRY_ID.tar.bz2"
export REBUILD_TARBALL=


# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: CAP_W_FLAG_FOUND=$CAP_W_FLAG_FOUND" 1>&2
    echo "$0: debug[3]: GTAR_TOOL=$GTAR_TOOL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: FILELIST_ENTRY_JSON_AWK=$FILELIST_ENTRY_JSON_AWK" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: DOT_PATH_CONTENT=$DOT_PATH_CONTENT" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
    echo "$0: debug[3]: IOCCC_CSS=$IOCCC_CSS" 1>&2
    echo "$0: debug[3]: VAR_MK=$VAR_MK" 1>&2
    echo "$0: debug[3]: LEET_MK=$LEET_MK" 1>&2
    echo "$0: debug[3]: TARBALL=$TARBALL" 1>&2
    echo "$0: debug[3]: REBUILD_TARBALL=$REBUILD_TARBALL" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# test - if needed - if the tarball is a non-empty writable file
#
if [[ -z $REBUILD_TARBALL && ! -e $TARBALL ]]; then
    REBUILD_TARBALL="true"
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	     "tarball does not exist: $TARBALL" 1>&2
    fi
fi
if [[ -z $REBUILD_TARBALL && ! -f $TARBALL ]]; then
    REBUILD_TARBALL="true"
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	     "tarball is not a file: $TARBALL" 1>&2
    fi
fi
if [[ -z $REBUILD_TARBALL && ! -w $TARBALL ]]; then
    REBUILD_TARBALL="true"
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	     "tarball is not a writable file: $TARBALL" 1>&2
    fi
fi
if [[ -z $REBUILD_TARBALL && ! -s $TARBALL ]]; then
    REBUILD_TARBALL="true"
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	     "tarball is not a non-empty writable file: $TARBALL" 1>&2
    fi
fi


# create a temporary file manifest list
#
export TMP_MANIFEST_LIST=".tmp.$NAME.MANIFEST_LIST.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary file manifest list: $TMP_MANIFEST_LIST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST; exit' 0 1 2 3 15
    rm -f "$TMP_MANIFEST_LIST"
    if [[ -e $TMP_MANIFEST_LIST ]]; then
	echo "$0: ERROR: cannot remove temporary file manifest list: $TMP_MANIFEST_LIST" 1>&2
	exit 10
    fi
    :> "$TMP_MANIFEST_LIST"
    if [[ ! -e $TMP_MANIFEST_LIST ]]; then
	echo "$0: ERROR: cannot create temporary file manifest list: $TMP_MANIFEST_LIST" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file manifest list is not used: $TMP_MANIFEST_LIST" 1>&2
fi


# create a temporary sort list of files to tar
#
export TMP_FILES_TO_TAR=".tmp.$NAME.FILES_TO_TAR.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary list of files to tar: $TMP_FILES_TO_TAR" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_FILES_TO_TAR; exit' 0 1 2 3 15
    rm -f "$TMP_FILES_TO_TAR"
    if [[ -e $TMP_FILES_TO_TAR ]]; then
	echo "$0: ERROR: cannot remove temporary list of files to tar: $TMP_FILES_TO_TAR" 1>&2
	exit 12
    fi
    :> "$TMP_FILES_TO_TAR"
    if [[ ! -e $TMP_FILES_TO_TAR ]]; then
	echo "$0: ERROR: cannot create temporary list of files to tar: $TMP_FILES_TO_TAR" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary list of files to tar is not used: $TMP_FILES_TO_TAR" 1>&2
fi


# create a temporary exit code
#
# It is a pain to set the EXIT_CODE deep inside a loop, so we write the EXIT_CODE into a file
# and read the file (setting EXIT_CODE again) after the loop.  A hack, but good enough for our needs.
#
export TMP_EXIT_CODE=".tmp.$NAME.EXIT_CODE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary exit code: $TMP_EXIT_CODE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_FILES_TO_TAR $TMP_EXIT_CODE; exit' 0 1 2 3 15
    rm -f "$TMP_EXIT_CODE"
    if [[ -e $TMP_EXIT_CODE ]]; then
	echo "$0: ERROR: cannot remove temporary exit code: $TMP_EXIT_CODE" 1>&2
	exit 14
    fi
    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
    if [[ ! -e $TMP_EXIT_CODE ]]; then
	echo "$0: ERROR: cannot create temporary exit code: $TMP_EXIT_CODE" 1>&2
	exit 15
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary exit code is not used: $TMP_EXIT_CODE" 1>&2
fi


# generate sorted list of entry files from the entry's manifest
#
# We also add ioccc.css and var.mk from the top level.
#
if [[ -z $NOOP ]]; then
    awk -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" > "$TMP_MANIFEST_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: awk -f $FILELIST_ENTRY_JSON_AWK $ENTRY_JSON > $TMP_MANIFEST_LIST failed, error: $status" 1>&2
	exit 1
    fi
    {
	echo "$IOCCC_CSS"
	echo "$VAR_MK"
	echo "$LEET_MK"
    } >> "$TMP_MANIFEST_LIST"
    LC_ALL=C sort -d "$TMP_MANIFEST_LIST" -o "$TMP_MANIFEST_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: LC_ALL=C sort -d $TMP_MANIFEST_LIST -o $TMP_MANIFEST_LIST failed, error: $status" 1>&2
	exit 1
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file manifest list was not formed: $TMP_MANIFEST_LIST" 1>&2
fi


# generate sorted list of found entry files
#
# We exclude the compressed tarball itself because we are writing it.
#
if [[ -z $NOOP ]]; then

    # exclude the compressed tarball from the tarlist
    #
    grep -F -v "$TARBALL" < "$TMP_MANIFEST_LIST" | while read -r file; do

	# if file does not exist, warn
	#
	if [[ ! -e $file ]]; then
	    echo "$0: Warning: missing $YYYY_DIR file: $file" 1>&2
	    # unless -W, missing files cause this tool to exit 1
	    if [[ -z $CAP_W_FLAG_FOUND ]]; then
		echo 1 > "$TMP_EXIT_CODE" # exit 1
	    fi
	else
	    echo "$file"
	fi
    done > "$TMP_FILES_TO_TAR"
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: list of files to tar starts below" 1>&2
	cat "$TMP_FILES_TO_TAR" 1>&2
	echo "$0: debug[7]: list of files to tar ends above" 1>&2
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary list of files to tar was not formed: $TMP_MANIFEST_LIST" 1>&2
fi
if [[ ! -s "$TMP_FILES_TO_TAR" ]]; then
    echo "$0: ERROR: no files found to tar for: $ENTRY_JSON" 1>&2
    exit 1
fi
EXIT_CODE=$(< "$TMP_EXIT_CODE")
if [[ -z $EXIT_CODE ]]; then
    echo "$0: ERROR: temporary exit file is empty: $TMP_EXIT_CODE" 1>&2
    exit 16
fi


# create a temporary list of files found in the tarball
#
export TMP_TARBALL_LIST=".tmp.$NAME.TARBALL_LIST.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary of files in the tarball: $TARBALL: $TMP_TARBALL_LIST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_FILES_TO_TAR $TMP_EXIT_CODE $TMP_TARBALL_LIST; exit' 0 1 2 3 15
    rm -f "$TMP_TARBALL_LIST"
    if [[ -e $TMP_TARBALL_LIST ]]; then
	echo "$0: ERROR: cannot remove temporary of files in the tarball: $TARBALL: $TMP_TARBALL_LIST" 1>&2
	exit 17
    fi
    :> "$TMP_TARBALL_LIST"
    if [[ ! -e $TMP_TARBALL_LIST ]]; then
	echo "$0: ERROR: cannot create temporary of files in the tarball: $TARBALL: $TMP_TARBALL_LIST" 1>&2
	exit 18
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary of files in the tarball: $TARBALL is not used: $TMP_TARBALL_LIST" 1>&2
fi


# create a temporary tarball
#
export TMP_TARBALL=".tmp.$NAME.TARBALL.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary tarball: $TMP_TARBALL" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_FILES_TO_TAR $TMP_EXIT_CODE $TMP_TARBALL_LIST $TMP_TARBALL; exit' 0 1 2 3 15
    rm -f "$TMP_TARBALL"
    if [[ -e $TMP_TARBALL ]]; then
	echo "$0: ERROR: cannot remove temporary tarball: $TMP_TARBALL" 1>&2
	exit 19
    fi
    :> "$TMP_TARBALL"
    if [[ ! -e $TMP_TARBALL ]]; then
	echo "$0: ERROR: cannot create temporary tarball: $TMP_TARBALL" 1>&2
	exit 20
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary tarball is not used: $TMP_TARBALL" 1>&2
fi


# test - if needed - if the sorted list of files from the tarball matches the sorted list of found entry files
#
if [[ -z $REBUILD_TARBALL ]]; then

    # form he sorted list of files in the tarball
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: $GTAR_TOOL -jtf $TARBALL > $TMP_TARBALL_LIST" 1>&2
    fi
    "$GTAR_TOOL" -jtf "$TARBALL" > "$TMP_TARBALL_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	REBUILD_TARBALL="true"
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	         "failed to list files in tarball: $TARBALL, error: $status" 1>&2
	fi
    fi
    if [[ -z $REBUILD_TARBALL ]]; then
	LC_ALL=C sort -d "$TMP_TARBALL_LIST" -o "$TMP_TARBALL_LIST"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    REBUILD_TARBALL="true"
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
		     "failed to sort list of files in tarball: $TARBALL, error: $status" 1>&2
	    fi
	else
	    if ! cmp -s "$TMP_TARBALL_LIST" "$TMP_FILES_TO_TAR"; then
		REBUILD_TARBALL="true"
		if [[ $V_FLAG -ge 1 ]]; then
		    echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
			 "sorted list of files in tarball: $TMP_TARBALL_LIST" \
			 "does not match sorted list of found entry files: $TMP_FILES_TO_TAR" 1>&2
		fi
	    fi
	fi
    fi
fi


# test - if needed - if the files in the tarball match the contents of the entry's files
#
if [[ -z $REBUILD_TARBALL ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: TZ=UTC LC_ALL=C $GTAR_TOOL --compare --file=$TARBALL -C . 2>&1 |" \
	     "grep -E -v ': (Uid|Gid|Mod time) differs$'" 1>&2
    fi
    TAR_CONTENTS_DIFFERS=$(TZ=UTC LC_ALL=C "$GTAR_TOOL" --compare --file="$TARBALL" -C . 2>&1 | \
			   grep -E -v ': (Uid|Gid|Mod time) differs$')
    export TAR_CONTENTS_DIFFERS
    if [[ -n $TAR_CONTENTS_DIFFERS ]]; then
	REBUILD_TARBALL="true"
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: REBUILD_TARBALL set to: $REBUILD_TARBALL," \
	         "contents of tarball: $TARBALL differs from contents of entry: $YYYY_DIR" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: tar differences starts below" 1>&2
	    echo "$TAR_CONTENTS_DIFFERS" 1>&2
	    echo "$0: debug[3]: tar differences ends above" 1>&2
	fi
    fi
fi


# test - if needed - update the tarball
#
# We use gnu tar to form the bzip2 compressed tarball with careful arguments
# so that the resulting tarball is consistent.  There are systems for which the
# tarball won't be the same.  However we do not need that.  All of the tests
# above are such that if $REBUILD_TARBALL is not empty, then the tarball needs
# to updated regardless.
#
if [[ -n $REBUILD_TARBALL ]]; then

    if [[ -z $NOOP ]]; then

	# determine the timestamp of now
	#
	TAR_TIMESTAMP=$(TZ=UTZ date '+%s')
	status="$?"
	export TAR_TIMESTAMP
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: new TZ=UTC date +%s failed, error: $status" 1>&2
	    exit 8
	fi
	if [[ $TAR_TIMESTAMP =~ ^-?[0-9]+$ ]]; then
	    if [[ $TAR_TIMESTAMP -le 0 ]]; then
		echo "$0: ERROR: new TAR_TIMESTAMP is not an integer > 0: $TAR_TIMESTAMP" 1>&2
		exit 8
	    fi
	else
	    echo "$0: ERROR: new TAR_TIMESTAMP is not an integer: $TAR_TIMESTAMP" 1>&2
	    exit 8
	fi

	# case: form the tarball verbosely if -v 5 or more
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to execute:" \
		"TZ=UTC LC_ALL=C $GTAR_TOOL --files-from=- --no-acls --no-xattrs --no-selinux --sort=name" \
		"--owner=501 --group=20 --numeric-owner --mtime=@${TAR_TIMESTAMP}" \
		"--pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime'" \
		"--totals -jcvf $TMP_TARBALL < $TMP_FILES_TO_TAR" 1>&2
	    TZ=UTC LC_ALL=C "$GTAR_TOOL" --files-from=- --no-acls --no-xattrs --no-selinux --sort=name \
			 --owner=501 --group=20 --numeric-owner --mtime="@${TAR_TIMESTAMP}" \
			 --pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime' \
			 --totals -jcvf "$TMP_TARBALL" < "$TMP_FILES_TO_TAR"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR:" \
		    "TZ=UTC LC_ALL=C $GTAR_TOOL --files-from=- --no-acls --no-xattrs --no-selinux --sort=name" \
		    "--owner=501 --group=20 --numeric-owner --mtime=@${TAR_TIMESTAMP}" \
		    "--pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime'" \
		    "--totals -jcvf $TMP_TARBALL < $TMP_FILES_TO_TAR failed, error: $status" 1>&2
		exit 8
	    fi

	# case: form the tarball silently
	#
	else
	    TZ=UTC LC_ALL=C "$GTAR_TOOL" --files-from=- --no-acls --no-xattrs --no-selinux --sort=name \
			 --owner=501 --group=20 --numeric-owner \
			 --pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime' \
			 --totals -jcf "$TMP_TARBALL" < "$TMP_FILES_TO_TAR"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR:" \
		    "TZ=UTC LC_ALL=C $GTAR_TOOL --files-from=- --no-acls --no-xattrs --no-selinux --sort=name" \
		    "--owner=501 --group=20 --numeric-owner --mtime=@${TAR_TIMESTAMP}" \
		    "--pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime'" \
		    "--totals -jcf $TMP_TARBALL < $TMP_FILES_TO_TAR failed, error: $status" 1>&2
		exit 8
	    fi
	fi

	# verify the tarball is not empty
	#
	if [[ ! -s $TMP_TARBALL ]]; then
	    echo "$0: ERROR: tarball is missing is empty: $TMP_TARBALL" 1>&2
	    exit 8
	fi

	# move temporary tarball into the permanent tarball
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: mv -f -- $TMP_TARBALL $TARBALL" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    mv -f -v -- "$TMP_TARBALL" "$TARBALL"
	    status="$?"
	else
	    mv -f -- "$TMP_TARBALL" "$TARBALL"
	    status="$?"
	fi
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_TARBALL $TARBALL filed, error code: $status" 1>&2
	    exit 8
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: built replaced HTML file: $TARBALL" 1>&2
	fi
	if [[ ! -s $TARBALL ]]; then
	    echo "$0: ERROR: not a non-empty index HTML file: $TARBALL" 1>&2
	    exit 8
	fi

    # case: -n
    #
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: because of -n, did not execute:" \
	     "TZ=UTC LC_ALL=C $GTAR_TOOL --files-from=- --no-acls --no-xattrs --no-selinux --sort=name" \
	     "--owner=501 --group=20 --numeric-owner" \
	     "--pax-option='exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime'" \
	     "--mtime=@${TAR_TIMESTAMP} --totals -jcvf $TMP_TARBALL < $TMP_FILES_TO_TAR" 1>&2
	echo "$0: debug[5]: because of -n, did not move temporary tarball: $TMP_TARBALL" \
	     "into the permanent tarball: $TARBALL" 1>&2
    fi

# case: tarball update not needed
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[1]: no need to update $TARBALL" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
     rm -f "$TMP_MANIFEST_LIST" "$TMP_FILES_TO_TAR" "$TMP_EXIT_CODE" "$TMP_TARBALL_LIST" "$TMP_TARBALL"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_MANIFEST_LIST $TMP_FILES_TO_TAR" \
	  "$TMP_EXIT_CODE $TMP_TARBALL_LIST $TMP_TARBALL" 1>&2
fi
exit "$EXIT_CODE"
