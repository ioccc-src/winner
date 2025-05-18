#!/usr/bin/env bash
#
# cvt-submission.sh - convert a submission into an entry
#
# Given a submission (that has won the IOCCC), with a `.auth.json`
# and `.info.json` and NO `.entry.json` file, we convert the
# `.auth.json` and `.info.json` into a new `.entry.json` file.
#
# We will form, as needed, new `author/author_handle.json`
# files for new authors, and update `author/author_handle.json`
# for authors who won previously.
#
# This script was written in 2024 by:
#
#   chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# with useful improvements and bug fixes by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# "Because sometimes even the IOCCC Judges need some help." :-)
#
# Copyright (c) 2024-2025 by Landon Curt Noll.  All Rights Reserved.
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
export VERSION="2.0.2 2025-05-17"
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
CHKENTRY_TOOL=$(type -P chkentry)
export CHKENTRY_TOOL
if [[ -z "$CHKENTRY_TOOL" ]]; then
    echo "$0: FATAL: chkentry tool is not installed or not in \$PATH" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
export MIN_CHKENTRY_VERSION="1.1.5"
CHKENTRY_VERSION=$("$CHKENTRY_TOOL" -V | head -1 | awk '{print $3;}')
if ! "$VERGE" "$CHKENTRY_VERSION" "$MIN_CHKENTRY_VERSION"; then
    echo "$0: FATAL: chkentry version: $CHKENTRY_VERSION < minimum version: $MIN_CHKENTRY_VERSION" 1>&2
    echo "$0: notice: consider updating chkentry from mkiocccentry repo" 1>&2
    echo "$0: notice: run: git clone https://github.com/ioccc-src/mkiocccentry.git" 1>&2
    echo "$0: notice: then: cd mkiocccentry && make clobber all" 1>&2
    echo "$0: notice: then: cd jparse && sudo make install clobber" 1>&2
    exit 5
fi
#
GTAR_TOOL=$(type -P gtar)
export GTAR_TOOL
if [[ -z "$GIT_TOOL" ]]; then
    echo "$0: FATAL: gtar (gnu tar) tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
#
export TOPDIR
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
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
export MKIOCCCENTRY_REPO="https://github.com/ioccc-src/mkiocccentry"
export INPUT_DATA_FILE
#
export NO_COMMENT="mandatory comment: because comments were removed from the original JSON spec"
export ENTRY_JSON_FORMAT_VERSION="1.2 2024-09-25"
export AUTHOR_JSON_FORMAT_VERSION="1.1 2024-02-11"
#
export NOOP=
export DO_NOT_PROCESS=
#
export TARBALL_DIR="/var/tmp"
#
export X_3="X""X""X"


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]
	[-c chkentry] [-T tarball_dir]
        [-i input_data] [-n] [-N] YYYY/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-c chkentry	path to the chkentry tool (def: $CHKENTRY_TOOL)

	-T tarball_dir	where to form the compressed tarball of modified files (def: $TARBALL_DIR)

	-i input_data	read data from file and disable asking if correct (def: from stdin)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	YYYY/dir	path from topdir to entry directory

Exit codes:
     0         all OK
     1	       invalid user input
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       invalid or missing .info.json and/or .auth.json files
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

    # obtain for the award
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
	    echo -n 'Is that correct? [y,N]: '
	    read -r Y_OR_N
	    if [[ $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
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

    # obtain for the award
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
	    echo -n 'Is that correct? [y,N]: '
	    read -r Y_OR_N
	    if [[ $Y_OR_N == y || $Y_OR_N == Y || $Y_OR_N == yes || $Y_OR_N == YES || $Y_OR_N == Yes ]]; then
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


# manifest_csv
#
# Write a manifest entry in CSV form to stdout.
#
# usage:
#       manifest_csv file_path inventory_order OK_to_edit display_as display_via_github entry_text
#
#   file_path	        path to the file relative to the entry directory
#   inventory_order     inventory order as displayed in the entry index.html file
#   OK_to_edit		boolean for if file should be modified, edited, replaced, or even removed
#   display_as	        kind of file it is and in particular how to display it
#   display_via_github	boolean indicates whether the file should be viewed via GitHub or not
#   entry_text		summary of what the file purpose is
#
# returns:
#       0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function manifest_csv
{
    local FILE_PATH;		# path to the file relative to the entry directory
    local INVENTORY_ORDER;	# inventory order as displayed in the entry index.html file
    local OK_TO_EDIT;		# boolean for if file should be modified, edited, replaced, or even removed
    local DISPLAY_AS;		# kind of file it is and in particular how to display it
    local DISPLAY_VIA_GITHUB;	# boolean indicates whether the file should be viewed via GitHub or not
    local ENTRY_TEXT;		# summary of what the file purpose is

    # parse args
    #
    if [[ $# -ne 6 ]]; then
        echo "$0: ERROR: in manifest_entry: expected 6 args, found $#" 1>&2
        return 1
    fi
    FILE_PATH="${1//,/%%COMMA%%}"
    if [[ -z $FILE_PATH ]]; then
        echo "$0: ERROR: in manifest_entry: file_path arg 1 is empty" 1>&2
	return 2
    fi
    INVENTORY_ORDER="${2//,/%%COMMA%%}"
    if [[ -z $INVENTORY_ORDER ]]; then
        echo "$0: ERROR: in manifest_entry: inventory_order arg 2 is empty" 1>&2
	return 3
    fi
    OK_TO_EDIT="${3//,/%%COMMA%%}"
    if [[ -z $OK_TO_EDIT ]]; then
        echo "$0: ERROR: in manifest_entry: OK_to_edit arg 3 is empty" 1>&2
	return 4
    fi
    DISPLAY_AS="${4//,/%%COMMA%%}"
    if [[ -z $DISPLAY_AS ]]; then
        echo "$0: ERROR: in manifest_entry: display_as arg 4 is empty" 1>&2
	return 5
    fi
    DISPLAY_VIA_GITHUB="${5//,/%%COMMA%%}"
    if [[ -z $DISPLAY_VIA_GITHUB ]]; then
        echo "$0: ERROR: in manifest_entry: display_via_github arg 5 is empty" 1>&2
	return 6
    fi
    ENTRY_TEXT="${6//,/%%COMMA%%}"
    if [[ -z $ENTRY_TEXT ]]; then
        echo "$0: ERROR: in manifest_entry: entry_text arg 6 is empty" 1>&2
	return 7
    fi

    # write CSV line
    #
    printf "%s,%s,%s,%s,%s,%s\n" "$FILE_PATH" "$INVENTORY_ORDER" "$OK_TO_EDIT" \
	    "$DISPLAY_AS" "$DISPLAY_VIA_GITHUB" "$ENTRY_TEXT"

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


# write_author_handle_file - update author_handle JSON file
#
# usage:
#
#   write_author_handle_file AUTHOR_INFO ENTRY_ID_SET TMP_FILENAME JSON_FILENAME
#
#   AUTHOR_INFO	    Associative array of author_handle JSON member names and values
#   ENTRY_ID_SET    Array of entry_id values
#   TMP_FILENAME    temporary JSON file to write into
#   JSON_FILENAME   author_handle JSON file to create or modify if needed
#
# return:
#
#   0	==> all OK
#   =! 0 ==> error
#
function write_author_handle_file
{
    local -n AUTH_INFO;		# name of array of author_handle JSON member names and values
    local -n ENTRY_SET;		# name of array of entry_id values
    local TMP_FILENAME;		# temporary JSON file to write into
    local JSON_FILENAME;	# author_handle JSON file to create or modify if needed
    local entry_set_length;	# length of the array of entry_id values
    local final_comma;		# 2nd to final index of the array of entry_id values
    local i;

    # parse args
    #
    if [[ $# -ne 4 ]]; then
        echo "$0: ERROR: in write_author_handle_file: expected 4 args, found $#" 1>&2
        return 1
    fi
    AUTH_INFO="$1"
    ENTRY_SET="$2"
    TMP_FILENAME="$3"
    JSON_FILENAME="$4"

    # write data to the temporary file
    #
    {
	# write start of temporary author_handle JSON file
	#
	printf "{\n"
	printf "    \"no_comment\" : \"%s\",\n" "${AUTH_INFO[no_comment]}"
	printf "    \"author_JSON_format_version\" : \"%s\",\n" "${AUTH_INFO[author_JSON_format_version]}"
	printf "    \"author_handle\" : \"%s\",\n" "${AUTH_INFO[author_handle]}"
	printf "    \"full_name\" : \"%s\",\n" "${AUTH_INFO[name]}"
	printf "    \"sort_word\" : \"%s\",\n" "${AUTH_INFO[sort_word]}"
	printf "    \"location_code\" : \"%s\",\n" "${AUTH_INFO[location_code]}"
	if [[ ${AUTH_INFO[email]} == null || -z ${AUTH_INFO[email]} ]]; then
	    printf "    \"email\" : null,\n"
	else
	    printf "    \"email\" : \"%s\",\n" "${AUTH_INFO[email]}"
	fi
	if [[ ${AUTH_INFO[url]} == null || -z ${AUTH_INFO[url]} ]]; then
	    printf "    \"url\" : null,\n"
	else
	    printf "    \"url\" : \"%s\",\n" "${AUTH_INFO[url]}"
	fi
	if [[ ${AUTH_INFO[alt_url]} == null || -z ${AUTH_INFO[alt_url]} ]]; then
	    printf "    \"alt_url\" : null,\n"
	else
	    printf "    \"alt_url\" : \"%s\",\n" "${AUTH_INFO[alt_url]}"
	fi
	if [[ ${AUTH_INFO[deprecated_twitter_handle]} == null || -z ${AUTH_INFO[deprecated_twitter_handle]} ]]; then
	    printf "    \"deprecated_twitter_handle\" : null,\n"
	else
	    printf "    \"deprecated_twitter_handle\" : \"%s\",\n" "${AUTH_INFO[deprecated_twitter_handle]}"
	fi
	if [[ ${AUTH_INFO[mastodon]} == null || -z ${AUTH_INFO[mastodon]} ]]; then
	    printf "    \"mastodon\" : null,\n"
	else
	    printf "    \"mastodon\" : \"%s\",\n" "${AUTH_INFO[mastodon]}"
	fi
	if [[ ${AUTH_INFO[mastodon_url]} == null || -z ${AUTH_INFO[mastodon_url]} ]]; then
	    printf "    \"mastodon_url\" : null,\n"
	else
	    printf "    \"mastodon_url\" : \"%s\",\n" "${AUTH_INFO[mastodon_url]}"
	fi
	if [[ ${AUTH_INFO[github]} == null || -z ${AUTH_INFO[github]} ]]; then
	    printf "    \"github\" : null,\n"
	else
	    printf "    \"github\" : \"%s\",\n" "${AUTH_INFO[github]}"
	fi
	if [[ ${AUTH_INFO[affiliation]} == null || -z ${AUTH_INFO[affiliation]} ]]; then
	    printf "    \"affiliation\" : null,\n"
	else
	    printf "    \"affiliation\" : \"%s\",\n" "${AUTH_INFO[affiliation]}"
	fi

	# write the winning_entry_set array to the temporary author_handle JSON file
	#
	printf "    \"winning_entry_set\" : [\n"
	entry_set_length=${#ENTRY_SET[@]}
	case "$entry_set_length" in
	0)  echo "$0: ERROR: Array of entry_id values is empty";
	    return 1
	    ;;
	1)  printf "        {\n"
	    printf "            \"entry_id\" : \"%s\"\n" "${ENTRY_SET[0]}"
	    printf "        }\n"
	    ;;
	*)  ((final_comma=entry_set_length-2))
	    ((final=entry_set_length-1))
	    for j in $(seq 0 "$final_comma"); do
		printf "        {\n"
		printf "            \"entry_id\" : \"%s\"\n" "${ENTRY_SET[$j]}"
		printf "        },\n"
	    done
	    printf "        {\n"
	    printf "            \"entry_id\" : \"%s\"\n" "${ENTRY_SET[$final]}"
	    printf "        }\n"
	    ;;
	esac
	printf "    ]\n"

	# write the end of the temporary author_handle JSON file
	#
	printf "}\n"

    } > "$TMP_FILENAME"

    # update author_handle JSON file if needed
    #
    if cmp -s "$TMP_FILENAME" "$JSON_FILENAME"; then

	# case: .entry.json did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: author_handle JSON file file did not change: $JSON_FILENAME" 1>&2
        fi

    else

        # case: .entry.json file changed, update the file
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_FILENAME $JSON_FILENAME" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_FILENAME" "$JSON_FILENAME" 1>&2
            status="$?"
        else
            mv -f -- "$TMP_FILENAME" "$JSON_FILENAME" 1>&2
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: in write_author_handle_file: mv -f -- $TMP_FILENAME $JSON_FILENAME filed," \
	         "error code: $status" 1>&2
            return 2
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated author_handle JSON file: $JSON_FILENAME" 1>&2
        fi
        if [[ ! -s $JSON_FILENAME ]]; then
            echo "$0: ERROR: in write_author_handle_file: not a non-empty author_handle JSON file: $JSON_FILENAME" 1>&2
            return 3
        fi
    fi

    # all OK
    #
    return 0
}


# parse command line
#
while getopts :hv:Vd:c:i:T:nN flag; do
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
    c) CHKENTRY_TOOL="$OPTARG"
	;;
    i) INPUT_DATA_FILE="$OPTARG"
	;;
    T) TARBALL_DIR="$OPTARG"
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
    echo  "$0: ERROR: .top is not a readable file: $TOP_FILE" 1>&2
    exit 6
fi
if [[ ! -s $TOP_FILE ]]; then
    echo  "$0: ERROR: .top is not a non-empty readable file: $TOP_FILE" 1>&2
    exit 6
fi


# verify that the bin/md2html.sh tool is executable
#
export MD2HTML_SH="$BIN_DIR/md2html.sh"
if [[ ! -e $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh does not exist: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -f $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not a regular file: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -x $MD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not an executable file: $MD2HTML_SH" 1>&2
    exit 5
fi


# verify that the bin/othermd2html.sh tool is executable
#
export OTHERMD2HTML_SH="$BIN_DIR/othermd2html.sh"
if [[ ! -e $OTHERMD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/othermd2html.sh does not exist: $OTHERMD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -f $OTHERMD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/othermd2html.sh is not a regular file: $OTHERMD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -x $OTHERMD2HTML_SH ]]; then
    echo  "$0: ERROR: bin/othermd2html.sh is not an executable file: $OTHERMD2HTML_SH" 1>&2
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
export INFO_JSON="$YYYY_DIR/.info.json"
export AUTH_JSON="$YYYY_DIR/.auth.json"
export AUTH_JSON_XZ="$YYYY_DIR/.auth.json.xz"
export REMARKS_MD="$YYYY_DIR/remarks.md"
export TAR_BZ2="$YYYY_DIR/$ENTRY_ID.tar.bz2"
export ENTRY_JSON="$YYYY_DIR/.entry.json"
export DOT_GITIGNORE="$YYYY_DIR/.gitignore"
export TRY_SH="$YYYY_DIR/try.sh"
export DOT_PATH="$YYYY_DIR/.path"
export README_MD="$YYYY_DIR/README.md"
export INDEX_HTML="$YYYY_DIR/index.html"


# determine template files
#
export TEMPLATE_DIR="template"
export NEXT_DIR="next"
export TEMPLATE_ENTRY_DIR="$TEMPLATE_DIR/entry"
export TEMPLATE_GITIGNORE="$TEMPLATE_ENTRY_DIR/gitignore"
export TEMPLATE_README_MD_HEAD="$TEMPLATE_ENTRY_DIR/README.md.head"
export TEMPLATE_README_MD_TAIL="$TEMPLATE_ENTRY_DIR/README.md.tail"
export TEMPLATE_TRY_SH="$NEXT_DIR/try.sh"


# determine TARBALL filename
#
NOW=$(date '+%Y%m%d.%H%M%S')
export NOW
export TARBALL="$TARBALL_DIR/$ENTRY_ID.mods.$NOW.tar.bz2"


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
    echo "$0: debug[3]: CHKENTRY_TOOL=$CHKENTRY_TOOL" 1>&2
    echo "$0: debug[3]: VERGE=$VERGE" 1>&2
    echo "$0: debug[3]: JSTRDECODE=$JSTRDECODE" 1>&2
    echo "$0: debug[3]: MIN_JSTRDECODE_VERSION=$MIN_JSTRDECODE_VERSION" 1>&2
    echo "$0: debug[3]: JSTRDECODE_VERSION=$JSTRDECODE_VERSION" 1>&2
    echo "$0: debug[3]: GTAR_TOOL=$GTAR_TOOL" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: JPARSE_TOOL=$JPARSE_TOOL" 1>&2
    echo "$0: debug[3]: MKIOCCCENTRY_REPO=$MKIOCCCENTRY_REPO" 1>&2
    echo "$0: debug[3]: INPUT_DATA_FILE=$INPUT_DATA_FILE" 1>&2
    echo "$0: debug[3]: NO_COMMENT=$NO_COMMENT" 1>&2
    echo "$0: debug[3]: ENTRY_JSON_FORMAT_VERSION=$ENTRY_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[3]: AUTHOR_JSON_FORMAT_VERSION=$AUTHOR_JSON_FORMAT_VERSION" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: ENTRY_PATH=$ENTRY_PATH" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: MD2HTML_SH=$MD2HTML_SH" 1>&2
    echo "$0: debug[3]: OTHERMD2HTML_SH=$OTHERMD2HTML_SH" 1>&2
    echo "$0: debug[3]: JVAL_WRAPPER=$JVAL_WRAPPER" 1>&2
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_DIR=$ENTRY_DIR" 1>&2
    echo "$0: debug[3]: ENTRY_ID=$ENTRY_ID" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: YYYY_DIR=$YYYY_DIR" 1>&2
    echo "$0: debug[3]: INFO_JSON=$INFO_JSON" 1>&2
    echo "$0: debug[3]: AUTH_JSON=$AUTH_JSON" 1>&2
    echo "$0: debug[3]: AUTH_JSON_XZ=$AUTH_JSON_XZ" 1>&2
    echo "$0: debug[3]: REMARKS_MD=$REMARKS_MD" 1>&2
    echo "$0: debug[3]: TAR_BZ2=$TAR_BZ2" 1>&2
    echo "$0: debug[3]: ENTRY_JSON=$ENTRY_JSON" 1>&2
    echo "$0: debug[3]: DOT_GITIGNORE=$DOT_GITIGNORE" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: README_MD=$README_MD" 1>&2
    echo "$0: debug[3]: INDEX_HTML=$INDEX_HTML" 1>&2
    echo "$0: debug[3]: TEMPLATE_DIR=$TEMPLATE_DIR" 1>&2
    echo "$0: debug[3]: NEXT_DIR=$NEXT_DIR" 1>&2
    echo "$0: debug[3]: TEMPLATE_ENTRY_DIR=$TEMPLATE_ENTRY_DIR" 1>&2
    echo "$0: debug[3]: TEMPLATE_GITIGNORE=$TEMPLATE_GITIGNORE" 1>&2
    echo "$0: debug[3]: TEMPLATE_README_MD_HEAD=$TEMPLATE_README_MD_HEAD" 1>&2
    echo "$0: debug[3]: TEMPLATE_README_MD_TAIL=$TEMPLATE_README_MD_TAIL" 1>&2
    echo "$0: debug[3]: TARBALL_DIR=$TARBALL_DIR" 1>&2
    echo "$0: debug[3]: NOW=$NOW" 1>&2
    echo "$0: debug[3]: TARBALL=$TARBALL" 1>&2
fi


# firewall - verify template files
#
if [[ ! -d $TEMPLATE_DIR ]]; then
    echo "$0: ERROR: missing template directory: $TEMPLATE_DIR" 1>&2
    exit 6
fi
if [[ ! -d $TEMPLATE_ENTRY_DIR ]]; then
    echo "$0: ERROR: missing template/entry directory: $TEMPLATE_ENTRY_DIR" 1>&2
    exit 6
fi
if [[ ! -f $TEMPLATE_GITIGNORE ]]; then
    echo "$0: ERROR: missing template gitignore file: $TEMPLATE_GITIGNORE" 1>&2
    exit 6
fi
if [[ ! -f $TEMPLATE_README_MD_HEAD ]]; then
    echo "$0: ERROR: missing template README.md.head file: $TEMPLATE_README_MD_HEAD" 1>&2
    exit 6
fi
if [[ ! -f $TEMPLATE_README_MD_TAIL ]]; then
    echo "$0: ERROR: missing template README.md.tail file: $TEMPLATE_README_MD_TAIL" 1>&2
    exit 6
fi
if [[ ! -d $NEXT_DIR ]]; then
    echo "$0: ERROR: missing next directory: $NEXT_DIR" 1>&2
    exit 6
fi
if [[ ! -f $TEMPLATE_TRY_SH ]]; then
    echo "$0: ERROR: missing next/try.sh: $TEMPLATE_TRY_SH" 1>&2
    exit 6
fi

# firewall - verify chkentry tool
#
if [[ ! -e $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: chkentry file does not exist: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -f $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: chkentry is not a file: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi
if [[ ! -x $CHKENTRY_TOOL ]]; then
    echo "$0: ERROR: cannot find an executable chkentry tool: $CHKENTRY_TOOL" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $MKIOCCCENTRY_REPO; cd mkiocccentry" 1>&2
    echo "$0: Notice: then if needed: make clobber all install" 1>&2
    exit 5
fi


# verify that YEAR is already in .top
#
if ! grep -E -q "^$YEAR_DIR$" "$TOP_FILE"; then
    echo "$0: ERROR: YEAR_DIR: $YEAR_DIR not found in: $TOP_FILE" 1>&2
    echo "$0: notice: consider running: bin/new-year.sh $YEAR_DIR -v 1" 1>&2
    exit 6
fi


# case: we have .auth.json.xz but not .auth.json
#
# Form a .auth.json from .auth.json.xz
#
if [[ -f $AUTH_JSON_XZ && ! -f $AUTH_JSON ]]; then
    if [[ -z $NOOP ]]; then

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to execute:" \
		 "xzcat $AUTH_JSON_XZ > $AUTH_JSON" 1>&2
	fi
	xzcat "$AUTH_JSON_XZ" > "$AUTH_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	     echo "$0: ERROR:" \
		  "xzcat $AUTH_JSON_XZ > $AUTH_JSON failed, error: $status" 1>&2
	     exit 7
	fi
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to execute:" \
		 "chmod -v 0444 $AUTH_JSON" 1>&2
	    chmod -v 0444 "$AUTH_JSON"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		 echo "$0: ERROR:" \
		      "chmod -v 0444 $AUTH_JSON failed, error: $status" 1>&2
		 exit 7
	    fi
	else
	    chmod 0444 "$AUTH_JSON"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		 echo "$0: ERROR:" \
		      "chmod 0444 $AUTH_JSON failed, error: $status" 1>&2
		 exit 7
	    fi
	fi

    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: because of -n, $AUTH_JSON file was not formed" 1>&2
    fi
fi


# verify .info.json and .auth.json are readable non-empty files
#
if [[ ! -e $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json does not exist: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -f $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not a regular file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -r $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not a readable file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ ! -s $INFO_JSON ]]; then
    echo  "$0: ERROR: .info.json is not a non-empty readable file: $INFO_JSON" 1>&2
    exit 6
fi
if [[ -z $NOOP ]]; then
    if [[ ! -e $AUTH_JSON ]]; then
	echo  "$0: ERROR: .auth.json does not exist: $AUTH_JSON" 1>&2
	exit 6
    fi
    if [[ ! -f $AUTH_JSON ]]; then
	echo  "$0: ERROR: .auth.json is not a regular file: $AUTH_JSON" 1>&2
	exit 6
    fi
    if [[ ! -r $AUTH_JSON ]]; then
	echo  "$0: ERROR: .auth.json is not a readable file: $AUTH_JSON" 1>&2
	exit 6
    fi
    if [[ ! -s $AUTH_JSON ]]; then
	echo  "$0: ERROR: .auth.json is not a non-empty readable file: $AUTH_JSON" 1>&2
	exit 6
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, $AUTH_JSON file not checked" 1>&2
fi


# initialize the list of files that we might tar
#
unset TAR_FILE_SET
declare -ag TAR_FILE_SET
#
for FILE in "$INFO_JSON" "$AUTH_JSON" "$REMARKS_MD" "$README_MD" "$INDEX_HTML" "$TAR_BZ2"; do
    if [[ -f $FILE ]]; then
	TAR_FILE_SET+=("$FILE")
    fi
done
#
# add each author/author_handle.json file referenced by .auth.json file that exists
#
unset AUTHOR_HANDLE_SET
declare -ag AUTHOR_HANDLE_SET
#
export PATTERN
PATTERN='$..author_handle'
if [[ $V_FLAG -ge 5 ]]; then
    echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $AUTH_JSON '$PATTERN'" 1>&2
fi
export FOUND_AUTHOR_HANDLES
FOUND_AUTHOR_HANDLES=$("$JVAL_WRAPPER" -b -q -- "$AUTH_JSON" "$PATTERN")
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: $JVAL_WRAPPER -b -q -- $AUTH_JSON '$PATTERN' failed," \
	  "error code: $status" 1>&2
    exit 10
fi
if [[ -z $FOUND_AUTHOR_HANDLES ]]; then
    echo "$0: ERROR: found no author_handle's in: $AUTH_JSON" 1>&2
    exit 11
fi
for AUTHOR_HANDLE in $FOUND_AUTHOR_HANDLES; do
    # add referenced by .auth.json if it exists
    AUTHOR_HANDLE_JSON="author/$AUTHOR_HANDLE.json"
    if [[ -f $AUTHOR_HANDLE_JSON ]]; then
	TAR_FILE_SET+=("$AUTHOR_HANDLE_JSON")
    fi
    # remember the author_handle for later even if it doesn't exist
    AUTHOR_HANDLE_SET+=("$AUTHOR_HANDLE")
done
#
if [[ $V_FLAG -ge 3 ]]; then
    for index in "${!TAR_FILE_SET[@]}"; do
	echo "$0: debug[3]: TAR_FILE_SET[$index]=${TAR_FILE_SET[$index]}" 1>&2
    done
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# save files that might be added to or removed from the tarball
#
if [[ -z $NOOP ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to execute:" \
	    "TZ=UTC LC_ALL=C $GTAR_TOOL --sort=name" \
	    "--totals -jcvf $TARBALL ${TAR_FILE_SET[*]}" 1>&2
	TZ=UTC LC_ALL=C "$GTAR_TOOL" --sort=name \
		     --totals -jcvf "$TARBALL" "${TAR_FILE_SET[@]}"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR:" \
		"TZ=UTC LC_ALL=C $GTAR_TOOL --sort=name" \
		"--totals -jcvf $TARBALL ${TAR_FILE_SET[*]} failed, error: $status" 1>&2
	    exit 12
	fi

    # case: form the tarball silently
    #
    else
	TZ=UTC LC_ALL=C "$GTAR_TOOL" --sort=name \
		     -jcf "$TARBALL" "${TAR_FILE_SET[@]}"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR:" \
		"TZ=UTC LC_ALL=C $GTAR_TOOL --sort=name" \
		"-jcf $TARBALL ${TAR_FILE_SET[*]} failed, error: $status" 1>&2
	    exit 13
	fi
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, tarball not formed: $TARBALL" 1>&2
fi


# perform the semantic check on .info.json and .auth.json
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to run: $CHKENTRY_TOOL -v 1" \
	 "-i .auth.json.xz -i .prev -i .submit.sh -i .txz -i .num.sh -i .orig" \
	 "-- $YYYY_DIR" 1>&2
    "$CHKENTRY_TOOL" -v 1 -i .auth.json.xz -i .prev -i .submit.sh -i .txz -i .num.sh -i .orig -- "$YYYY_DIR"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $CHKENTRY_TOOL -v 1 -i .auth.json.xz -i .prev -i .submit.sh -i .txz -i .num.sh -i .orig" \
	     "-- $YYYY_DIR failed," \
	      "error code: $status" 1>&2
	exit 7
    fi
else
    "$CHKENTRY_TOOL" -i .auth.json.xz -i .prev -i .submit.sh -i .txz -i .num.sh -i .orig -- "$YYYY_DIR"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: $CHKENTRY_TOOL -i .auth.json.xz -i .prev -i .submit.sh -i .txz -i .num.sh -i .orig" \
	     "-- $YYYY_DIR failed," \
	      "error code: $status" 1>&2
	exit 7
    fi
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
	exit 14
    fi
    :> "$TMP_ENTRY_JSON"
    if [[ ! -e $TMP_ENTRY_JSON ]]; then
	echo "$0: ERROR: cannot create temporary .entry.json file: $TMP_ENTRY_JSON" 1>&2
	exit 15
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary .entry.json file is not used: $TMP_ENTRY_JSON" 1>&2
fi


# create a temporary author_handle JSON file
#
export TMP_AUTHOR_HANDLE_JSON=".tmp.$NAME.AUTHOR_HANDLE_JSON.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary author_handle file: $TMP_AUTHOR_HANDLE_JSON" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_ENTRY_JSON $TMP_AUTHOR_HANDLE_JSON; exit' 0 1 2 3 15
    rm -f "$TMP_AUTHOR_HANDLE_JSON"
    if [[ -e $TMP_AUTHOR_HANDLE_JSON ]]; then
	echo "$0: ERROR: cannot remove temporary author_handle file: $TMP_AUTHOR_HANDLE_JSON" 1>&2
	exit 16
    fi
    :> "$TMP_AUTHOR_HANDLE_JSON"
    if [[ ! -e $TMP_AUTHOR_HANDLE_JSON ]]; then
	echo "$0: ERROR: cannot create temporary author_handle file: $TMP_AUTHOR_HANDLE_JSON" 1>&2
	exit 17
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary author_handle file is not used: $TMP_AUTHOR_HANDLE_JSON" 1>&2
fi


# create a temporary manifest.csv file
#
export TMP_MANIFEST_CSV=".tmp.$NAME.MANIFEST_CSV.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary manifest csv file: $TMP_MANIFEST_CSV" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_ENTRY_JSON $TMP_AUTHOR_HANDLE_JSON $TMP_MANIFEST_CSV; exit' 0 1 2 3 15
    rm -f "$TMP_MANIFEST_CSV"
    if [[ -e $TMP_MANIFEST_CSV ]]; then
	echo "$0: ERROR: cannot remove temporary manifest csv file: $TMP_MANIFEST_CSV" 1>&2
	exit 18
    fi
    :> "$TMP_MANIFEST_CSV"
    if [[ ! -e $TMP_MANIFEST_CSV ]]; then
	echo "$0: ERROR: cannot create temporary manifest csv file: $TMP_MANIFEST_CSV" 1>&2
	exit 19
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary manifest csv file is not used: $TMP_MANIFEST_CSV" 1>&2
fi


# obtain title from .info.json
#
export PATTERN='$..title'
TITLE=$("$JVAL_WRAPPER" -b -q "$INFO_JSON" "$PATTERN")
export TITLE
if [[ -z $TITLE ]]; then
    TITLE="${ENTRY_DIR}.${YEAR_DIR}"
    echo "$0: Warning empty title for in $INFO_JSON, use $TITLE" 1>&2
fi


# obtain title from .info.json
#
export ABSTRACT='$..abstract'
ABSTRACT=$("$JVAL_WRAPPER" -b -q "$INFO_JSON" "$PATTERN")
export ABSTRACT
if [[ -z $ABSTRACT ]]; then
    ABSTRACT="default abstract for ${YEAR_DIR}/${ENTRY_DIR}"
    echo "$0: Warning empty abstreact for in $INFO_JSON, will use $ABSTRACT" 1>&2
fi


# case: without -n
#
export VALUE
if [[ -z $NOOP ]]; then

    # form the start of the temporary .entry.json file
    #
    {
	echo '{'
	echo '    "no_comment" : "'"$NO_COMMENT"'",'
	echo '    "entry_JSON_format_version" : "'"$ENTRY_JSON_FORMAT_VERSION"'",'
    } > "$TMP_ENTRY_JSON"

    # write the award to the temporary .entry.json file
    #
    VALUE=
    prompt_string "award"
    status="$?"
    if [[ $status -ne 0 || -z $VALUE ]]; then
	echo "$0: ERROR: prompt_string award failed," \
		 "error code: $status" 1>&2
	exit 1
    fi
    {
	# write award
	#
	echo "    \"award\" : \"${VALUE}\","

	# write IOCCC year to the temporary .entry.json file
	#
	echo "    \"year\" : ${YEAR_DIR},"

	# write entry directory to the temporary .entry.json file
	#
	echo "    \"dir\" : \"${ENTRY_DIR}\","

	# write entry_id to the temporary .entry.json file
	#
	echo "    \"entry_id\" : \"${ENTRY_ID}\","

	# write title to the temporary .entry.json file
	#
	echo "    \"title\" : \"${TITLE}\","

	# write abstract to the temporary .entry.json file
	#
	echo "    \"abstract\" : \"${ABSTRACT}\","

	# start the author_set JSON array
	#
	echo "    \"author_set\" : ["
    } >> "$TMP_ENTRY_JSON"

    # process each author_handle
    #
    export i=0
    # In the for loop below, we prefer to use individual redirects
    #
    # SC2129 (style): Consider using { cmd1; cmd2; } >> file instead of individual redirects
    # https://www.shellcheck.net/wiki/SC2129
    # shellcheck disable=SC2129
    for AUTHOR_HANDLE in "${AUTHOR_HANDLE_SET[@]}"; do

	# case: not the first author_handle
	#
	if [[ $i -ge 1 ]]; then
	    printf ",\n"
	fi

	# initialize the AUTHOR_INFO
	#
	unset AUTHOR_INFO
	declare -Ag AUTHOR_INFO
	AUTHOR_INFO[no_comment]="$NO_COMMENT"
	AUTHOR_INFO[author_JSON_format_version]="$AUTHOR_JSON_FORMAT_VERSION"
	AUTHOR_INFO[deprecated_twitter_handle]="null"
	AUTHOR_INFO[author_handle]="$AUTHOR_HANDLE"

	# parse an element value of the this particular author in the authors JSON array
	#
	PATTERN='$.authors['"$i"']'
	if [[ $V_FLAG -ge 5 ]]; then
	    echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $AUTH_JSON '$PATTERN'" 1>&2
	fi
	export AUTHOR_DATA
	AUTHOR_DATA=$("$JVAL_WRAPPER" -q -- "$AUTH_JSON" "$PATTERN")
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: $JVAL_WRAPPER -q -- $AUTH_JSON '$PATTERN' failed," \
		  "error code: $status" 1>&2
	    exit 20
	fi
	if [[ -z $AUTHOR_DATA ]]; then
	    echo "$0: ERROR: found nothing for author[$i] in: $AUTH_JSON" 1>&2
	    exit 21
	fi
	export AUTHOR_PAST_WINNING_AUTHOR=
	export AUTHOR_DEFAULT_HANDLE=
	export AUTHOR_AUTHOR_NUMBER=
	while read -r NAME VALUE; do

	    # parse name value
	    #
	    case "$NAME" in
	    name)
		AUTHOR_INFO[name]="$VALUE"
		;;
	    location_code)
		AUTHOR_INFO[location_code]="$VALUE"
		;;
	    email)
		AUTHOR_INFO[email]="$VALUE"
		;;
	    url)
		AUTHOR_INFO[url]="$VALUE"
		;;
	    alt_url)
		AUTHOR_INFO[alt_url]="$VALUE"
		;;
	    mastodon)
		AUTHOR_INFO[mastodon]="$VALUE"
		;;
	    github)
		AUTHOR_INFO[github]="$VALUE"
		;;
	    affiliation)
		AUTHOR_INFO[affiliation]="$VALUE"
		;;
	    past_winning_author)
		AUTHOR_PAST_WINNING_AUTHOR="$VALUE"
		;;
	    default_handle)
		AUTHOR_DEFAULT_HANDLE="$VALUE"
		;;
	    author_handle)
		if [[ $AUTHOR_HANDLE != "$VALUE" ]]; then
		    echo "$0: ERROR: AUTHOR_HANDLE: $AUTHOR_HANDLE != author_handle value: $VALUE" 1>&2
		    exit 22
		fi
		AUTHOR_INFO[author_handle]="$VALUE"
		;;
	    author_number)
		if [[ $i != "$VALUE" ]]; then
		    echo "$0: ERROR: AUTHOR_HANDLE: $AUTHOR_HANDLE i: $i != author_number: $VALUE" 1>&2
		    exit 23
		fi
		AUTHOR_AUTHOR_NUMBER="$VALUE"
		;;
	    *)
		echo "$0: ERROR: AUTHOR_HANDLE: $AUTHOR_HANDLE unknown name: $NAME" 1>&2
		exit 24
		;;
	    esac
	done <<< "$AUTHOR_DATA"

	# verify we have all of the required information for this particular author
	#
	for NAME in name location_code email url alt_url mastodon github affiliation author_handle; do
	    if [[ -z ${AUTHOR_INFO[${NAME}]} ]]; then
		 echo "$0: ERROR: AUTHOR_HANDLE[$i]: $AUTHOR_HANDLE missing $NAME value from: $AUTH_JSON" 1>&2
		 exit 25
	    fi
	done
	if [[ -z $AUTHOR_PAST_WINNING_AUTHOR ]]; then
	     echo "$0: ERROR: AUTHOR_HANDLE[$i]: $AUTHOR_HANDLE missing past_winning_author value from: $AUTH_JSON" 1>&2
	     exit 26
	fi
	if [[ -z $AUTHOR_DEFAULT_HANDLE ]]; then
	     echo "$0: ERROR: AUTHOR_HANDLE[$i]: $AUTHOR_HANDLE missing default_handle value from: $AUTH_JSON" 1>&2
	     exit 27
	fi
	if [[ -z $AUTHOR_AUTHOR_NUMBER ]]; then
	     echo "$0: ERROR: AUTHOR_HANDLE[$i]: $AUTHOR_HANDLE missing author_number value from: $AUTH_JSON" 1>&2
	     exit 28
	fi

	# determine sort_word from the Author's last name
	#
	SORT_WORD=$(echo "${AUTHOR_INFO[name]}" | sed -e 's/^.* //' | tr '[:upper:]' '[:lower:]' | tr -d -c 'a-z0-9')
	export SORT_WORD
	if [[ -z $SORT_WORD ]]; then
	    echo "$0: ERROR: AUTHOR_HANDLE: $AUTHOR_HANDLE unable to determine the sort_word for: ${AUTHOR_INFO[name]}" 1>&2
	    exit 29
	fi
	case "$SORT_WORD" in
	[a-z]*) ;;
	*) SORT_WORD="z$SORT_WORD" ;;	# prepend if the last name does not begin with a letter
	esac
	AUTHOR_INFO[sort_word]="$SORT_WORD"

	# determine the mastodon_url for non-null mastodon
	#
	case "${AUTHOR_INFO[mastodon]}" in
	\"@*@*\")
	    # We have a 2 phase swap and substitution.  As such it is simpler to use sed.
	    #
	    # SC2001 (style): See if you can use ${variable//search/replace} instead.
	    # https://www.shellcheck.net/wiki/SC2001
	    # shellcheck disable=SC2001
	    AUTHOR_INFO[mastodon_url]=$(echo "${AUTHOR_INFO[mastodon]}" |
			sed -e 's;^"@\([^@]*\)@\(.*\)"$;https://\2/\1;') ;;
	*) AUTHOR_INFO[mastodon_url]="null" ;;
	esac

	# form author/author_handle.json
	#
	AUTHOR_HANDLE_JSON="author/$AUTHOR_HANDLE.json"

	# clear the entry_id set
	#
	unset ENTRY_ID_SET
	declare -ag ENTRY_ID_SET

	# case: author/author_handle.json exists
	#
	if [[ -e $AUTHOR_HANDLE_JSON ]]; then

	    # firewall
	    #
	    if [[ ! -f $AUTHOR_HANDLE_JSON ]]; then
		echo "$0: ERROR: author_handle JSON is not a file: $AUTHOR_HANDLE_JSON" 1>&2
		exit 30
	    fi
	    if [[ ! -r $AUTHOR_HANDLE_JSON ]]; then
		echo "$0: ERROR: author_handle JSON is not a readable file: $AUTHOR_HANDLE_JSON" 1>&2
		exit 31
	    fi
	    if [[ ! -s $AUTHOR_HANDLE_JSON ]]; then
		echo "$0: ERROR: author_handle JSON is not a non-empty readable file: $AUTHOR_HANDLE_JSON" 1>&2
		exit 32
	    fi

	    # parse author/author_handle.json file other than the winning_entry_set
	    #
	    if [[ $V_FLAG -ge 5 ]]; then
		echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -q -- $AUTHOR_HANDLE_JSON | sed -E -e ..." 1>&2
	    fi
	    export AUTHOR_DATA
	    AUTHOR_DATA=$("$JVAL_WRAPPER" -q -- "$AUTHOR_HANDLE_JSON" |
			  sed -E -e '/^entry_id\t/d')
	    status_codes=("${PIPESTATUS[@]}")
	    if [[ ${status_codes[*]} =~ [1-9] ]]; then
		echo "$0: ERROR: $JVAL_WRAPPER -q -- $AUTHOR_HANDLE_JSON | sed -E -e ... failed," \
		     "error codes: ${status_codes[*]}" 1>&2
		exit 33
	    fi
	    if [[ -z $AUTHOR_DATA ]]; then
		echo "$0: ERROR: found entry_id's in: $AUTH_JSON" 1>&2
		exit 34
	    fi
	    while read -r NAME VALUE; do

		# parse name value got non
		#
		case "$NAME" in
		no_comment)
		    if [[ $VALUE != "$NO_COMMENT" ]]; then
			echo "$0: ERROR: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "invalid no_comment: $VALUE != \"$NO_COMMENT\"" 1>&2
			exit 35
		    fi
		    ;;
		author_JSON_format_version)
		    if [[ $VALUE != "$AUTHOR_JSON_FORMAT_VERSION" ]]; then
			echo "$0: ERROR: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "invalid author_JSON_format_version: $VALUE != \"$AUTHOR_JSON_FORMAT_VERSION\"" 1>&2
			exit 36
		    fi
		    ;;
		author_handle)
		    if [[ $VALUE != "${AUTHOR_INFO[author_handle]}" ]]; then
			echo "$0: ERROR: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "invalid author_handle: $VALUE != ${AUTHOR_INFO[author_handle]}" 1>&2
			exit 37
		    fi
		    ;;
		full_name)
		    if [[ $VALUE != "${AUTHOR_INFO[name]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of full_name from: $VALUE to: ${AUTHOR_INFO[name]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		sort_word)
		    if [[ $VALUE != "${AUTHOR_INFO[sort_word]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of sort_word from: $VALUE to: ${AUTHOR_INFO[sort_word]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		location_code)
		    if [[ $VALUE != "${AUTHOR_INFO[location_code]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of location_code from: $VALUE to: ${AUTHOR_INFO[location_code]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		email)
		    if [[ $VALUE != "${AUTHOR_INFO[email]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of email from: $VALUE to: ${AUTHOR_INFO[email]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		url)
		    if [[ $VALUE != "${AUTHOR_INFO[url]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of url from: $VALUE to: ${AUTHOR_INFO[url]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		alt_url)
		    if [[ $VALUE != "${AUTHOR_INFO[alt_url]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of alt_url from: $VALUE to: ${AUTHOR_INFO[alt_url]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		deprecated_twitter_handle)
		    AUTHOR_INFO[deprecated_twitter_handle]="$VALUE"
		    ;;
		mastodon)
		    if [[ $VALUE != "${AUTHOR_INFO[mastodon]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of mastodon from: $VALUE to: ${AUTHOR_INFO[mastodon]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		mastodon_url)
		    if [[ $VALUE != "${AUTHOR_INFO[mastodon_url]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of mastodon_url from: $VALUE to: ${AUTHOR_INFO[mastodon_url]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		github)
		    if [[ $VALUE != "${AUTHOR_INFO[github]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of github from: $VALUE to: ${AUTHOR_INFO[github]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		affiliation)
		    if [[ $VALUE != "${AUTHOR_INFO[affiliation]}" ]]; then
			echo "$0: notice: author_handle file: $AUTHOR_HANDLE_JSON" \
			     "change of affiliation from: $VALUE to: ${AUTHOR_INFO[affiliation]}" 1>&2
			echo 1>&2
		    fi
		    ;;
		*)
		    echo "$0: ERROR: author_handle file: $AUTHOR_HANDLE_JSON" \
		         "unknown $NAME : $VALUE" 1>&2
		    exit 38
		    ;;
		esac
	    done <<< "$AUTHOR_DATA"

	    # collect the entry_ids from the winning_entry_set and add the new entry_id
	    #
	    PATTERN='$..entry_id'
	    if [[ $V_FLAG -ge 5 ]]; then
		echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $AUTHOR_HANDLE_JSON '$PATTERN'" 1>&2
	    fi
	    export ENTRY_IDS
	    ENTRY_IDS=$( { "$JVAL_WRAPPER" -b -q -- "$AUTHOR_HANDLE_JSON" "$PATTERN";
			    status="$?"
			    if [[ $status -ne 0 ]]; then
				echo "$0: ERROR: $JVAL_WRAPPER -b -q -- $AUTHOR_HANDLE_JSON '$PATTERN' failed," \
				      "error code: $status" 1>&2
				exit 39
			    fi
			    echo "$ENTRY_ID"
			 } | LC_ALL=C sort -d -u )
	    if [[ -z $AUTHOR_DATA ]]; then
		echo "$0: ERROR: found no entry_id's in: $AUTHOR_HANDLE_JSON" 1>&2
		exit 40
	    fi
	    while read -r ENTRY_ID_SET_VALUE; do
		ENTRY_ID_SET+=("$ENTRY_ID_SET_VALUE")
	    done <<< "$ENTRY_IDS"

	# case: a new author/author_handle.json needs to be formed
	#
	else
	    ENTRY_ID_SET+=("$ENTRY_ID")
	fi

	# create or modify the author/author_handle.json as needed
	#
	write_author_handle_file AUTHOR_INFO ENTRY_ID_SET "$TMP_AUTHOR_HANDLE_JSON" "$AUTHOR_HANDLE_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: write_author_handle_file AUTHOR_INFO ENTRY_ID_SET" \
		 "$TMP_AUTHOR_HANDLE_JSON $AUTHOR_HANDLE_JSON failed," \
		 "error code: $status" 1>&2
	    exit 41
	fi

	# output the author_handle information for .entry.json
	#
	printf "        {\n"
	printf "            \"author_handle\" : \"%s\"\n" "$AUTHOR_HANDLE"
	printf "        }"

	# count this author
	#
	((++i))
    done >> "$TMP_ENTRY_JSON"
    printf "\n    ],\n" >> "$TMP_ENTRY_JSON"

    # begin the manifest array
    #
    echo "    \"manifest\" : [" >> "$TMP_ENTRY_JSON"
    ((count=0))

    # write manifest csv line for entry source code
    #
    # This is the 1st manifest element of the array.  Moreover, we will
    # leave out the trailing comma.
    #
    ((++count))
    PATTERN='$..c_src'
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN'" 1>&2
    fi
    export FILE_PATH
    FILE_PATH=$("$JVAL_WRAPPER" -b -q -- "$INFO_JSON" "$PATTERN")
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN' failed," \
		 "error code: $status" 1>&2
	exit 42
    fi
    if [[ -z $FILE_PATH ]]; then
	echo "$0: ERROR: cannot determine c_src in manifest from: $INFO_JSON" 1>&2
	exit 7
    fi
    if [[ ! -e $YYYY_DIR/$FILE_PATH ]]; then
	echo "$0: ERROR: manifest file for c_src does not exist: $YYYY_DIR/$FILE_PATH" 1>&2
	exit 43
    fi
    if [[ ! -f $YYYY_DIR/$FILE_PATH ]]; then
	echo "$0: ERROR: manifest file for c_src is not a file: $YYYY_DIR/$FILE_PATH" 1>&2
	exit 44
    fi
    manifest_csv "$FILE_PATH" 20 true c true "entry source code" >> "$TMP_MANIFEST_CSV"
    export PROG_C="$FILE_PATH"

    # write manifest csv line for entry Makefile
    #
    ((++count))
    PATTERN='$..Makefile'
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN'" 1>&2
    fi
    export FILE_PATH
    FILE_PATH=$("$JVAL_WRAPPER" -b -q -- "$INFO_JSON" "$PATTERN")
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN' failed," \
		 "error code: $status" 1>&2
	exit 45
    fi
    if [[ -z $FILE_PATH ]]; then
	echo "$0: ERROR: cannot determine Makefile in manifest from: $INFO_JSON" 1>&2
	exit 46
    fi
    if [[ ! -e $YYYY_DIR/$FILE_PATH ]]; then
	echo "$0: ERROR: manifest file for Makefile does not exist: $YYYY_DIR/$FILE_PATH" 1>&2
	exit 47
    fi
    if [[ ! -f $YYYY_DIR/$FILE_PATH ]]; then
	echo "$0: ERROR: manifest file for Makefile is not a file: $YYYY_DIR/$FILE_PATH" 1>&2
	exit 48
    fi
    manifest_csv "$FILE_PATH" 30 true makefile true "entry Makefile" >> "$TMP_MANIFEST_CSV"

    # write manifest csv line for alt source file if found
    #
    export ALT_C
    ALT_C=$(basename "$PROG_C" .c)".alt.c"
    if [[ -f $YYYY_DIR/$ALT_C ]]; then

	# manifest for entry alt source code
	#
	((++count))
	manifest_csv "$ALT_C" 40 true c true "alternate source code" >> "$TMP_MANIFEST_CSV"
    fi

    # form original source code if needed
    #
    export ORIG_C
    ORIG_C=$(basename "$PROG_C" .c)".orig.c"
    if [[ ! -f $YYYY_DIR/$ORIG_C ]]; then
	if [[ $V_FLAG -ge 3 ]]; then
	    echo  "$0: debug[3]: about to run: cp -f -p -v $YYYY_DIR/$PROG_C $YYYY_DIR/$ORIG_C" 1>&2
	    cp -f -p -v "$YYYY_DIR/$PROG_C" "$YYYY_DIR/$ORIG_C"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p -v $YYYY_DIR/$PROG_C $YYYY_DIR/$ORIG_C failed," \
			 "error code: $status" 1>&2
		exit 49
	    fi
	else
	    cp -f -p "$YYYY_DIR/$PROG_C" "$YYYY_DIR/$ORIG_C"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p $YYYY_DIR/$PROG_C $YYYY_DIR/$ORIG_C failed," \
			 "error code: $status" 1>&2
		exit 50
	    fi
	fi
    fi

    # write manifest csv line for original source code
    #
    ((++count))
    manifest_csv "$ORIG_C" 50 false c true "original source code" >> "$TMP_MANIFEST_CSV"

    # collect manifest for extra_file(s)
    #
    export PATTERN
    PATTERN='$..extra_file'
    if [[ $V_FLAG -ge 5 ]]; then
	echo  "$0: debug[5]: about to run: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN' | ,,, sort ..." 1>&2
    fi
    export EXTRA_FILE_SET
    EXTRA_FILE_SET=$("$JVAL_WRAPPER" -b -q -- "$INFO_JSON" "$PATTERN" | LC_ALL=C sort -d -u)
    status_codes=("${PIPESTATUS[@]}")
    if [[ ${status_codes[*]} =~ [1-9] ]]; then
	echo "$0: ERROR: $JVAL_WRAPPER -b -q -- $INFO_JSON '$PATTERN' | ... sort ... failed," \
		 "error code: ${status_codes[*]}" 1>&2
	exit 51
    fi

    # perform some validation checks on the extra_file set
    #
    for EXTRA_FILE in $EXTRA_FILE_SET; do

	# test if extra_file is an invalid filename
	#
	case "$EXTRA_FILE" in
	prog.c|Makefile|prog.orig.c|index.html|README.md|remarks.md|\.*)
	    echo "$0: ERROR: invalid extra_file filename: $EXTRA_FILE" 1>&2
	    exit 52
	    ;;
	*) ;;
	esac

	# test if extra_file is not a file
	#
	if [[ ! -e $YYYY_DIR/$EXTRA_FILE ]]; then
	    echo "$0: ERROR: manifest file for extra_file does not exist: $YYYY_DIR/$EXTRA_FILE" 1>&2
	    exit 53
	fi
	if [[ ! -f $YYYY_DIR/$EXTRA_FILE ]]; then
	    echo "$0: ERROR: manifest file for extra_file is not a file: $YYYY_DIR/$EXTRA_FILE" 1>&2
	    exit 54
	fi
    done

    # process HTML files that do not yet exist but are associated with markdown extra_files
    #
    for EXTRA_FILE in $EXTRA_FILE_SET; do

	# case: extra_file is a markdown file
	#
	if [[ $EXTRA_FILE =~ (.*)\.md$ ]]; then

	    # warn if there is a HTML file associated with the markdown file
	    #
	    export HTML_FILE="${BASH_REMATCH[1]}.html"
	    if [[ -e $YYYY_DIR/$HTML_FILE ]]; then
		echo 1>&2
		echo "$0: Warning: markdown file: $EXTRA_FILE and HTML file: $HTML_FILE both exist" 1>&2
		echo "$0: Warning: verify HTML file is an HTML version of markdown," \
		     "or exclude $YYYY_DIR/$EXTRA_FILE from bin/md2html.cfg processing" 1>&2
		echo 1>&2
	    fi
	    HTML_FILE_BASENAME=$(basename "$HTML_FILE")
	    export HTML_FILE_BASENAME

	    # write manifest csv line for the markdown file
	    #
	    ((++count))
	    manifest_csv "$EXTRA_FILE" 4000000000 true markdown true \
		"markdown source for $HTML_FILE_BASENAME" >> "$TMP_MANIFEST_CSV"

	    # prompt for entry_text of HTML file
	    #
	    VALUE=
	    prompt_string "entry_text for $HTML_FILE"
	    status="$?"
	    if [[ $status -ne 0 || -z $VALUE ]]; then
		echo "$0: ERROR: prompt_string entry_text for $HTML_FILE failed," \
			 "error code: $status" 1>&2
		exit 1
	    fi
	    export ENTRY_TEXT="$VALUE"

	    # write manifest csv line for the HTML file associated with the markdown file
	    #
	    ((++count))
	    manifest_csv "$HTML_FILE" 100 false markdown true "$ENTRY_TEXT" >> "$TMP_MANIFEST_CSV"

	# case: extra_file is an HTML file
	#
	elif [[ $EXTRA_FILE =~ (.*)\.html$ ]]; then

	    # case: there is a markdown file associated with this HTML file
	    #
	    export MD_FILE="${BASH_REMATCH[1]}.md"
	    if [[ -e $YYYY_DIR/$HTML_FILE ]]; then

		# NOTE: We have or will process the HTML file in this loop, nothing to do here
		#
		continue
	    fi

	    # prompt for entry_text of HTML file
	    #
	    VALUE=
	    prompt_string "entry_text for $EXTRA_FILE"
	    status="$?"
	    if [[ $status -ne 0 || -z $VALUE ]]; then
		echo "$0: ERROR: prompt_string inventory_order for $EXTRA_FILE failed," \
			 "error code: $status" 1>&2
		exit 1
	    fi
	    export ENTRY_TEXT="$VALUE"

	    # write manifest csv line for the HTML file associated with the markdown file
	    #
	    ((++count))
	    manifest_csv "$EXTRA_FILE" 100 false html true "$ENTRY_TEXT" >> "$TMP_MANIFEST_CSV"
	fi
    done

    # process extra_files that are neither markdown nor HTML
    #
    for EXTRA_FILE in $EXTRA_FILE_SET; do

	# ignore HTML files because we processed them above
	#
	if [[ $EXTRA_FILE =~ \.html$ || $EXTRA_FILE =~ \.md$ ]]; then
	    continue
	fi

	# prompt for inventory_order
	#
	VALUE=
	prompt_integer "inventory_order for $EXTRA_FILE"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_string inventory_order for $EXTRA_FILE failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	export INVENTORY_ORDER="$VALUE"

	# prompt for display_as
	#
	VALUE=
	prompt_string "display_as for $EXTRA_FILE"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_string inventory_order for $EXTRA_FILE failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	export DISPLAY_AS="$VALUE"

	# prompt for entry_text
	#
	VALUE=
	prompt_string "entry_text for $EXTRA_FILE"
	status="$?"
	if [[ $status -ne 0 || -z $VALUE ]]; then
	    echo "$0: ERROR: prompt_string inventory_order for $EXTRA_FILE failed," \
		     "error code: $status" 1>&2
	    exit 1
	fi
	export ENTRY_TEXT="$VALUE"

	# write manifest csv line for original source code
	#
	((++count))
	manifest_csv "$EXTRA_FILE" "$INVENTORY_ORDER" true "$DISPLAY_AS" true "$ENTRY_TEXT" >> "$TMP_MANIFEST_CSV"
    done

    # write manifest csv line for compressed tarball
    #
    ((++count))
    manifest_csv "$ENTRY_ID.tar.bz2" 1415926535 false tbz2 false "download entry tarball" >> "$TMP_MANIFEST_CSV"

    # write manifest csv line for .entry.json
    #
    ((++count))
    manifest_csv .entry.json 4000000000 true json true "entry summary and manifest in JSON" >> "$TMP_MANIFEST_CSV"

    # form .gitignore if needed
    #
    if [[ ! -f $DOT_GITIGNORE ]]; then
	if [[ $V_FLAG -ge 3 ]]; then
	    echo  "$0: debug[3]: about to run: cp -f -p -v $TEMPLATE_GITIGNORE $DOT_GITIGNORE" 1>&2
	    cp -f -p -v "$YYYY_DIR/$DOT_GITIGNORE" "$DOT_GITIGNORE"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p -v $TEMPLATE_GITIGNORE $DOT_GITIGNORE failed," \
			 "error code: $status" 1>&2
		exit 55
	    fi
	else
	    cp -f -p "$TEMPLATE_GITIGNORE" "$DOT_GITIGNORE"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p $TEMPLATE_GITIGNORE $DOT_GITIGNORE failed," \
			 "error code: $status" 1>&2
		exit 56
	    fi
	fi
    fi

    # write manifest csv line for .gitignore
    #
    ((++count))
    manifest_csv .gitignore 4000000000 true gitignore true "list of files that should not be committed under git" \
	>> "$TMP_MANIFEST_CSV"

    # if try.sh does not exist, copy example over, otherwise just update
    # manifest
    #
    if [[ ! -f $TRY_SH ]]; then
	if [[ $V_FLAG -ge 3 ]]; then
	    echo  "$0: debug[3]: about to run: cp -f -p -v $TEMPLATE_TRY_SH $TRY_SH" 1>&2
	    cp -f -p -v "$TEMPLATE_TRY_SH" "$TRY_SH"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p -v $TEMPLATE_TRY_SH $TRY_SH failed," \
			 "error code: $status" 1>&2
		exit 55
	    fi
	else
	    cp -f -p "$TEMPLATE_TRY_SH" "$TRY_SH"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: cp -f -p $TEMPLATE_TRY_SH $TRY_SH failed," \
			 "error code: $status" 1>&2
		exit 56
	    fi
	fi
    fi

    # write manifest csv line for try.sh
    #
    ((++count))
    manifest_csv try.sh 100 true shellscript true "script to try entry" \
	>> "$TMP_MANIFEST_CSV"


    # form .path if needed
    #
    if [[ ! -f $DOT_PATH ]]; then
	echo "$YYYY_DIR" > "$DOT_PATH"
    fi

    # write manifest csv line for .path
    #
    ((++count))
    manifest_csv .path 4000000000 false path false "directory path from top level directory" \
	>> "$TMP_MANIFEST_CSV"

    # form README.md if needed
    #
    if [[ ! -f $README_MD ]]; then

	if [[ $V_FLAG -ge 3 ]]; then
	    echo  "$0: debug[3]: forming README.md: $README_MD"
	fi
	cat "$TEMPLATE_README_MD_HEAD" > "$README_MD"
	if [[ -f $YYYY_DIR/remarks.md ]]; then
	    cat "$YYYY_DIR/remarks.md" >> "$README_MD"
	else
	    echo "$X_3 - no remarks.md file was found" >> "$README_MD"
	fi
	sed -e "s/$X_3-YEAR-$X_3/$YEAR_DIR/" "$TEMPLATE_README_MD_TAIL" >> "$README_MD"
    fi

    # write manifest csv line for README.md
    #
    ((++count))
    manifest_csv README.md 4000000000 true markdown true "markdown source for this web page" \
	>> "$TMP_MANIFEST_CSV"

    # write manifest csv line for index.html
    #
    ((++count))
    manifest_csv index.html 4294967295 false html false "this web page" >> "$TMP_MANIFEST_CSV"

    # sort the manifest csv file
    #
    if [[ $V_FLAG -ge 5 ]]; then
        echo "$0: debug[5]: about to: LC_ALL=C sort -t, -k2n -k1,1 -k3,6 $TMP_MANIFEST_CSV -o $TMP_MANIFEST_CSV" 1>&2
    fi
    LC_ALL=C sort -t, -k2n -k1,1 -k3,6 "$TMP_MANIFEST_CSV" -o "$TMP_MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
        echo "$0: ERROR: LC_ALL=C sort -t, -k2n -k1,1 -k3,6 $TMP_MANIFEST_CSV -o $TMP_MANIFEST_CSV failed," \
             "error code: $status" 1>&2
        exit 57
    elif [[ $V_FLAG -ge 3 ]]; then
        echo "$0: debug[3]: sorted temporary manifest csv file: $TMP_MANIFEST_CSV" 1>&2
    fi

    # convert manifest csv lines in the manifest csv file into manifest JSON entries
    #
    MANIFEST_CSV_LINES=$(wc -l < "$TMP_MANIFEST_CSV")
    export MANIFEST_CSV_LINES
    export line=0
    sed -e 's/,/ /g' "$TMP_MANIFEST_CSV" |
      while read -r FILE_PATH INVENTORY_ORDER OK_TO_EDIT DISPLAY_AS DISPLAY_VIA_GITHUB ENTRY_TEXT; do

	# determine if manifest needs a comma
	#
	((++line))
	export COMMA="comma"
	if [[ $line -ge $MANIFEST_CSV_LINES ]]; then
	    COMMA=""
	fi

	# write inventory item into temporary .entry.json file
	#
	manifest_entry "$FILE_PATH" "$INVENTORY_ORDER" "$OK_TO_EDIT" "$DISPLAY_AS" "$DISPLAY_VIA_GITHUB" \
		       "$ENTRY_TEXT" "$COMMA" >> "$TMP_ENTRY_JSON"
      done

    # end the manifest array and end of temporary .entry.json file
    #
    # We complete the last manifest_entry that was written.
    #
    printf "    ]\n}\n" >> "$TMP_ENTRY_JSON"

    # validate the JSON in the temporary .entry.json file
    #
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: about to: $JPARSE_TOOL -q -- $TMP_ENTRY_JSON" 1>&2
    fi
    "$JPARSE_TOOL" -q -- "$TMP_ENTRY_JSON" 1>&2
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: $JPARSE_TOOL -q -- $TMP_ENTRY_JSON filed," \
	     "error code: $status" 1>&2
	exit 58
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
            exit 59
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated .entry.json: $ENTRY_JSON" 1>&2
        fi
        if [[ ! -s $ENTRY_JSON ]]; then
            echo "$0: ERROR: not a non-empty .entry.json: $ENTRY_JSON" 1>&2
            exit 60
        fi
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled adding YYYY_DIR: $YYYY_DIR to $DOT_YEAR" 1>&2
fi


# build HTML files based on extra_file markdown files
#
for EXTRA_FILE in $EXTRA_FILE_SET; do

    # case: extra_file is a markdown file
    #
    if [[ $EXTRA_FILE =~ (.*)\.md$ ]]; then

	# form HTML file if it does not exist
	#
	export HTML_FILE="${BASH_REMATCH[1]}.html"
	if [[ ! -e $HTML_FILE ]]; then

	    if [[ -z $NOOP ]]; then

		if [[ $V_FLAG -ge 1 ]]; then
		    echo  "$0: debug[1]: about to run: $OTHERMD2HTML_SH -v $V_FLAG -- $YYYY_DIR/$EXTRA_FILE" 1>&2
		fi
		"$OTHERMD2HTML_SH" -v "$V_FLAG" -- "$YYYY_DIR/$EXTRA_FILE"
		status="$?"
		if [[ $status -ne 0 ]]; then
		    echo "$0: ERROR: $OTHERMD2HTML_SH -v $V_FLAG -- $YYYY_DIR/$EXTRA_FILE filed," \
			 "error code: $status" 1>&2
		    exit 61
		fi
	    elif [[ $V_FLAG -ge 3 ]]; then
		echo "$0: debug[3]: -n disabled forming HTML: $YYYY_DIR/$HTML_FILE" 1>&2
	    fi

	# HTML file already exists
	#
	elif [[ $V_FLAG -ge 1 ]]; then
	    echo  "$0: notice: markdown: $YYYY_DIR/$EXTRA_FILE HTML file exists: $YYYY_DIR/$HTML_FILE" 1>&2
	fi
    fi
done


# form index.html if needed
#
if [[ -z $NOOP ]]; then
    if [[ ! -f $INDEX_HTML ]]; then

	if [[ $V_FLAG -ge 1 ]]; then
	    echo  "$0: debug[1]: about to run: $MD2HTML_SH -v $V_FLAG -- $README_MD $INDEX_HTML" 1>&2
	fi
	"$MD2HTML_SH" -v "$V_FLAG" -- "$README_MD" "$INDEX_HTML"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: $MD2HTML_SH -v $V_FLAG -- $README_MD $INDEX_HTML filed," \
		 "error code: $status" 1>&2
	    exit 62
	fi
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled forming index.html: $INDEX_HTML" 1>&2
fi


# remove submission files that are no longer needed for a winning IOCCC entry
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: about to run: rm -f -v -- $INFO_JSON $AUTH_JSON $AUTH_JSON.xz $REMARKS_MD $YYYY_DIR/.prev" \
	 "$YYYY_DIR/.submit.sh $YYYY_DIR/.txz $YYYY_DIR/.num.sh $YYYY_DIR/.orig" 1>&2
fi
rm -f -v -- "$INFO_JSON" "$AUTH_JSON" "$AUTH_JSON.xz" "$REMARKS_MD" "$YYYY_DIR/.prev" \
	    "$YYYY_DIR/.submit.sh" "$YYYY_DIR/.txz" "$YYYY_DIR/.num.sh" "$YYYY_DIR/.orig"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: rm -f -v -- $INFO_JSON $AUTH_JSON $AUTH_JSON.xz $REMARKS_MD $YYYY_DIR/.prev" \
	 "$YYYY_DIR/.submit.sh $YYYY_DIR/.txz $YYYY_DIR/.num.sh $YYYY_DIR/.orig filed," \
	 "error code: $status" 1>&2
    exit 63
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
