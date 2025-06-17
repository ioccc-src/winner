#!/usr/bin/env bash
#
# cvt-submission.sh - Form README.md from remarks.md and 2 templates
#
# Given a submission (that may be in the final rounds of judging
# but may not not yet have won the IOCCC) form a README.md file
# using the contents of the remarks.md and templates from
# template/entry/README.md.head and template/entry/README.md.tail.
#
# This script was written in 2025 by:
#
#   chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Copyright (c) 2025 by Landon Curt Noll.  All Rights Reserved.
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
export VERSION="2.0.0 2025-06-16"
NAME=$(basename "$0")
export NAME
export V_FLAG=0
#
export NOOP=
export DO_NOT_PROCESS=
#
export FORCE=""
#
export X_3="X""X""X"


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]
	[-c chkentry] [-T tarball_dir]
        [-i input_data] [-n] [-N] YYYY README.md.head remarks.md README.md.tail README.md

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-f		force overwrite of README.md if it exists (def: do not overwrite)

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process anything, just parse arguments (def: process something)

	YYYY		IOCCC year
	README.md.head	path to the README.md.head header file
	remarks.md	path to the submission remarks.md file
	README.md.tail	path to the README.md.tail trailer file
	README.md	path to the README.md file to create

Exit codes:
     0         all OK
     1	       failed to create or overwrite README.md
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       YYYY is not a valid year
     6	       command line file not found or not readable
 >= 10         internal error

$NAME version: $VERSION"


# parse command line
#
while getopts :hv:VfnN flag; do
  case "$flag" in
    h) echo "$USAGE" 1>&2
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    f) FORCE="true"
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
if [[ $# -ne 5 ]]; then
    echo "$0: ERROR: expected 5 args, found: $#" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
export YYYY="$1"
export TEMPLATE_README_MD_HEAD="$2"
export REMARKS_MD="$3"
export TEMPLATE_README_MD_TAIL="$4"
export README_MD="$5"


# firewall - command line args
#
if ! [[ $YYYY =~ [0-9][0-9][0-9][0-9] ]]; then
    echo "$0: ERROR: YYYY is not a valid 4 digit year: $YYYY" 1>&2
    exit 5
fi
if [[ $YYYY -lt 1984 || $YYYY -gt 2099 ]]; then
    echo "$0: ERROR: YYYY is not a valid IOCCC year (1984 thru 2099): $YYYY" 1>&2
    exit 5
fi
if [[ ! -f $TEMPLATE_README_MD_HEAD ]]; then
    echo "$0: ERROR: missing template README.md.head file: $TEMPLATE_README_MD_HEAD" 1>&2
    exit 6
fi
if [[ ! -r $TEMPLATE_README_MD_HEAD ]]; then
    echo "$0: ERROR: template README.md.head file not readable: $TEMPLATE_README_MD_HEAD" 1>&2
    exit 6
fi
if [[ ! -f $REMARKS_MD ]]; then
    echo "$0: ERROR: missing template remarks.md file: $REMARKS_MD" 1>&2
    exit 6
fi
if [[ ! -r $REMARKS_MD ]]; then
    echo "$0: ERROR: template remarks.md file not readable: $REMARKS_MD" 1>&2
    exit 6
fi
if [[ ! -f $TEMPLATE_README_MD_TAIL ]]; then
    echo "$0: ERROR: missing template README.md.tail file: $TEMPLATE_README_MD_TAIL" 1>&2
    exit 6
fi
if [[ ! -r $TEMPLATE_README_MD_TAIL ]]; then
    echo "$0: ERROR: template README.md.tail file not readable: $TEMPLATE_README_MD_TAIL" 1>&2
    exit 6
fi
if [[ -z $FORCE && -e $README_MD ]]; then
    echo "$0: ERROR: -f was not used and readme.md exists: $README_MD" 1>&2
    exit 1
fi


# set umask to avoid group writable files
#
umask 0022


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
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: FORCE=$FORCE" 1>&2
    echo "$0: debug[3]: X_3=$X_3" 1>&2
    echo "$0: debug[3]: YYYY=$YYYY" 1>&2
    echo "$0: debug[3]: TEMPLATE_README_MD_HEAD=$TEMPLATE_README_MD_HEAD" 1>&2
    echo "$0: debug[3]: REMARKS_MD=$REMARKS_MD" 1>&2
    echo "$0: debug[3]: TEMPLATE_README_MD_TAIL=$TEMPLATE_README_MD_TAIL" 1>&2
    echo "$0: debug[3]: README_MD=$README_MD" 1>&2
fi

# form README.md
#
if [[ -z $NOOP ]]; then

    if [[ $V_FLAG -ge 3 ]]; then
	echo  "$0: debug[3]: forming README.md: $README_MD"
    fi

    # pre-remove README.md
    #
    # If README.md exists, then the only way we can get here is if -f was used.
    # If README.md does not exist, then rm -f does no harm and will not fail.
    #
    rm -f "$README_MD"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: rm -f $README_MD failed," \
	     "error code: $status" 1>&2
	exit 1
    fi

    # start with the header
    #
    cat "$TEMPLATE_README_MD_HEAD" > "$README_MD"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: cat $TEMPLATE_README_MD_HEAD > $README_MD failed," \
	     "error code: $status" 1>&2
	exit 1
    fi

    # append the submission remarks.md contents
    #
    cat "$REMARKS_MD" >> "$README_MD"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: cat $REMARKS_MD >> $README_MD failed," \
	     "error code: $status" 1>&2
	exit 1
    fi

    # append the trailer with the year substituted
    #
    sed -e "s/$X_3-YEAR-$X_3/$YYYY/" "$TEMPLATE_README_MD_TAIL" >> "$README_MD"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: sed -e 's/$X_3-YEAR-$X_3/$YYYY/' $TEMPLATE_README_MD_TAIL >> $README_MD failed," \
	     "error code: $status" 1>&2
	exit 1
    fi

    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: formed README.md: $README_MD"
    fi

# case: with -n
#
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: -n disabled forming README_MD" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
