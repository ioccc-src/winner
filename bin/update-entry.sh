#!/usr/bin/env bash
#
# update-entry.sh - update a converted entry with new files
#
# Given a submission or entry that had been processed by the
# bin/cvt-submission tool (i.e., has a `.entry.json` file,
# and **NO** `.info.json`, **NOR** `.entry.json` files),
# add "git listed files that are not already in the
# manifest of the  `.entry.json` file.
#
# By a "git listed" file, we mean that the file has been
# "git add"-ed, although not necessarily "git commit"-ed to the repo.
# I.e., files listed by the command "git ls-files YYYY/dir" that
# aren't already in the  `.entry.json` manifest will be added.
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
export VERSION="2.0.1 2026-04-30"
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
export MIN_JSTRDECODE_VERSION="2.2.3"
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
JPARSE_TOOL=$(type -P jparse)
export JPARSE_TOOL
if [[ -z "$JPARSE_TOOL" ]]; then
    echo "$0: FATAL: jparse tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: to install jparse:" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
export MIN_JPARSE_VERSION="2.0.3"
JPARSE_VERSION=$("$JPARSE_TOOL" -V | head -1 | awk '{print $3;}')
if ! "$VERGE" "$JPARSE_VERSION" "$MIN_JPARSE_VERSION"; then
    echo "$0: FATAL: jparse version: $JPARSE_VERSION < minimum version: $MIN_JPARSE_VERSION" 1>&2
    echo "$0: notice: consider updating jparse from mkiocccentry repo" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
#
export CHECK_ONLY=
export NOOP=
export DO_NOT_PROCESS=
#
export VALUE=


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-i input_data] [-c] [-n] [-N] YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-i input_data	read data from file and disable asking if correct (def: from stdin)

	-c		report on any manifest and git ls-files differences only (def: process differences)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	YYYY/dir	path from topdir to entry directory

Exit codes:
     0         all OK
     1	       invalid user input, or consistency check (-c) failed
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       invalid or missing .entry.json file, invalid manifest in .entry.json file
 >= 10         internal error

$NAME version: $VERSION"


# prompt_string
#
# Prompt the user for a string and output as a decoded JSON string.
#
# If "-i input_data: is used, the printing of the prompt is disabled,
# and the query of correctness is also disabled.
#
# usage:
#       prompt_string item_name
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function prompt_string
{
    local INPUT;		# user input
    local DECODED;		# INPUT decoded as JSON string
    local Y_OR_N;		# y or n
    local ITEM_NAME;		# name of the item being prompted for

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in prompt_string: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ITEM_NAME="$1"
    if [[ -z $ITEM_NAME ]]; then
        echo "$0: ERROR: in prompt_string: 1st arg is empty" 1>&2
	return 2
    fi

    # obtain the string
    #
    while :; do

	# prompt for value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo -n "Enter $ITEM_NAME: "
	fi
	read -r INPUT
	if [[ -z "$INPUT" ]]; then
	    echo "$0: Warning: in prompt_string: $ITEM_NAME cannot be empty, try again" 1>&2
	    echo 1>&2
	    continue
	fi

	# JSON decode value
	#
	DECODED=$("$JSTRDECODE" -d -q -N -- "$INPUT")
	status="$?"
	if [[ $status -ne 0 || -z $DECODED ]]; then
	    echo "$0: ERROR: in prompt_string: $JSTRDECODE -d -q -N -- $INPUT failed," \
		 "error code: $status" 1>&2
	    exit 1
	fi

	# verify JSON decoded value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo
	    echo "Verify decoded $ITEM_NAME: $DECODED" 1>&2
	    echo
	    echo -n 'Is that correct? [Y,n]: '
	    read -r Y_OR_N
	    if [[ -z $Y_OR_N || $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
		break
	    fi
	    echo
	else
	    break
	fi
    done
    if [[ -z $INPUT_DATA_FILE ]]; then
	echo
    fi

    # set VALUE to the JSON decoded string
    #
    VALUE="$DECODED"
    return 0
}


# prompt_word
#
# Prompt the user for a lower case word and output as a decoded JSON word.
#
# The input must start work a lower case letter followed by 0 or more
# local case letters or digits:
#
#   ^[a-z][0-9a-z]*$
#
# If "-i input_data: is used, the printing of the prompt is disabled,
# and the query of correctness is also disabled.
#
# usage:
#       prompt_word item_name
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function prompt_word
{
    local INPUT;		# user input
    local DECODED;		# INPUT decoded as JSON string
    local Y_OR_N;		# y or n
    local ITEM_NAME;		# name of the item being prompted for

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in prompt_word: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ITEM_NAME="$1"
    if [[ -z $ITEM_NAME ]]; then
        echo "$0: ERROR: in prompt_word: 1st arg is empty" 1>&2
	return 2
    fi

    # obtain the lower case word
    #
    while :; do

	# prompt for value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo -n "Enter $ITEM_NAME: "
	fi
	read -r INPUT
	if [[ -z "$INPUT" ]]; then
	    echo "$0: Warning: in prompt_word: $ITEM_NAME cannot be empty, try again" 1>&2
	    echo 1>&2
	    continue
	fi

	# must start with lower case lewtter and followed bu 0 or more lower case letters and digits
	#
	if ! [[ $INPUT =~ ^[a-z][0-9a-z]*$ ]]; then
	    echo "$0: Warning: in prompt_word: $ITEM_NAME must match "'^[a-z][0-9a-z]*$'" regex, try again" 1>&2
	    echo 1>&2
	    continue
	fi

	# JSON decode value
	#
	DECODED=$("$JSTRDECODE" -d -q -N -- "$INPUT")
	status="$?"
	if [[ $status -ne 0 || -z $DECODED ]]; then
	    echo "$0: ERROR: in prompt_word: $JSTRDECODE -d -q -N -- $INPUT failed," \
		 "error code: $status" 1>&2
	    exit 1
	fi

	# verify JSON decoded value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo
	    echo "Verify decoded $ITEM_NAME: $DECODED" 1>&2
	    echo
	    echo -n 'Is that correct? [Y,n]: '
	    read -r Y_OR_N
	    if [[ -z $Y_OR_N || $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
		break
	    fi
	    echo
	else
	    break
	fi
    done
    if [[ -z $INPUT_DATA_FILE ]]; then
	echo
    fi

    # set VALUE to the JSON decoded string
    #
    VALUE="$DECODED"
    return 0
}


# prompt_integer
#
# Prompt the user for an integer and output as a decoded JSON string.
#
# If "-i input_data: is used, the printing of the prompt is disabled,
# and the query of correctness is also disabled.
#
# usage:
#       prompt_integer item_name
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function prompt_integer
{
    local INPUT;		# user input
    local DECODED;		# INPUT decoded as JSON string
    local Y_OR_N;		# y or n
    local ITEM_NAME;		# name of the item being prompted for

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in prompt_integer: expected 1 arg, found $#" 1>&2
        return 1
    fi
    ITEM_NAME="$1"
    if [[ -z $ITEM_NAME ]]; then
        echo "$0: ERROR: in prompt_integer: 1st arg is empty" 1>&2
	return 2
    fi

    # obtain the integer
    #
    while :; do

	# prompt for value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo -n "Enter $ITEM_NAME: "
	fi
	read -r INPUT
	if [[ -z "$INPUT" ]]; then
	    echo "$0: Warning: in prompt_integer: $ITEM_NAME cannot be empty, try again" 1>&2
	    echo 1>&2
	    continue
	fi
	if [[ $INPUT =~ ^[[:digit:]]+$ && $INPUT -ge 0 && $INPUT -le 4294967295 ]]; then
	    # JSON decode value
	    #
	    DECODED=$("$JSTRDECODE" -d -q -N -- "$INPUT")
	    status="$?"
	    if [[ $status -ne 0 || -z $DECODED ]]; then
		echo "$0: ERROR: in prompt_integer: $JSTRDECODE -d -q -N -- $INPUT failed," \
		     "error code: $status" 1>&2
		exit 1
	    fi
	else
	    echo "$0: Warning: in prompt_integer: $ITEM_NAME must be an integer >= 0 and <= 4294967295, try again" 1>&2
	    echo 1>&2
	    continue
	fi

	# verify JSON decoded value
	#
	if [[ -z $INPUT_DATA_FILE ]]; then
	    echo
	    echo "Verify decoded $ITEM_NAME: $DECODED" 1>&2
	    echo
	    echo -n 'Is that correct? [Y,n]: '
	    read -r Y_OR_N
	    if [[ -z $Y_OR_N || $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
		break
	    fi
	    echo
	else
	    break
	fi
    done
    if [[ -z $INPUT_DATA_FILE ]]; then
	echo
    fi

    # set VALUE to the JSON decoded string
    #
    VALUE="$DECODED"
    return 0
}


# manifest_entry
#
# Write a manifest entry in JSON form to stdout.
#
# usage:
#       manifest_entry file_path inventory_order OK_to_edit display_as display_via_github entry_text comma
#
#   file_path	        path to the file relative to the entry directory
#   inventory_order     inventory order as displayed in the entry index.html file
#   OK_to_edit		boolean for if file should be modified, edited, replaced, or even removed
#   display_as	        kind of file it is and in particular how to display it
#   display_via_github	boolean indicates whether the file should be viewed via GitHub or not
#   entry_text		summary of what the file purpose is
#   comma		"comma" ==> print comma after array element
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function manifest_entry
{
    local FILE_PATH;		# path to the file relative to the entry directory
    local INVENTORY_ORDER;	# inventory order as displayed in the entry index.html file
    local OK_TO_EDIT;		# boolean for if file should be modified, edited, replaced, or even removed
    local DISPLAY_AS;		# kind of file it is and in particular how to display it
    local DISPLAY_VIA_GITHUB;	# boolean indicates whether the file should be viewed via GitHub or not
    local ENTRY_TEXT;		# summary of what the file purpose is
    local COMMA;		# true ==> print comma after array element

    # parse args
    #
    if [[ $# -ne 7 ]]; then
        echo "$0: ERROR: in manifest_entry: expected 7 args, found $#" 1>&2
        return 1
    fi
    FILE_PATH="${1///%%COMMA%%/,}"
    if [[ -z $FILE_PATH ]]; then
        echo "$0: ERROR: in manifest_entry: file_path arg 1 is empty" 1>&2
	return 2
    fi
    INVENTORY_ORDER="${2///%%COMMA%%/,}"
    if [[ -z $INVENTORY_ORDER ]]; then
        echo "$0: ERROR: in manifest_entry: inventory_order arg 2 is empty" 1>&2
	return 3
    fi
    OK_TO_EDIT="${3///%%COMMA%%/,}"
    if [[ -z $OK_TO_EDIT ]]; then
        echo "$0: ERROR: in manifest_entry: OK_to_edit arg 3 is empty" 1>&2
	return 4
    fi
    DISPLAY_AS="${4///%%COMMA%%/,}"
    if [[ -z $DISPLAY_AS ]]; then
        echo "$0: ERROR: in manifest_entry: display_as arg 4 is empty" 1>&2
	return 5
    fi
    DISPLAY_VIA_GITHUB="${5///%%COMMA%%/,}"
    if [[ -z $DISPLAY_VIA_GITHUB ]]; then
        echo "$0: ERROR: in manifest_entry: display_via_github arg 5 is empty" 1>&2
	return 6
    fi
    ENTRY_TEXT="${6///%%COMMA%%/,}"
    if [[ -z $ENTRY_TEXT ]]; then
        echo "$0: ERROR: in manifest_entry: entry_text arg 6 is empty" 1>&2
	return 7
    fi
    COMMA="$7"

    # start of manifest entry
    #
    printf "        {\n"

    # output file_path
    #
    printf "            \"file_path\" : \"%s\",\n" "$FILE_PATH"

    # output inventory_order
    #
    printf "            \"inventory_order\" : %s,\n" "$INVENTORY_ORDER"

    # output OK_to_edit
    #
    printf "            \"OK_to_edit\" : %s,\n" "$OK_TO_EDIT"

    # output display_as
    #
    printf "            \"display_as\" : \"%s\",\n" "$DISPLAY_AS"

    # output display_via_github
    #
    printf "            \"display_via_github\" : %s,\n" "$DISPLAY_VIA_GITHUB"

    # output entry_text
    #
    printf "            \"entry_text\" : \"%s\"\n" "$ENTRY_TEXT"

    # end of manifest entry
    #
    # We do not issue a return, allowing either the next manifest entry or
    # the end of the manifest array to close the array.
    #
    if [[ $COMMA == "comma" ]]; then
	printf "        },\n"
    else
	printf "        }\n"
    fi
    return 0
}


# array_eq
#
# Test if two bash arrays are identical
#
# usage:
#       array_eq arr1 arr2
#
# returns:
#       0 ==> both arrays are identical
#       1 ==> arrays differ
#     > 1 ==> error
#
function array_eq
{
    local -n arr1=$1	# Nameref (Bash 4.3+) to pass arrays by reference
    local -n arr2=$2	# Nameref (Bash 4.3+) to pass arrays by reference

    # parse args
    #
    if [[ $# -ne 2 ]]; then
        echo "$0: ERROR: in array_eq: expected 2 arg2, found $#" 1>&2
        return 2
    fi

    # case: different lengths - arrays must differ
    #
    if [[ ${#arr1[@]} -ne ${#arr2[@]} ]]; then
	return 1
    fi

    # scan arrays for a different element
    #
    for i in "${!arr1[@]}"; do
	if [[ "${arr1[$i]}" != "${arr2[$i]}" ]]; then
	    return 1  # Elements differ at index $i
	fi
    done
    return 0	# identical
}


# parse command line
#
while getopts :hv:Vd:i:cnN flag; do
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
    i) INPUT_DATA_FILE="$OPTARG"
	;;
    c) CHECK_ONLY="true"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
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
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: expected 1 arg, found: $#" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
export ENTRY_PATH="$1"


# set umask to avoid group writable files
#
umask 0022


# if -i input_data, replace stdin with the input data file
#
if [[ -n $INPUT_DATA_FILE ]]; then
    if [[ ! -e $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data file does not exist: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -f $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not a regular file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -r $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not a readable file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    if [[ ! -s $INPUT_DATA_FILE ]]; then
	echo  "$0: ERROR: input data filetop is not a non-empty readable file: $INPUT_DATA_FILE" 1>&2
	exit 3
    fi
    exec 0<"$INPUT_DATA_FILE"
fi


# verify that we have a bin subdirectory
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


# verify that the bin/jval-wrapper.sh tool is executable
#
export JVAL_WRAPPER="$BIN_DIR/jval-wrapper.sh"
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
# Now that we have moved to topdir, form and verify YYYY_DIR is a writable directory
export YYYY_DIR="$YEAR_DIR/$ENTRY_DIR"
if [[ ! -e $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH does not exist: $YYYY_DIR" 1>&2
    exit 6
fi
if [[ ! -d $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a directory: $YYYY_DIR" 1>&2
    exit 6
fi
if [[ ! -w $YYYY_DIR ]]; then
    echo "$0: ERROR: YYYY/dir from arg: $ENTRY_PATH is not a writable directory: $YYYY_DIR" 1>&2
    exit 6
fi


# determine files that are found in and/or will be created in an entry
#
export ENTRY_JSON="$YYYY_DIR/.entry.json"


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
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
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: VERGE=$VERGE" 1>&2
    echo "$0: debug[3]: JSTRDECODE=$JSTRDECODE" 1>&2
    echo "$0: debug[3]: MIN_JSTRDECODE_VERSION=$MIN_JSTRDECODE_VERSION" 1>&2
    echo "$0: debug[3]: JSTRDECODE_VERSION=$JSTRDECODE_VERSION" 1>&2
    echo "$0: debug[3]: JPARSE_TOOL=$JPARSE_TOOL" 1>&2
    echo "$0: debug[3]: MIN_JPARSE_VERSION=$MIN_JPARSE_VERSION" 1>&2
    echo "$0: debug[3]: JPARSE_VERSION=$JPARSE_VERSION" 1>&2
    echo "$0: debug[3]: INPUT_DATA_FILE=$INPUT_DATA_FILE" 1>&2
    echo "$0: debug[3]: CHECK_ONLY=$CHECK_ONLY" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: VALUE=$VALUE" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: FILELIST_ENTRY_JSON_AWK=$FILELIST_ENTRY_JSON_AWK" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
fi


# verify .entry.json is readable non-empty files
#
if [[ ! -e $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .ientry.json does not exist: $ENTRY_JSON" 1>&2
    exit 6
fi
if [[ ! -f $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a regular file: $ENTRY_JSON" 1>&2
    exit 6
fi
if [[ ! -r $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a readable file: $ENTRY_JSON" 1>&2
    exit 6
fi
if [[ ! -s $ENTRY_JSON ]]; then
    echo  "$0: ERROR: .entry.json is not a non-empty readable file: $ENTRY_JSON" 1>&2
    exit 6
fi


# verify that .entry.json is valid JSON
#
"$JPARSE_TOOL" -q -- "$ENTRY_JSON" 1>&2
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: $JPARSE_TOOL -q -- $ENTRY_JSON filed," \
	 "error code: $status" 1>&2
    exit 6
fi


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


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# obtain a dictionary sorted file_path strings from the manifest in the .entry.json file
#
unset MANIFEST
MANIFEST=()
readarray -t MANIFEST < <(awk -v print_relative=true -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" | LC_ALL=C sort -d)
if [[ ${#MANIFEST[@]} -le 0 ]]; then
    echo "$0: ERROR: empty manifest for: $ENTRY_JSON" 1>&2
    exit 7
fi
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: manifest path list starts below for: $ENTRY_JSON" 1>&2
    printf "%s\n" "${MANIFEST[@]}"
    echo "$0: debug[5]: manifest path list ends above for: $ENTRY_JSON" 1>&2
fi


# verify that we have no duplicates in the manifest in the .entry.json file
#
unset COUNT_MANIFEST
declare -A COUNT_MANIFEST
unset DUP_MANIFEST
DUP_MANIFEST=()
for elem in "${MANIFEST[@]}"; do
    ((COUNT_MANIFEST["$elem"]++))  # Increment count for each element
    if [[ ${COUNT_MANIFEST["$elem"]} -gt 1 ]]; then
	DUP_MANIFEST+=("$elem")
    fi
done
#
if [[ ${#DUP_MANIFEST[@]} -gt 0 ]]; then
    echo "$0: ERROR: duplicate manifest list starts below for: $ENTRY_JSON" 1>&2
    printf "%s\n" "${DUP_MANIFEST[@]}"
    echo "$0: ERROR: duplicate manifest list ends above for: $ENTRY_JSON" 1>&2
    exit 7
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: no manifest duplicates found for: $ENTRY_JSON" 1>&2
fi


# obtain a dictionary sorted list of files under YYYY_DIR under git control
#
unset FILE_LIST
FILE_LIST=()
readarray -t FILE_LIST < <(cd "$YYYY_DIR" || exit 10 ; "$GIT_TOOL" ls-files . | LC_ALL=C sort -d)
if [[ ${#FILE_LIST[@]} -le 0 ]]; then
    echo "$0: ERROR: no files under git for: $YYYY_DIR" 1>&2
    exit 6
fi
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: git ls-files list starts below for $ENTRY_JSON" 1>&2
    printf "%s\n" "${FILE_LIST[@]}"
    echo "$0: debug[5]: git ls-files list ends above for $ENTRY_JSON" 1>&2
fi


# firewall - verify that we have no duplicates in the files under YYYY_DIR under git control
#
# A duplicate for files under YYYY_DIR under git control should never happen unless
# there is something seriously wrong with the repo.
#
unset COUNT_FILE_LIST
declare -A COUNT_FILE_LIST
unset DUP_FILE_LIST
DUP_FILE_LIST=()
for elem in "${FILE_LIST[@]}"; do
    ((COUNT_FILE_LIST["$elem"]++))  # Increment count for each element
    if [[ ${COUNT_FILE_LIST["$elem"]} -gt 1 ]]; then
	DUP_FILE_LIST+=("$elem")
    fi
done
#
if [[ ${#DUP_FILE_LIST[@]} -gt 0 ]]; then
    echo "$0: ERROR: duplicate git ls-files list starts below for: $ENTRY_JSON" 1>&2
    printf "%s\n" "${DUP_FILE_LIST[@]}"
    echo "$0: ERROR: duplicate git ls-files list ends above for: $ENTRY_JSON" 1>&2
    exit 11
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: no git ls-files duplicates found for: $ENTRY_JSON" 1>&2
fi


# build associative arrays for both MANIFEST and FILE_LIST
#
unset ASSOC_MANIFEST
declare -A ASSOC_MANIFEST
for elem in "${MANIFEST[@]}"; do
  ASSOC_MANIFEST["$elem"]="$elem"   # Value is irrelevant (we just need keys)
done
#
unset ASSOC_FILE_LIST
declare -A ASSOC_FILE_LIST
for elem in "${FILE_LIST[@]}"; do
  ASSOC_FILE_LIST["$elem"]="$elem"  # Value is irrelevant (we just need keys)
done


# firewall - look for manifest files not under git control
#
unset GIT_NON_MANIFEST
GIT_NON_MANIFEST=()
for elem in "${MANIFEST[@]}"; do
    if [[ ! -v ASSOC_FILE_LIST["$elem"] ]]; then  # -v checks if key exists
	GIT_NON_MANIFEST+=("$elem")
    fi
done
#
if [[ ${#GIT_NON_MANIFEST[@]} -gt 0 ]]; then
    echo "$0: ERROR: manifest files not under git control starts below for: $ENTRY_JSON" 1>&2
    printf "%s\n" "${GIT_NON_MANIFEST[@]}"
    echo "$0: ERROR: manifest files not under git control ends above for: $ENTRY_JSON" 1>&2
    echo "$0: notice: correct manifest and/or git control for: $ENTRY_JSON" 1>&2
    exit 7
fi


# case: manifest and files under git control for identical for YYYY_DIR
#
if array_eq MANIFEST FILE_LIST; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo  "$0: debug[3]: manifest and git ls-files lists are identical" 1>&2
    fi
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: manifest is up to date for: $YYYY_DIR" 1>&2
    fi
    exit 0
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: manifest needs updating for: $YYYY_DIR" 1>&2
fi


# report on files under git control that are missing from the manifest
#
unset GIT_NON_MANIFEST
GIT_NON_MANIFEST=()
unset GIT_NON_MANIFEST_PATH
GIT_NON_MANIFEST_PATH=()
for elem in "${FILE_LIST[@]}"; do
    if [[ ! -v ASSOC_MANIFEST["$elem"] ]]; then  # -v checks if key exists
	GIT_NON_MANIFEST+=("$elem")
	GIT_NON_MANIFEST_PATH+=("$YYYY_DIR/$elem")
    fi
done
#
if [[ ${#GIT_NON_MANIFEST[@]} -gt 0 ]]; then
    echo "$0: Warning: files git control that are missing from the manifest starts below for: $ENTRY_JSON" 1>&2
    printf "%s\n" "${GIT_NON_MANIFEST_PATH[@]}"
    echo "$0: Warning: files git control that are missing from the manifest ends above for: $ENTRY_JSON" 1>&2
    if [[ -n $CHECK_ONLY ]]; then
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: -c used and manifest check failed for: $ENTRY_JSON" 1>&2
	fi
	exit 1
    fi
fi


# build associative arrays for GIT_NON_MANIFEST
#
unset ASSOC_GIT_NON_MANIFEST
declare -A ASSOC_GIT_NON_MANIFEST
for elem in "${GIT_NON_MANIFEST[@]}"; do
  ASSOC_GIT_NON_MANIFEST["$elem"]="$elem"   # Value is irrelevant (we just need keys)
done


# report markdown files missing from the manifest without an corresponding html file in the manifest or under git control
#
for elem in "${GIT_NON_MANIFEST[@]}"; do
    if [[ $elem =~ (.*)\.md$ ]]; then
	HTML_FILE=${elem//.md/.html}
	if [[ ! -v ASSOC_MANIFEST["$HTML_FILE"] &&
	      ! -v ASSOC_FILE_LIST["$HTML_FILE"] &&
	      ! -v ASSOC_GIT_NON_MANIFEST["$HTML_FILE"] ]]; then  # -v checks if key exists
	    echo "$0: Warning: found new markdown file: $elem without an HTML file: $HTML_FILE" 1>&2
	    if [[ -n $CHECK_ONLY ]]; then
		if [[ $V_FLAG -ge 3 ]]; then
		    echo "$0: debug[3]: -c used and manifest check failed for: $ENTRY_JSON" 1>&2
		fi
		exit 1
	    fi
	fi
    fi
done
if [[ -n $CHECK_ONLY ]]; then
    exit 0
fi


# create a temporary .entry.json file
#
export TMP_ENTRY_JSON=".tmp.$NAME.ENTRY_JSON.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_ENTRY_JSON; exit' 0 1 2 3 15
    rm -f "$TMP_ENTRY_JSON"
    if [[ -e $TMP_ENTRY_JSON ]]; then
	echo "$0: ERROR: cannot remove temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
	exit 12
    fi
    :> "$TMP_ENTRY_JSON"
    if [[ ! -e $TMP_ENTRY_JSON ]]; then
	echo "$0: ERROR: cannot create temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, temporary .entry.json file is not used: $TMP_ENTRY_JSON" 1>&2
fi


# load the temporary .entry.json file with all lines up until the end of the JSON manifest array
#
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: loading lines up until the end of the JSON manifest array into: $TMP_ENTRY_JSON" 1>&2
fi
awk -v print_until=true -f "$FILELIST_ENTRY_JSON_AWK" "$ENTRY_JSON" > "$TMP_ENTRY_JSON"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: awk -v print_until=true -f $FILELIST_ENTRY_JSON_AWK $ENTRY_JSON > $TMP_ENTRY_JSON failed," \
	 "error code: $status" 1>&2
    exit 14
fi
printf "        },\n" >> "$TMP_ENTRY_JSON"


# ####################################################################################### #
#                                                                                         #
# SYNC: The effect of the following code block that assigns $DISPLAY_VIA_GITHUB based on  #
#       the value of $FILE_PATH or $DISPLAY_AS must be synced with equivalent code blocks #
#       from the following (look for this comment block:                                  #
#                                                                                         #
#           bin/bad-display-as.sh                                                         #
#           bin/cvt-submission.sh                                                         #
#           bin/update-entry.sh                                                           #
#                                                                                         #
# ####################################################################################### #

# process each file under git control that is missing from the manifest
#
export COUNT=0
for elem in "${GIT_NON_MANIFEST[@]}"; do

    # set path to the file relative to the entry directory
    #
    FILE_PATH="$elem"

    # case: special prog.c
    #
    if [[ $FILE_PATH == "prog.c" ]]; then
	INVENTORY_ORDER="20"
	OK_TO_EDIT="true"
	DISPLAY_AS="c"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="entry source code"

    # case: special Makefile
    #
    elif [[ $FILE_PATH == "Makefile" ]]; then
	INVENTORY_ORDER="30"
	OK_TO_EDIT="true"
	DISPLAY_AS="makefile"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="entry Makefile"

    # case: special prog.alt.c
    #
    elif [[ $FILE_PATH == "prog.alt.c" ]]; then
	INVENTORY_ORDER="40"
	OK_TO_EDIT="true"
	DISPLAY_AS="c"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="alternate source code"

    # case: special prog.orig.c
    #
    elif [[ $FILE_PATH == "prog.orig.c" ]]; then
	INVENTORY_ORDER="50"
	OK_TO_EDIT="false"
	DISPLAY_AS="c"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="original source code"

    # case: special try.sh
    #
    elif [[ $FILE_PATH == "try.sh" ]]; then
	INVENTORY_ORDER="100"
	OK_TO_EDIT="true"
	DISPLAY_AS="shellscript"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="script to try entry"

    # case: special try.alt.sh
    #
    elif [[ $FILE_PATH == "try.alt.sh" ]]; then
	INVENTORY_ORDER="100"
	OK_TO_EDIT="true"
	DISPLAY_AS="shellscript"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="script to try alternate code"

    # case: compressed tarball
    #
    elif [[ $FILE_PATH =~ (.*)\.tar.bz2$ ]]; then
	INVENTORY_ORDER="1415926535"
	OK_TO_EDIT="false"
	DISPLAY_AS="tbz2"
	DISPLAY_VIA_GITHUB="false"
	ENTRY_TEXT="download entry tarball"

    # case: .entry.json
    #
    elif [[ $FILE_PATH == ".entry.json" ]]; then
	INVENTORY_ORDER="4000000000"
	OK_TO_EDIT="true"
	DISPLAY_AS="json"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="entry summary and manifest in JSON"

    # case: .gitignore
    #
    elif [[ $FILE_PATH == ".gitignore" ]]; then
	INVENTORY_ORDER="4000000000"
	OK_TO_EDIT="true"
	DISPLAY_AS="gitignore"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="list of files that should not be committed under git"

    # case: .path
    #
    elif [[ $FILE_PATH == ".path" ]]; then
	INVENTORY_ORDER="4000000000"
	OK_TO_EDIT="false"
	DISPLAY_AS="path"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="directory path from top level directory"

    # case: README.md
    #
    elif [[ $FILE_PATH == "README.md" ]]; then
	INVENTORY_ORDER="4000000000"
	OK_TO_EDIT="true"
	DISPLAY_AS="markdown"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="markdown source for this web page"

    # case: index.html
    #
    elif [[ $FILE_PATH == "index.html" ]]; then
	INVENTORY_ORDER="4294967295"
	OK_TO_EDIT="false"
	DISPLAY_AS="html"
	DISPLAY_VIA_GITHUB="false"
	ENTRY_TEXT="this web page"

    # case: special markdown files
    #
    elif [[ $FILE_PATH =~ (.*)\.md$ ]]; then
	HTML_FILE_BASENAME=$(basename "$FILE_PATH")
	INVENTORY_ORDER="4000000000"
	OK_TO_EDIT="true"
	DISPLAY_AS="markdown"
	DISPLAY_VIA_GITHUB="true"
	ENTRY_TEXT="markdown source for $HTML_FILE_BASENAME"

    # case: html files associated with markdown files
    #
    elif [[ $FILE_PATH =~ (.*)\.html$ && -f ${FILE_PATH//.html/.md} ]]; then
	HTML_PATH=${FILE_PATH//.html/.md}
	HTML_FILE_BASENAME=$(basename "$HTML_PATH")
	INVENTORY_ORDER="100"
	OK_TO_EDIT="false"
	DISPLAY_AS="html"
	DISPLAY_VIA_GITHUB="false"
	ENTRY_TEXT="entry_text for $HTML_FILE_BASENAME"

    # case: extra files
    #
    else

	# prompt for inventory_order
	#
	VALUE=
	prompt_integer "inventory_order for $FILE_PATH"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_integer inventory_order for $FILE_PATH failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	INVENTORY_ORDER="$VALUE"

	# assume OK to edit
	#
	OK_TO_EDIT="true"

	# prompt for display_as
	#
	VALUE=
	prompt_word "display_as for $FILE_PATH"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_word display_as for $FILE_PATH failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	DISPLAY_AS="$VALUE"

	# assume display via GitHub
	#
	DISPLAY_VIA_GITHUB="true"

	# prompt for entry_text
	#
	VALUE=
	prompt_string "entry_text for $FILE_PATH"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_string entry_text for $FILE_PATH failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	ENTRY_TEXT="$VALUE"
    fi

    # Force dot-files to display via GitHub repo file ("display_via_github" : true),
    # regardless of "display_as" value because GitHub will not allow a dot-file to
    # be displayed on the rendered website.
    #
    if [[ $FILE_PATH =~ ^[.] ]]; then
	DISPLAY_VIA_GITHUB="true"

    else

	# use known "display_as" type to determine if
	#
	#	"display_via_github" : true
	#
	#	    Force the inventory file to be displayed as a GitHub repo file
	#
	#	"display_via_github" : false
	#
	#	    Let the browser fetch the file via the www.isthe.com web site,
	#	    or the browser to cause the file to be downloaded
	#
	case "$DISPLAY_AS" in

	# case: "display_via_github" : false
	#
	# browser fetch the file via www.isthe.com, or cause the browser to download
	#
	binary)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	bz2)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	bzip2)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	gzip)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	html)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	image)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	kernel)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	midi)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	mp3)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	pdf)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	rgb)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	spreadsheet)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	tarball)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	tbz2)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	wav)
	    DISPLAY_VIA_GITHUB="false"
	    ;;
	zip)
	    DISPLAY_VIA_GITHUB="false"
	    ;;

	# case: "display_via_github" : true
	#
	# display inventory contents via a GitHub repo file
	#
	*)
	    DISPLAY_VIA_GITHUB="true"
	    ;;
	esac
    fi

    # determine if we are on the final member
    #
    ((COUNT++))
    if [[ $COUNT -eq ${#GIT_NON_MANIFEST[@]} ]]; then
	COMMA=""
    else
	COMMA="comma"
    fi

    # append the new manifest
    #
    if [[ -z $NOOP ]]; then
	manifest_entry "$FILE_PATH" "$INVENTORY_ORDER" "$OK_TO_EDIT" "$DISPLAY_AS" \
		       "$DISPLAY_VIA_GITHUB" "$ENTRY_TEXT" "$COMMA" >> "$TMP_ENTRY_JSON"

	# close the JSON if are on the final member
	#
	if [[ $COUNT -eq ${#GIT_NON_MANIFEST[@]} ]]; then
	    printf "    ]\n}\n" >> "$TMP_ENTRY_JSON"
	fi
    fi
done


# validate the JSON in the temporary .entry.json file
#
if [[ -z $NOOP ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to: $JPARSE_TOOL -q -- $TMP_ENTRY_JSON" 1>&2
    fi
    "$JPARSE_TOOL" -q -- "$TMP_ENTRY_JSON" 1>&2
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JPARSE_TOOL -q -- $TMP_ENTRY_JSON filed," \
	     "error code: $status" 1>&2
	exit 15
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: valid JSON: $TMP_ENTRY_JSON" 1>&2
    fi


    # update .entry.json if needed
    #
    if cmp -s "$TMP_ENTRY_JSON" "$ENTRY_JSON"; then

	# case: .entry.json did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: .entry.json file did not change: $ENTRY_JSON" 1>&2
	fi

    else

	# case: .entry.json file changed, update the file
	#
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: about to: mv -f -- $TMP_ENTRY_JSON $ENTRY_JSON" 1>&2
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    mv -f -v -- "$TMP_ENTRY_JSON" "$ENTRY_JSON" 1>&2
	    status="$?"
	else
	    mv -f -- "$TMP_ENTRY_JSON" "$ENTRY_JSON" 1>&2
	    status="$?"
	fi
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mv -f -- $TMP_ENTRY_JSON $ENTRY_JSON filed," \
		 "error code: $status" 1>&2
	    exit 16
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: updated .entry.json: $ENTRY_JSON" 1>&2
	fi
	if [[ ! -s $ENTRY_JSON ]]; then
	    echo "$0: ERROR: not a non-empty .entry.json: $ENTRY_JSON" 1>&2
	    exit 17
	fi
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, .entry.json file is updated: $ENTRY_JSON" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
