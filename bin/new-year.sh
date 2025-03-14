#!/usr/bin/env bash
#
# new-year.sh - add a new IOCCC year
#
# We update the ${YEAR} make variable in the top level `Makefile`.
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


# IOCCC requires use of C locale
#
export LC_ALL="C"
export LANG="C"
export LC_NUMERIC="C"


# set variables referenced in the usage message
#
export VERSION="2.0.0 2025-03-13"
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
NUMBER_TOOL=$(type -P number)
export NUMBER_TOOL
if [[ -z $NUMBER_TOOL ]]; then
    echo "$0: FATAL: number tool is not installed or not in \$PATH" 1>&2
    echo "$0: notice: see the number GitHub repo: https://github.com/lcn2/number" 1>&2
    exit 5
fi
export TOPDIR
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export TEMPLATE="template"
#
export NOOP=
export DO_NOT_PROCESS=


# output_english_ordinal
#
# Write the English ordinal form of a non-negative integer to standard output (stdout).
# We also capitalize the first letter of each English word.
#
# NOTE: We restrict the integer to non-negative simply because the contest starts
#	with the first: the NUMBER_TOOL handles negative integers.
#
# NOTE: We also restrict the integer to <= 999 because the NUMBER_TOOL starts
#       to write multi-line English names at 1000 and we don't want to parse
#       such multi-line output.   So we leave it up to the IOCCC judges who
#       are judging the 1000th IOCCC to improve this code.  :-)
#
# usage:
#       output_english_ordinal integer
#
# returns:
#       0 ==> no errors detected
#     > 0 ==> function error number
#
function output_english_ordinal
{
    local INTEGER;	    # integer argument
    local ENGLISH_NAME;	    # integer in English form
    local CAP_ENGLISH_NAME; # ENGLISH_NAME with first letters Capitalized

    # parse args
    #
    if [[ $# -ne 1 ]]; then
        echo "$0: ERROR: in output_english_ordinal: expected 1 arg, found $#" 1>&2
        return 1
    fi
    INTEGER="$1"
    if [[ $INTEGER =~ ^-?[0-9]+$ ]]; then
	:
    else
	echo "$0: ERROR: in output_english_ordinal: argument is not an integer: $INTEGER" 1>&2
	return 2
    fi
    if [[ $INTEGER -lt 0 ]]; then
	echo "$0: ERROR: in output_english_ordinal: integer is negative: $INTEGER" 1>&2
	return 3
    fi
    if [[ $INTEGER -gt 999 ]]; then
	echo "$0: ERROR: in output_english_ordinal: integer must be < 999 (see comment): $INTEGER" 1>&2
	return 4
    fi

    # obtain the English name for INTEGER
    #
    ENGLISH_NAME=$("$NUMBER_TOOL" -- "$INTEGER")
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: in output_english_ordinal: $NUMBER_TOOL -- $INTEGER failed," \
	     "error code: $status" 1>&2
	return 5
    fi
    if [[ -z $ENGLISH_NAME ]]; then
	echo "$0: ERROR: in output_english_ordinal: ENGLISH_NAME is empty" 1>&2
	return 6
    fi

    # Capitalize first letters in ENGLISH_NAME
    #
    CAP_ENGLISH_NAME=$(echo "$ENGLISH_NAME" | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1')
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: in output_english_ordinal: echo $ENGLISH_NAME | awk ... failed," \
	     "error code: $status" 1>&2
	return 7
    fi
    if [[ -z $CAP_ENGLISH_NAME ]]; then
	echo "$0: ERROR: in output_english_ordinal: ENGLISH_NAME is empty" 1>&2
	return 8
    fi

    # Output the English name as a Cardinal
    #
    echo "$CAP_ENGLISH_NAME" | sed -E \
	-e 's/One$/First/' -e 's/Two$/Second/' -e 's/Three$/Third/' -e 's/Four$/Forth/' \
	-e 's/Five$/Fifth/' -e 's/Six$/Sixth/' -e 's/Seven$/Seventh/' -e 's/Eight$/Eighth/' \
	-e 's/Nine$/Ninth/' -e 's/Ten$/Tenth/' -e 's/Eleven$/Eleventh/' -e 's/Twelve$/Twelfth/' \
	-e 's/teen$/teenth/' -e 's/ty$/tieth/' -e 's/dred$/dredth/'
    return 0
}


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N] year

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	year		4 digit IOCCC year

Exit codes:
     0         all OK
     1	       invalid year
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:Vd:nN flag; do
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
YEAR="$1"
if [[ $YEAR =~ ^[1-9][0-9][0-9][0-9]$ ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: attending to add year: $YEAR" 1>&2
    fi
else
    echo "$0: ERROR: must be a 4 digit year >= 1000 and <= 9999: $YEAR" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 1
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


# cd to topdir
#
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


# verify we have a non-empty readable Makefile
#
export MAKE_FILE="Makefile"
if [[ ! -e $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile does not exist: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -f $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not a regular file: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -r $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not an readable file: $MAKE_FILE" 1>&2
    exit 6
fi
if [[ ! -s $MAKE_FILE ]]; then
    echo  "$0: ERROR: Makefile is not a non-empty readable file: $MAKE_FILE" 1>&2
    exit 6
fi


# print running info if verbose
#
# If -v 3 or higher, print exported variables in order that they were exported.
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: LC_ALL=$LC_ALL" 1>&2
    echo "$0: debug[3]: LANG=$LANG" 1>&2
    echo "$0: debug[3]: LC_NUMERIC=$LC_NUMERIC" 1>&2
    echo "$0: debug[3]: VERSION=$VERSION" 1>&2
    echo "$0: debug[3]: NAME=$NAME" 1>&2
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: GIT_TOOL=$GIT_TOOL" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: NUMBER_TOOL=$NUMBER_TOOL" 1>&2
    echo "$0: debug[3]: TEMPLATE=$TEMPLATE" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: YEAR=$YEAR" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: TOP_FILE=$TOP_FILE" 1>&2
    echo "$0: debug[3]: MAKE_FILE=$MAKE_FILE" 1>&2
fi


# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi


# Create YYYY directory if needed
#
if [[ -z $NOOP ]]; then

    # case: YYYY does not exist
    #
    if [[ ! -e $YEAR ]]; then
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: mkdir -p $YEAR" 1>&2
	fi
	mkdir -p "$YEAR"
	status="$?"
        if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: mkdir -p $YEAR failed," \
		 "error code: $status" 1>&2
	    exit 10
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: created directory: $YEAR" 1>&2
	fi

    # case: YYYY exists but is not a directory
    #
    elif [[ ! -d $YEAR ]]; then
	echo "$0: ERROR: exists but is not a directory: $YEAR" 1>&2
	exit 11
    fi

elif [[ $V_FLAG -ge 3 && ! -d $YEAR ]]; then
    echo "$0: debug[3]: -n disabled creating missing directory: $YEAR" 1>&2
fi


# Add the template Makefile if there is no YYYY/Makefile file
#
export YEAR_MAKEFILE="$YEAR/Makefile"
if [[ -z $NOOP ]]; then

    # case: YYYY/Makefile does not exist
    #
    if [[ ! -e $YEAR_MAKEFILE ]]; then

	# verify that the template directory exists
	#
	if [[ ! -d $TEMPLATE ]]; then
	    echo "$0: ERROR: YYYY/Makefile: $YEAR_MAKEFILE does not exist and" \
		 "template is missing: $TEMPLATE" 1>&2
	    exit 12
	fi

	# verify that the YYYY/Makefile template is a file
	#
	export YEAR_MAKEFILE_TEMPLATE="$TEMPLATE/Makefile.year"
	if [[ ! -f $YEAR_MAKEFILE_TEMPLATE ]]; then
	    echo "$0: ERROR: YYYY/Makefile: $YEAR_MAKEFILE does not exist and" \
		 "template Makefile is missing: $YEAR_MAKEFILE_TEMPLATE" 1>&2
	    exit 13
	fi

	# form year Makefile
	#
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: sed -e ... $YEAR_MAKEFILE_TEMPLATE > $YEAR_MAKEFILE" 0>&2
	fi
	sed -e "s/%%YEAR%%/$YEAR/g" "$YEAR_MAKEFILE_TEMPLATE" > "$YEAR_MAKEFILE"
	status="$?"
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: sed -e .. $YEAR_MAKEFILE_TEMPLATE > $YEAR_MAKEFILE filed," \
	         "error code: $status" 1>&2
            exit 14
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated Makefile: $MAKE_FILE" 1>&2
        fi

    # case: YYYY exists but is not a file
    #
    elif [[ ! -d $YEAR ]]; then
	echo "$0: ERROR: YYYY/Makefile exists but is not a file: $YEAR_MAKEFILE" 1>&2
	exit 15
    fi

elif [[ $V_FLAG -ge 3 && ! -f $YEAR_MAKEFILE ]]; then
    echo "$0: debug[3]: -n disabled creating Makefile: $YEAR_MAKEFILE" 1>&2
fi


# form an empty YYYY/.year file if needed
#
export YEAR_FILE="$YEAR/.year"
if [[ -z $NOOP ]]; then

    # case: .year file does not exist
    #
    if [[ ! -e $YEAR_FILE ]]; then

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: touch $YEAR_FILE" 1>&2
	fi
	touch "$YEAR_FILE"
	status="$?"
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: touch $YEAR_FILE filed," \
	         "error code: $status" 1>&2
            exit 16
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: created: $YEAR_FILE" 1>&2
        fi

    elif [[ ! -f $YEAR_FILE ]]; then
	echo "$0: ERROR: .year exists but is not a file: $YEAR_FILE" 1>&2
	exit 17
    fi

elif [[ $V_FLAG -ge 3 && ! -e $YEAR_FILE ]]; then
    echo "$0: debug[3]: -n disabled creating .year: $YEAR_FILE" 1>&2
fi


# create a temporary Makefile
#
export TMP_MAKEFILE=".tmp.$NAME.MAKEFILE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary Makefile: $TMP_MAKEFILE" 1>&2
fi
trap 'rm -f $TMP_MAKEFILE; exit' 0 1 2 3 15
rm -f "$TMP_MAKEFILE"
if [[ -e $TMP_MAKEFILE ]]; then
    echo "$0: ERROR: cannot remove temporary Makefile: $TMP_MAKEFILE" 1>&2
    exit 18
fi
touch "$TMP_MAKEFILE"
if [[ ! -e $TMP_MAKEFILE ]]; then
    echo "$0: ERROR: cannot create temporary Makefile: $TMP_MAKEFILE" 1>&2
    exit 19
fi


# form the temporary Makefile with the added year
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: forming temporary Makefile: $TMP_MAKEFILE" 1>&2
fi
sed -n -e '1,/^# BEGIN - DO NOT REMOVE THIS LINE - make new_year uses this line #/p' "$MAKE_FILE" > "$TMP_MAKEFILE"
make new_year NEW_YEAR="$YEAR" >> "$TMP_MAKEFILE"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: make new_year NEW_YEAR=\"$YEAR\" >> \"$TMP_MAKEFILE\" failed," \
	 "error code: $status" 1>&2
    exit 20
fi
sed -n -e '/^# END - DO NOT REMOVE THIS LINE - make new_year also uses this #/,$p' "$MAKE_FILE" >> "$TMP_MAKEFILE"


# Update Makefile if is changes and not -n
#
if [[ -z $NOOP ]]; then

    if cmp -s "$TMP_MAKEFILE" "$MAKE_FILE"; then

	# case: Makefile did not change
	#
	if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: Makefile file did not change: $MAKE_FILE" 1>&2
        fi

    else

        # case: Makefile file changed, update the file
        #
        if [[ $V_FLAG -ge 5 ]]; then
            echo "$0: debug[5]: about to: mv -f -- $TMP_MAKEFILE $MAKE_FILE" 1>&2
        fi
        if [[ $V_FLAG -ge 3 ]]; then
            mv -f -v -- "$TMP_MAKEFILE" "$MAKE_FILE"
            status="$?"
        else
            mv -f -- "$TMP_MAKEFILE" "$MAKE_FILE"
            status="$?"
        fi
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: mv -f -- $TMP_MAKEFILE $MAKE_FILE filed," \
	         "error code: $status" 1>&2
            exit 21
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated Makefile: $MAKE_FILE" 1>&2
        fi
        if [[ ! -s $MAKE_FILE ]]; then
            echo "$0: ERROR: not a non-empty Makefile: $MAKE_FILE" 1>&2
            exit 22
        fi

	# update .top
	#
	if [[ $V_FLAG -ge 3 ]]; then
            echo "$0: debug[3]: about to: make genpath_top >/dev/null" 1>&2
        fi
	make genpath_top >/dev/null
	status="$?"
        if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: make -fC$YEAR genpath_top >/dev/null failed," \
		 "error code: $status" 1>&2
	    exit 23
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated .top" 1>&2
	fi
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled updating: $MAKE_FILE" 1>&2
fi


# Add the template README.md if there is no YYYY/README.md file
#
export YEAR_README="$YEAR/README.md"
if [[ -z $NOOP ]]; then

    # case: YYYY/README.md does not exist
    #
    if [[ ! -e $YEAR_README ]]; then

	# verify that the template directory exists
	#
	if [[ ! -d $TEMPLATE ]]; then
	    echo "$0: ERROR: YYYY/README.md: $YEAR_README does not exist and" \
		 "template is missing: $TEMPLATE" 1>&2
	    exit 24
	fi

	# verify that the YYYY/README.md template is a file
	#
	export YEAR_README_TEMPLATE="$TEMPLATE/README.md.year"
	if [[ ! -f $YEAR_README_TEMPLATE ]]; then
	    echo "$0: ERROR: YYYY/README.md: $YEAR_README does not exist and" \
		 "template README.md.year is missing: $YEAR_README_TEMPLATE" 1>&2
	    exit 25
	fi

	# determine the IOCCC ordinal
	#
	CONTEST_NUMNER=$(sed -n "/$YEAR/=" "$TOP_FILE")
	if [[ -z $CONTEST_NUMNER ]]; then
	    echo "$0: ERROR: failed to determine content number for YYYY: $YEAR in: $TOP_FILE" 1>&2
	    exit 26
	fi
	OUTPUT_ENGLISH_ORDINAL=$(output_english_ordinal "$CONTEST_NUMNER")
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: output_english_ordinal $CONTEST_NUMNER failed," \
		 "error code: $status" 1>&2
	    exit 27
	fi
	if [[ -z $OUTPUT_ENGLISH_ORDINAL ]]; then
	    echo "$0: ERROR: failed to determine content orignal for YYYY: $YEAR for contest: $CONTEST_NUMNER" 1>&2
	    exit 28
	fi

	# form year README.md
	#
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: sed -e ... $YEAR_README_TEMPLATE > $YEAR_README" 0>&2
	fi
	sed -e "s/%%YEAR%%/$YEAR/g" \
	    -e "s/%%OUTPUT_ENGLISH_ORDINAL%%/$OUTPUT_ENGLISH_ORDINAL/g" \
	    "$YEAR_README_TEMPLATE" > "$YEAR_README"
	status="$?"
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: sed -e .. $YEAR_README_TEMPLATE > $YEAR_README filed," \
	         "error code: $status" 1>&2
            exit 29
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated YYYY/README.md $YEAR_README" 1>&2
        fi

    # case: YYYY exists but is not a file
    #
    elif [[ ! -d $YEAR ]]; then
	echo "$0: ERROR: YYYY/README.md exists but is not a file: $YEAR_README" 1>&2
	exit 30
    fi

elif [[ $V_FLAG -ge 3 && ! -f $YEAR_README ]]; then
    echo "$0: debug[3]: -n disabled creating YYYY/README.md: $YEAR_README" 1>&2
fi


# form YYYY/.filelist file if needed
#
export YEAR_FILELIST="$YEAR/.filelist"
if [[ -z $NOOP ]]; then

    # case: .filelist does not exist
    #
    if [[ ! -e $YEAR_FILELIST ]]; then

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: touch $YEAR_FILELIST" 1>&2
	fi
	touch "$YEAR_FILELIST"
	status="$?"
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: touch $YEAR_FILELIST filed," \
	         "error code: $status" 1>&2
            exit 31
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: created: $YEAR_FILELIST" 1>&2
        fi

	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: about to: make genfilelist YEARS=$YEAR" 1>&2
	fi
	make genfilelist YEARS="$YEAR"
	status="$?"
        if [[ $status -ne 0 ]]; then
            echo "$0: ERROR: make genfilelist YEARS=$YEAR filed," \
	         "error code: $status" 1>&2
            exit 32
        elif [[ $V_FLAG -ge 1 ]]; then
            echo "$0: debug[1]: updated: $YEAR_FILELIST" 1>&2
        fi

    elif [[ ! -f $YEAR_FILE ]]; then
	echo "$0: ERROR: .filelist exists but is not a file: $YEAR_FILELIST" 1>&2
	exit 33
    fi

elif [[ $V_FLAG -ge 3 && ! -e $YEAR_FILELIST ]]; then
    echo "$0: debug[3]: -n disabled creating .filelist: $YEAR_FILELIST" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
