#!/usr/bin/env bash
#
# csv2entry.sh - convert CSV files into .entry.json for all entries
#
# This tool takes as input, the following CSV files:
#
# author_wins.csv - author_handle followed by all their entry_ids
# manifest.csv - information about files under a entry
# year_prize.csv - entry_id followed by the entry's award
#
# This tool updates .entry.json files for all entries.
# Only those .entry.json files whose content is modified are written.
#
# There is no requirement to sort the CSV files, nor convert
# them to UNIX format, nor append a final newline to the file.
#
# This tool will canonicalize CSV files before using them
# as input.  Thus, if one wishes to import the CSV file into
# some spreadsheet such as the [macOS](https://www.apple.com/macos)
# [Numbers](https://www.apple.com/numbers/) spreadsheet,
# modifies the content and final exports back to the CSV file,
# this tool will modify the CSV file (if needed) in order
# to restore the CSV order and other canonicalizing processes.
#
# This tool will flag as an error, any empty fields, fields that are
# an un-quoted _NULL_ or _null_, fields that start with whitespace,
# fields that ends with whitespace, or fields that contain consecutive
# whitespace characters.
#
# Internal details of csv2entry.sh
#
# We first canonicalize the CSV files by replacing any "carriage
# return line feeds" with "newlines.  We also make sure that the CSV
# file ends in a newline.  We do this because some spreadsheet
# applications, when exporting to a CSV file, do not do this.
#
# We also sort the CSV files in the same way that `bin/entry2csv.sh`
# sorts its CSV output files.  We do this in case the
# CSV files were imported into a spreadsheet where their order
# was changed before exporting.  This means one is free
# to order the CSV file content as you wish as this
# tool will reset these CSV file.
#
# Next this tool processes the non-CSV comment lines in manifest.csv.
# The 1st and 2nd fields of manifest.csv prefer to entry YYYY and
# entry sub-directory (i.e., the YYYY/dir directory under the
# root of the git repository).  From that list of YYYY/dir
# IOCCC entry directories, we will create the `.entry.json` files.
# We only modify those `.entry.json` files when their content changes.
#
# NOTE:
#
# While this tool uses `jparse(1)` to verify that the modified
# `.entry.json` contains valid JSON content, this tool does NOT
# perform any semantic checks.  For example, this tool does NOT
# verify that the manifest in the `.entry.json` file matches the
# files in the YYYY/dir directory, or even that the `.entry.json`
# contains a manifest (or any of the other required JSON content).
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
shopt -s lastpipe	# explicitly run the last command of the pipe line in the current shell


# set variables referenced in the usage message
#
export VERSION="1.2.2 2024-08-17"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
GIT_TOOL=$(type -P git)
export GIT_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: git tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
DOS2UNIX_TOOL=$(type -P dos2unix)
export DOS2UNIX_TOOL
if [[ -z "$DOS2UNIX_TOOL" ]]; then
    echo "$0: FATAL: dos2unix tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
"$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
status="$?"
if [[ $status -eq 0 ]]; then
    TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
fi
export TOPDIR
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"
#
JPARSE_TOOL=$(type -P jparse)
export JPARSE_TOOL
export AUTHOR_WINS_CSV="author_wins.csv"
export MANIFEST_CSV="manifest.csv"
export YEAR_PRIZE_CSV="year_prize.csv"
export DOT_ENTRY_JSON_BASENAME=".entry.json"
export ENTRY_JSON_FORMAT_VERSION="1.1 2024-02-11"
export NO_COMMENT="mandatory comment: because comments were removed from the original JSON spec"
export AUTHOR_DIR="author"


# canonicalize_csv
#
# We canonicalize the CSV file by replacing any "carriage
# return line feeds" with "newlines.  We also make sure that the CSV
# file ends in a newline.
#
# usage:
#       canonicalize_csv input.cvs output.csv
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function canonicalize_csv
{
    local INPUT_CSV;	# input CSV file
    local OUTPUT_CSV;	# output CSV file
    local status0;	# status for 1st command in pipe
    local status1;	# status for 2nd command in pipe

    # parse args
    #
    if [[ $# -ne 2 ]]; then
        echo "$0: ERROR: in canonicalize_csv: expected 2 args, found $#" 1>&2
        return 1
    fi
    INPUT_CSV="$1"
    if [[ ! -e $INPUT_CSV ]]; then
        echo "$0: ERROR: in canonicalize_csv: input.cvs does not exist: $INPUT_CSV" 1>&2
        return 2
    fi
    if [[ ! -f $INPUT_CSV ]]; then
        echo "$0: ERROR: in canonicalize_csv: input.cvs is not a file: $INPUT_CSV" 1>&2
        return 3
    fi
    if [[ ! -r $INPUT_CSV ]]; then
        echo "$0: ERROR: in canonicalize_csv: input.cvs is not a readable file: $INPUT_CSV" 1>&2
        return 4
    fi
    OUTPUT_CSV="$2"

    # Convert any "carriage return line feeds" and add newline to last line if there isn't one.
    # Add final newline if missing.
    # Remove trailing empty fields in non-comment lines.
    #
    "$DOS2UNIX_TOOL" -e -f -q -- < "$INPUT_CSV" |
        sed -e 's/^TRUE,/true,/g' \
	    -e 's/,TRUE,/,true,/g' \
	    -e 's/,TRUE$/,true/' \
	    -e 's/^FALSE,/false,/g' \
	    -e 's/,FALSE,/,false,/g' \
	    -e 's/,FALSE$/,false/' \
	    -e 's/^\([^#].*[^,]\),,*$/\1/' > "$OUTPUT_CSV"
    status0="${PIPESTATUS[0]}"
    status1="${PIPESTATUS[1]}"
    if [[ $status0 -ne 0 || $status1 -ne 0 ]]; then
	echo "$0: ERROR: in canonicalize_csv:" \
	     "$DOS2UNIX_TOOL ... < $INPUT_CSV | sed ... > $OUTPUT_CSV failed," \
	     "error codes: $status0 and $status1" 1>&2
	return 5
    fi

    # check for double whitespace
    #
    if grep -E -q '[[:space:]][[:space:]]' "$OUTPUT_CSV" >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found double whitespace: $INPUT_CSV" 1>&2
        return 6
    fi

    # check for field with leading whitespace
    #
    if grep -E -q ',[[:space:]]|^[[:space:]]' "$OUTPUT_CSV" >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found field with leading whitespace: $INPUT_CSV" 1>&2
        return 7
    fi

    # check for field with trailing whitespace
    #
    if grep -E -q '[[:space:]],|[[:space:]]$' "$OUTPUT_CSV" >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found field with trailing whitespace: $INPUT_CSV" 1>&2
        return 8
    fi

    # check for field with NULL
    #
    if grep -E -q '^NULL,|,NULL,|,NULL$' "$OUTPUT_CSV" >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found field with NULL: $INPUT_CSV" 1>&2
        return 9
    fi

    # check for field with null
    #
    if grep -E -q '^null,|,null,|,null$' "$OUTPUT_CSV" >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found field with null: $INPUT_CSV" 1>&2
        return 10
    fi

    # check for empty fields in non-comment lines
    #
    if grep -v '^#' "$OUTPUT_CSV" 2>/dev/null | grep -E ',,|,$' >/dev/null 2>&1; then
        echo "$0: ERROR: in canonicalize_csv: found non-comment empty fields: $INPUT_CSV" 1>&2
        return 11
    fi
    return 0
}


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N] [-j jparse]
			[author_wins.csv [manifest.csv [year_prize.csv]]]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	-j jparse	path to the jparse tool (def: $JPARSE_TOOL)

	author_wins.csv	where to form author_wins.csv (def: $AUTHOR_WINS_CSV)
	manifest.csv	where to form manifest.csv (def: $MANIFEST_CSV)
	year_prize.csv	where to form year_prize.csv (def: $YEAR_PRIZE_CSV)

Exit codes:
     0         all OK
     1         unable to write or invalid .entry.json file
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
     8         unable to write or invalid CSV or temporary file
     9	       unknown author_handle or not found in author/author_handle.json or invalid JSON
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd:D:nNj: flag; do
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
    j) JPARSE_TOOL="$OPTARG"
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


# remove the options
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
case "$#" in
0) ;;
1) AUTHOR_WINS_CSV="$1" ;;
2) AUTHOR_WINS_CSV="$1" ; MANIFEST_CSV="$2" ;;
3) AUTHOR_WINS_CSV="$1" ; MANIFEST_CSV="$2" ; YEAR_PRIZE_CSV="$3" ;;
*) echo "$0: expected 0, 1, 2 or 3 args, found #$" 1>&2
   echo 1>*2
   echo  "$USAGE" 1>&2
   exit 3
   ;;
esac


# verify that CSV files are in a writable directories
#
if [[ -z $AUTHOR_WINS_CSV ]]; then
    echo "$0: ERROR: AUTHOR_WINS_CSV is empty" 1>&2
    exit 8
fi
AUTHOR_WINS_CSV_DIR=$(dirname "$AUTHOR_WINS_CSV")
export AUTHOR_WINS_CSV_DIR
if [[ ! -w $AUTHOR_WINS_CSV_DIR ]]; then
    echo "$0: ERROR: AUTHOR_WINS_CSV file: $AUTHOR_WINS_CSV in a non-writable directory: $AUTHOR_WINS_CSV_DIR" 1>&2
    exit 8
fi
#
if [[ -z $MANIFEST_CSV ]]; then
    echo "$0: ERROR: MANIFEST_CSV is empty" 1>&2
    exit 8
fi
MANIFEST_CSV_DIR=$(dirname "$MANIFEST_CSV")
export MANIFEST_CSV_DIR
if [[ ! -w $MANIFEST_CSV_DIR ]]; then
    echo "$0: ERROR: AUTHOR_WINS_CSV file: $MANIFEST_CSV in a non-writable directory: $MANIFEST_CSV_DIR" 1>&2
    exit 8
fi
#
if [[ -z $YEAR_PRIZE_CSV ]]; then
    echo "$0: ERROR: YEAR_PRIZE_CSV is empty" 1>&2
    exit 8
fi
YEAR_PRIZE_CSV_DIR=$(dirname "$YEAR_PRIZE_CSV")
export YEAR_PRIZE_CSV_DIR
if [[ ! -w $YEAR_PRIZE_CSV_DIR ]]; then
    echo "$0: ERROR: YEAR_PRIZE_CSV file: $YEAR_PRIZE_CSV in a non-writable directory: $YEAR_PRIZE_CSV_DIR" 1>&2
    exit 8
fi


# verify that we have a topdir directory
#
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    exit 6
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
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


# verify that we have a bin subdirectory
#
export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


# find the jval-wrapper.sh tool
#
JVAL_WRAPPER="$BIN_PATH/jval-wrapper.sh"
if [[ ! -x $JVAL_WRAPPER ]]; then
    echo "$0: ERROR: cannot find the bin/jval-wrapper.sh executable" 1>&2
    exit 5
fi


# verify jparse tool
#
if [[ -z "$JPARSE_TOOL" ]]; then
    echo "$0: ERROR: cannot find an executable jparse tool" 1>&2
    exit 5
fi
if [[ ! -f "$JPARSE_TOOL" ]]; then
    echo "$0: ERROR: jparse is not a file: $JPARSE_TOOL" 1>&2
    exit 5
fi
if [[ ! -x "$JPARSE_TOOL" ]]; then
    echo "$0: ERROR: jparse is not an executable file: $JPARSE_TOOL" 1>&2
    exit 5
fi


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: JPARSE_TOOL=$JPARSE_TOOL" 1>&2
    echo "$0: debug[3]: AUTHOR_WINS_CSV=$AUTHOR_WINS_CSV" 1>&2
    echo "$0: debug[3]: MANIFEST_CSV=$MANIFEST_CSV" 1>&2
    echo "$0: debug[3]: YEAR_PRIZE_CSV=$YEAR_PRIZE_CSV" 1>&2
    echo "$0: debug[3]: AUTHOR_WINS_CSV_DIR=$AUTHOR_WINS_CSV_DIR" 1>&2
    echo "$0: debug[3]: MANIFEST_CSV_DIR=$MANIFEST_CSV_DIR" 1>&2
    echo "$0: debug[3]: YEAR_PRIZE_CSV_DIR=$YEAR_PRIZE_CSV_DIR" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_DIR" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: DOT_ENTRY_JSON_BASENAME=$DOT_ENTRY_JSON_BASENAME" 1>&2
    echo "$0: debug[3]: ENTRY_JSON_FORMAT_VERSION=$ENTRY_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[3]: NO_COMMENT=$NO_COMMENT" 1>&2
    echo "$0: debug[3]: AUTHOR_DIR=$AUTHOR_DIR" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# create a temporary author.csv file
#
export TMP_AUTHOR_WINS_CSV=".tmp.$NAME.AUTHOR_WINS_CSV.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV author.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV; exit' 0 1 2 3 15
rm -f "$TMP_AUTHOR_WINS_CSV"
if [[ -e $TMP_AUTHOR_WINS_CSV ]]; then
    echo "$0: ERROR: cannot remove temporary CSV author.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
    exit 10
fi
echo '# author_handle,entry_id,entry_id,entry_id,…,,,,,,,,,,,,,,,' > \
  "$TMP_AUTHOR_WINS_CSV"
if [[ ! -e $TMP_AUTHOR_WINS_CSV ]]; then
    echo "$0: ERROR: cannot create temporary CSV author.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
    exit 11
fi


# create a temporary manifest.csv file
#
export TMP_MANIFEST_CSV=".tmp.$NAME.MANIFEST_CSV.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV manifest.csv file: $TMP_MANIFEST_CSV" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV; exit' 0 1 2 3 15
rm -f "$TMP_MANIFEST_CSV"
if [[ -e $TMP_MANIFEST_CSV ]]; then
    echo "$0: ERROR: cannot remove temporary CSV manifest.csv file: $TMP_MANIFEST_CSV" 1>&2
    exit 12
fi
echo '# year,dir,file_path,inventory_order,OK_to_edit,display_as,display_via_github,entry_text' > \
  "$TMP_MANIFEST_CSV"
if [[ ! -e $TMP_MANIFEST_CSV ]]; then
    echo "$0: ERROR: cannot create temporary CSV manifest.csv file: $TMP_MANIFEST_CSV" 1>&2
    exit 13
fi


# create a temporary year_prize.csv file
#
export TMP_YEAR_PRIZE_CSV=".tmp.$NAME.YEAR_PRIZE_CSV.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV year_prize.csv file: $TMP_YEAR_PRIZE_CSV" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV; exit' 0 1 2 3 15
rm -f "$TMP_YEAR_PRIZE_CSV"
if [[ -e $TMP_YEAR_PRIZE_CSV ]]; then
    echo "$0: ERROR: cannot remove temporary CSV year_prize.csv file: $TMP_YEAR_PRIZE_CSV" 1>&2
    exit 14
fi
echo '# year_handle,award name' > \
  "$TMP_YEAR_PRIZE_CSV"
if [[ ! -e $TMP_YEAR_PRIZE_CSV ]]; then
    echo "$0: ERROR: cannot create temporary CSV year_prize.csv file: $TMP_YEAR_PRIZE_CSV" 1>&2
    exit 15
fi


# create a temporary YYYY_DIR inventory file
#
export TMP_YYYY_DIR_INV=".tmp.$NAME.YYYY_DIR_inventory.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV temporary YYYY_DIR inventory file: $TMP_YYYY_DIR_INV" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV $TMP_YYYY_DIR_INV; exit' 0 1 2 3 15
rm -f "$TMP_YYYY_DIR_INV"
if [[ -e $TMP_YYYY_DIR_INV ]]; then
    echo "$0: ERROR: cannot remove temporary CSV temporary YYYY_DIR inventory file: $TMP_YYYY_DIR_INV" 1>&2
    exit 16
fi
: > "$TMP_YYYY_DIR_INV"
if [[ ! -e $TMP_YYYY_DIR_INV ]]; then
    echo "$0: ERROR: cannot create temporary CSV temporary YYYY_DIR inventory file: $TMP_YYYY_DIR_INV" 1>&2
    exit 17
fi


# create a temporary 2nd 2nd YYYY_DIR inventory file
#
export TMP_2ND_YYYY_DIR_INV=".tmp.$NAME.YYYY_DIR_inventory.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV temporary 2nd YYYY_DIR inventory file: $TMP_2ND_YYYY_DIR_INV" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV $TMP_YYYY_DIR_INV \
	    $TMP_YYYY_DIR_INV $TMP_2ND_YYYY_DIR_INV; exit' 0 1 2 3 15
rm -f "$TMP_2ND_YYYY_DIR_INV"
if [[ -e $TMP_2ND_YYYY_DIR_INV ]]; then
    echo "$0: ERROR: cannot remove temporary CSV temporary 2nd YYYY_DIR inventory file: $TMP_2ND_YYYY_DIR_INV" 1>&2
    exit 18
fi
: > "$TMP_2ND_YYYY_DIR_INV"
if [[ ! -e $TMP_2ND_YYYY_DIR_INV ]]; then
    echo "$0: ERROR: cannot create temporary CSV temporary 2nd YYYY_DIR inventory file: $TMP_2ND_YYYY_DIR_INV" 1>&2
    exit 19
fi


# create a temporary .entry.json inventory file
#
export TMP_ENTRY_JSON=".tmp.$NAME.entry.json.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary CSV temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV $TMP_YYYY_DIR_INV \
	    $TMP_YYYY_DIR_INV $TMP_2ND_YYYY_DIR_INV $TMP_ENTRY_JSON; exit' 0 1 2 3 15
rm -f "$TMP_ENTRY_JSON"
if [[ -e $TMP_ENTRY_JSON ]]; then
    echo "$0: ERROR: cannot remove temporary CSV temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
    exit 20
fi
: > "$TMP_ENTRY_JSON"
if [[ ! -e $TMP_ENTRY_JSON ]]; then
    echo "$0: ERROR: cannot create temporary CSV temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
    exit 21
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
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV $TMP_YYYY_DIR_INV $TMP_YYYY_DIR_INV \
	    $TMP_2ND_YYYY_DIR_INV $TMP_ENTRY_JSON $TMP_EXIT_CODE; exit' 0 1 2 3 15
rm -f "$TMP_EXIT_CODE"
if [[ -e $TMP_EXIT_CODE ]]; then
    echo "$0: ERROR: cannot remove temporary exit code: $TMP_EXIT_CODE" 1>&2
    exit 22
fi
echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
if [[ ! -e $TMP_EXIT_CODE ]]; then
    echo "$0: ERROR: cannot create temporary exit code: $TMP_EXIT_CODE" 1>&2
    exit 23
fi


# create a temporary author_handle inventory file
#
export TMP_AUTHOR_HANDLE_INVENTORY=".tmp.$NAME.AUTHOR_HANDLE_INVENTORY.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
fi
trap 'rm -f $TMP_AUTHOR_WINS_CSV $TMP_MANIFEST_CSV $TMP_YEAR_PRIZE_CSV $TMP_YYYY_DIR_INV $TMP_YYYY_DIR_INV \
	    $TMP_2ND_YYYY_DIR_INV $TMP_ENTRY_JSON $TMP_EXIT_CODE $TMP_AUTHOR_HANDLE_INVENTORY; exit' 0 1 2 3 15
rm -f "$TMP_AUTHOR_HANDLE_INVENTORY"
if [[ -e $TMP_AUTHOR_HANDLE_INVENTORY ]]; then
    echo "$0: ERROR: cannot remove temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
    exit 24
fi
: > "$TMP_AUTHOR_HANDLE_INVENTORY"
if [[ ! -e $TMP_AUTHOR_HANDLE_INVENTORY ]]; then
    echo "$0: ERROR: cannot create temporary author_handle inventory file: $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
    exit 25
fi


# canonicalize author_wins.csv into temporary author_wins.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: canonicalize $AUTHOR_WINS_CSV" 1>&2
    fi
    canonicalize_csv "$AUTHOR_WINS_CSV" "$TMP_AUTHOR_WINS_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: canonicalize_csv $AUTHOR_WINS_CSV $TMP_AUTHOR_WINS_CSV failed," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: canonicalize temporary author_wins.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not canonicalize: $AUTHOR_WINS_CSV"
fi


# sort the temporary author_wins.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to: LC_ALL=C sort -t, -k1d,1 -k2d,2 $TMP_AUTHOR_WINS_CSV -o $TMP_AUTHOR_WINS_CSV" 1>&2
    fi
    LC_ALL=C sort -t, -k1d,1 -k2d,2 "$TMP_AUTHOR_WINS_CSV" -o "$TMP_AUTHOR_WINS_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: LC_ALL=C sort -t, -k1d,1 -k2d,2 $TMP_AUTHOR_WINS_CSV -o $TMP_AUTHOR_WINS_CSV failed," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: sorted temporary author_wins.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not sort: $TMP_AUTHOR_WINS_CSV"
fi


# replace author_wins.csv file with the temporary file if author_wins.csv is missing or different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_AUTHOR_WINS_CSV" "$AUTHOR_WINS_CSV"; then

	# case: author_wins.csv did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: author_wins.csv file did not change: $AUTHOR_WINS_CSV" 1>&2
        fi

    else

        # case: author_wins.csv file changed, update the file
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_AUTHOR_WINS_CSV $AUTHOR_WINS_CSV" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_AUTHOR_WINS_CSV" "$AUTHOR_WINS_CSV"
            status="$?"
        else
            mv -f -- "$TMP_AUTHOR_WINS_CSV" "$AUTHOR_WINS_CSV"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_AUTHOR_WINS_CSV $AUTHOR_WINS_CSV filed," \
	         "error code: $status" 1>&2
            exit 8
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: replaced author_wins.csv file: $AUTHOR_WINS_CSV" 1>&2
        fi
        if [[ ! -s $AUTHOR_WINS_CSV ]]; then
            echo "$0: ERROR: not a non-empty author_wins.csv file: $AUTHOR_WINS_CSV" 1>&2
            exit 8
        fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not update $AUTHOR_WINS_CSV"
fi


# scan author_wins.csv file for unknown author handles and
#      author handles w/o author/author_handle.json file and
#      author/author_handle.json file that do not reference the entry id
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to: scan for unknown author handles" 1>&2
fi
export line=0
sed -e 's/,/ /g' "$AUTHOR_WINS_CSV" | while read -r AUTHOR_HANDLE ENTRY_ID_SET; do

    # skip comment lines
    #
    ((++line))
    if [[ $AUTHOR_HANDLE =~ '#' ]]; then
	continue;
    fi

    # look for unknown author handles
    #
    export AUTHOR_HANDLE_JSON="$AUTHOR_DIR/$AUTHOR_HANDLE.json"
    if [[ ! -f $AUTHOR_DIR/$AUTHOR_HANDLE.json ]]; then
	echo "$0: ERROR: entry_id $ENTRY_ID refers to an unknown author_handle: $AUTHOR_HANDLE" 1>&2
	echo "$0: Warning: no such author_handle file: $AUTHOR_HANDLE_JSON" 1>&2
	echo "$0: Warning: line: $line for: $AUTHOR_WINS_CSV flagging unknown author_handle as an error: continuing" 1>&2
	EXIT_CODE="9"  # exit 9
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	# NOTE: We do NOT want to stop processing via continue - proceeding instead

    # look for lines with no entry ids
    #
    elif [[ -z $ENTRY_ID_SET ]]; then
	echo "$0: ERROR: line: $line of author_wins.csv: $AUTHOR_WINS_CSV as no entry ids on the line" 1>&2
	EXIT_CODE="8"  # exit 8
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	# NOTE: We do NOT want to stop processing via continue - proceeding instead

    # look for unknown entry_id's
    #
    else

	# verify the JSON of author/author_handle.json
	#
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: about to run: $JPARSE_TOOL -q -- $AUTHOR_HANDLE_JSON" 1>&2
	fi
	echo "$AUTHOR_HANDLE_JSON" >> "$TMP_AUTHOR_HANDLE_INVENTORY"
	if "$JPARSE_TOOL" -q -- "$AUTHOR_HANDLE_JSON"; then

	    # case: author/author_handle.json file is valid JSON
	    #
	    if [[ $V_FLAG -ge 9 ]]; then
		echo "$0: debug[9]: valid JSON for: $AUTHOR_HANDLE_JSON" 1>&2
	    fi

	    # check each entry id on the line
	    #
	    echo "$ENTRY_ID_SET" | sed -e 's/ /\n/g' | while read -r ENTRY_ID; do

		# convert ENTRY_ID into YYYY_DIR
		#
		export YEAR_DIR=${ENTRY_ID%%_*}
		export ENTRY_DIR=${ENTRY_ID#*_}
		export YYYY_DIR="${YEAR_DIR}/${ENTRY_DIR}"

		# verify that the entry exists
		#
		if [[ ! -d $YYYY_DIR ]]; then

		    # case: entry does not exist
		    #
		    echo "$0: ERROR: line: $line of author_wins.csv: $AUTHOR_WINS_CSV" \
			 "refers to unknown entry id: $ENTRY_ID" 1>&2
		    EXIT_CODE="7"  # exit 7
		    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
		    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
		    # NOTE: We do NOT want to stop processing via continue - proceeding instead

		# verify that the author/author_handle.json file refers to the entry id
		#
		else

		    # check if the author/author_handle.json file refers to the entry id
		    #
		    FOUND=$("$JVAL_WRAPPER" -w -b "$AUTHOR_HANDLE_JSON" '$..entry_id')
		    if [[ -z $FOUND ]]; then
			echo "$0: ERROR: line: $line of author_wins.csv: $AUTHOR_WINS_CSV" \
			     "entry id: $ENTRY_ID not in winning_entry_set of: $AUTHOR_HANDLE_JSON" 1>&2
			EXIT_CODE="9"  # exit 9
			echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
			echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
			# NOTE: We do NOT want to stop processing via continue - proceeding instead
		    fi
		fi
	    done

	# case: author/author_handle.json is not valid JSON
	#
	else
	    echo "$0: ERROR: line: $line of author_wins.csv: $AUTHOR_WINS_CSV" \
		 "is not valid JSON for: $AUTHOR_HANDLE_JSON" 1>&2
	    EXIT_CODE="1"  # exit 1
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    # NOTE: We do NOT want to stop processing via continue - proceeding instead
	fi
    fi
done


# verify that the author directory contains only author_handle.json files referenced by author_wins.csv
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: sort $TMP_AUTHOR_HANDLE_INVENTORY -o $TMP_AUTHOR_HANDLE_INVENTORY" 1>&2
fi
LC_ALL=C sort "$TMP_AUTHOR_HANDLE_INVENTORY" -o "$TMP_AUTHOR_HANDLE_INVENTORY"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: LC_ALL=C sort $TMP_AUTHOR_HANDLE_INVENTORY -o $TMP_AUTHOR_HANDLE_INVENTORY failed," \
	 "error code: $status" 1>&2
    exit 9
fi
AUTHOR_DIFF=$(find "$AUTHOR_DIR" -mindepth 1 -maxdepth 1 -type f -name '*.json' 2>&1 |
	      LC_ALL=C sort |
	      diff -u - "$TMP_AUTHOR_HANDLE_INVENTORY")
export AUTHOR_DIFF
if [[ -n $AUTHOR_DIFF ]]; then
    echo "$0: ERROR: author handles in author_wins.csv: $AUTHOR_WINS_CSV differs from author directory: $AUTHOR_DIR" 1>&2
    echo "$0: Warning: author directory differences start below" 1>&2
    echo "$AUTHOR_DIFF" 1>&2
    echo "$0: Warning: author directory differences end above" 1>&2
    EXIT_CODE="9"  # exit 1
    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
    # NOTE: We do NOT want to stop processing via continue - proceeding instead
fi


# canonicalize manifest.csv into temporary manifest.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: canonicalize $MANIFEST_CSV" 1>&2
    fi
    canonicalize_csv "$MANIFEST_CSV" "$TMP_MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: canonicalize_csv $MANIFEST_CSV $TMP_MANIFEST_CSV failed," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: sorted temporary manifest.csv file: $TMP_MANIFEST_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not canonicalize: $MANIFEST_CSV"
fi


# sort the temporary manifest.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to: LC_ALL=C sort -t, -k1,1 -k2d,2 -k4n,4 -k3,3 -k5d,8 $TMP_MANIFEST_CSV -o $TMP_MANIFEST_CSV" 1>&2
    fi
    LC_ALL=C sort -t, -k1,1 -k2d,2 -k4n,4 -k3,3 -k5d,8 "$TMP_MANIFEST_CSV" -o "$TMP_MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: LC_ALL=C sort -t, -k1,1 -k2d,2 -k4n,4 -k3,3 -k5d,8 $TMP_MANIFEST_CSV -o $TMP_MANIFEST_CSV failed," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: sorted temporary manifest.csv file: $TMP_MANIFEST_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not sort: $TMP_MANIFEST_CSV"
fi


# replace manifest.csv file with the temporary file if manifest.csv is missing or different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_MANIFEST_CSV" "$MANIFEST_CSV"; then

	# case: manifest.csv did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: manifest.csv file did not change: $MANIFEST_CSV" 1>&2
        fi

    else

        # case: manifest.csv file changed, update the file
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_MANIFEST_CSV $MANIFEST_CSV" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_MANIFEST_CSV" "$MANIFEST_CSV"
            status="$?"
        else
            mv -f -- "$TMP_MANIFEST_CSV" "$MANIFEST_CSV"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_MANIFEST_CSV $MANIFEST_CSV filed," \
	         "error code: $status" 1>&2
            exit 8
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: replaced manifest.csv file: $MANIFEST_CSV" 1>&2
        fi
        if [[ ! -s $MANIFEST_CSV ]]; then
            echo "$0: ERROR: not a non-empty manifest.csv file: $MANIFEST_CSV" 1>&2
            exit 8
        fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not update $MANIFEST_CSV"
fi


# canonicalize year_prize.csv into temporary year_prize.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to: canonicalize $YEAR_PRIZE_CSV" 1>&2
    fi
    canonicalize_csv "$YEAR_PRIZE_CSV" "$TMP_YEAR_PRIZE_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: canonicalize_csv $YEAR_PRIZE_CSV $TMP_YEAR_PRIZE_CSV failed," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: sorted temporary year_prize.csv file: $TMP_YEAR_PRIZE_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not canonicalize: $YEAR_PRIZE_CSV"
fi


# sort the temporary year_prize.csv file
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: about to: LC_ALL=C sort -t, -k1d,1 -k2d,2 $TMP_YEAR_PRIZE_CSV -o $TMP_YEAR_PRIZE_CSV" 1>&2
    fi
    LC_ALL=C sort -t, -k1d,1 -k2d,2 "$TMP_YEAR_PRIZE_CSV" -o "$TMP_YEAR_PRIZE_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: LC_ALL=C sort -t, -k1d,1 -k2d,2 $TMP_YEAR_PRIZE_CSV -o $TMP_YEAR_PRIZE_CSV," \
	     "error code: $status" 1>&2
	exit 8
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: sorted temporary year_prize.csv file: $TMP_YEAR_PRIZE_CSV" 1>&2
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not sort: $TMP_YEAR_PRIZE_CSV"
fi


# replace year_prize.csv file with the temporary file if year_prize.csv is missing or different
#
if [[ -z $NOOP ]]; then
    if cmp -s "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"; then

	# case: year_prize.csv did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: year_prize.csv file did not change: $YEAR_PRIZE_CSV" 1>&2
        fi

    else

        # case: year_prize.csv file changed, update the file
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_YEAR_PRIZE_CSV $YEAR_PRIZE_CSV" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"
            status="$?"
        else
            mv -f -- "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_YEAR_PRIZE_CSV $YEAR_PRIZE_CSV filed," \
	         "error code: $status" 1>&2
            exit 8
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: replaced year_prize.csv file: $YEAR_PRIZE_CSV" 1>&2
        fi
        if [[ ! -s $YEAR_PRIZE_CSV ]]; then
            echo "$0: ERROR: not a non-empty year_prize.csv file: $YEAR_PRIZE_CSV" 1>&2
            exit 8
        fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
   echo "$0: debug[3]: because of -n, will not update $YEAR_PRIZE_CSV"
fi


# generate a YYYY_DIR inventory file
#
export YYYY
for YYYY in $(< "$TOP_FILE"); do

    # debug YYYY
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: scanning year: $YYYY" 1>&2
    fi

    # verify that YYYY is a readable directory
    #
    if [[ ! -e $YYYY ]]; then
	echo  "$0: ERROR: YYYY does not exist: $YYYY" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi
    if [[ ! -d $YYYY ]]; then
	echo  "$0: ERROR: YYYY is not a directory: $YYYY" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi
    if [[ ! -r $YYYY ]]; then
	echo  "$0: ERROR: YYYY is not an readable directory: $YYYY" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi

    # verify that YYYY has a non-empty readable .year file
    #
    export YEAR_FILE="$YYYY/.year"
    if [[ ! -e $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year does not exist: $YEAR_FILE" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi
    if [[ ! -f $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not a regular file: $YEAR_FILE" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi
    if [[ ! -r $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not an readable file: $YEAR_FILE" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi
    if [[ ! -s $YEAR_FILE ]]; then
	echo  "$0: ERROR: YYYY/.year is not a non-empty readable file: $YEAR_FILE" 1>&2
	EXIT_CODE="6"  # exit 6
	echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	continue
    fi

    # process each entry directory under YYYY
    #
    export YYYY_DIR
    for YYYY_DIR in $(< "$YEAR_FILE"); do

	# debug YYYY
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[3]: scanning year/dir: $YYYY_DIR" 1>&2
	fi

	# parse YYYY_DIR
	#
	if [[ ! -d $YYYY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	if [[ ! -w $YYYY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR is not a writable directory: $YYYY_DIR" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	export YEAR_DIR=${YYYY_DIR%%/*}
	if [[ -z $YEAR_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR not in YYYY/dir form: $YYYY_DIR" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	export ENTRY_DIR=${YYYY_DIR#*/}
	if [[ -z $ENTRY_DIR ]]; then
	    echo "$0: ERROR: YYYY_DIR not in $YEAR_DIR/dir form: $YYYY_DIR" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	if [[ $ENTRY_DIR = */* ]]; then
	    echo "$0: ERROR: YYYY_DIR: $YYYY_DIR dir contains a /: $ENTRY_DIR" 1>&2
	    EXIT_CODE="6"  # exit 6
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	export ENTRY_ID="${YEAR_DIR}_${ENTRY_DIR}"

	# verify that YYYY_DIR is a writable directory
	#
	if [[ ! -e $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR does not exist: $YYYY_DIR" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	if [[ ! -d $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR is not a directory: $YYYY_DIR" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	if [[ ! -w $YYYY_DIR ]]; then
	    echo  "$0: ERROR: YYYY_DIR is not an writable directory: $YYYY_DIR" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi

	# verify YYYY/dir/.path
	#
	export DOT_PATH="$YYYY_DIR/.path"
	if [[ ! -s $DOT_PATH ]]; then
	    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi
	DOT_PATH_CONTENT=$(< "$DOT_PATH")
	if [[ $YYYY_DIR != "$DOT_PATH_CONTENT" ]]; then
	    echo "$0: ERROR: arg: $YYYY_DIR does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
	    EXIT_CODE="7"  # exit 7
	    echo "$0: Warning: EXIT_CODE set to: $EXIT_CODE" 1>&2
	    echo "$EXIT_CODE" > "$TMP_EXIT_CODE"
	    continue
	fi

	# append YYYY_DIR to YYYY_DIR inventory file
	#
	echo "$YYYY_DIR" >> "$TMP_YYYY_DIR_INV"
    done
done


# canonicalize the YYYY_DIR inventory file
#
if [[ ! -s $TMP_YYYY_DIR_INV ]]; then
    echo "$0: ERROR: arg: YYYY_DIR inventory file is not a non-empty file: $TMP_YYYY_DIR_INV" 1>&2
    exit 26
fi
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: LC_ALL=C sort -t/ -d $TMP_YYYY_DIR_INV -o $TMP_YYYY_DIR_INV" 1>&2
fi
LC_ALL=C sort -t/ -d "$TMP_YYYY_DIR_INV" -o "$TMP_YYYY_DIR_INV"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: LC_ALL=C sort -t/ -d $TMP_YYYY_DIR_INV -o $TMP_YYYY_DIR_INV failed," \
	 "error code: $status" 1>&2
    exit 8
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: sorted temporary author_wins.csv file: $TMP_AUTHOR_WINS_CSV" 1>&2
fi


# form a 2nd YYYY_DIR inventory from author_wins.csv
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: sed .. $AUTHOR_WINS_CSV | LC_ALL=C sort -t/ -d | LC_ALL=C uniq > $TMP_2ND_YYYY_DIR_INV" 1>&2
fi
sed -e '/^#/d' -e 's/^[^,]*,//' -e 's/,/\n/g' -e 's/_/\//g' "$AUTHOR_WINS_CSV" |
  LC_ALL=C sort -t/ -d |
  LC_ALL=C uniq > "$TMP_2ND_YYYY_DIR_INV"
status_codes=("${PIPESTATUS[@]}")
if [[ ${status_codes[*]} =~ [1-9] ]]; then
   echo "$0: ERROR: sed .. $AUTHOR_WINS_CSV | LC_ALL=C sort -t/ -d > $TMP_2ND_YYYY_DIR_INV failed," \
        "error codes: ${status_codes[*]}" 1>&2
   exit 27
fi


# error if author_wins.csv and YYYY/dir tree are not identical
#
if ! cmp -s "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"; then

    # report author_wins.csv inventory problem
    #
    echo "$0: ERROR: The entries referenced in author_wins.csv: $AUTHOR_WINS_CSV do not match YYYY/dir tree" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and author_wins.csv entries starts below: $AUTHOR_WINS_CSV" 1>&2
    diff -u "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and author_wins.csv entries ends above" 1>&2
    exit 28

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: author_wins.csv entry inventory is correct" 1>&2
fi


# form a 2nd YYYY_DIR inventory from manifest.csv
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: sed .. $MANIFEST_CSV | LC_ALL=C sort -t/ -d | uniq > $TMP_2ND_YYYY_DIR_INV" 1>&2
fi
sed -e '/^#/d' -e 's/,/\//' -e 's/,.*//' "$MANIFEST_CSV" | LC_ALL=C sort -t/ -d | uniq > "$TMP_2ND_YYYY_DIR_INV"
status_codes=("${PIPESTATUS[@]}")
if [[ ${status_codes[*]} =~ [1-9] ]]; then
   echo "$0: ERROR: sed .. $MANIFEST_CSV | LC_ALL=C sort -t/ -d | uniq > $TMP_2ND_YYYY_DIR_INV failed," \
        "error codes: ${status_codes[*]}" 1>&2
   exit 29
fi


# error if manifest.csv and YYYY/dir tree are not identical
#
if ! cmp -s "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"; then

    # report manifest.csv inventory problem
    #
    echo "$0: ERROR: The entries referenced in manifest.csv $MANIFEST_CSV do not match YYYY/dir tree" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and manifest.csv entries starts below: $MANIFEST_CSV" 1>&2
    diff -u "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and manifest.csv entries ends above" 1>&2
    exit 30

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: manifest.csv.csv entry inventory is correct" 1>&2
fi


# form a 2nd YYYY_DIR inventory from year_prize.csv
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: sed .. $YEAR_PRIZE_CSV | LC_ALL=C sort -t/ -d > $TMP_2ND_YYYY_DIR_INV" 1>&2
fi
sed -e '/^#/d' -e 's/,.*//' -e 's/_/\//' "$YEAR_PRIZE_CSV" | LC_ALL=C sort -t/ -d > "$TMP_2ND_YYYY_DIR_INV"
status_codes=("${PIPESTATUS[@]}")
if [[ ${status_codes[*]} =~ [1-9] ]]; then
   echo "$0: ERROR: sed .. $YEAR_PRIZE_CSV | LC_ALL=C sort -t/ -d > $TMP_2ND_YYYY_DIR_INV failed," \
        "error codes: ${status_codes[*]}" 1>&2
   exit 31
fi


# error if manifest.csv and YYYY/dir tree are not identical
#
if ! cmp -s "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV"; then

    # report author_wins.csv inventory problem
    #
    echo "$0: ERROR: The entries referenced in year_prize.csv $YEAR_PRIZE_CSV do not match YYYY/dir tree" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and year_prize.csv entries starts below: $YEAR_PRIZE_CSV" 1>&2
    diff -u "$TMP_YEAR_PRIZE_CSV" "$YEAR_PRIZE_CSV" 1>&2
    echo "$0: Warning: difference between YYYY/dir tree and year_prize.csv entries ends above" 1>&2
    exit 32

elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: year_prize.csv entry inventory is correct" 1>&2
fi


# process lines in the canonicalized manifest.csv, writing entry .entry.json files as we go
#
export PREV_ENTRY_DIR=""
export PREV_ENTRY_ID=""
export PREV_ENTRY_JSON=""
export PREV_YEAR=""
export line=0
export file_number=0
sed -e '/^#/d' -e 's/,/ /g' "$MANIFEST_CSV" |
  while read -r YEAR DIR FILE_PATH INVENTORY_ORDER OK_TO_EDIT DISPLAY_AS DISPLAY_VIA_GITHUB ENTRY_TEXT; do

    # verify the ENTRY_DIR
    #
    ((++line))
    export ENTRY_DIR="$YEAR/$DIR"
    export ENTRY_ID="${YEAR}_${DIR}"
    export ENTRY_JSON="$ENTRY_DIR/$DOT_ENTRY_JSON_BASENAME"
    export YYYY_DIR="$YEAR/$DIR"
    if [[ ! -d $ENTRY_DIR ]]; then
	echo "$0: ERROR: manifest.csv: $MANIFEST_CSV line $line: not a directory: $ENTRY_DIR" 1>&2
	exit 7
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: line: $line" 1>&2
	echo "$0: debug[7]: YEAR: $YEAR" 1>&2
	echo "$0: debug[7]: DIR: $DIR" 1>&2
	echo "$0: debug[7]: FILE_PATH: $FILE_PATH" 1>&2
	echo "$0: debug[7]: INVENTORY_ORDER: $INVENTORY_ORDER" 1>&2
	echo "$0: debug[7]: OK_TO_EDIT: $OK_TO_EDIT" 1>&2
	echo "$0: debug[7]: DISPLAY_AS: $DISPLAY_AS" 1>&2
	echo "$0: debug[7]: DISPLAY_VIA_GITHUB: $DISPLAY_VIA_GITHUB" 1>&2
	echo "$0: debug[7]: ENTRY_TEXT: $ENTRY_TEXT" 1>&2
	echo "" 1>&2
	echo "$0: debug[7]: # ENTRY_DIR: $ENTRY_DIR" 1>&2
	echo "$0: debug[7]: # ENTRY_ID: $ENTRY_ID" 1>&2
	echo "$0: debug[7]: # ENTRY_JSON: $ENTRY_JSON" 1>&2
	echo "" 1>&2
	echo "$0: debug[7]: # YYYY_DIR: $YYYY_DIR" 1>&2
	echo "" 1>&2
	echo "$0: debug[7]: # PREV_ENTRY_DIR: $PREV_ENTRY_DIR" 1>&2
	echo "$0: debug[7]: # PREV_ENTRY_ID: $PREV_ENTRY_ID" 1>&2
	echo "$0: debug[7]: # PREV_YEAR: $PREV_YEAR" 1>&2
	echo "" 1>&2
    fi

    # firewall - verify we have the proper non-empty fields
    #
    if [[ -z $YEAR || -z $DIR || -z $FILE_PATH || -z $INVENTORY_ORDER || -z $OK_TO_EDIT ||
	  -z $DISPLAY_AS || -z $DISPLAY_VIA_GITHUB || -z $ENTRY_TEXT ]]; then
	echo "$0: ERROR: found empty field on line $line in manifest.csv: $MANIFEST_CSV" 1>&2
	exit 8
    fi

    # case: manifest.csv line refers to a new entry
    #
    if [[ $PREV_ENTRY_DIR != "$ENTRY_DIR" ]]; then

	# case: unless 1st line, complete the previous temporary .entry.json file
	#
	if [[ $line -gt 1 ]]; then

	    # write end of temporary .entry.json file
	    #
	    {
		printf "\n    ]\n"
		printf "}\n"
	    } >> "$TMP_ENTRY_JSON"

	    # verify JSON of temporary .entry.json file
	    #
	    if [[ $V_FLAG -ge 7 ]]; then
		echo "$0: debug[7]: about to run: $JPARSE_TOOL -q -- $TMP_ENTRY_JSON" 1>&2
	    fi
	    if "$JPARSE_TOOL" -q -- "$TMP_ENTRY_JSON"; then
		if [[ $V_FLAG -ge 9 ]]; then
		    echo "$0: debug[9]: valid JSON for $PREV_ENTRY_DIR: $TMP_ENTRY_JSON" 1>&2
		fi
	    else
		echo "$0: ERROR: .entry.json is not valid JSON for $PREV_ENTRY_DIR: $TMP_ENTRY_JSON" 1>&2
		exit 1
	    fi

	    # update entry .entry.json if different
	    #
	    if [[ -z $NOOP ]]; then
		if cmp -s "$TMP_ENTRY_JSON" "$PREV_ENTRY_JSON"; then

		    # case: .entry.json did not change
		    #
		    if [[ $V_FLAG -ge 5 ]]; then
			echo "$0: debug[5]: .entry.json file did not change: $PREV_ENTRY_JSON" 1>&2
		    fi

		else

		    # case: .entry.json file changed, update the file
		    #
		    if [[ $V_FLAG -ge 5 ]]; then
			echo "$0: debug[5]: about to: mv -f -- $TMP_ENTRY_JSON $PREV_ENTRY_JSON" 1>&2
		    fi
		    if [[ $V_FLAG -ge 3 ]]; then
			mv -f -v -- "$TMP_ENTRY_JSON" "$PREV_ENTRY_JSON"
			status="$?"
		    else
			mv -f -- "$TMP_ENTRY_JSON" "$PREV_ENTRY_JSON"
			status="$?"
		    fi
		    if [[ $status -ne 0 ]]; then
			echo "$0: ERROR: mv -f -- $TMP_ENTRY_JSON $PREV_ENTRY_JSON filed," \
			     "error code: $status" 1>&2
			exit 1
		    elif [[ $V_FLAG -ge 1 ]]; then
			echo "$0: debug[1]: replaced .entry.json file: $PREV_ENTRY_JSON" 1>&2
		    fi
		fi

	    elif [[ $V_FLAG -ge 3 ]]; then
	       echo "$0: debug[3]: because of -n, will not update $PREV_ENTRY_JSON"
	    fi
	fi

	# note if we are processing the start of a new year
	#
	if [[ $PREV_YEAR != "$YEAR" ]]; then
	    if [[ $V_FLAG -ge 1 ]]; then
		echo "$0: debug[1]: starting to process year: $YEAR" 1>&2
	    fi
	fi

	# this entry will become the next previous entry
	#
	PREV_ENTRY_DIR="$ENTRY_DIR"
	PREV_ENTRY_ID="$ENTRY_ID"
	PREV_ENTRY_JSON="$ENTRY_JSON"
	PREV_YEAR="$YEAR"

	# initialize first line of the temporary .entry.file
	#
	file_number=0
	rm -f "$TMP_ENTRY_JSON"
	if [[ -e $TMP_ENTRY_JSON ]]; then
	    echo "$0: ERROR: unable to remove temporary .entry.file: $TMP_ENTRY_JSON" 1>&2
	    exit 1
	fi
	echo "{" > "$TMP_ENTRY_JSON"
	if [[ ! -s $TMP_ENTRY_JSON ]]; then
	    echo "$0: ERROR: unable to write start of .entry.file: $TMP_ENTRY_JSON" 1>&2
	    exit 1
	fi

	# append top level lines to the temporary .entry.file
	#
	{
	    printf "    \"no_comment\" : \"%s\",\n" "$NO_COMMENT"
	    printf "    \"entry_JSON_format_version\" : \"%s\",\n" "$ENTRY_JSON_FORMAT_VERSION"
	} >> "$TMP_ENTRY_JSON"

	# determine the award for this entry
	#
	AWARD=$(grep "^$ENTRY_ID," "$YEAR_PRIZE_CSV" | sed -e 's/^[^,]*,//')
	if [[ -z $AWARD ]]; then
	    echo "$0: ERROR: cannot determine award for: $ENTRY_ID" 1>&2
	    exit 8
	fi

	# append the award, year and entry_id to the temporary .entry.file
	#
	{
	    printf "    \"award\" : \"%s\",\n" "$AWARD"
	    printf "    \"year\" : %s,\n" "$YEAR"
	    printf "    \"dir\" : \"%s\",\n" "$DIR"
	    printf "    \"entry_id\" : \"%s\",\n" "$ENTRY_ID"
	} >> "$TMP_ENTRY_JSON"

	# write the start of the author_set JSON array to the temporary .entry.file
	#
	printf "    \"author_set\" : [\n" >> "$TMP_ENTRY_JSON"

	# append the author JSON members to the temporary .entry.file
	#
	author_number=0
	grep -F "$ENTRY_ID" "$AUTHOR_WINS_CSV" |
	  grep -E ",$ENTRY_ID,|,$ENTRY_ID$" |
	  sed -e 's/,.*//g' |
	  while read -r AUTHOR_HANDLE; do

	    # case: not first author
	    #
	    ((++author_number))
	    if [[ $author_number -gt 1 ]]; then
		printf ",\n" >> "$TMP_ENTRY_JSON"
	    fi

	    # write start of author JSON member
	    #
	    printf "\t{ \"author_handle\" : \"%s\" }" "$AUTHOR_HANDLE" >> "$TMP_ENTRY_JSON"
	done
	#
	# For SC2129, we need to append two lines after the look, however shellcheck
	# is confused, perhaps because the string includes a } character.
	#
	# SC2129 (style): Consider using { cmd1; cmd2; } >> file instead of individual redirects.
	# https://www.shellcheck.net/wiki/SC2129
	# shellcheck disable=SC2129
	printf "\n    ],\n" >> "$TMP_ENTRY_JSON"

	# write the start of the manifest JSON array to the temporary .entry.file
	#
	printf "    \"manifest\" : [\n" >> "$TMP_ENTRY_JSON"

	# append the first manifest entry to the temporary .entry.file
	#
	{
	    printf "\t{\n"
	    printf "\t    \"file_path\" : \"%s\",\n" "$FILE_PATH"
	    printf "\t    \"inventory_order\" : %s,\n" "$INVENTORY_ORDER"
	    printf "\t    \"OK_to_edit\" : %s,\n" "$OK_TO_EDIT"
	    printf "\t    \"display_as\" : \"%s\",\n" "$DISPLAY_AS"
	    printf "\t    \"display_via_github\" : %s,\n" "$DISPLAY_VIA_GITHUB"
	    printf "\t    \"entry_text\" : \"%s\"\n" "$ENTRY_TEXT"
	    printf  "\t}"
	} >> "$TMP_ENTRY_JSON"

    # case: manifest.csv line continues with the same entry
    #
    else

	# close the first manifest entry to the temporary .entry.file
	# append the next manifest entry to the temporary .entry.file
	#
	{
	    printf ",\n"
	    printf "\t{\n"
	    printf "\t    \"file_path\" : \"%s\",\n" "$FILE_PATH"
	    printf "\t    \"inventory_order\" : %s,\n" "$INVENTORY_ORDER"
	    printf "\t    \"OK_to_edit\" : %s,\n" "$OK_TO_EDIT"
	    printf "\t    \"display_as\" : \"%s\",\n" "$DISPLAY_AS"
	    printf "\t    \"display_via_github\" : %s,\n" "$DISPLAY_VIA_GITHUB"
	    printf "\t    \"entry_text\" : \"%s\"\n" "$ENTRY_TEXT"
	    printf  "\t}"
	} >> "$TMP_ENTRY_JSON"
    fi
done


# XXX - update `author/author_handle.json` files as needed based on canonicalized author_wins.csv data - XXX #


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
EXIT_CODE=$(< "$TMP_EXIT_CODE")
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit non-zero: $EXIT_CODE" 1>&2
elif [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to exit $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
