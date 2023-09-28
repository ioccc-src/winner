#!/usr/bin/env bash
#
# sgit - run sed (by default with -i) on one or more globs under git control
#
# This script allows one to run sed on files under git control, based on globs
# (pattern or exact file name) without having to come up with a list of files
# first and then passing those directly to sed.
#
# It allows for multiple sed commands and multiple globs. By default it uses -i
# to edit the file in place (WITHOUT BACKUP EXTENSION; use sgit -i option if you
# want a backup!) but in place editing can be overridden with the -I option. Use
# -h option to see all the options. The README.md provides much more information
# on the usage of the script and I recommend you look at that.
#
# For a list of warnings see the usage string and more so the README.md file as
# there are some options that when used together (or an option not used with
# another) can in some cases empty files (depends on command) or one can end up
# creating many additional files (if backing up the files for instance with the
# -i option).
#
# - Cody Boone Ferguson (@xexyl)
#

export SGIT_VERSION="0.0.11-1 28-04-2023" # format: major.minor.patch-release DD-MM-YYYY

USAGE="usage: $(basename "$0") [-h] [-V] [-v level] [-x] [-I] [-i extension] [-o sed_option] [-s sed] [-e command] <glob...>

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -x			    turn on tracing (set -x)
    -I			    disable in place editing

    -i extension	    set backup extension (default none)
				WARNING: sed -i overwrites existing files
				WARNING: this will create another file for each file changed

    -o sed_option	    append sed options to options list
				WARNING: use of '-o -n' without '-I', can depending on
				sed commands, empty files as if both sed -i and sed -n were
				used together

				NOTE: you must pass the '-' for short options and '--' for long options!
				NOTE: if you pass more than one option or it takes an option arg you must
				quote it!

    -s sed		    set path to sed
    -e command		    append sed command to list of commands to execute on globs

sgit version: $SGIT_VERSION"

SED="$(type -P sed)"
export SED
export I_FLAG=
export VERBOSITY=0
export EXTENSION=""

# we need an array for sed commands
declare -a SED_COMMANDS
# we need an array for sed options
declare -a SED_OPTIONS

# we need to remove ' ' from the IFS!
IFS=$'\t\n'

# parse args
#
while getopts :hVv:xIi:o:s:e: flag; do
    case "$flag" in
    h)	echo "$USAGE" 1>&2
	exit 2
	;;
    V)	echo "$SGIT_VERSION" 1>&2
	exit 2
	;;
    v)	VERBOSITY="$OPTARG";
	;;
    x)	set -x
	;;
    I)	I_FLAG="-I"
	;;
    i)  EXTENSION="$OPTARG"
	;;
    o)	SED_OPTIONS+=("$OPTARG")
	;;
    s)	SED="$OPTARG"
	;;
    e)	SED_COMMANDS+=(-e "$OPTARG")
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	exit 3
	;;
    :)	echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *)  echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    esac
done

shift $(( OPTIND - 1 ));

# firewall

# check that SED_COMMANDS is not empty!
if [[ -z "${SED_COMMANDS[*]}" ]]; then
    echo "$(basename "$0"): ERROR: you must specify at least one sed command and one glob" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi

# check that sed is executable
if [[ -z "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed cannot be empty" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
elif [[ ! -f "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed is not a regular file: $SED" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
elif [[ ! -x "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed is not an executable file: $SED" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi

# also check number of remaining args
if [[ "$#" -eq 0 ]]; then
    echo "$(basename "$0"): ERROR: you must specify at least one glob" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi

# then check that this is a git repo!
git status 2>/dev/null 1>&2
status="$?"
if [[ "$status" -ne 0 ]]; then
    echo "$(basename "$0"): ERROR: ${PWD} not a git repository" 1>&2
    exit 1
fi

if [[ $VERBOSITY -gt 1 ]]; then
    echo "debug[2]: sed commands:  ${SED_COMMANDS[*]}" 1>&2
fi

# This might not the best performance because it does this on all files of the
# glob rather than only those files matched by the glob with matching text but
# it's better than it used to be (it used to run git ls-files on the repo for
# each sed command so the more you had the slower it would become as it had to
# get the list of files each time!).
#
# A better approach would be to somehow use git grep to find files that match
# but this would complicate the command line (at least in any way I can think of
# how to do it) so we do it on all files in the repo.
#
# But these would possibly require additional args to the command and
# unnecessarily complicate matters. Anyway it's something of a hack so it
# doesn't have to be perfect (not that there even is such a thing as perfect).
#
if [[ "$VERBOSITY" -gt 1 ]]; then
    echo "debug[2]: looping through all globs" 1>&2
fi

if [[ -n "$EXTENSION" ]]; then
    if [[ "$VERBOSITY" -ge 1 ]]; then
	echo "debug[1]: using backup extension: $EXTENSION" 1>&2
    fi
fi

GLOBS="$#"
i=0
while [[ "$i" -lt "$GLOBS" ]]; do
    if [[ "$VERBOSITY" -gt 1 ]]; then
	echo "debug[2]: found glob: $i" 1>&2
    fi


    if [[ "$VERBOSITY" -ge 1 ]]; then
	if [[ -z "$I_FLAG" ]]; then
	    # Determine if any sed options were specified. We only need to know
	    # if the array is empty or not; we do not need to expand it in the
	    # check.
	    #
	    # SC2128 (warning): Expanding an array without an index only gives the first element.
	    # shellcheck disable=SC2128
	    if [[ -n "$SED_OPTIONS" ]]; then
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED -i\"$EXTENSION\" ${SED_OPTIONS[*]} ${SED_COMMANDS[*]}" 1>&2
	    else
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED -i\"$EXTENSION\" ${SED_COMMANDS[*]}" 1>&2
	    fi
	else
	    if [[ -n "$SED_OPTIONS" ]]; then
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED ${SED_OPTIONS[*]} ${SED_COMMANDS[*]}" 1>&2
	    else
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED ${SED_COMMANDS[*]}" 1>&2
	    fi
	fi
    fi

    if [[ -z "$I_FLAG" ]]; then
	if [[ -n "$SED_OPTIONS" ]]; then
	    git ls-files "$1" | xargs "$SED" -i"$EXTENSION" "${SED_OPTIONS[*]}" "${SED_COMMANDS[@]}"
	else
	    git ls-files "$1" | xargs "$SED" -i"$EXTENSION" "${SED_COMMANDS[@]}"
	fi
    else
	if [[ -n "$SED_OPTIONS" ]]; then
	    git ls-files "$1" | xargs "$SED" "${SED_OPTIONS[*]}" "${SED_COMMANDS[@]}"
	else
	    git ls-files "$1" | xargs "$SED" "${SED_COMMANDS[@]}"
	fi
    fi
    ((i++))
    shift 1
    if [[ "$VERBOSITY" -gt 2 ]]; then
	if [[ "$#" -eq 1 ]]; then
	    echo "debug[2]: $# remaining glob" 1>&2
	else
	    echo "debug[2]: $# remaining globs" 1>&2
	fi
    fi

done

exit 0
