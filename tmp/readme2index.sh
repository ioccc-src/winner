#!/usr/bin/env bash
#
# readme2index - convert README.md into index.html
#
# Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
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
# We must declare arrays with -ag or -Ag
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
shopt -s globskipdots	# enable never matching . nor ..
shopt -u nocaseglob	# disable strict case matching
shopt -u extglob	# enable extended globbing patterns
shopt -s globstar	# enable ** to match all files and zero or more directories and subdirectories

# other required bash options
#
# Requires bash with a version 4.2 or later
#
shopt -s lastpipe	# run last command of a pipeline not executed in the background in the current shell environment

# set usage message
#
export USAGE="usage: $0 [-h] [-v level] [-V] [-n] [-N]
	[-d topdir] [-c md2html.cfg] [-H phase=name ..]
	[-b tool] [-B optstr] [-p tool] [-P optstr] [-a tool] [-A optstr]
	[-s token=value ..] [-S] [-o tool ..] [-O tool=optstr ..]
	[-e string ..] [-E exitcode] yyyy/dir

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-n		go thru the actions, but do not update any files (def: do the action)
	-N		do not process file, just parse arguments and ignore the file (def: process the file)

	-d topdir	set topdir (def: if 'git rev-parse --is-inside-work-tree' is true, then
					 topdir is output of 'git rev-parse --show-toplevel')
			NOTE: -d may only be used in command_options (getopt phase 0)

	-c md2html.cfg	Use md2html.cfg as the configuration file (def: use topdir/inc/md2html.cfg)
			NOTE: -c may only be used in command_options (getopt phase 0)

	-H phase=name	use 'phase.name.html' file for HTML phase named 'phase' (def: use 'phase.default.html')
	-H phase=.	ignore processing for HTML phase 'phase' (def: process HTML phase)
			NOTE: The 'phase' string may not contain = (equal), nor / (slash).
			NOTE: The 'phase.name.html' file is assumed under the 'topdir/inc' directory.

	-b tool		run 'before tool' during HTML phase number 20 (def: do not output before pandoc wrapper tool)
	-b .		skip HTML phase number 20 (def: do nothing during HTML phase number 20)
	-B optstr	run 'before tool' with options found in 'optstr' (def: do not add any options to 'before tool')

	-p tool		run 'pandoc wrapper tool' (not path to pandoc itself) during HTML phase number 21 (def: use inc/pandoc_wapper.sh)
	-p .		skip HTML phase number 21 (def: do nothing during HTML phase number 21)
	-P optstr	run 'pandoc wrapper tool' with options found in 'optstr' (def: use only the 'pandoc wrapper tool' default options)

	-a tool		run 'after tool' during HTML phase number 20 (def: do not output after pandoc wrapper tool)
	-a .		skip HTML phase number 22 (def: do nothing during HTML phase number 22)
	-A optstr	run 'after tool' with options found in 'optstr' (def: do not add any options to 'after tool')

	-s token=value	substitute %%token%% with value except in HTML phase numbers 20-29 (def: do not substitute any tokens)
			NOTE: The 'token' string may not contain ; (semicolon), nor = (equal), nor % (percent).
			NOTE: The 'value' string may not contain ; (semicolon).
	-S		failure to replace a %%token%% is not an error (def: exit non-zero for non-substituted tokens)

	-o tool		Use output tool, 'tool', to generate option lines (def: do not)
	-o .		disable use of 'output tool' (def: do not use an 'output tool')
			NOTE: -o may only be used in command_options and md2html.cfg cfg_options (getopt phases 0 and 2)
	-O tool=optstr	run the 'token replace' named 'tool' with options found in 'optstr' (def: do not add any options)
			NOTE: The 'tool' string may not contain = (equal), nor double-quote, nor single-quote.
			NOTE: -O may only be used in command_options and md2html.cfg cfg_options (getopt phases 0 and 2)

	-e string	output string, followed by newline, to stderr (def: do not)
	-E exitcode	force exit with exitcode (def: exit based on success or failure of the action)

	yyyy/dir	path from topdir to winner directory: must contain README.md and .path

Exit codes:
     0	       all OK
     2	       -h and help string printed or -V and version string printed
     3	       command line error
     4	       bash version is < 4.2
     5	       yyyy/dir is not a winner directory
     6	       tool not found or not executable (before, pandoc wrapper, after, output tools)
     7	       HTML phase file not found or not readable
 >= 10 < 200   internal error
 >= 200	       tool error

$NAME version: $VERSION"

##################################
# command line parsing functions #
##################################

# setup global variables
#
# Call this once at the start of the shell script.
#
function global_variable_setup
{
    local n	# loop index

    # setup
    #
    export VERSION="0.2 2023-12-29"
    NAME=$(basename "$0")
    export NAME
    #
    export V_FLAG=0
    export NOOP=0
    export DO_NOT_PROCESS=0
    export TOPDIR=
    export REPO_URL="https://github.com/ioccc-src/temp-test-ioccc"
    export REPO_NAME="temp-test-ioccc"
    export MD2HTML_CFG=
    export BEFORE_TOOL=
    export BEFORE_TOOL_OPTSTR=
    export PANDOC_WRAPPER="inc/pandoc_wapper.sh"
    export PANDOC_WRAPPER_OPTSTR=
    export AFTER_TOOL=
    export AFTER_TOOL_OPTSTR=
    unset TOKEN
    declare -Ag TOKEN
    export CAP_S_FLAG=
    unset OUTPUT_TOOL
    declare -ag OUTPUT_TOOL
    unset OUTPUT_TOOL_OPTSTR
    declare -Ag OUTPUT_TOOL_OPTSTR
    export MATCH_OPTIONS=

    # determine path to topdir if we are in a git repo
    #
    GIT_TOOL=$(type -P git)
    export GIT_TOOL
    if [[ -z "$GIT_TOOL" ]]; then
	echo "$0: FATAL: git tool is not installed or not in PATH" 1>&2
	exit 10
    fi
    "$GIT_TOOL" rev-parse --is-inside-work-tree >/dev/null 2>&1
    status="$?"
    if [[ $status -eq 0 ]]; then
	TOPDIR=$("$GIT_TOOL" rev-parse --show-toplevel)
    fi

    # setup phase names in phase array
    #
    unset PHASE_NAME
    declare -ag PHASE_NAME
    PHASE_NAME=(top head body header topnav begin-row begin-leftcolumn sidenav end-leftcolumn
		end-leftcolumn begin-rightcolumn before-content before-content after-content
		end-row footer bottom)
    unset HTML_PHASE_NAME
    declare -Ag HTML_PHASE_NAME
    for n in "${PHASE_NAME[@]}"; do
	HTML_PHASE_NAME[$n]="default"
    done

    # initialize command line parse pass number
    #
    export GETOPT_PHASE=0
}

# print the usage message, exit code and version information
#
# Call this to print the usage message, by default to stdout.
# However one might usually want to do:
#
#	print_usage 1>&2
#
function print_usage
{
    # print usage message
    #
    echo "$USAGE"
}

# parse command line arguments
#
# You MUST call this function at least once AND after calling global_variable_setup.
# You may call this function again, after setting a new command line args. For example:
#
#	global_variable_setup	# must be first
#	parse_command_line	# parse the command line given to the shell script
#
#	# collect and parse command line arguments
#	ARG="$1"		# for example, grab only the first command line argument
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
#	# set new command like options and parse them
#	set -- -s token0=value0 -o inc/foo.sh -O inc/foo.sh="-v 3" -s token1=vaulue1
#	parse_command_line
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
#	# set new command like options and parse them
#	set -- -s token2=value2 -o inc/bar.sh -O inc/bar.sh="-v 1" -s token4=vaulue4
#	parse_command_line
#
#	# do whatever you need to do in terms of validating the resulting effect on
#	# global variables and validating command like options
#
#	# perform the actions as needed
#
function parse_command_line
{
    local flag		# getopts found flag
    local NAME_VALUE	# name=value string
    local NAME		# name from name=value
    local VALUE		# value from name=value

    # setup that will effectively clear any previous getopts state
    #
    unset OPTIND

    # parse command line
    #
    while getopts :hv:VnNd:c:H:b:B:p:P:a:A:s:So:O:e:E: flag; do
      case "$flag" in
	h) print_usage 1>&2
	    exit 2
	    ;;
	v) V_FLAG="$OPTARG"
	    ;;
	V) echo "$VERSION"
	    exit 2
	    ;;
	n) NOOP="true"
	    ;;
	N) DO_NOT_PROCESS="true"
	    ;;
	d) # -d only in getopt phase 0
	    if [[ $GETOPT_PHASE -ne 0 ]]; then
		echo "$0: ERROR: -d may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    TOPDIR="$OPTARG"
	    ;;
	c) # -c only in getopt phase 0
	    if [[ $GETOPT_PHASE -ne 0 ]]; then
		echo "$0: ERROR: -c may only be used during getopt phase 0, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    MD2HTML_CFG="$OPTARG"
	    ;;
	H) # parse: -H phase=name
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # name cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, name cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # name cannot contain a /
	    if [[ $NAME == *'/'* ]]; then
		echo "$0: ERROR: -H name=value, name cannot contain a / character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # name must be a known phase name
	    if [[ -z ${HTML_PHASE_NAME[$NAME]} ]]; then
		echo "$0: ERROR: -H name=value, name is unknown" 1>&2
		for n in "${PHASE_NAME[@]}"; do
		    echo "$0: notice: valid name: $n"
		done 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # treat VALUE of . as an HTML PHASE name unset
	    #
	    if [[ $VALUE == . ]]; then
		# unset phase name
		HTML_PHASE_NAME[$NAME]=
	    else
		# change phase name
		HTML_PHASE_NAME[$NAME]="$VALUE"
	    fi
	    ;;
	b) # parse: -p tool
	    if [[ $OPTARG == . ]]; then
		# unset before tool
		BEFORE_TOOL=
	    else
		# change before tool
		BEFORE_TOOL="$OPTARG"
	    fi
	    ;;
	B) BEFORE_TOOL_OPTSTR="$OPTARG"
	    ;;
	p) # parse -p tool
	    if [[ $OPTARG == . ]]; then
		# unset pandoc wrapper tool
		PANDOC_WRAPPER=
	    else
		# change pandoc wrapper tool
		PANDOC_WRAPPER="$OPTARG"
	    fi
	    ;;
	P) PANDOC_WRAPPER_OPTSTR="$OPTARG"
	    ;;
	a) # parse: -a tool
	    if [[ $OPTARG == . ]]; then
		# unset after tool
		AFTER_TOOL=
	    else
		# change after tool
		AFTER_TOOL="$OPTARG"
	    fi
	    ;;
	A) AFTER_TOOL_OPTSTR="$OPTARG"
	    ;;
	s) # parse: -s token=value
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # token cannot contain a ;
	    if [[ $NAME == *';'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a ; character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a %
	    if [[ $NAME == *'%'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a % character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # value cannot contain a ;
	    if [[ $VALUE == *';'* ]]; then
		echo "$0: ERROR: -H name=value, value cannot contain a ; character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # set %%token%% value
	    TOKEN[$NAME]="$VALUE"
	    ;;
	S) CAP_S_FLAG="true"
	    ;;
	o) # -o only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -ne 0 && $GETOPT_PHASE -ne 2 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 2, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    OUTPUT_TOOL+=("$OPTARG")
	    ;;
	O) # -O only in getopt phase 0 and 1
	    if [[ $GETOPT_PHASE -ne 0 && $GETOPT_PHASE -ne 2 ]]; then
		echo "$0: ERROR: -o may only be used during getopt phase 0 and 2, current getopt phase: $GETOPT_PHASE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    #
	    # parse: -O tool=optstr
	    NAME_VALUE="$OPTARG"
	    case "$NAME_VALUE" in
	    *=*) # parse name=value
		NAME=${NAME_VALUE%%=*}
		VALUE=${NAME_VALUE#*=}
		;;
	    *) echo "$0: ERROR: -H option not in phase=name form" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
		;;
	    esac
	    # token cannot contain a =
	    if [[ $NAME == *'='* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a = character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a double-quote
	    if [[ $NAME == *'"'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a double-quote character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # token cannot contain a single-quote
	    if [[ $NAME == *'"'* ]]; then
		echo "$0: ERROR: -H name=value, token cannot contain a single-quote character: $NAME_VALUE" 1>&2
		echo 1>&2
		print_usage 1>&2
		exit 3
	    fi
	    # set tool optstr value
	    OUTPUT_TOOL_OPTSTR[$NAME]="$VALUE"
	    ;;
	e) echo "$OPTARG" 1>&2
	    ;;
	E) exit "$OPTARG"
	    ;;
	\?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	:) echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
	*) echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	    echo 1>&2
	    print_usage 1>&2
	    exit 3
	    ;;
      esac
    done
}

#################################
# md2html.cfg related functions #
#################################

# first file_glob match for md2html.cfg file
#
# usage:
#	match_md2html md2html_path file_path
#
#	md2html_path	md2html.cfg configuration file path
#	file_path	file path to match in md2html.cfg
#
# returns:
#	0	file_path matched in md2html_path
#	1	file_path not matched
#   >= 10	internal error
#
# NOTE: This function sets MATCH_OPTIONS to the cfg_options set of
#	the first line from md2html_path with a file_glob that matches file_path.
#
function match_md2html
{
    local MD2HTML_PATH;		# path to md2html.cfg file
    local FILE_PATH;		# file path to match in md2html.cfg
    local FILE_GLOB;		# file pattern from the md2html.cfg file
    local CFG_OPTIONS;		# args associated with file pattern from the md2html.cfg file
    local NO_MATCH_FOUND;	# 0 ==> found a match in md2html.cfg, =! 0 ==> no match found

    # parse args
    #
    if [[ $# -ne 2 ]]; then
	echo "$0: ERROR: match_md2html requires 2 args, found: $#" 1>&2
	exit 11
    fi
    MD2HTML_PATH="$1"
    FILE_PATH="$2"

    # md2html.cfg must be a non-empty file
    #
    if [[ ! -s $MD2HTML_PATH ]]; then
	echo "$0: ERROR: md2html_path is not a non-empty file: $MD2HTML_PATH" 1>&2
	exit 12
    fi

    # scan md2html.cfg for first match
    #
    NO_MATCH_FOUND=1
    sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' < "$MD2HTML_PATH" | while read -r FILE_GLOB CFG_OPTIONS; do
	# SC2053 (warning): Quote the right-hand side of == in [[ ]] to prevent glob matching.
	# shellcheck disable=SC2053
	if [[ $FILE_PATH == $FILE_GLOB ]]; then
	    if [[ $V_FLAG -ge 5 ]]; then
		echo "$0: debug[5]: file_path: $FILE_PATH matches file_glob: $FILE_GLOB" 1>&2
	    fi
	    MATCH_OPTIONS="$CFG_OPTIONS"
	    NO_MATCH_FOUND=0
	    break
	fi
    done

    # return 0 if match was found
    #
    if [[ $NO_MATCH_FOUND -eq 0 ]]; then
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: cfg_options matches file_path: $FILE_PATH: $CFG_OPTIONS" 1>&2
	fi
	return 0
    fi

    # no match
    #
    MATCH_OPTIONS=
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: file_path: $FILE_PATH no match found" 1>&2
    fi
    return 1
}

###################################
# required initial variable setup #
###################################

global_variable_setup

##################
# getopt phase 0 #
##################

# set getopt phase to 0
#
GETOPT_PHASE=0

# process command line options
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: after parse_command_line of getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 1 ]]; then
    echo "$0: ERROR: phase ${GETOPT_PHASE} parse_command_line call expected 1 arg, found: $#" 1>&2
    exit 3
fi
#
export WINNER_PATH="$1"
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: WINNER_PATH=$WINNER_PATH" 1>&2
fi

# verify that we have a topdir directory
#
if [[ -z $TOPDIR ]]; then
    echo "$0: ERROR: cannot find top of git repo directory" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 13
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: TOPDIR is not a directory: $TOPDIR" 1>&2
    echo "$0: Notice: if needed: $GIT_TOOL clone $REPO_URL; cd $REPO_NAME" 1>&2
    exit 14
fi

# verify that we have in inc directory
#
export INC="$TOPDIR/inc"
if [[ ! -d $TOPDIR/inc ]]; then
    echo "$0: ERROR: inc is not a directory under TOPDIR/inc: $TOPDIR/inc" 1>&2
    exit 15
fi

# verify we have a readable md2html.cfg file
#
if [[ -z $MD2HTML_CFG ]]; then
    MD2HTML_CFG="$INC/md2html.cfg"
fi
if [[ ! -e $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg does not exist: $MD2HTML_CFG" 1>&2
    exit 16
fi
if [[ ! -f $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a file: $MD2HTML_CFG" 1>&2
    exit 17
fi
if [[ ! -r $MD2HTML_CFG ]]; then
    echo "$0: ERROR: md2html.cfg is not a readable file: $MD2HTML_CFG" 1>&2
    exit 18
fi

# cd to topdir
#
if [[ ! -e $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to non-existent path: $TOPDIR" 1>&2
    exit 19
fi
if [[ ! -d $TOPDIR ]]; then
    echo "$0: ERROR: cannot cd to a non-directory: $TOPDIR" 1>&2
    exit 20
fi
export CD_FAILED
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: about to: cd $TOPDIR" 1>&2
fi
cd "$TOPDIR" || CD_FAILED="true"
if [[ -n $CD_FAILED ]]; then
    echo "$0: ERROR: cd $TOPDIR failed" 1>&2
    exit 21
fi
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: now in directory: $(/bin/pwd)" 1>&2
fi

# verify that WINNER_PATH is a winner directory
#
# WINNER_PATH must be in yyyy/dir form
# yyyy must be a directory
# yyyy must be a writible directory
# yyyy/.year must be a non-empty file
# yyyy/dir must be a directory
# yyyy/dir/.path must be a non-empty file
# WINNER_PATH must match the contents of yyyy/dir/.path
#
if [[ ! -d $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a directory: $WINNER_PATH" 1>&2
    exit 5
fi
if [[ ! -w $WINNER_PATH ]]; then
    echo "$0: ERROR: arg is not a writable directory: $WINNER_PATH" 1>&2
    exit 5
fi
export YEAR_DIR=${WINNER_PATH%%/*}
if [[ -z $YEAR_DIR ]]; then
    echo "$0: ERROR: arg not in yyyy/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
export WINNER_DIR=${WINNER_PATH#*/}
if [[ -z $WINNER_DIR ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH not in $YEAR_DIR/dir form: $WINNER_PATH" 1>&2
    exit 5
fi
if [[ $WINNER_DIR = */* ]]; then
    echo "$0: ERROR: dir from arg: $WINNER_PATH contains a /: $WINNER_DIR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR ]]; then
    echo "$0: ERROR: yyyy from arg: $WINNER_PATH is not a directory: $YEAR_DIR" 1>&2
    exit 5
fi
export DOT_YEAR="$YEAR_DIR/.year"
if [[ ! -s $DOT_YEAR ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_YEAR" 1>&2
    exit 5
fi
if [[ ! -d $YEAR_DIR/$WINNER_DIR ]]; then
    echo "$0: ERROR: yyyy/dir from arg: $WINNER_PATH is not a directory: $YEAR_DIR/$WINNER_DIR" 1>&2
    exit 5
fi
export DOT_PATH="$YEAR_DIR/$WINNER_DIR/.path"
if [[ ! -s $DOT_PATH ]]; then
    echo "$0: ERROR: not a non-empty file: $DOT_PATH" 1>&2
    exit 5
fi
DOT_PATH_CONTENT=$(< "$DOT_PATH")
if [[ $WINNER_PATH != "$DOT_PATH_CONTENT" ]]; then
    echo "$0: ERROR: arg: $WINNER_PATH does not match $DOT_PATH contents: $DOT_PATH_CONTENT" 1>&2
    exit 5
fi

# setup README_PATH and INDEX_PATH based on YEAR_DIR and WINNER_DIR
#
export README_PATH="$YEAR_DIR/$WINNER_DIR/README.md"
if [[ ! -e $README_PATH ]]; then
    echo "$0: ERROR: file does not exist: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -f $README_PATH ]]; then
    echo "$0: ERROR: not a file: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -r $README_PATH ]]; then
    echo "$0: ERROR: not a readable file: $README_PATH" 1>&2
    exit 5
fi
if [[ ! -s $README_PATH ]]; then
    echo "$0: ERROR: readable file is empty: $README_PATH" 1>&2
    exit 5
fi
#
export INDEX_PATH="$YEAR_DIR/$WINNER_DIR/index.html"
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: YEAR_DIR=$YEAR_DIR" 1>&2
    echo "$0: debug[3]: WINNER_DIR=$WINNER_DIR" 1>&2
    echo "$0: debug[3]: DOT_YEAR=$DOT_YEAR" 1>&2
    echo "$0: debug[3]: DOT_PATH=$DOT_PATH" 1>&2
    echo "$0: debug[3]: README_PATH=$README_PATH" 1>&2
    echo "$0: debug[3]: INDEX_PATH=$INDEX_PATH" 1>&2
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

##################
# getopt phase 1 #
##################

# set getopt phase to 1
#
GETOPT_PHASE=1
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

# run output tools and parse output as more options
#
# report output tools and output tool options
if [[ $V_FLAG -ge 5 ]]; then
    for n in "${!OUTPUT_TOOL[@]}"; do
	VALUE="${OUTPUT_TOOL[$n]}"
	echo "$0: debug[5]: phase ${GETOPT_PHASE} -o output tool: $VALUE args: ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    done
fi

# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 6
    fi
done

# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool: $VALUE ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    fi
    # SC2046 (warning): Quote this to prevent word splitting.
    # SC2086 (info): Double quote to prevent globbing and word splitting.
    # shellcheck disable=SC2046,SC2086
    OUTPUT_TOOL_OUTPUT=$("$VALUE" ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- "${WINNER_PATH}")
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool output: $OUTPUT_TOOL_OUTPUT" 1>&2
    fi

    # process command line arguments from output tool
    #
    if [[ -n $OUTPUT_TOOL_OUTPUT ]]; then

	# parse output tool options
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# shellcheck disable=SC2086
	parse_command_line $OUTPUT_TOOL_OUTPUT

	# parse output tool arguments
	#
	shift $(( OPTIND - 1 ));
	#
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool file argument count: $#" 1>&2
	fi
	if [[ $# -ne 1 ]]; then
	    echo "$0: ERROR: phase ${GETOPT_PHASE} output tool expected 1 arg, found: $#" 1>&2
	    exit 3
	fi
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool produced no output" 1>&2
    fi
done

# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTSTR
declare -Ag OUTPUT_TOOL_OPTSTR
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

##################
# getopt phase 2 #
##################

# set getopt phase to 2
#
GETOPT_PHASE=2
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

# find the first match md2html.cfg for README_PATH
#
match_md2html "$MD2HTML_CFG" "$README_PATH"
status="$?"
if [[ $status -ne 0 ]]; then
    echo "$0: ERROR: README_PATH: $README_PATH does not match any lines in: $MD2HTML_CFG" 1>&2
    exit 22
fi

# set new options from match md2html.cfg for README_PATH
#
# SC2086 (info): Double quote to prevent globbing and word splitting.
# shellcheck disable=SC2086
set -- $MATCH_OPTIONS

# parse the command line options
#
parse_command_line "$@"

# parse the command line arguments
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: after phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
#
shift $(( OPTIND - 1 ));
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: phase ${GETOPT_PHASE} parse_command_line call file argument count: $#" 1>&2
fi
if [[ $# -ne 0 ]]; then
    echo "$0: ERROR: phase ${GETOPT_PHASE} parse_command_line call expected 0 args, found: $#" 1>&2
    exit 3
fi
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

##################
# getopt phase 3 #
##################

# set getopt phase to 3
#
GETOPT_PHASE=3
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

# run output tools and parse output as more options
#
# report output tools and output tool options
if [[ $V_FLAG -ge 5 ]]; then
    for n in "${!OUTPUT_TOOL[@]}"; do
	VALUE="${OUTPUT_TOOL[$n]}"
	echo "$0: debug[5]: phase ${GETOPT_PHASE} -o output tool: $VALUE args: ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    done
fi

# verify output tools are executable
#
for n in "${!OUTPUT_TOOL[@]}"; do
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[ ! -e "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not found: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -f "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not a file: $VALUE" 1>&2
	exit 6
    fi
    if [[ ! -x "$VALUE" ]]; then
	echo "$0: ERROR: phase ${GETOPT_PHASE} -o output tool not an executable file: $VALUE" 1>&2
	exit 6
    fi
done

# execute each output tool and parse the output tool's options and arguments
#
for n in "${!OUTPUT_TOOL[@]}"; do

    # obtain output from the output tool
    #
    VALUE="${OUTPUT_TOOL[$n]}"
    if [[  $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} about to call output tool: $VALUE ${OUTPUT_TOOL_OPTSTR[$VALUE]}" 1>&2
    fi
    # SC2046 (warning): Quote this to prevent word splitting.
    # SC2086 (info): Double quote to prevent globbing and word splitting.
    # shellcheck disable=SC2046,SC2086
    OUTPUT_TOOL_OUTPUT=$("$VALUE" ${OUTPUT_TOOL_OPTSTR[$VALUE]} -- "${WINNER_PATH}")
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool output: $OUTPUT_TOOL_OUTPUT" 1>&2
    fi

    # process command line arguments from output tool
    #
    if [[ -n $OUTPUT_TOOL_OUTPUT ]]; then

	# parse output tool options
	#
	# SC2086 (info): Double quote to prevent globbing and word splitting.
	# shellcheck disable=SC2086
	parse_command_line $OUTPUT_TOOL_OUTPUT

	# parse output tool arguments
	#
	shift $(( OPTIND - 1 ));
	#
	if [[ $V_FLAG -ge 7 ]]; then
	    echo "$0: debug[7]: phase ${GETOPT_PHASE} output tool file argument count: $#" 1>&2
	fi
	if [[ $# -ne 0 ]]; then
	    echo "$0: ERROR: phase ${GETOPT_PHASE} output tool expected 0 args, found: $#" 1>&2
	    exit 3
	fi
    elif [[ $V_FLAG -ge 5 ]]; then
	echo "$0: debug[5]: phase ${GETOPT_PHASE} output tool produced no output" 1>&2
    fi
done

# clear output tools and output tool options
#
unset OUTPUT_TOOL
declare -ag OUTPUT_TOOL
unset OUTPUT_TOOL_OPTSTR
declare -Ag OUTPUT_TOOL_OPTSTR
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: end getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi

############################################
# debugging after getopt phase is complete #
############################################

# set getopt phase to 4
#
GETOPT_PHASE=4
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: begin getopt phase ${GETOPT_PHASE} debug level: $V_FLAG" 1>&2
fi
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: finished all getopt parsing" 1>&2
fi

# validate HTML phase names
#
for n in "${PHASE_NAME[@]}"; do
    HTML_PHASE_FILE="$INC/$n.${HTML_PHASE_NAME[$n]}.html"
    if [[ $V_FLAG -ge 9 ]]; then
	echo "$0: debug[9]: HTML phase $n: ${HTML_PHASE_NAME[$n]} file: $HTML_PHASE_FILE" 1>&2
    fi
    if [[ ! -e "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n file not found: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
    if [[ ! -f "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n not a file: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
    if [[ ! -r "$HTML_PHASE_FILE" ]]; then
	echo "$0: ERROR: HTML phase $n not a readable file: $HTML_PHASE_FILE" 1>&2
	exit 7
    fi
done

# validate before tool
#
if [[ -n $BEFORE_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $BEFORE_TOOL ]]; then
	    echo "$0: debug[5]: -b before tool: $BEFORE_TOOL" 1>&2
	fi
	if [[ -n $BEFORE_TOOL_OPTSTR ]]; then
	    echo "$0: debug[5]: -B before tool options: $BEFORE_TOOL_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not found: $BEFORE_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -f "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not a file: $BEFORE_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -x "$BEFORE_TOOL" ]]; then
	echo "$0: ERROR: -b before tool not an executable file: $BEFORE_TOOL" 1>&2
	exit 6
    fi
fi

# validate pandoc wrapper tool
#
if [[ -n $PANDOC_WRAPPER_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $PANDOC_WRAPPER_TOOL ]]; then
	    echo "$0: debug[5]: -p pandoc wrapper tool: $PANDOC_WRAPPER_TOOL" 1>&2
	fi
	if [[ -n $PANDOC_WRAPPER_TOOL_OPTSTR ]]; then
	    echo "$0: debug[5]: -P pandoc wrapper tool options: $PANDOC_WRAPPER_TOOL_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$PANDOC_WRAPPER_TOOL" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not found: $PANDOC_WRAPPER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -f "$PANDOC_WRAPPER_TOOL" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not a file: $PANDOC_WRAPPER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -x "$PANDOC_WRAPPER_TOOL" ]]; then
	echo "$0: ERROR: -p pandoc wrapper tool not an executable file: $PANDOC_WRAPPER_TOOL" 1>&2
	exit 6
    fi
fi

# validate after tool
#
if [[ -n $AFTER_TOOL ]]; then
    if [[ $V_FLAG -ge 5 ]]; then
	if [[ -n $AFTER_TOOL ]]; then
	    echo "$0: debug[5]: -a after tool: $AFTER_TOOL" 1>&2
	fi
	if [[ -n $AFTER_TOOL_OPTSTR ]]; then
	    echo "$0: debug[5]: -A after tool options: $AFTER_TOOL_OPTSTR" 1>&2
	fi
    fi
    if [[ ! -e "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not found: $AFTER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -f "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not a file: $AFTER_TOOL" 1>&2
	exit 6
    fi
    if [[ ! -x "$AFTER_TOOL" ]]; then
	echo "$0: ERROR: -a after tool not an executable file: $AFTER_TOOL" 1>&2
	exit 6
    fi
fi

# report TOKEN sed patterns
#
if [[ $V_FLAG -ge 5 ]]; then
    for n in "${!TOKEN[@]}"; do
	VALUE="${TOKEN[$n]}"
	echo "$0: debug[5]: -s token replacement: sed -e s;%%$n%%;$VALUE;g" 1>&2
    done
fi

# XXX - write more code here - XXX #
#
echo "$0: Notice: if $0 was complete, $README_PATH would be used to form $INDEX_PATH" 1>&2
exit 0
