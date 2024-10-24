#!/usr/bin/env bash
#
# find-missing-links.sh - find markdown links to missing local files
#
# Find all markdown links to local files that do not exist.
#
# This tool does **NOT** check that a remote URL exists.
# This tool only checks on links to local files.
#
# This tool does **NOT** check links in a given place in a file.
# This tool only checks that local files linked by markdown exist.
#
# This tool does **NOT** check HTML file links.
# This tool only checks markdown based links.
#
# NOTE: If the markdown link is malformed, this tool
# might generate an error about a file that does exist.
# If this tool claims that a file is missing that does exist,
# look for a malformed markdown line and/or use of markdown
# that is **NOT** an IOCCC markdown best practice.
#
#  See the IOCCC markdown best practices file, markdown.html, for more info.
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
export VERSION="1.1.1 2024-04-28"
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


# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)

Exit codes:
     0		all OK
     1		missing links found
     2		-h and help string printed or -V and version string printed
     3		command line error
     4		bash version is too old
     5		git not installed or not in \$PATH
     6		problems found with or in the topdir or topdir/YYYY directory
     7		problems found with or in the entry topdir/YYYY/dir directory
 >= 10		internal error

$NAME version: $VERSION"


# fast_dirname - perform dirname(1) without calling a command
#
# This is very similar with dirname(1) except it is much faster.
#
# usage:
#	fast_dirname path_name
#
#	path to obtain the directory from
#
function fast_dirname
{
    local PATH_NAME;	# path_name argument to be modified

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in fast_dirname: debug_parameters requires 1 arg, found: $#" 1>&2
	exit 10
    fi
    PATH_NAME="$1"

    # firewall - reject empty paths
    #
    if [[ -z $PATH_NAME ]]; then
	echo "$0: ERROR: in fast_dirname: pathname arg is empty" 1>&2
	exit 11
    fi

    # reduce multiple consecutive /'s to just /
    #
    while :; do
        case "$PATH_NAME" in
	*//*) PATH_NAME="${PATH_NAME//\/\//\/}" ;;
	*) break ;;
	esac
    done

    # trim any trailing /
    #
    PATH_NAME=${PATH_NAME%%/}

    # case: if we only had /'s return /
    #
    if [[ -z "$PATH_NAME" ]]; then
	echo '/'
	return;
    fi

    # case: PATH_NAME is an absolute path starting with /
    #
    case "$PATH_NAME" in
    /*) echo "${PATH_NAME%/*}"; return ;;
    */*) echo "${PATH_NAME%/*}"; return ;;
    *) echo '.'; return ;;
    esac
}


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
export TOOL
case "$#" in
0) ;;
*) echo "$0: ERROR: expected 0 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: start scan for missing links" 1>&2
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


# create a temporary missing link error message file
#
export TMP_MISSING_LINK=".tmp.$NAME.MISSING_LINK.$$.tmp"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary missing link error message file: $TMP_MISSING_LINK" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_MISSING_LINK; exit' 0 1 2 3 15
    rm -f "$TMP_MISSING_LINK"
    if [[ -e $TMP_MISSING_LINK ]]; then
	echo "$0: ERROR: cannot remove temporary missing link error message file: $TMP_MISSING_LINK" 1>&2
	exit 12
    fi
    :> "$TMP_MISSING_LINK"
    if [[ ! -e $TMP_MISSING_LINK ]]; then
	echo "$0: ERROR: cannot create temporary missing link error message file: $TMP_MISSING_LINK" 1>&2
	exit 13
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary missing link error message file is not used: $TMP_MISSING_LINK" 1>&2
fi


# collect markdown links
#
#	Here be extended regular expression magic dragons! :-)
#
# We will try to explain, as best as we can, these complex regular expressions.
#
# After grep of markdown files (files in sorted dictionary order) for markdown line lines, we sed:
#
#	# remove any "[some string]" that is not immediately followed by "("
#
#	-e 's/\[[^]]*\]([^(])/\1/' \
#
#	# remove any trailing "[followed by text without a closing bracket"
#
#	-e 's/\[[^]]*$//' \
#
# Then processing the second file (after the filename field) we sed:
#
#	# remove any leading "..non-[-stuff..["
#
#	    -e 's/^[^[]()+\[/[/' \
#
#	# replace "beginning text stuff](" with "[text stuff]("
#	#     because the previous line might have ended with "[beginning"
#
#	    -e 's/^([^][]*\]\()/[\1/g' \
#
#	# remove any "[..non-]-stuff..][..more-non-]-stuff..]"
#
#	    -e 's/(\[[^][]*\])+([^(])/\2/g' \
#
#	# remove any non-link before the first "[some string](path)"
#
#	    -e 's/^[^][]+(\[[^]]*\]\([^(]*\))/\1/' \
#
#	# remove any final "[..non-]-stuff..$"
#
#	    -e 's/\[[^]]*$//' \
#
#	# remove any final "(..non-)-stuff..)..non-[-stuff.."
#
#	    -e 's/(\([^)]*\))[^[]*$/\1/' \
#
#	# remove any trailing non-[-text after the final "[some string](path)"
#
#	    -e 's/(\[[^]]*\]\([^(]*\))[^[]+$/\1/' \
#
#	# replace ")..non-open-bracket-stuff.["  with ") ["
#
#	    -e 's/\)[^[]*\[/) [/g' \
#
#	# replace "[some string](apath) [other string](bpath)" with two lines:
#	#
#	#	"[some string](apath)"
#	#	"[other string](bpath)"
#
#	    -e 's/(\[[^]]*\]\([^(]*\))/\1\n/g' \
#
#	# remove blank and empty lines
#
#	    -e '/^\s*$/d' \
#
# Then pipe the lines into another sed:
#
#	# replace multiple space with a single space
#
#	    -e 's/  +/ /g' \
#
#	# remove the leading "[pseudo title]("
#
#	    -e 's/\[[^]]*\]\(//' \
#
#	# remove trailing ")":
#
#	    -e 's/\)$//' \
#
#	# remove and trailing #name
#
#	    -e 's/#.*$//' \
#
#	# remove any leading whitespace
#
#	    -e 's/^ //' \
#
#	# remove blank and empty lines
#
#	    -e '/^\s*$/d' \
#
#	# delete all http: and https: URLs
#
#	    -e '/^https?:/d' \
#
#	# delete all mailto: URLs
#
#	    -e '/^mailto:/d' \
#
#	# add current directory in front of absolute paths
#
#	    -e "s;^/;$PWD;" \
#
#	# add current directory followed by / in front of relative paths
#
#	    -e "s;^([^/]);$PWD/\1;" \
#
#	# convert "%%REPO_URL%%/" into TOPDIR
#
#	    -e "s;%%REPO_URL%%/*;$TOPDIR/;" \
#
#	# convert "%%DOCROOT_SLASH%%" into TOPDIR
#
#	    -e "s;%%DOCROOT_SLASH%%/*;$TOPDIR/;" \
#
#	# relative paths have the directory of the markdown file added to them
#
#	    -e "s;^([^/]);$TOPDIR/$MD_DIR/\1;" \
#
#	# delete all lines containing "%%TOKEN%%" as this is a just a test/example token
#
#	    -e '/%%TOKEN%%/d' \
#
# At this point in the pipe, we have absolute /-based paths to markdown linked local files.
# We test if those file exist, and if not report a problem in the form:
#
#	# Missing file linked in: markdown_file_name.md
#	# Markdown line: ..the markdown line containing the line..
#	/missing/filename
#
"$GIT_TOOL" ls-files --exclude markdown.md --exclude ./tmp |
    LANG=C sort -d |
    xargs grep '\]([^)][^)]*)' /dev/null |
    sed -E \
	-e 's;^\.\/;;' \
	-e 's/^([^:]+):\s*/\1 /' \
	|
    while read -r MD_PATH MD_LINE; do

	# note directory containing the markdown file
	#
        MD_DIR=$(fast_dirname "$MD_PATH")
	export MD_DIR

	# extract markdown parts from the given markdown file
	#
	echo "$MD_LINE" |
	sed -E \
	    -e 's/^[^[]()+\[/[/' \
	    -e 's/^([^][]*\]\()/[\1/g' \
	    -e 's/(\[[^][]*\])+([^(])/\2/g' \
	    -e 's/^[^][]+(\[[^]]*\]\([^(]*\))/\1/' \
	    -e 's/\[[^]]*$//' \
	    -e 's/(\([^)]*\))[^[]*$/\1/' \
	    -e 's/(\[[^]]*\]\([^(]*\))[^[]+$/\1/' \
	    -e 's/\)[^[]*\[/) [/g' \
	    -e 's/(\[[^]]*\]\([^(]*\))/\1\n/g' \
	    -e '/^\s*$/d' \
	    |
	sed -E \
	    -e 's/  +/ /g' \
	    -e 's/\[[^]]*\]\(//' \
	    -e 's/\)$//' \
	    -e 's/#.*$//' \
	    -e 's/^ //' \
	    -e '/^\s*$/d' \
	    -e '/^https?:/d' \
	    -e '/^mailto:/d' \
	    -e "s;%%REPO_URL%%/*;$TOPDIR/;" \
	    -e "s;%%DOCROOT_SLASH%%/*;$TOPDIR/;" \
	    -e "s;^([^/]);$TOPDIR/$MD_DIR/\1;" \
	    -e '/%%TOKEN%%/d' \
	    |

	 # write to stderr, missing file messages
	 #
	 # The absolute path is written to stderr, while
	 # info about the possible cause is written to stderr with lines starting with #
	 #
	 # We output exact 4 lines per missing link.
	 #
         while read -r ABS_LOCAL_FILE_PATH; do
	    if [[ ! -e $ABS_LOCAL_FILE_PATH ]]; then
		echo "# Missing file linked in: $MD_PATH"
		echo "# Markdown line: $MD_LINE"
		echo "$ABS_LOCAL_FILE_PATH"
		echo
	    fi
	 done
     done > "$TMP_MISSING_LINK"


# count the missing links
#
MISSING_LINK_COUNT=$(wc -l < "$TMP_MISSING_LINK" | tr -d ' ')
export MISSING_LINK_COUNT
((MISSING_LINK_COUNT=MISSING_LINK_COUNT/4))


# report on any missing links
#
if [[ -s $TMP_MISSING_LINK ]]; then
    sed -e "s;^$TOPDIR/;;" "$TMP_MISSING_LINK" 1>&2
fi


# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ -s $TMP_MISSING_LINK ]]; then
    echo "$0: ERROR: $MISSING_LINK_COUNT missing link(s) found" 1>&2
    exit 1
fi
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: $MISSING_LINK_COUNT missing link(s) found" 1>&2
fi
exit 0
