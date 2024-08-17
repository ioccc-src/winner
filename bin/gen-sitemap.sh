#!/usr/bin/env bash
#
# gen-sitemap.sh - generate an xml sitemap
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
export VERSION="1.3.14 2024-08-19"
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
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
export CAP_W_FLAG_FOUND=
export MODTIME_METHOD=""
#
STAT_TOOL=$(type -P stat)
if [[ -z "$STAT_TOOL" ]]; then
    STAT_TOOL="false"	# we have no stat tool
fi
#
LS_TOOL=$(type -P ls)
if [[ -z "$LS_TOOL" ]]; then
    echo "$0: FATAL: ls tool is not installed or not in \$PATH" 1>&2
    exit 5
fi


# output_modtime - file modification time in W3C Datetime format:
#
#       https://www.w3.org/TR/NOTE-datetime
#
# for use in XML format for sitemaps:
#
#       https://www.sitemaps.org/protocol.html
#
# usage:
#       output_modtime filename
#
function output_modtime
{
    local FILENAME;	# filename argument

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_modtime: expected 1 arg, found $#" 1>&2
        return 1
    fi
    FILENAME="$1"

    # produce output given the MODTIME_METHOD
    #
    case "$MODTIME_METHOD" in

    # macOS stat
    #
    macos_stat)
	TZ=UTC "$STAT_TOOL" -f '%Sm' -t '%FT%T+00:00' "$FILENAME"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: in output_modtime:" \
		 "TZ=UTC $STAT_TOOL -f '%Sm' -t '%FT%T+00:00' $FILENAME failed, error code: $status" 1>&2
	    exit 1
	fi
	;;

    # RHEL Linux stat
    #
    RHEL_stat)
	TZ=UTC "$STAT_TOOL" -c '%y' "$FILENAME" | sed -e 's/ /T/' -e 's/\.[0-9]* //' -e 's/\([0-9][0-9]\)$/:&/'
	status_codes=("${PIPESTATUS[@]}")
	if [[ ${status_codes[*]} =~ [1-9] ]]; then
	    echo "$0: ERROR: in output_modtime:" \
		 "TZ=UTC $STAT_TOOL -c '%y' $FILENAME | sed .. failed," \
		 "error codes: ${status_codes[*]}" 1>&2
	    exit 1
	fi
	;;

    ls_D)
	# We want to look at the format of ls -D, not find
	#
	# SC2012 (info): Use find instead of ls to better handle non-alphanumeric filenames.
	# https://www.shellcheck.net/wiki/SC2012
	# shellcheck disable=SC2012
	status_codes=("${PIPESTATUS[@]}")
	if [[ ${status_codes[*]} =~ [1-9] ]]; then
	TZ=UTZ "$LS_TOOL" -D '%FT%T+00:00' -ld "$FILENAME" | awk '{print $6;}'
	    echo "$0: ERROR: in output_modtime:" \
		 "TZ=UTZ $LS_TOOL -D '%FT%T+00:00' -ld $FILENAME | awk .. failed," \
		 "error codes: ${status_codes[*]}" 1>&2
	    exit 1
	fi
	;;

    *) echo "0: in output_modtime: unknown MODTIME_METHOD value: $MODTIME_METHOD" 1>&2
	exit 9
	;;
    esac
    return 0
}

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-w site_url] [-W]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-w site_url	Base URL of the website (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on tool command lines.

	-W		Warn if a file in the manifest is missing: (def: error if a file is missing)

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
     8	       some file is missing and -W was not given
     9	       unable to determine a method to find the modification time of a file in W3C Datefile format
 >= 10         internal error

$NAME version: $VERSION"

# setup
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"

# parse command line
#
while getopts :hv:Vd:nNw:W flag; do
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
    w) SITE_URL="$OPTARG"
	;;
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

# verify that we have an archive/historic subdirectory
#
export ARCHIVE_HISTORIC_PATH="$TOPDIR/archive/historic"
if [[ ! -d $ARCHIVE_HISTORIC_PATH ]]; then
    echo "$0: ERROR: archive/historic is not a directory under topdir: $ARCHIVE_HISTORIC_PATH" 1>&2
    exit 6
fi
export ARCHIVE_HISTORIC_DIR="archive/historic"

# verify that we have an author subdirectory
#
export AUTHOR_PATH="$TOPDIR/author"
if [[ ! -d $AUTHOR_PATH ]]; then
    echo "$0: ERROR: author is not a directory under topdir: $AUTHOR_PATH" 1>&2
    exit 6
fi
export AUTHOR_DIR="author"

# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"

# verify that we have an inc subdirectory
#
export INC_PATH="$TOPDIR/inc"
if [[ ! -d $INC_PATH ]]; then
    echo "$0: ERROR: inc is not a directory under topdir: $INC_PATH" 1>&2
    exit 6
fi
export INC_DIR="inc"

# determine the name of sitemap
#
export SITEMAP="sitemap.xml"

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

# determine how we can determine the file modification time in W3C Datetime format:
#
#	https://www.w3.org/TR/NOTE-datetime
#
# for use in XML format for sitemaps:
#
#	https://www.sitemaps.org/protocol.html
#
# Unfortunately there is NO single widely available, but simple command produce a modification
# time in W3C Datetime format.  At best we can try one of several methods in the hopes that
# we can find a method for the system in question.
#
# We will attempt to find the modification time in W3C Datetime of the .top file.
#
# Try macOS stat:
#
TZ=UTC "$STAT_TOOL" -f '%Sm' -t '%FT%T+00:00' "$TOP_FILE" > /dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    MODTIME_METHOD="macos_stat"
    if [[ $V_FLAG -ge 5 ]]; then
        echo "$0: debug[5]: TZ=UTC $STAT_TOOL -f '%Sm' -t '%FT%T+00:00' works, MODTIME_METHOD: $MODTIME_METHOD" 1>&2
    fi

else

    # Try RHEL Linux stat:
    #
    # NOTE: We only need to test the stat command.
    #
    TZ=UTC "$STAT_TOOL" -c '%y' "$TOP_FILE" > /dev/null 2>&1
    status="$?"
    if [[ $status -eq 0 ]]; then
	MODTIME_METHOD="RHEL_stat"
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: TZ=UTC $STAT_TOOL -c '%y' works, MODTIME_METHOD: $MODTIME_METHOD" 1>&2
	fi

    else

	# Try ls -D:
	#
	TZ=UTZ "$LS_TOOL" -D '%FT%T+00:00' -ld "$TOP_FILE" > /dev/null 2>&1
	status="$?"
	if [[ $status -eq 0 ]]; then
	    MODTIME_METHOD="ls_D"
	    if [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: TZ=UTZ $LS_TOOL -D '%FT%T+00:00' -ld works, MODTIME_METHOD: $MODTIME_METHOD" 1>&2
	    fi

	else
	    echo "$0: ERROR: we cannot determine how to form a file modification time in W3C Datetime formt" 1>&2
	    exit 9
	fi
    fi
fi

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
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: CAP_W_FLAG_FOUND=$CAP_W_FLAG_FOUND" 1>&2
    echo "$0: debug[3]: MODTIME_METHOD=$MODTIME_METHOD" 1>&2
    echo "$0: debug[3]: STAT_TOOL=$STAT_TOOL" 1>&2
    echo "$0: debug[3]: LS_TOOL=$LS_TOOL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: ARCHIVE_HISTORIC_PATH=$ARCHIVE_HISTORIC_PATH" 1>&2
    echo "$0: debug[3]: ARCHIVE_HISTORIC_DIR=$ARCHIVE_HISTORIC_DIR" 1>&2
    echo "$0: debug[3]: AUTHOR_PATH=$AUTHOR_PATH" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: INC_PATH=$INC_PATH" 1>&2
    echo "$0: debug[3]: INC_DIR=$INC_DIR" 1>&2
    echo "$0: debug[3]: SITEMAP=$SITEMAP" 1>&2
    echo "$0: debug[3]: FILELIST_ENTRY_JSON_AWK=$FILELIST_ENTRY_JSON_AWK" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
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
export TMP_MANIFEST_LIST=".tmp.$NAME.MANIFEST_LIST.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary file manifest list: $TMP_MANIFEST_LIST" 1>&2
fi
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

# create a temporary exit code
#
# It is a pain to set the EXIT_CODE deep inside a loop, so we write the EXIT_CODE into a file
# and read the file (setting EXIT_CODE again) after the loop.  A hack, but good enough for our needs.
#
export TMP_EXIT_CODE=".tmp.$NAME.EXIT_CODE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary exit code: $TMP_EXIT_CODE" 1>&2
fi
trap 'rm -f $TMP_MANIFEST_LIST $TMP_EXIT_CODE; exit' 0 1 2 3 15
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

# create a temporary sitemap
#
export TMP_SITEMAP=".tmp.$NAME.SITEMAP.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary tarball: $TMP_SITEMAP" 1>&2
fi
trap 'rm -f $TMP_MANIFEST_LIST $TMP_EXIT_CODE $TMP_SITEMAP; exit' 0 1 2 3 15
rm -f "$TMP_SITEMAP"
if [[ -e $TMP_SITEMAP ]]; then
    echo "$0: ERROR: cannot remove temporary tarball: $TMP_SITEMAP" 1>&2
    exit 16
fi
:> "$TMP_SITEMAP"
if [[ ! -e $TMP_SITEMAP ]]; then
    echo "$0: ERROR: cannot create temporary tarball: $TMP_SITEMAP" 1>&2
    exit 17
fi

# add top level files to the file manifest list
#
# We do not (yet?) include these files:
#
#	CNAME		- needed for only GitHub
#	google*.html	- used for Google Site Verification
#	sitemap.xml	- we are building the sitemap!
#
cat << EOF0 >> "$TMP_MANIFEST_LIST"
CODE_OF_CONDUCT.html
CODE_OF_CONDUCT.md
LICENSE
Makefile
README.html
README.md
authors.html
bugs.html
bugs.md
contact.html
contact.md
faq.html
faq.md
.gitignore
index.html
index.md
ioccc.css
judges.html
judges.md
location.html
news.html
news.md
robots.txt
status.json
thanks-for-help.html
thanks-for-help.md
.top
var.mk
winners.html
years.html
EOF0

# add files from selected sub-directories
#
find "$ARCHIVE_HISTORIC_DIR" "$AUTHOR_DIR" "$BIN_DIR" "$INC_DIR" -type f -print >> "$TMP_MANIFEST_LIST"

# generate sorted list of entry files from the full IOCCC manifest
#
# We also include the YYYY/.filelist contents.
#
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

    # output year level .filelist contents to
    #
    cat "$FILELIST" >> "$TMP_MANIFEST_LIST"

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
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: starting to process year/dir: $YYYY_DIR" 1>&2
	fi

	# parse YYYY_DIR
	#
	if [[ ! -d $YYYY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	    EXIT_CODE=7  # exit 7
	    continue
	fi
	if [[ ! -w $YYYY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR is not a writable directory: $YYYY_DIR" 1>&2
	    EXIT_CODE=7  # exit 7
	    continue
	fi
	export YEAR_DIR=${YYYY_DIR%%/*}
	if [[ -z $YEAR_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR not in YYYY/dir form: $YYYY_DIR" 1>&2
	    EXIT_CODE=7  # exit 7
	    continue
	fi
	export ENTRY_DIR=${YYYY_DIR#*/}
	if [[ -z $ENTRY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR not in $YEAR_DIR/dir form: $YYYY_DIR" 1>&2
	    EXIT_CODE=7  # exit 7
	    continue
	fi
	if [[ $ENTRY_DIR = */* ]]; then
	    echo "$0: ERROR: YYYY_DIR: $YYYY_DIR dir contains a /: $ENTRY_DIR" 1>&2
	    EXIT_CODE=7  # exit 7
	    continue
	fi

	# verify that YYYY_DIR is a writable directory
	#
	if [[ ! -e $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR does not exist: $YYYY_DIR" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	if [[ ! -d $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	if [[ ! -w $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR is not an writable directory: $YYYY_DIR" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi

	# verify YYYY/dir/.path
	#
	export DOT_PATH="$YYYY_DIR/.path"
	if [[ ! -s $DOT_PATH ]]; then
	    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	DOT_PATH_CONTENT=$(< "$DOT_PATH")
	if [[ $YYYY_DIR != "$DOT_PATH_CONTENT" ]]; then
	    echo "$0: ERROR: arg: $YYYY_DIR does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	export ENTRY_JSON="$YYYY_DIR/.entry.json"
	if [[ ! -e $ENTRY_JSON ]]; then
	    echo "$0: ERROR: .entry.json does not exist: $ENTRY_JSON" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	if [[ ! -f $ENTRY_JSON ]]; then
	    echo "$0: ERROR: .entry.json is not a file: $ENTRY_JSON" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi
	if [[ ! -r $ENTRY_JSON ]]; then
	    echo "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
	    EXIT_CODE=7 # exit 7
	    continue
	fi

	# use the entry's manifest to add files to the IOCCC year's manifest
	#
	awk -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" >> "$TMP_MANIFEST_LIST"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: awk -f $FILELIST_ENTRY_JSON_AWK $ENTRY_JSON >> $TMP_MANIFEST_LIST failed, error: $status" 1>&2
	    exit 1
	fi
    done

done
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit $EXIT_CODE" 1>&2
    exit "$EXIT_CODE"
fi

# sort the manifest list
#
LC_ALL=C sort -d "$TMP_MANIFEST_LIST" -o "$TMP_MANIFEST_LIST"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: LC_ALL=C sort -d $TMP_MANIFEST_LIST -o $TMP_MANIFEST_LIST failed, error: $status" 1>&2
    exit 1
fi

# verify that the manifest list contains only readable files
#
for FILE in $(< "$TMP_MANIFEST_LIST"); do

    if [[ ! -e $FILE ]]; then
	if [[ -z $CAP_W_FLAG_FOUND ]]; then
	    echo "$0: ERROR: file does not exist: $FILE" 1>&2
	else
	    echo "$0: Warning: file does not exist: $FILE" 1>&2
	fi
	EXIT_CODE=8 # exit 8
	continue
    fi
    if [[ ! -f $FILE ]]; then
	if [[ -z $CAP_W_FLAG_FOUND ]]; then
	    echo "$0: ERROR: is not a file: $FILE" 1>&2
	else
	    echo "$0: Warning: is not a file: $FILE" 1>&2
	fi
	EXIT_CODE=8 # exit 8
	continue
    fi
    if [[ ! -r $FILE ]]; then
	if [[ -z $CAP_W_FLAG_FOUND ]]; then
	    echo "$0: ERROR: is not a readable file: $FILE" 1>&2
	else
	    echo "$0: Warning: is not a readable file: $FILE" 1>&2
	fi
	EXIT_CODE=8 # exit 8
	continue
    fi

done
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit $EXIT_CODE" 1>&2
    exit "$EXIT_CODE"
fi

# form the sitemap
#
if [[ -z $NOOP ]]; then

    # debug
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to form a sitemap: $TMP_SITEMAP" 1>&2
    fi

    # output the XML header
    #
    # We just want to echo twice.
    #
    # SC2129 (style): Consider using { cmd1; cmd2; } >> file instead of individual redirects.
    # https://www.shellcheck.net/wiki/SC2129
    # shellcheck disable=SC2129
    echo '<?xml version="1.0" encoding="UTF-8"?>' >> "$TMP_SITEMAP"
    echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> "$TMP_SITEMAP"

    # output XML for each file in the manifest, in sorted filepath order
    #
    LC_ALL=C sort -d -f -t / "$TMP_MANIFEST_LIST" | while read -r FILE_PATH; do
	LASTMOD=$(output_modtime "$FILE_PATH")
	export LASTMOD
	echo '<url>'
	echo "    <loc>$SITE_URL/$FILE_PATH</loc>"
	echo "    <lastmod>$LASTMOD</lastmod>"
	echo '</url>'
    done >>  "$TMP_SITEMAP"

    # output the XML trailer
    #
    echo '</urlset>' >> "$TMP_SITEMAP"

    # verify the sitemap is not empty
    #
    if [[ ! -s $TMP_SITEMAP ]]; then
	echo "$0: ERROR: tarball is missing os empty: $TMP_SITEMAP" 1>&2
	EXIT_CODE=8 # exit 8
    fi

# case: -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, did not form sitemap: $TMP_SITEMAP" 1>&2
fi
EXIT_CODE=$(< "$TMP_EXIT_CODE")
if [[ -z $EXIT_CODE ]]; then
    echo "$0: ERROR: temporary exit file has no contents: $TMP_EXIT_CODE" 1>&2
    exit 19
fi

# move the sitemap in place only if different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_SITEMAP" "$SITEMAP"; then

	# case: tarball did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: file did not change: $SITEMAP" 1>&2
	fi

    else

	# case: tarball changed, update the file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: mv -f -- $TMP_SITEMAP $SITEMAP" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    mv -f -v -- "$TMP_SITEMAP" "$SITEMAP"
	    status="$?"
	else
	    mv -f -- "$TMP_SITEMAP" "$SITEMAP"
	    status="$?"
	fi
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_SITEMAP $SITEMAP filed, error code: $status" 1>&2
	    EXIT_CODE=8 # exit 8
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: built replaced HTML file: $SITEMAP" 1>&2
	fi
	if [[ ! -s $SITEMAP ]]; then
	    echo "$0: ERROR: not a non-empty index HTML file: $SITEMAP" 1>&2
	    EXIT_CODE=8 # exit 8
	fi
     fi

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary file manifest list was not formed: $TMP_MANIFEST_LIST" 1>&2
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_MANIFEST_LIST" "$TMP_EXIT_CODE" "$TMP_SITEMAP"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_MANIFEST_LIST $TMP_EXIT_CODE $TMP_SITEMAP" 1>&2
fi
exit "$EXIT_CODE"
