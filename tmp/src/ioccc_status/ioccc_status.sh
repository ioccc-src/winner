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
export IOCCC_STATUS_SCRIPT_VERSION="0.0.2-0 2023-10-04" # major.minor.release-patch YYYY-MM-DD

USAGE="usage: $(basename "$0") [-h] [-V] [-v level] [-s status] [-d] [-n] [-i status_ver] status.json

    -h			    print help and exit
    -V			    print version and exit
    -v level		    set verbosity level
    -s status		    set contest status to open or closed

				NOTE: status must be one of \"open\" or \"closed\"

    -d			    update status_date
    -n			    update latest_news date
    -i status_ver	    update IOCCC_status_version

				NOTE: version must match the regexp: ^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$

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

# parse args
#
while getopts :hVv:s:dni: flag; do
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
    :)	echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
   *)
	;;
    esac
done

#
# remove the options
#
shift $(( OPTIND - 1 ));
#
# verify arg count
#
if [[ $# -gt 1 ]]; then
    echo "$0: ERROR: expected 0 or 1 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
#
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
    echo "$0: ERROR: status.json not a file: $STATUS_JSON_FILE" 1>&2
    exit 1
fi
if [[ ! -r $STATUS_JSON_FILE ]]; then
    echo "$0: ERROR: status.json not a readable file: $STATUS_JSON_FILE" 1>&2
    exit 1
fi

# check that if -s ($STATUS_FLAG) used that the status ($STATUS) is either 'open' or 'closed'
if [[ -n "$STATUS_FLAG" ]]; then
    if [[ "$STATUS" != "open" && "$STATUS" != "closed" ]]; then
	echo "$0: ERROR: status must be 'open' or 'closed'" 1>&2
	exit 3
    fi
fi

# check format of IOCCC_status_version if set (-i used, $UPDATE_IOCCC_STATUS_VERSION)
if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
    echo "$IOCCC_STATUS_VERSION" | grep -qE '^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$'
    if [[ "${PIPESTATUS[1]}" -ne 0 ]]; then
	echo "$0: ERROR: IOCCC_status_version must match the regexp: '^[0-9]+\.[0-9]+ [0-9]{4}-[0-9]{2}-[0-9]{2}$'" 1>&2
	exit 3
    fi
fi

if [[ "$VERBOSITY" -gt 1 ]]; then
    echo "$0: status.json file: $STATUS_JSON_FILE" 1>&2
    if [[ -n "$STATUS_FLAG" ]]; then
	echo "$0: will update contest status to: \"$STATUS\"" 1>&2
    fi
    if [[ -n "$UPDATE_DATE" ]]; then
	echo "$0: will update status_date to: $(date)" 1>&2
    fi
    if [[ -n "$UPDATE_NEWS" ]]; then
	echo "$0: will update latest_news to: $(date)" 1>&2
    fi
    if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
	echo "$0: will update IOCCC_status_version to: $IOCCC_STATUS_VERSION" 1>&2
    fi
fi

# first status_date if requested
if [[ -n "$UPDATE_DATE" ]]; then
    sed -i'' "s|\"status_date\" : \".*[^\"]\"|\"status_date\" : \"$(date)\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -ge 1 ]]; then
	echo "$0: updated status_date to: $(date)" 1>&2
    fi
fi

# then update latest_news date if requested
if [[ -n "$UPDATE_NEWS" ]]; then
    sed -i'' "s|\"latest_news\" : \".*[^\"]\"|\"latest_news\" : \"$(date)\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -ge 1 ]]; then
	echo "$0: updated latest_news to: $(date)" 1>&2
    fi
fi

# then update IOCCC_STATUS_VERSION if requested
if [[ -n "$UPDATE_IOCCC_STATUS_VERSION" ]]; then
    sed -i'' "s|\"IOCCC_status_version\" : \".*[^\"]\"|\"IOCCC_status_version\" : \"$IOCCC_STATUS_VERSION\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -ge 1 ]]; then
	echo "$0: updated IOCCC_status_version to: \"$IOCCC_STATUS_VERSION\"" 1>&2
    fi
fi

# finally if we need to change the status of the contest do so
if [[ -n "$STATUS_FLAG" ]]; then
    sed -i'' "s|\"contest\" : \".*[^\"]\"|\"contest\" : \"$STATUS\"|g" "$STATUS_JSON_FILE"

    if [[ "$VERBOSITY" -ge 1 ]]; then
	echo "$0: updated contest status to: \"$STATUS\"" 1>&2
    fi
fi
