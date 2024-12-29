#!/usr/bin/env bash
#
# status2html.sh - output status.json HTML for the status.html page
#
# This tool is intended to be used as a "before tool" during HTML phase number 20.
# In particular, lines in the bin/md2html.cfg configuration file of the form:
#
#	-b
#	bin/status2html.sh
#
# will cause tools such as bin/gen-status.sh to execute this code.
#
# The usual way to run bin/gen-status.sh is via:
#
#	bin/gen-status.sh -v 1
#
# This may be more easily done via make:
#
#	make gen_status
#
# This script was written in 2024 by:
#
#   chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# with improvements by:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# "Because sometimes even the IOCCC Judges need some help." :-)
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
export VERSION="1.4.4 2024-12-29"
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
export DOCROOT_SLASH="./"
export REPO_TOP_URL="https://github.com/ioccc-src/winner"
# GitHub puts individual files under the "blob/master" sub-directory.
export REPO_URL="$REPO_TOP_URL/blob/master"
export SITE_URL="https://www.ioccc.org"
export URL="#"


# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-D docroot/] [-n] [-N]
			[-U url] [-w site_url] [-e string ..] [-E exitcode]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-U url		URL of HTML file being formed (def: $URL)
	-w site_url	Base URL of the website (def: $SITE_URL)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

Exit codes:
     0         all OK
     1	       some internal tool exited non-zero
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is too old
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
     7	       problems found with or in the entry topdir/YYYY/dir directory
     8	       error in status.json file
 >= 10         internal error

$NAME version: $VERSION"


# setup
#
export NOOP=
export DO_NOT_PROCESS=


# parse command line
#
while getopts :hv:Vd:D:nNU:w:e:E: flag; do
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
    D) # parse -D docroot/
	case "$OPTARG" in
	*/) ;;
	*) echo "$0: ERROR: in -D docroot/, the docroot must end in /" 1>&2
	   echo 1>&2
	   echo "$USAGE" 1>&2
	   exit 3
	   ;;
	esac
	DOCROOT_SLASH="$OPTARG"
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    U) URL="$OPTARG"
	;;
    w) SITE_URL="$OPTARG"
	;;
    e) echo "$OPTARG" 1>&2
	;;
    E) exit "$OPTARG"
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
# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
if [[ $# -ge 2 ]]; then
    echo "$0: ERROR: expected 0 or 1 args, found: $#" 1>&2
    exit 3
fi
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: arg: $1" 1>&2
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


export BIN_PATH="$TOPDIR/bin"
if [[ ! -d $BIN_PATH ]]; then
    echo "$0: ERROR: bin is not a directory under topdir: $BIN_PATH" 1>&2
    exit 6
fi
export BIN_DIR="bin"


# verify that the bin/pandoc-wrapper.sh tool is executable
#
export PANDOC_WRAPPER="$BIN_DIR/pandoc-wrapper.sh"
if [[ ! -e $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh does not exist: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -f $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not a regular file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi
if [[ ! -x $PANDOC_WRAPPER ]]; then
    echo  "$0: ERROR: bin/md2html.sh is not an executable file: $PANDOC_WRAPPER" 1>&2
    exit 5
fi


# verify status.json file
#
export STATUS_JSON="status.json"
if [[ ! -e $STATUS_JSON ]]; then
    echo  "$0: ERROR: status.json does not exist: $STATUS_JSON" 1>&2
    exit 1
fi
if [[ ! -f $STATUS_JSON ]]; then
    echo  "$0: ERROR: status.json is not a regular file: $STATUS_JSON" 1>&2
    exit 1
fi
if [[ ! -r $STATUS_JSON ]]; then
    echo  "$0: ERROR: status.json is not an readable file: $STATUS_JSON" 1>&2
    exit 1
fi
if [[ ! -s $STATUS_JSON ]]; then
    echo  "$0: ERROR: status.json is not an non-empty readable file: $STATUS_JSON" 1>&2
    exit 1
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
    echo "$0: debug[3]: REPO_TOP_URL=$REPO_TOP_URL" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: URL=$URL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DO_NOT_PROCESS=$DO_NOT_PROCESS" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    echo "$0: debug[3]: CD_FAILED=$CD_FAILED" 1>&2
    echo "$0: debug[3]: BIN_PATH=$BIN_PATH" 1>&2
    echo "$0: debug[3]: BIN_DIR=$BIN_DIR" 1>&2
    echo "$0: debug[3]: STATUS_JSON=$STATUS_JSON" 1>&2
fi


# If -N, time to exit
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: arguments parsed, -N given, exit 0" 1>&2
    fi
    exit 0
fi


# create a temporary markdown for pandoc to process
#
export TMP_FILE=".tmp.$NAME.FILE.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary markdown file: $TMP_FILE" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
    rm -f "$TMP_FILE"
    if [[ -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot remove temporary markdown file: $TMP_FILE" 1>&2
	exit 10
    fi
    :> "$TMP_FILE"
    if [[ ! -e $TMP_FILE ]]; then
	echo "$0: ERROR: cannot create temporary markdown file: $TMP_FILE" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary markdown file is not used: $TMP_FILE" 1>&2
fi


# obtain the contest_status from status.json
#
CONTEST_STATUS=$(grep '"contest_status"\s*:\s*"[^"][^"]*"' "$STATUS_JSON" | sed -e 's/",\s*$//' -e 's/^.*"//')
status="$?"
export CONTEST_STATUS
if [[ $status -ne 0 || -z $CONTEST_STATUS ]]; then
    echo "$0: ERROR: cannot determine contest_status from status.json: $STATUS_JSON" 1>&2
    exit 8
fi


# validate and normalize the contest_status cfrom status.json
#
case "$CONTEST_STATUS" in
p|pending) CONTEST_STATUS="pending"
    ;;
o|open) CONTEST_STATUS="open"
    ;;
j|judging) CONTEST_STATUS="judging"
    ;;
c|closed) CONTEST_STATUS="closed"
    ;;
*) echo "$0: ERROR: unexpected status from $status.json: $CONTEST_STATUS" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 8
    ;;
esac


# write temporary markdown file for status.json
#
{
    # write status of the contest
    #
    case "$CONTEST_STATUS" in
    pending) echo "# The IOCCC is not yet open"
	echo
        echo "While the IOCCC is not open now, there is a tentative opening date for the next IOCCC."
        echo
	echo "See the [IOCCC news](news.html) for details including the tentative" \
	     "scheduled opening date."
	echo
	echo "A preliminary [IOCCC rules](next/rules.html), preliminary [IOCCC guidelines](next/guidelines.html)," \
	     "and preliminary [mkiocccentry tools](https://github.com/ioccc-src/mkiocccentry) have been posted."
	echo
	echo "Comments and suggestions on these preliminary items are welcome, see [FAQ 0.5](faq.html#feedback)" \
	     "for information on how."
	;;
    open) echo "# The IOCCC is open for submissions"
	echo
	echo "See the [IOCCC news](news.html) page for possible updates to rules, guidelines, tools and deadlines."
	echo
	echo "See [How to enter the IOCCC](faq.html#enter) FAQ for additional information."
	echo
	echo "**IMPORTANT**: If you viewed the preliminary IOCCC rules, guidelines, and tools while the IOCCC status" \
	     "was pending, be sure to review the official IOCCC rules, guidelines, and tools for any changes that may" \
	     "have been recently made before submitting to the IOCCC."
	;;
    judging) echo "# The IOCCC is closed to new submissions"
	echo
	echo "The [IOCCC judges](judges.html) are in the process of judging the submissions they received" \
	     "the IOCCC was open."
	echo
	echo "Watch the [@IOCCC mastodon feed](https://fosstodon.org/@ioccc), as well as the" \
	     "[IOCCC news](news.html) page for updates."
	;;
    closed) echo "# The IOCCC is closed"
        echo
		echo "The IOCCC is **NOT** accepting [new submissions](next/submit.html) at this time.  See the" \
	     "[IOCCC winning entries page](years.html) for the entries that have won the IOCCC."
	echo
	echo "Watch both [this IOCCC status page](status.html) and the" \
	     "[@IOCCC mastodon feed](https://fosstodon.org/@ioccc) for information about future IOCCC openings."
	;;
    *) echo "# The IOCCC status is unknown"
        echo
	echo "The IOCCC status is an unexpected status value: $CONTEST_STATUS"
        echo
        echo "This is a **BUG**, not a feature.  Feel free to report it!" 1>&2
		echo "See the [GitHub issues page](https://github.com/ioccc-src/winner/issues/new/choose)." 1>&2
	;;
    esac
    echo

    # write status.json content to status.html
    #
    echo '# status.json'
    echo '```'
    sed -e 's/^/    /' "$STATUS_JSON"
    echo '```'
} | if [[ -z $NOOP ]]; then
    cat >> "$TMP_FILE"
else
    cat > /dev/null
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: -n disabled write of author header into: $TMP_FILE" 1>&2
    fi
fi


# convert temporary markdown file into HTML
#
if [[ -z $NOOP ]]; then
    echo "<!-- START: this line starts content generated by: bin/$NAME -->"
    echo
    if [[ $V_FLAG -ge 1 ]]; then
	echo  "$0: debug[1]: about to execute: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
    fi
    "$PANDOC_WRAPPER" "$TMP_FILE" -
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: pandoc failed, error: $status" 1>&2
	exit 1
    fi
    echo
    echo "<!-- END: next line ends content generated by: bin/$NAME -->"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: $PANDOC_WRAPPER $TMP_FILE -" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -z $NOOP ]]; then
    rm -f "$TMP_FILE"
elif [[ $V_FLAG -ge 1 ]]; then
    echo  "$0: debug[1]: -n disabled execution of: rm -f $TMP_FILE" 1>&2
fi
exit 0
