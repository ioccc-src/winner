#!/usr/bin/env bash
#
# sgit - run sed (by default with -i) on all files (or one or more globs) under
# git control
#
# This script allows one to run sed under git control without having to come up
# with a list of files first and then passing those to the command.
#
# It allows for multiple sed commands and multiple globs. By default it uses -i
# to edit the file in place (WITHOUT BACKUP EXTENSION; use -i option if you want
# a backup!) but in place editing can be overridden with the -I option. See -h
# option for all the options.
#
# DISCLAIMER AND WARNING: this is something of a hack and might be error prone.
# It works for what is needed but possibly could be improved. Even so I like it
# how it is and I don't think it would do much good to add many more additional
# features.
#
# - Cody Boone Ferguson (@xexyl)
#

export SGIT_VERSION="0.0.8-1 19-04-2023" # format: major.minor.patch-release DD-MM-YYYY

USAGE="usage: $(basename "$0") [-h] [-V] [-v level] [-x] [-I] [-i extension] [-o sed_options] [-s sed] [-e command] <glob...>

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -x			    turn on tracing (set -x)
    -I			    disable in place editing
    -i extension	    set backup extension (default none)
				WARNING: sed -i overwrites existing files
				WARNING: this will create another file for each file changed
    -o			    sed options (NOTE: don't pass '-'!)
				WARNING: use of '-o n' without '-I', can depending on command, empty files
    -s sed		    set path to sed
    -e command		    append sed command to list of commands to execute on globs

sgit version: $SGIT_VERSION"

SED="$(type -P sed)"
export SED
export SED_OPTIONS=""
export I_FLAG=
export VERBOSITY=0
export EXTENSION=""

# we need an array for sed commands
declare -a SED_COMMANDS

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
    o)	SED_OPTIONS="-$OPTARG"
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
   *)
	;;
    esac
done

shift $(( OPTIND - 1 ));

# firewall

# check that SED_COMMANDS is not empty!
if [[ -z "${SED_COMMANDS[*]}" ]]; then
    echo "$(basename "$0"): ERROR: you must specify at least one sed command" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 2
fi

# check that sed is executable
if [[ -z "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed cannot be empty" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 2
elif [[ ! -f "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed is not a regular file: $SED" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 2
elif [[ ! -x "$SED" ]]; then
    echo "$(basename "$0"): ERROR: sed is not an executable file: $SED" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 2
fi

# also check number of remaining args
if [[ "$#" -eq 0 ]]; then
    echo "$(basename "$0"): ERROR: you must specify at least one glob" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 2
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
# each sed command so the more you had the slow it would become as it had to get
# the list of files each time!).
#
# A better approach would be to somehow use git grep to find files that match
# but this would complicate the command line (at least in anyway I can think of
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
	    if [[ -n "$SED_OPTIONS" ]]; then
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED -i\"$EXTENSION\" $SED_OPTIONS ${SED_COMMANDS[*]}" 1>&2
	    else
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED -i\"$EXTENSION\" ${SED_COMMANDS[*]}" 1>&2
	    fi
	else
	    if [[ -n "$SED_OPTIONS" ]]; then
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED $SED_OPTIONS ${SED_COMMANDS[*]}" 1>&2
	    else
		echo "debug[1]: about to run: git ls-files $1 | xargs $SED ${SED_COMMANDS[*]}" 1>&2
	    fi
	fi
    fi

    if [[ -z "$I_FLAG" ]]; then
	if [[ -n "$SED_OPTIONS" ]]; then
	    git ls-files "$1" | xargs "$SED" -i"$EXTENSION" "$SED_OPTIONS" "${SED_COMMANDS[@]}"
	else
	    git ls-files "$1" | xargs "$SED" -i"$EXTENSION" "${SED_COMMANDS[@]}"
	fi
    else
	if [[ -n "$SED_OPTIONS" ]]; then
	    git ls-files "$1" | xargs "$SED" "$SED_OPTIONS" "${SED_COMMANDS[@]}"
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
