#!/usr/bin/env bash
#
# gen-status.sh - create the top level status.md and status.html files
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

# firewall - must be bash with a version 4.2 or later
#
# We must declare arrays with -ag or -Ag, and we need loops to "export" modified variables.
#
if [[ -z ${BASH_VERSINFO[0]} || ${BASH_VERSINFO[0]} -lt 4 || ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 2 ]]; then
    echo "$0: ERROR: bash version must be >= 4.2: $BASH_VERSION" 1>&2
    exit 4
fi

# setup bash file matching
#
# Requires bash with a version 4.2 or later
#
shopt -s nullglob	# enable expanded to nothing rather than remaining unexpanded
shopt -u failglob	# disable error message if no matches are found
shopt -u dotglob	# disable matching files starting with .
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories

# set variables referenced in the usage message
#
export VERSION="1.1 2024-03-10"
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
export TAGLINE="bin/$NAME"
export MD2HTML_SH="bin/md2html.sh"
export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
export SITE_URL="https://ioccc-src.github.io/temp-test-ioccc"
JPARSE_TOOL=$(type -P jparse)
export JPARSE_TOOL
if [[ -z "$JPARSE_TOOL" ]]; then
    echo "$0: FATAL: jparse tool is not installed or not in \$PATH" 1>&2
    exit 5
fi
export IOCCC_STATUS_VERSION="1.0 2024-03-09"
#
export NOOP=
export DO_NOT_PROCESS=
export EXIT_CODE="0"

# clear options we will add to tools
#
unset TOOL_OPTION
declare -ag TOOL_OPTION

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-d topdir] [-n] [-N]
			[-t tagline] [-T md2html.sh] [-u repo_url]
			[p | pending | o | open | j | judging | c | closed]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-d topdir	set topdir (def: $TOPDIR)
			NOTE: The '-d topdir' is passed as leading options on tool command lines.
	-D docroot/	set the document root path followed by slash (def: $DOCROOT_SLASH)
			NOTE: The '-D docroot/' is passed as leading options on tool command lines.
			NOTE: 'docroot' must end in a slash

	-n		go thru the actions, but do not update any files (def: do the action)
			NOTE: -n is passed to tool
	-N		do not process anything, just parse arguments (def: process something)

	-t tagline	string to write about the tool that formed the markdown content (def: $TAGLINE)
			NOTE: 'tagline' may be enclosed within, but may NOT contain an internal single-quote, or double-quote.
	-T md2html.sh	run 'markdown to html tool' to convert markdown into HTML (def: $MD2HTML_SH)

	-u repo_url	Base level URL of target git repo (def: $REPO_URL)
			NOTE: The '-u repo_url' is passed as leading options on tool command lines.
	-w site_url	Base URL of the web site (def: $SITE_URL)
			NOTE: The '-w site_url' is passed as leading options on tool command lines.

	[p | pending]	Set the contest_status to pending
	[o | open]	Set the contest_status to open
	[j | judging]	Set the contest_status to judging
	[c | closed]	Set the contest_status to closed
			(def: do not change contest_status)

NOTE: The '-v level' is passed as initial command line options to the 'markdown to html tool' (md2html.sh).
      The 'tagline' is passed as '-t tagline' to the 'markdown to html tool' (md2html.sh), after the '-v level'.
      Any '-T md2html.sh', '-p tool', '-P pandoc_opts', '-u repo_url', '-U top_url'
      are passed to the 'markdown to html tool' (md2html.sh), and will be before any command line arguments.

Exit codes:
     0         all OK
     1	       some file is not found, not a readable file or is malformed
     2         -h and help string printed or -V and version string printed
     3         command line error
     4         bash version is < 4.2
     5	       some internal tool is not found or not an executable file
     6	       problems found with or in the topdir or topdir/YYYY directory
 >= 10         internal error

$NAME version: $VERSION"

# output_mod_date
#
# output file modification date in UTC timezone in %FT%T+00:00 format
#
function output_mod_date
{
    local FILENAME;	# filename to obtain mod date
    local LS_OUTPUT;	# output of the ls(1) command

    # parse args
    #
    if [[ $# -ne 1 ]]; then
	echo "$0: ERROR: in output_mod_date expected 1 arg, found $#" 1>&2
	return 1
    fi
    FILENAME="$1"
    if [[ ! -e $FILENAME ]]; then
	echo "$0: ERROR: in output_mod_date: filename arg does not exist: $FILENAME" 1>&2
	return 3
    fi
    if [[ ! -r $FILENAME ]]; then
	echo "$0: ERROR: in output_mod_date: filename arg is not a readable: $FILENAME" 1>&2
	return 5
    fi

    # obtain ls output
    #
    LS_OUTPUT=$(TZ=UTC ls -D '%FT%T+00:00' -ld "$FILENAME" 2>/dev/null)
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: in output_mod_date: TZ=UTC ls -D '%FT%T+00:00' -ld $FILENAME failed, error: $status" 1>&2
	return 6
    fi
    if [[ -z $LS_OUTPUT ]]; then
	echo "$0: ERROR: in output_mod_date: TZ=UTC ls -D '%FT%T+00:00' -ld $FILENAME output is empty" 1>&2
	return 7
    fi

    # extract the date string and write it to standard output
    #
    awk '{print $6;}' <<< "$LS_OUTPUT"
    return 0;
}

# output_status_json
#
# write an status.json file to standard output (stdout)
#
# usage:
#	output_status_json contest_status news.html status.json
#
# returns:
#	0 ==> no errors detected, but output may be empty
#     > 0 ==> function error number
#
function output_status_json
{
    local IOCCC_STATUS;	# IOCCC contest_status arg
    local NEWS_PATH;	# news.html file path
    local STATUS_PATH;	# status.json file path
    local NEWS_MOD_DATE;	# modification date of news.html
    local STATUS_MOD_DATE;	# modification date of status.json

    # parse args
    #
    if [[ $# -ne 3 ]]; then
	echo "$0: ERROR: in output_status_json: expected 3 args, found $#" 1>&2
	return 1
    fi
    IOCCC_STATUS="$1"
    if [[ -z $IOCCC_STATUS ]]; then
	echo "$0: ERROR: in output_status_json: contest_status arg is empty" 1>&2
	return 2
    fi
    NEWS_PATH="$2"
    if [[ ! -e $NEWS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg does not exist: $NEWS_PATH" 1>&2
	return 3
    fi
    if [[ ! -f $NEWS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg is not a file: $NEWS_PATH" 1>&2
	return 4
    fi
    if [[ ! -r $NEWS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg is not a readable file: $NEWS_PATH" 1>&2
	return 5
    fi
    STATUS_PATH="$3"
    if [[ ! -e $STATUS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg does not exist: $STATUS_PATH" 1>&2
	return 6
    fi
    if [[ ! -f $STATUS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg is not a file: $STATUS_PATH" 1>&2
	return 7
    fi
    if [[ ! -r $STATUS_PATH ]]; then
	echo "$0: ERROR: in output_status_json: news.html arg is not a readable file: $STATUS_PATH" 1>&2
	return 8
    fi

    # obtain news.html file modification date
    #
    NEWS_MOD_DATE=$(output_mod_date "$NEWS_PATH")
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: in output_status_json: modification date of $NEWS_PATH failed, error: $status" 1>&2
	return 9
    fi
    if [[ -z $NEWS_MOD_DATE ]]; then
	echo "$0: ERROR: in output_status_json: modification date of $NEWS_PATH is empty" 1>&2
	return 10
    fi

    # obtain status.json file modification date
    #
    STATUS_MOD_DATE=$(output_mod_date "$STATUS_PATH")
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: in output_status_json: modification date of $STATUS_PATH failed, error: $status" 1>&2
	return 11
    fi
    if [[ -z $STATUS_MOD_DATE ]]; then
	echo "$0: ERROR: in output_status_json: modification date of $STATUS_PATH is empty" 1>&2
	return 12
    fi

    # output json
    #
    echo '{'
    echo '    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",'
    echo "    \"IOCCC_status_version\" : \"$IOCCC_STATUS_VERSION\","
    echo "    \"contest_status\" : \"$IOCCC_STATUS\","
    echo "    \"news_update\" : \"$NEWS_MOD_DATE\","
    echo "    \"status_update\" : \"$STATUS_MOD_DATE\""
    echo '}'
    return 0
}

# parse command line
#
while getopts :hv:Vd:D:nNt:T:u:w: flag; do
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
	TOOL_OPTION+=("-d")
	TOOL_OPTION+=("$TOPDIR")
	;;
    D) # parse -D docroot/
	case "$OPTARG" in
	*/) ;;
	*) echo "$0: ERROR: in -D docroot/, the docroot must end in /" 1>&2
	   echo 1>&2
	   print_usage 1>&2
	   exit 3
	   ;;
	esac
	DOCROOT_SLASH="$OPTARG"
	# -D docroot/ always added after arg parsing
	;;
    n) NOOP="-n"
	;;
    N) DO_NOT_PROCESS="-N"
	;;
    t) # parse -t tagline
	case "$OPTARG" in
	*"'"*)
	    echo "$0: ERROR: in -t tagline, the tagline may not contain a single-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*'"'*)
	    echo "$0: ERROR: in -t tagline, the tagline may not contain a double-quote character: $OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*) ;;
	esac
	TAGLINE="$OPTARG"
	# -t tagline always added after arg parsing
	;;
    T) MD2HTML_SH="$OPTARG"
	TOOL_OPTION+=("-T")
	TOOL_OPTION+=("$MD2HTML_SH")
	;;
    u) REPO_URL="$OPTARG"
	TOOL_OPTION+=("-u")
	TOOL_OPTION+=("$REPO_URL")
	;;
    w) SITE_URL="$OPTARG"
	TOOL_OPTION+=("-w")
	TOOL_OPTION+=("$SITE_URL")
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
# verify arg count and parse args
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: file argument count: $#" 1>&2
fi
#
if [[ $# -gt 1 ]]; then
    echo "$0: ERROR: expected 0 or 1 args, found: $#" 1>&2
    exit 3
fi
export CONTEST_STATUS=
if [[ $# -eq 1 ]]; then
    case "$1" in
    p|pending) CONTEST_STATUS="pending"
	;;
    o|open) CONTEST_STATUS="open"
	;;
    j|judging) CONTEST_STATUS="judging"
	;;
    c|closed) CONTEST_STATUS="closed"
	;;
    *) echo "$0: ERROR: unexpected status arg: $1" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    esac
fi

# always add the '-v level' option, unless level is empty, to the set of options passed to the md2html.sh tool
#
if [[ -n $V_FLAG ]]; then
    TOOL_OPTION+=("-v")
    TOOL_OPTION+=("$V_FLAG")
fi

# always add the '-t tagline' option, unless tagline is empty, to the set of options passed to the md2html.sh tool
#
if [[ -n $TAGLINE ]]; then
    TOOL_OPTION+=("-t")
    TOOL_OPTION+=("$TAGLINE")
fi

# always add the '-U URL' for the top level status.html file
#
TOOL_OPTION+=("-U")
TOOL_OPTION+=("$SITE_URL/status.html")

# always add the '-D docroot/' for the top level status.html file
#
TOOL_OPTION+=("-D")
TOOL_OPTION+=("$DOCROOT_SLASH")

# verify that we have a topdir directory
#
REPO_NAME=$(basename "$REPO_URL")
export REPO_NAME
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR does not exist: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 6
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
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

# verify that the md2html tool is executable
#
if [[ ! -e $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh does not exist: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -f $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh is not a regular file: $MD2HTML_SH" 1>&2
    exit 5
fi
if [[ ! -x $MD2HTML_SH ]]; then
    echo  "$0: ERROR: md2html.sh is not an executable file: $MD2HTML_SH" 1>&2
    exit 5
fi

# verify readable non-empty news.html file
#
export NEWS_HTML="news.html"
if [[ ! -e $NEWS_HTML ]]; then
    echo  "$0: ERROR: news.html does not exist: $NEWS_HTML" 1>&2
    exit 1
fi
if [[ ! -f $NEWS_HTML ]]; then
    echo  "$0: ERROR: news.html is not a regular file: $NEWS_HTML" 1>&2
    exit 1
fi
if [[ ! -r $NEWS_HTML ]]; then
    echo  "$0: ERROR: news.html is not an executable file: $NEWS_HTML" 1>&2
    exit 1
fi
if [[ ! -s $NEWS_HTML ]]; then
    echo  "$0: ERROR: news.html is not an executable file: $NEWS_HTML" 1>&2
    exit 1
fi

# verify readable non-empty status.json file
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
    echo  "$0: ERROR: status.json is not an executable file: $STATUS_JSON" 1>&2
    exit 1
fi
if [[ ! -s $STATUS_JSON ]]; then
    echo  "$0: ERROR: status.json is not an executable file: $STATUS_JSON" 1>&2
    exit 1
fi

# verify readable non-empty status.md file
#
export STATUS_MD="status.md"
if [[ ! -e $STATUS_MD ]]; then
    echo  "$0: ERROR: status.md does not exist: $STATUS_MD" 1>&2
    exit 1
fi
if [[ ! -f $STATUS_MD ]]; then
    echo  "$0: ERROR: status.md is not a regular file: $STATUS_MD" 1>&2
    exit 1
fi
if [[ ! -r $STATUS_MD ]]; then
    echo  "$0: ERROR: status.md is not an executable file: $STATUS_MD" 1>&2
    exit 1
fi
if [[ ! -s $STATUS_MD ]]; then
    echo  "$0: ERROR: status.md is not an executable file: $STATUS_MD" 1>&2
    exit 1
fi

# note status.html file
#
export STATUS_HTML="status.html"

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
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: TAGLINE=$TAGLINE" 1>&2
    echo "$0: debug[3]: MD2HTML_SH=$MD2HTML_SH" 1>&2
    echo "$0: debug[3]: CONTEST_STATUS=$CONTEST_STATUS" 1>&2
    echo "$0: debug[3]: REPO_URL=$REPO_URL" 1>&2
    echo "$0: debug[3]: SITE_URL=$SITE_URL" 1>&2
    echo "$0: debug[3]: JPARSE_TOOL=$JPARSE_TOOL" 1>&2
    echo "$0: debug[3]: NOOP=$NOOP" 1>&2
    echo "$0: debug[3]: DOCROOT_SLASH=$DOCROOT_SLASH" 1>&2
    echo "$0: debug[3]: EXIT_CODE=$EXIT_CODE" 1>&2
    echo "$0: debug[3]: REPO_NAME=$REPO_NAME" 1>&2
    for index in "${!TOOL_OPTION[@]}"; do
	echo "$0: debug[3]: TOOL_OPTION[$index]=${TOOL_OPTION[$index]}" 1>&2
    done
    echo "$0: debug[3]: NEWS_HTML=$NEWS_HTML" 1>&2
    echo "$0: debug[3]: STATUS_JSON=$STATUS_JSON" 1>&2
    echo "$0: debug[3]: STATUS_MD=$STATUS_MD" 1>&2
    echo "$0: debug[3]: STATUS_HTML=$STATUS_HTML" 1>&2
fi

# validate JSON in status.json
#
"$JPARSE_TOOL" -q "$STATUS_JSON"
status="$?"
if [[ $status -ne 0 ]]; then
    echo  "$0: ERROR: status.json is not valid JSON, jparse error code: $status" 1>&2
    exit 1
fi

# obtain contest_status if CONTEST_STATUS was not set in the arg
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the author/author_handle.json file - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
if [[ -z $CONTEST_STATUS ]]; then

    # obtain the contest_status from status.json
    #
    CONTEST_STATUS=$(grep '"contest_status"\s*:\s*"[^"][^"]*"' "$STATUS_JSON" | sed -e 's/",\s*$//' -e 's/^.*"//')
    status="$?"
    if [[ $status -ne 0 || -z $CONTEST_STATUS ]]; then
	echo "$0: ERROR: cannot determine contest_status from status.json: $STATUS_JSON" 1>&2
	exit 1
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
	exit 1
	;;
    esac
fi

# -N stops early before any processing is performed
#
if [[ -n $DO_NOT_PROCESS ]]; then
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: arguments parsed, -N given, exiting 0" 1>&2
    fi
    exit 0
fi

# create a temporary status.json file
#
TMP_STATUS_JSON=".$NAME.$$.entry.md"
if [[ $V_FLAG -ge 3 ]]; then
    echo  "$0: debug[3]: temporary status.json file: $TMP_STATUS_JSON" 1>&2
fi
if [[ -z $NOOP ]]; then
    trap 'rm -f $TMP_STATUS_JSON; exit' 0 1 2 3 15
    rm -f "$TMP_STATUS_JSON"
    if [[ -e $TMP_STATUS_JSON ]]; then
	echo "$0: ERROR: cannot remove temporary status.json file: $TMP_STATUS_JSON" 1>&2
	exit 10
    fi
    :> "$TMP_STATUS_JSON"
    if [[ ! -e $TMP_STATUS_JSON ]]; then
	echo "$0: ERROR: cannot create temporary status.json file: $TMP_STATUS_JSON" 1>&2
	exit 11
    fi
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary status.json file is not used: $TMP_STATUS_JSON" 1>&2
fi

# generate the temporary status.json file
#
# In this stage, we use the date of the actual status.json file.
#
if [[ -z $NOOP ]]; then

    # generate a temporary status.json file based on current status, news.html and status.json
    #
    output_status_json "$CONTEST_STATUS" "$NEWS_HTML" "$STATUS_JSON" > "$TMP_STATUS_JSON"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: failed to form temporary status.json file: $TMP_STATUS_JSON, error code: $status" 1>&2
        exit 12
    fi
    if [[ ! -s $TMP_STATUS_JSON ]]; then
	echo "$0: ERROR: failed to form temporary status.json, file missing or empty: $TMP_STATUS_JSON" 1>&2
        exit 13
    fi

    # check if temporary status.json file is different from the actual status.json file
    #
    if cmp -s "$STATUS_JSON" "$TMP_STATUS_JSON"; then

	# case: temporary status.json file is the same, nothing to do
	#
	if [[ $V_FLAG -ge 3 ]]; then
	    echo "$0: debug[3]: no change to status.json" 1>&2
	fi

    # case: temporary status.json file is different from the actual status.json
    #
    else

	# case: temporary status.json file needs to replace status.json
	#
	# We now must rebuild the temporary status.json file using the new modification time,
	# so we now touch the status.json file for a new modification time.
	touch -m "$STATUS_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to touch -m $STATUS_JSON, error code: $status" 1>&2
	    exit 14
        fi
	#
	# Rebuild temporary status.json file with updated (touched) modification time
	#
	output_status_json "$CONTEST_STATUS" "$NEWS_HTML" "$STATUS_JSON" > "$TMP_STATUS_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to reform temporary status.json file: $TMP_STATUS_JSON, error code: $status" 1>&2
	    exit 15
	fi
	if [[ ! -s $TMP_STATUS_JSON ]]; then
	    echo "$0: ERROR: failed to reform temporary status.json, file missing or empty: $TMP_STATUS_JSON" 1>&2
	    exit 16
	fi
	#
	# touch the temporary status.json file to have the updated (touched) modification time
	#
	touch -m -r "$STATUS_JSON" "$TMP_STATUS_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to touch -m -r $STATUS_JSON $TMP_STATUS_JSON, error code: $status" 1>&2
	    exit 17
        fi

	# move the temporary status.json file into place
	#
	if [[ $V_FLAG -ge 1 ]]; then
	    echo "$0: debug[1]: updating: $STATUS_JSON" 1>&2
	    mv -v -f "$TMP_STATUS_JSON" "$STATUS_JSON"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: failed to mv -v -f $TMP_STATUS_JSON $STATUS_JSON, error code: $status" 1>&2
		exit 18
	    fi
	else
	    mv -f "$TMP_STATUS_JSON" "$STATUS_JSON"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: failed to mv -f $TMP_STATUS_JSON $STATUS_JSON, error code: $status" 1>&2
		exit 19
	    fi
	fi
    fi

elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, temporary status.json file is NOT written into: $TMP_STATUS_JSON" 1>&2
fi

# use the md2html.sh tool to form the status.html file, unless -n
#
if [[ -z $NOOP ]]; then
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: about to run: $MD2HTML_SH ${TOOL_OPTION[*]} --" \
	     "status.md $STATUS_HTML" 1>&2
    fi
    "$MD2HTML_SH" "${TOOL_OPTION[@]}" -- \
      status.md "$STATUS_HTML"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: md2html.sh: $MD2HTML_SH ${TOOL_OPTION[*]} --" \
	     "status.md $STATUS_HTML" \
	     "failed, error: $status" 1>&2
	exit 20
    elif [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: now up to date: $STATUS_HTML" 1>&2
    fi

# report disabled by -n
#
elif [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: because of -n, did not run: $MD2HTML_SH ${TOOL_OPTION[*]} --" \
         "status.md $STATUS_HTML" 1>&2
fi

# file cleanup
#
if [[ -z $NOOP ]]; then
    rm -f -- "$TMP_STATUS_JSON"
elif [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: because of -n, disabled: rm -f -- $TMP_STATUS_JSON" 1>&2
fi

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
