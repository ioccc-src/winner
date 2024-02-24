#!/usr/bin/env bash
#
# tar-all.sh - tar files for all IOCCC years
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
export VERSION="1.0.1 2024-02-23"
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
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
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
			[-p tool] [-u repo_url] [-w site_url] [-W]

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

	-W		Warn if a file in the manifest is missing: (def: error if a file is missing)

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
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
while getopts :hv:Vd:D:nNp:u:U:w:W flag; do
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
    W) CAP_W_FLAG_FOUND="true"
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
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: expected 0 args, found: $#" 1>&2
    exit 3
fi
#

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

# verify that we have an bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"

# determine the name of our tarball
#
export TARBALL="ioccc.tar.bz2"

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

# verify we have non-empty readable ioccc.css file
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

# verify we have a non-empty readable .top file
#
export TOP_FILE=".top"
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

# parameter debugging
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: GTAR_TOOL=$GTAR_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: CAP_W_FLAG_FOUND=$CAP_W_FLAG_FOUND" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: TARBALL=$TARBALL" 1>&2
    echo "$0: debug[3]: FILELIST_ENTRY_JSON_AWK=$FILELIST_ENTRY_JSON_AWK" 1>&2
    echo "$0: debug[3]: IOCCC_CSS=$IOCCC_CSS" 1>&2
    echo "$0: debug[3]: VAR_MK=$VAR_MK" 1>&2
    echo "$0: debug[3]: FILELIST=$FILELIST" 1>&2
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
TMP_TAR_LIST=".$NAME.$$.tar.list"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary file tar list: $TMP_TAR_LIST" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_TAR_LIST; exit' 0 1 2 3 15
    rm -f "$TMP_TAR_LIST"
    if [[ -e $TMP_TAR_LIST ]]; then
	echo "$0: ERROR: cannot remove temporary file tar list: $TMP_TAR_LIST" 1>&2
	exit 12
    fi
    :> "$TMP_TAR_LIST"
    if [[ ! -e $TMP_TAR_LIST ]]; then
	echo "$0: ERROR: cannot create temporary file tar list: $TMP_TAR_LIST" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file tar list is not used: $TMP_TAR_LIST" 1>&2
fi

# create a temporary exit code
#
# It is a pain to set the EXIT_CODE deep inside a loop, so we write the EXIT_CODE into a file
# and read the file (setting EXIT_CODE again) after the loop.  A hack, but good enough for our needs.
#
TMP_EXIT_CODE=".$NAME.$$.exit.code"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary exit code: $TMP_EXIT_CODE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_TAR_LIST $TMP_EXIT_CODE; exit' 0 1 2 3 15
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

# create a temporary tarball
#
TMP_TARBALL=".$NAME.$$.tar.bz2"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary tarball: $TMP_TARBALL" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MANIFEST_LIST $TMP_TAR_LIST $TMP_EXIT_CODE $TMP_TARBALL; exit' 0 1 2 3 15
    rm -f "$TMP_TARBALL"
    if [[ -e $TMP_TARBALL ]]; then
	echo "$0: ERROR: cannot remove temporary tarball: $TMP_TARBALL" 1>&2
	exit 16
    fi
    :> "$TMP_TARBALL"
    if [[ ! -e $TMP_TARBALL ]]; then
	echo "$0: ERROR: cannot create temporary tarball: $TMP_TARBALL" 1>&2
	exit 17
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary tarball is not used: $TMP_TARBALL" 1>&2
fi

# add the top level top level files into the IOCCC year's manifest
#
{
    echo "$IOCCC_CSS"
    echo "$VAR_MK"
} >> "$TMP_MANIFEST_LIST"

# generate sorted list of entry files from the full IOCCC manifest
#
if [[ -z $NOOP ]]; then

    # process each IOCCC year
    #
    export YYYY
    for YYYY in $(< "$TOP_FILE"); do

	# debug YYYY
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: starting to process year: $YYYY" 1>&2
	fi

	# verify we have non-empty readable year level .filelist file
	#
	export FILELIST="$YYYY/.filelist"
	if [[ ! -e $FILELIST ]]; then
	    echo "$0: ERROR: .filelist for $YYYY does not exist: $FILELIST" 1>&2
	    exit 6
	fi
	if [[ ! -f $FILELIST ]]; then
	    echo "$0: ERROR: .filelist for $YYYY is not a file: $FILELIST" 1>&2
	    exit 6
	fi
	if [[ ! -r $FILELIST ]]; then
	    echo "$0: ERROR: .filelist for $YYYY is not a readable file: $FILELIST" 1>&2
	    exit 6
	fi
	if [[ ! -s $FILELIST ]]; then
	    echo "$0: ERROR: .filelist for $YYYY is not a not a non-empty readable file: $FILELIST" 1>&2
	    exit 6
	fi

	# load the year level into the IOCCC year's manifest
	#
	grep -F -v  "$YYYY/$YYYY.tar.bz2" "$FILELIST" >> "$TMP_MANIFEST_LIST"

	# verify that YYYY is a readable directory
	#
	if [[ ! -e $YYYY ]]; then
	    echo  "$0: ERROR: YYYY does not exist: $YYYY" 1>&2
	    exit 6
	fi
	if [[ ! -d $YYYY ]]; then
	    echo  "$0: ERROR: YYYY is not a directory: $YYYY" 1>&2
	    exit 6
	fi
	if [[ ! -r $YYYY ]]; then
	    echo  "$0: ERROR: YYYY is not an readable directory: $YYYY" 1>&2
	    exit 6
	fi

	# verify that YYYY has a non-empty readable .year file
	#
	export YEAR_FILE="$YYYY/.year"
	if [[ ! -e $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year does not exist: $YEAR_FILE" 1>&2
	    exit 6
	fi
	if [[ ! -f $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not a regular file: $YEAR_FILE" 1>&2
	    exit 6
	fi
	if [[ ! -r $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not an readable file: $YEAR_FILE" 1>&2
	    exit 6
	fi
	if [[ ! -s $YEAR_FILE ]]; then
	    echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $YEAR_FILE" 1>&2
	    exit 6
	fi

	# process each entry directory under YYYY
	#
	export YYYY_DIR
	for YYYY_DIR in $(< "$YEAR_FILE"); do

	    # debug YYYY_DIR
	    #
	    if [[ $V_FLAG -ge 3 ]]; then
		echo "$0: debug[3]: starting to process year/dir: $YYYY_DIR" 1>&2
	    fi

	    # parse YYYY_DIR
	    #
	    if [[ ! -d $YYYY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
		EXIT_CODE=7  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -w $YYYY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR is not a writable directory: $YYYY_DIR" 1>&2
		EXIT_CODE=7  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    export YEAR_DIR=${YYYY_DIR%%/*}
	    if [[ -z $YEAR_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR not in YYYY/dir form: $YYYY_DIR" 1>&2
		EXIT_CODE=7  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    export ENTRY_DIR=${YYYY_DIR#*/}
	    if [[ -z $ENTRY_DIR ]]; then
		echo "$0: ERROR: YYYY_DIR not in $YEAR_DIR/dir form: $YYYY_DIR" 1>&2
		EXIT_CODE=7  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ $ENTRY_DIR = */* ]]; then
		echo "$0: ERROR: YYYY_DIR: $YYYY_DIR dir contains a /: $ENTRY_DIR" 1>&2
		EXIT_CODE=7  # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # verify that YYYY_DIR is a writable directory
	    #
	    if [[ ! -e $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR does not exist: $YYYY_DIR" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -d $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -w $YYYY_DIR ]]; then
		echo  "$0: ERROR: YYYY_DIR is not an writable directory: $YYYY_DIR" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # verify YYYY/dir/.path
	    #
	    export DOT_PATH="$YYYY_DIR/.path"
	    if [[ ! -s $DOT_PATH ]]; then
		echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    DOT_PATH_CONTENT=$(< "$DOT_PATH")
	    if [[ $YYYY_DIR != "$DOT_PATH_CONTENT" ]]; then
		echo "$0: ERROR: arg: $YYYY_DIR does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    export ENTRY_JSON="$YYYY_DIR/.entry.json"
	    if [[ ! -e $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -f $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi
	    if [[ ! -r $ENTRY_JSON ]]; then
		echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
		EXIT_CODE=7 # exit 7
		echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		continue
	    fi

	    # use the entry's manifest to add files to the IOCCC year's manifest, excluding the entry's tarball file
	    #
	    awk -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" >> "$TMP_MANIFEST_LIST"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: awk -f $FILELIST_ENTRY_JSON_AWK $ENTRY_JSON >> $TMP_MANIFEST_LIST failed, error: $status" 1>&2
		exit 1
	    fi

	    # remove entry's tarball from the IOCCC year's manifest
	    #
	    export ENTRY_ID="${YEAR_DIR}_${ENTRY_DIR}"
	    sed -i '' -e "/$ENTRY_ID\.tar\.bz2$/d" "$TMP_MANIFEST_LIST"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: sed -i '' -e '/$ENTRY_ID.tar.bz2/d' $TMP_MANIFEST_LIST failed, error: $status" 1>&2
		exit 1
	    fi
	done

	# sort the manifest list
	#
	sort -d -u "$TMP_MANIFEST_LIST" -o "$TMP_MANIFEST_LIST"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: sort -d -u $TMP_MANIFEST_LIST -o $TMP_MANIFEST_LIST failed, error: $status" 1>&2
	    exit 1
	fi

    done

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file manifest list was not formed: $TMP_MANIFEST_LIST" 1>&2
fi

# generate sorted list of found entry files
#
# We exclude the compressed tarball itself because we are writing it.
#
if [[ -z $NOOP ]]; then

    # debug YYYY
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: verifying that all files in the manifest exist" 1>&2
    fi

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
    done > "$TMP_TAR_LIST"
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: list of files to tar start below" 1>&2
	cat "$TMP_TAR_LIST" 1>&2
	echo "$0: debug[7]: list of files to tar ends above" 1>&2
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file tar list was not formed: $TMP_MANIFEST_LIST" 1>&2
fi
if [[ ! -s "$TMP_TAR_LIST" ]]; then
    echo "$0: ERROR: no files found to tar for: $ENTRY_JSON" 1>&2
    exit 1
fi
EXIT_CODE=$(< "$TMP_EXIT_CODE")
if [[ -z $EXIT_CODE ]]; then
    echo "$0: ERROR: temporary exit file is empty: $TMP_EXIT_CODE" 1>&2
    exit 18
fi

# form the tarball
#
# We use gnu tar to form the bzip2 compressed tarball with careful arguments
# so that the resulting tarball is the same, byte for byte.
#
if [[ -z $NOOP ]]; then

    # debug
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to form compressed tarball: $TMP_TARBALL" 1>&2
    fi

    # case: form the tarball verbosely if -v 3 or more
    #
    if [[ $V_FLAG -gt 3 ]]; then
	echo "$0: debug[3]: about to execute:" \
	    "$GTAR_TOOL --files-from=- --sparse --no-acls --sort=name" \
	    "--owner=501 --group=20 --numeric-owner --totals" \
	    "--pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime" \
	    "-jcvf $TMP_TARBALL < $TMP_TAR_LIST" 1>&2
	"$GTAR_TOOL" --files-from=- --sparse --no-acls --sort=name \
		     --owner=501 --group=20 --numeric-owner --totals \
		     --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
		     -jcvf "$TMP_TARBALL" < "$TMP_TAR_LIST"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR:" \
		"$GTAR_TOOL --files-from=- --sparse --no-acls --sort=name" \
		"--owner=501 --group=20 --numeric-owner --totals" \
		"--pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime" \
		"-jcvf $TMP_TARBALL < $TMP_TAR_LIST failed, error: $status" 1>&2
	    EXIT_CODE=8 # exit 8
	fi

    # case: form the tarball silently
    #
    else
	"$GTAR_TOOL" --files-from=- --sparse --no-acls --sort=name \
		     --owner=501 --group=20 --numeric-owner \
		     --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
		     -jcf "$TMP_TARBALL" < "$TMP_TAR_LIST"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR:" \
		"$GTAR_TOOL --files-from=- --sparse --no-acls --sort=name" \
		"--owner=501 --group=20 --numeric-owner" \
		"--pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime" \
		"-jcf $TMP_TARBALL < $TMP_TAR_LIST failed, error: $status" 1>&2
	    EXIT_CODE=8 # exit 8
	fi
    fi

    # verify the tarball is not empty
    #
    if [[ ! -s $TMP_TARBALL ]]; then
	echo "$0: ERROR: tarball is missing os empty: $TMP_TARBALL" 1>&2
	EXIT_CODE=8 # exit 8
    fi

# case: -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, did not execute:" \
		"$GTAR_TOOL --files-from=- --sparse --no-acls --sort=name" \
		"--owner=501 --group=20 --numeric-owner --totals" \
		"--pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime" \
		"-jcvf $TMP_TARBALL < $TMP_TAR_LIST" 1>&2
fi
EXIT_CODE=$(< "$TMP_EXIT_CODE")
if [[ -z $EXIT_CODE ]]; then
    echo "$0: ERROR: temporary exit file has no contents: $TMP_EXIT_CODE" 1>&2
    exit 19
fi

# move the tarball in place only if different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_TARBALL" "$TARBALL"; then

	# case: tarball did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: file did not change: $TARBALL" 1>&2
	fi

    else

	# case: tarball changed, update the file
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
	if [[ status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_TARBALL $TARBALL filed, error code: $status" 1>&2
	    EXIT_CODE=8 # exit 8
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: built replaced HTML file: $TARBALL" 1>&2
	fi
	if [[ ! -s $TARBALL ]]; then
	    echo "$0: ERROR: not a non-empty index HTML file: $TARBALL" 1>&2
	    EXIT_CODE=8 # exit 8
	fi
     fi

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file manifest list was not formed: $TMP_MANIFEST_LIST" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_MANIFEST_LIST" "$TMP_TAR_LIST" "$TMP_EXIT_CODE" "$TMP_TARBALL"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_MANIFEST_LIST $TMP_TAR_LIST $TMP_EXIT_CODE $TMP_TARBALL" 1>&2
fi
exit "$EXIT_CODE"
