#!/usr/bin/env bash
#
# chk-entry.sh - check if the files in an entry match the entry's manifest
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
# We must declare arrays with -ag or -Ag, and we need loops to "export" modified variables.
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
export VERSION="1.0 2024-02-12"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 210
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR
export DOCROOT_SLASH="../../"
export PANDOC_WRAPPER="bin/pandoc-wrapper.sh"
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
export URL="#"

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-p tool] [-u repo_url] [-w site_url]
			YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	This option is ignored

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-p tool		This option is ignored

	-u repo_url	This option is ignored
	-w site_url	This option is ignored

	YYYY/dir	path from topdir to entry directory: must contain the files: README.md, .path and .entry.json

Exit codes:
     0         all OK
     1	       entry files to not match manifest in .entry.json
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       YYYY/dir is not a entry directory
     6	       bin/filelist.entry.json.awk is not a non-empty readable file
     7	       error in trying to determine files used by the entry
     8	       missing critical top level file
 >= 10  < 210  ((not used))
 >= 210	       internal tool error

$NAME version: $VERSION"

# setup
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"

# parse command line
#
while getopts :hv:Vd:D:nNp:u:U:w: flag; do
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
    p)  ;;
    u)  ;;
    U)  ;;
    w)  ;;
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
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 220
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 221
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 222
fi

# verify that we have an bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 223
fi
export BIN_DIR="bin"

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 224
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 225
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 226
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi

# verify that ENTRY_PATH is a entry directory
#
# ENTRY_PATH must be in YYYY/dir form
# YYYY must be a directory
# YYYY must be a writable directory
# YYYY/.year must be a non-empty file
# YYYY/dir must be a directory
# YYYY/dir/.path must be a non-empty file
# ENTRY_PATH must match the contents of YYYY/dir/.path
# YYYY/dir/.entry.json must be a non-empty file
#
if [[ ! -d $ENTRY_PATH ]]; then
    echo "$0: ERROR: arg is not a directory: $ENTRY_PATH" 1>&2
    exit 5
fi
if [[ ! -w $ENTRY_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $ENTRY_PATH" 1>&2
    exit 5
fi
export YEAR_DIR=${ENTRY_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in YYYY/dir form: $ENTRY_PATH" 1>&2
    exit 5
fi
export ENTRY_DIR=${ENTRY_PATH#*/}
if [[ -z $ENTRY_DIR ]]; then
    echo "$0: ERROR: arg: $ENTRY_PATH not in $YEAR_DIR/dir form: $ENTRY_PATH" 1>&2
    exit 5
fi
if [[ $ENTRY_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $ENTRY_PATH contains a /: $ENTRY_DIR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: YYYY from arg: $ENTRY_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 5
fi
export ENTRY_ID="${YEAR_DIR}_${ENTRY_DIR}"
export DOT_YEAR="$YEAR_DIR/.year"
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 5
fi
# Now that we have moved to topdir, form and verify YYYY_DIR is a writable directory
export YYYY_DIR="$YEAR_DIR/$ENTRY_DIR"
if [[ ! -e $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH does not exist: $YYYY_DIR" 1>&2
    exit 5
fi
if [[ ! -d $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a directory: $YYYY_DIR" 1>&2
    exit 5
fi
if [[ ! -w $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a writable directory: $YYYY_DIR" 1>&2
    exit 5
fi
export DOT_PATH="$YYYY_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 5
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
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

# verify we have our awk tool
#
FILELIST_ENTRY_JSON_AWK="$BIN_DIR/filelist.entry.json.awk"
if [[ ! -e $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  does not exist: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 6
fi
if [[ ! -f $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a file: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 6
fi
if [[ ! -r $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a readable file: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 6
fi
if [[ ! -s $FILELIST_ENTRY_JSON_AWK ]]; then
    echo "$0: ERROR: filelist.entry.json.awk  is not a not a non-empty readable file: $FILELIST_ENTRY_JSON_AWK" 1>&2
    exit 6
fi

# verify we have non-empty readable ioccc.css file
#
IOCCC_CSS="ioccc.css"
if [[ ! -e $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css does not exist: $IOCCC_CSS" 1>&2
    exit 8
fi
if [[ ! -f $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a file: $IOCCC_CSS" 1>&2
    exit 8
fi
if [[ ! -r $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a readable file: $IOCCC_CSS" 1>&2
    exit 8
fi
if [[ ! -s $IOCCC_CSS ]]; then
    echo "$0: ERROR: ioccc.css is not a not a non-empty readable file: $IOCCC_CSS" 1>&2
    exit 8
fi

# verify we have non-empty readable ioccc.css file
#
VAR_MK="var.mk"
if [[ ! -e $VAR_MK ]]; then
    echo "$0: ERROR: var.mk does not exist: $VAR_MK" 1>&2
    exit 8
fi
if [[ ! -f $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a file: $VAR_MK" 1>&2
    exit 8
fi
if [[ ! -r $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a readable file: $VAR_MK" 1>&2
    exit 8
fi
if [[ ! -s $VAR_MK ]]; then
    echo "$0: ERROR: var.mk is not a not a non-empty readable file: $VAR_MK" 1>&2
    exit 8
fi

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: PANDOC_WRAPPER=$PANDOC_WRAPPER" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: URL=$URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
    echo "$0: debug[3]: FILELIST_ENTRY_JSON_AWK=$FILELIST_ENTRY_JSON_AWK" 1>&2
    echo "$0: debug[3]: IOCCC_CSS=$IOCCC_CSS" 1>&2
    echo "$0: debug[3]: VAR_MK=$VAR_MK" 1>&2
fi

# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi

# create a temporary file manifest list
#
TMP_MANIFEST_LIST=".$NAME.$$.manifest.list"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_MANIFEST_LIST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST; exit' 0 1 2 3 15
    rm -f "$TMP_MANIFEST_LIST"
    if [[ -e $TMP_MANIFEST_LIST ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_MANIFEST_LIST" 1>&2
	exit 227
    fi
    :> "$TMP_MANIFEST_LIST"
    if [[ ! -e $TMP_MANIFEST_LIST ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_MANIFEST_LIST" 1>&2
	exit 228
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_MANIFEST_LIST" 1>&2
fi

# create a temporary find files list
#
TMP_FILE_LIST=".$NAME.$$.find.list"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_FILE_LIST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_FILE_LIST; exit' 0 1 2 3 15
    rm -f "$TMP_FILE_LIST"
    if [[ -e $TMP_FILE_LIST ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_FILE_LIST" 1>&2
	exit 227
    fi
    :> "$TMP_FILE_LIST"
    if [[ ! -e $TMP_FILE_LIST ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_FILE_LIST" 1>&2
	exit 228
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_FILE_LIST" 1>&2
fi

# generate sorted list of entry files from the entry's manifest
#
awk -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" > "$TMP_MANIFEST_LIST"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: awk -f $FILELIST_ENTRY_JSON_AWK $ENTRY_JSON > $TMP_MANIFEST_LIST failed, error: $status" 1>&2
    exit 7
fi
echo "$IOCCC_CSS" >> "$TMP_MANIFEST_LIST"
echo "$VAR_MK" >> "$TMP_MANIFEST_LIST"
sort -d -u "$TMP_MANIFEST_LIST" -o "$TMP_MANIFEST_LIST"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: sort -d -u $TMP_MANIFEST_LIST -o $TMP_MANIFEST_LIST failed, error: $status" 1>&2
    exit 7
fi

# generate sorted list of found entry files
#
find "$IOCCC_CSS" "$VAR_MK" "$ENTRY_PATH" -type f -print > "$TMP_FILE_LIST"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: find $IOCCC_CSS $VAR_MK $ENTRY_PATH -type f -print > $TMP_FILE_LIST failed, error: $status" 1>&2
    exit 7
fi
sort -d -u "$TMP_FILE_LIST" -o "$TMP_FILE_LIST"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: sort -d -u $TMP_FILE_LIST -o $TMP_FILE_LIST failed, error: $status" 1>&2
    exit 7
fi

# note if the manifest does NOT match the file list
#
if cmp -s "$TMP_MANIFEST_LIST" "$TMP_FILE_LIST"; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: file list marches manifest for: $ENTRY_PATH" 1>&2
    fi
else
    echo "$0: Warning: file list does NOT match manifest for: $ENTRY_PATH" 1>&2
    echo "$0: Warning: manifest files that are missing starts below: $ENTRY_PATH" 1>&2
    comm -23 "$TMP_MANIFEST_LIST" "$TMP_FILE_LIST"
    echo "$0: Warning: manifest files that are missing ends above: $ENTRY_PATH" 1>&2
    echo "$0: Warning: found files not in manifest starts below: $ENTRY_PATH" 1>&2
    comm -13 "$TMP_MANIFEST_LIST" "$TMP_FILE_LIST"
    echo "$0: Warning: found files not in manifest ends above: $ENTRY_PATH" 1>&2
    EXIT_CODE=1 # exit 1
fi

# All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_MANIFEST_LIST" "$TMP_FILE_LIST"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_MANIFEST_LIST" 1>&2
fi
exit "$EXIT_CODE"
