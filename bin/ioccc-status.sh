#!/usr/bin/env bash
# 
# ioccc_status.sh - quickly update status.json file
#
# Written by Cody Boone Ferguson in 2023:
#
#	@xexyl
#	https://xexyl.net		Cody Boone Ferguson
#	https://ioccc.xexyl.net
#
# If -s option is used, the status field is updated, providing that the status
# arg is either "closed" or "open".
#
# If the -d or -n flags are used then it will update the status_date or
# latest_news fields, respectively.
# 
# If the -i status_ver option is used the IOCCC_status_version field will be
# updated.
#
# The -N option is a dry-run: it will just show what would have been changed
# without the option.
#
# The -S option lets one set the path to sed(1).
#
# The -G option lets one set the path to grep(1).
#
export IOCCC_STATUS_SCRIPT_VERSION="0.0.5-0 2024-01-22" # major.minor.release-patch YYYY-MM-DD

SED="$(type -P sed)"
GREP="$(type -P grep)"

USAGE="usage: $(basename "$0") [-h] [-V] [-v level] [-s status] [-d] [-n] [-i status_ver] [-N] [-S] [-G] status.json

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -s status		    set contest status to open or closed

				NOTE: status must be one of \"open\" or \"closed\"

    -d			    update status_date
    -n			    update latest_news date
    -i status_ver	    update IOCCC_status_version

				NOTE: version must match the regexp: ^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$

    -N			    set dry-run mode: just show what would be changed (def: make changes)
    -S sed		    set path to sed(1) (def: $SED)
    -G grep		    set path to grep(1) (def: $GREP)

    status.json		    the file to update

status version: $IOCCC_STATUS_SCRIPT_VERSION"

export UPDATE_DATE=""
export UPDATE_NEWS=""
export UPDATE_IOCCC_STATUS_VERSION=""
export IOCCC_STATUS_VERSION=""
export VERBOSITY=0
export STATUS_JSON_FILE=""
export STATUS_FLAG=""
export STATUS="closed" # default closed
export DRY_RUN_MODE=""
export SED # already found default
export GREP # already found default

# parse args
#
while getopts :hVv:s:dni:NS:G: flag; do
    case "$flag" in
    h)	echo "$USAGE" 1>&2
	exit 2
	;;
    V)	echo "$IOCCC_STATUS_SCRIPT_VERSION" 1>&2
	exit 2
	;;
    v)	VERBOSITY="$OPTARG";
	;;
    s)	STATUS_FLAG="-s"
	STATUS="$OPTARG";
	;;
    d)	UPDATE_DATE="-d"
	;;
    n)	UPDATE_NEWS="-n"
	;;
    i)  UPDATE_IOCCC_STATUS_VERSION="-i"
	IOCCC_STATUS_VERSION="$OPTARG"
	;;
    N)	DRY_RUN_MODE="-N"
	;;
    S)	SED="$OPTARG"
	;;
    G)	GREP="$OPTARG"
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


# remove the options
#
shift $(( OPTIND - 1 ));

# verify arg count
#
if [[ $# != 1 ]]; then
    echo "$0: ERROR: expected exactly one arg, got: $#" 1>&2
    echo 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi

# parse args
#
if [[ $# -gt 0 ]]; then
    export STATUS_JSON_FILE="$1"
fi

# firewall STATUS_JSON_FILE must be a readable file
#
if [[ ! -e $STATUS_JSON_FILE ]]; then
    echo "$0: ERROR: status.json does not exist: $STATUS_JSON_FILE" 1>&2
    exit 1
fi
if [[ ! -f $STATUS_JSON_FILE ]]; then
    echo "$0: ERROR: status.json not a regular file: $STATUS_JSON_FILE" 1>&2
    exit 1
fi
if [[ ! -r $STATUS_JSON_FILE ]]; then
    echo "$0: ERROR: status.json not a readable file: $STATUS_JSON_FILE" 1>&2
    exit 1
fi
if [[ ! -w $STATUS_JSON_FILE ]]; then
    echo "$0: ERROR: status.json is not a writable file: $STATUS_JSON_FILE" 1>&2
    exit 1
fi

# check that $SED is an executable file
if [[ ! -x "$SED" ]]; then
    echo "$0: sed not an executable file: $SED" 1>&2
    exit 3
fi
# check that $GREP is an executable file
if [[ ! -x "$GREP" ]]; then
    echo "$0: grep not an executable file: $GREP" 1>&2
    exit 3
fi

# check that if -s ($STATUS_FLAG) used that the status ($STATUS) is either 'open' or 'closed'
#
if [[ -n "$STATUS_FLAG" ]]; then
    if [[ "$STATUS" != "open" && "$STATUS" != "closed" ]]; then
	echo "$0: ERROR: status must be 'open' or 'closed'" 1>&2
	exit 3
    fi
fi

# check format of IOCCC_status_version if set (-i used, $UPDATE_IOCCC_STATUS_VERSION)
#
if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
    echo "$IOCCC_STATUS_VERSION" | "$GREP" -qE '^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$'
    if [[ "${PIPESTATUS[1]}" -ne 0 ]]; then
	echo "$0: ERROR: IOCCC_status_version must match the regexp: '^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$'" 1>&2
	exit 3
    fi
fi

# get date for options that update the date
DATE="$(date)"
# if verbosity is >= 1 or dry-run specified show what would/will be updated
if [[ "$VERBOSITY" -ge 1 ]]; then
    echo "$0: status.json file: $STATUS_JSON_FILE" 1>&2
    if [[ -n "$STATUS_FLAG" ]]; then
	echo "$0: will update contest status to: \"$STATUS\"" 1>&2
    fi
    if [[ -n "$UPDATE_DATE" ]]; then
	echo "$0: will update status_date to: \"$DATE\"" 1>&2
    fi
    if [[ -n "$UPDATE_NEWS" ]]; then
	echo "$0: will update latest_news to: \"$DATE\"" 1>&2
    fi
    if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
	echo "$0: will update IOCCC_status_version to: \"$IOCCC_STATUS_VERSION\"" 1>&2
    fi
elif [[ -n "$DRY_RUN_MODE" ]]; then
    echo "$0: status.json file: $STATUS_JSON_FILE" 1>&2
    if [[ -n "$STATUS_FLAG" ]]; then
	echo "$0: would update contest status to: \"$STATUS\"" 1>&2
    fi
    if [[ -n "$UPDATE_DATE" ]]; then
	echo "$0: would update status_date to: \"$DATE\"" 1>&2
    fi
    if [[ -n "$UPDATE_NEWS" ]]; then
	echo "$0: would update latest_news to: \"$DATE\"" 1>&2
    fi
    if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
	echo "$0: would update IOCCC_status_version to: \"$IOCCC_STATUS_VERSION\"" 1>&2
    fi

    # nothing to do, exit success
    exit 0
fi

# first status_date if requested and not dry-run
if [[ -n "$UPDATE_DATE" ]]; then
    "$SED" -i'' "s|\"status_date\" : \".*[^\"]\"|\"status_date\" : \"$DATE\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -gt 1 ]]; then
	echo "$0: updated status_date to: \"$DATE\"" 1>&2
    fi
fi

# then update latest_news date if requested
if [[ -n "$UPDATE_NEWS" ]]; then
    "$SED" -i'' "s|\"latest_news\" : \".*[^\"]\"|\"latest_news\" : \"$DATE\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -gt 1 ]]; then
	echo "$0: updated latest_news to: \"$DATE\"" 1>&2
    fi
fi

# then update IOCCC_STATUS_VERSION if requested
if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
    "$SED" -i'' "s|\"IOCCC_status_version\" : \".*[^\"]\"|\"IOCCC_status_version\" : \"$IOCCC_STATUS_VERSION\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -gt 1 ]]; then
	echo "$0: updated IOCCC_status_version to: \"$IOCCC_STATUS_VERSION\"" 1>&2
    fi
fi

# finally if we need to change the status of the contest do so
if [[ -n "$STATUS_FLAG" ]]; then
    "$SED" -i'' "s|\"contest\" : \".*[^\"]\"|\"contest\" : \"$STATUS\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -gt 1 ]]; then
	echo "$0: updated contest status to: \"$STATUS\"" 1>&2
    fi
fi
exit 0
