#!/usr/bin/env bash
#
# gen_author_json - generate author/author_handle.json files
#
# Generate the initial contents of the author/author_handle.json using
# tmp/author_handle.txt and tmp/author.csv and tmp/author-wins.csv.
#
# XXX - This is a temporary utility that will be replaced when
#	the .entry.json files are built.
#
# Copyright (c) 2023,2024 by Landon Curt Noll.  All Rights Reserved.
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

# setup
#
export VERSION="1.1 2024-03-04"
NAME=$(basename "$0"); export NAME
export JSTRENCODE="../../mkiocccentry/jparse/jstrencode"
export LOCATION="../../mkiocccentry/soup/location"
#
export V_FLAG=0

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-V] author_handle.txt author.csv author-wins.csv author_dir

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-V		print version string and exit

	-t jstrencode=path	path of jstrencode utility (def: ../../mkiocccentry/jparse/jstrencode)
	-t location=path	path of location utility (def: ../../mkiocccentry/soup/location)

	author_handle.txt	author handle names, one per line
	author.csv		CSV of information about each author
	author-wins.csv		CSV showing wins for each author
	author_dir		directory to create with author_handle.json files

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    missing file (author_handle.txt, author.csv, author-wins.csv_
     5	    author_dir already exists or cannot be created
     6	    cannot find critical executable tool
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:Vt: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    V) echo "$VERSION"
	exit 2
	;;
    t) case "$OPTARG" in
       jstrencode=*)
	  JSTRENCODE=${OPTIND##jstrencode=}
	  ;;
       location=*)
	  LOCATION=${OPTIND##location=}
	  ;;
       *=*)
	  echo "$0: ERROR: -t tool=path is unknown" 1>&2
	  echo 1>&2
	  echo "$USAGE" 1>&2
	  ;;
       *) echo "$0: ERROR: -t optarg must be of the form -t tool=path" 1>&2
	  echo 1>&2
	  echo "$USAGE" 1>&2
	  exit 3
	  ;;
        esac
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
# verify arg count
#
if [[ $# -ne 4 ]]; then
    echo "$0: ERROR: expected 4 args, found: $#" 1>&2
    echo "$USAGE" 1>&2
    exit 3
fi
#
# parse args
#
export AUTHOR_HANDLE_TXT="$1"
if [[ ! -r $AUTHOR_HANDLE_TXT ]]; then
    echo "$0: ERROR: author_handle.txt not a readable file: $AUTHOR_HANDLE_TXT"
    exit 4
fi
export AUTHOR_CSV="$2"
if [[ ! -r $AUTHOR_CSV ]]; then
    echo "$0: ERROR: author.csv not a readable file: $AUTHOR_CSV"
    exit 4
fi
export AUTHOR_WINS="$3"
if [[ ! -r $AUTHOR_WINS ]]; then
    echo "$0: ERROR: author-wins.csv not a readable file: $AUTHOR_WINS"
    exit 4
fi
export AUTHOR_DIR="$4"
if [[ -e $AUTHOR_DIR ]]; then
    echo "$0: ERROR: author_dir exists: $AUTHOR_DIR"
    exit 4
fi
if [[ $V_FLAG -ge 1 ]]; then
    echo "$0: debug[1]: debug level: $V_FLAG" 1>&2
fi

# form the initial author_dir
#
mkdir -p "$AUTHOR_DIR"
if [[ ! -d $AUTHOR_DIR ]]; then
    echo "$0: ERROR: cannot mkdir author_dir $AUTHOR_DIR"
    exit 5
fi

# verify tool paths
#
if [[ ! -e $JSTRENCODE ]]; then
    echo "$0: ERROR: jstrencode does not exist: $JSTRENCODE" 1>&2
    exit 6
fi
if [[ ! -f $JSTRENCODE ]]; then
    echo "$0: ERROR: jstrencode is not a regular file: $JSTRENCODE" 1>&2
    exit 6
fi
if [[ ! -x $JSTRENCODE ]]; then
    echo "$0: ERROR: jstrencode not executable: $JSTRENCODE" 1>&2
    exit 6
fi
if [[ ! -e $LOCATION ]]; then
    echo "$0: ERROR: location does not exist: $LOCATION" 1>&2
    exit 6
fi
if [[ ! -f $LOCATION ]]; then
    echo "$0: ERROR: location is not a regular file: $LOCATION" 1>&2
    exit 6
fi
if [[ ! -x $LOCATION ]]; then
    echo "$0: ERROR: location not executable: $LOCATION" 1>&2
    exit 6
fi

# make is easier to process CSV files
#
IFS="$IFS,"

# process each author handle
#
grep -v '^#' "$AUTHOR_HANDLE_TXT" | while read -r AUTHOR_HANDLE; do

    # firewall - must be unique author handle
    #
    AUTHOR_HANDLE_JSON="$AUTHOR_DIR/$AUTHOR_HANDLE.json"
    export AUTHOR_HANDLE_JSON
    if [[ -e $AUTHOR_HANDLE_JSON ]]; then
	echo "$0: ERROR: AUTHOR_HANDLE.json file already exists: $AUTHOR_HANDLE_JSON" 1>&2
	exit 10
    fi
    if [[ $V_FLAG -ge 3 ]]; then
	echo "$0: debug[3]: processing author handle: $AUTHOR_HANDLE" 1>&2
    fi
    touch "$AUTHOR_HANDLE_JSON"
    if [[ ! -e $AUTHOR_HANDLE_JSON ]]; then
	echo "$0: ERROR: cannot create AUTHOR_HANDLE.json file: $AUTHOR_HANDLE_JSON" 1>&2
	exit 11
    fi

    # firewall - must have 1 and only 1 line in author.csv
    #
    FOUND_AUTHOR_CSV_COUNT=$(grep -v '^#' "$AUTHOR_CSV" 2>/dev/null | grep -c "^[^,]*,[^,]*,$AUTHOR_HANDLE," 2>/dev/null)
    if [[ $FOUND_AUTHOR_CSV_COUNT -ne 1 ]]; then
	echo "$0: ERROR: expected to find one entry for $AUTHOR_HANDLE in $AUTHOR_CSV, found: $FOUND_AUTHOR_CSV_COUNT" 1>&2
	exit 12
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: grep -v '^#' \"$AUTHOR_CSV\" 2>/dev/null | grep -c \"^[^,]*,[^,]*,$AUTHOR_HANDLE,\" 2>/dev/null" 1>&2
    fi

    # firewall - must have 1 and only 1 line in author-wins.csv
    #
    FOUND_AUTHOR_WINS_COUNT=$(grep -v '^#' "$AUTHOR_WINS" 2>/dev/null | grep -c "^$AUTHOR_HANDLE," 2>/dev/null)
    if [[ $FOUND_AUTHOR_WINS_COUNT -ne 1 ]]; then
	echo "$0: ERROR: expected to find one entry for $AUTHOR_HANDLE in $AUTHOR_WINS, found: $FOUND_AUTHOR_WINS_COUNT" 1>&2
	exit 13
    fi
    if [[ $V_FLAG -ge 7 ]]; then
	echo "$0: debug[7]: grep -v '^#' \"$AUTHOR_WINS\" 2>/dev/null | grep -c \"^$AUTHOR_HANDLE,\" 2>/dev/null" 1>&2
    fi

    # obtain their author.csv data for this author handle
    #
    # The format of author.csv is:
    #
    # # sort_word,name,author_handle,url,email,location_code,deprecated_twitter,mastodon,alternate_url,
    #
    # 0:    lower case sort word
    # 1:    name
    # 2:    author_handle
    # 3:    url
    # 4:    email address
    # 5:    location ISO 3166 code
    # 6:    deprecated twitter handle
    # 7:    mastodon handle
    # 8:    alternate url
    #
    grep -v '^#' "$AUTHOR_CSV" 2>/dev/null | grep "^[^,]*,[^,]*,$AUTHOR_HANDLE," 2>/dev/null |
	while IFS="," read -r SORT_WORD NAME AUTHOR_HANDLE_FROM_AUTHOR_CSV URL EMAIL LOCATION_CODE DEPRECATED_TWITTER \
			      MASTODON ALTERNATE_URL EXTRA; do

	# parse CSV values
	#
	export SORT_WORD NAME AUTHOR_HANDLE_FROM_AUTHOR_CSV URL EMAIL LOCATION_CODE DEPRECATED_TWITTER
	export MASTODON ALTERNATE_URL EXTRA
	if [[ $V_FLAG -ge 9 ]]; then
	    echo "$0: debug[9]: SORT_WORD: $SORT_WORD"
	    echo "$0: debug[7]: NAME: $NAME"
	    echo "$0: debug[7]: author_handle: $AUTHOR_HANDLE_FROM_AUTHOR_CSV"
	    echo "$0: debug[7]: URL: $URL"
	    echo "$0: debug[7]: EMAIL: $EMAIL"
	    echo "$0: debug[7]: LOCATION_CODE: $LOCATION_CODE"
	    echo "$0: debug[7]: DEPRECATED_TWITTER: $DEPRECATED_TWITTER"
	    echo "$0: debug[7]: MASTODON: $MASTODON"
	    echo "$0: debug[7]: ALTERNATE_URL: $ALTERNATE_URL"
	    echo "$0: debug[7]: EXTRA: $EXTRA"
	fi
	if [[ -z $SORT_WORD ]]; then
	    echo "$0: ERROR: cannot find SORT_WORD for author handle $AUTHOR_HANDLE In $AUTHOR_CSV" 1>&2
	    exit 14
	fi
	if [[ -z $NAME ]]; then
	    echo "$0: ERROR: cannot find NAME for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 15
	fi
	if [[ -z $AUTHOR_HANDLE_FROM_AUTHOR_CSV ]]; then
	    echo "$0: ERROR: cannot find author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 16
	fi
	if [[ -z $URL ]]; then
	    echo "$0: ERROR: cannot find URL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 17
	fi
	if [[ -z $EMAIL ]]; then
	    echo "$0: ERROR: cannot find EMAIL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 18
	fi
	if [[ -z $LOCATION_CODE ]]; then
	    echo "$0: ERROR: cannot find LOCATION_CODE for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 19
	fi
	if [[ -z $DEPRECATED_TWITTER ]]; then
	    echo "$0: ERROR: cannot find DEPRECATED_TWITTER for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 20
	fi
	if [[ -z $MASTODON ]]; then
	    echo "$0: ERROR: cannot find MASTODON for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 21
	fi
	if [[ -z $ALTERNATE_URL ]]; then
	    echo "$0: ERROR: cannot find ALTERNATE_URL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 22
	fi
	if [[ -n $EXTRA ]]; then
	    echo "$0: ERROR: found unexpected data for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 23
	fi

	# convert "null" to empty values for fields that can use them, object to null for fields that do not want them
	#
	if [[ $SORT_WORD = "null" ]]; then
	    echo "$0: ERROR: found null SORT_WORD for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 24
	fi
	if [[ $NAME = "null" ]]; then
	    echo "$0: ERROR: found null NAME for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 25
	fi
	if [[ $AUTHOR_HANDLE_FROM_AUTHOR_CSV = "null" ]]; then
	    echo "$0: ERROR: found null author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 26
	fi
	if [[ $LOCATION_CODE = "null" ]]; then
	    LOCATION_CODE=""
	fi
	if [[ $DEPRECATED_TWITTER = "null" ]]; then
	    DEPRECATED_TWITTER=""
	fi

	# verify that the AUTHOR_HANDLE_FROM_AUTHOR_CSV from the AUTHOR_CSV file matches the author handle
	#
	if [[ $AUTHOR_HANDLE != "$AUTHOR_HANDLE_FROM_AUTHOR_CSV" ]]; then
	    echo "$0: ERROR: author handle: $AUTHOR_HANDLE_FROM_AUTHOR_CSV mismatch for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 27
	fi

	# if location code is non-empty, verify it is valid by obtaining the location name
	#
	export LOCATION_NAME=""
	if [[ -n $LOCATION_CODE ]]; then
	    LOCATION_NAME=$("$LOCATION" -- "$LOCATION_CODE" 2>/dev/null)
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: LOCATION_CODE: $LOCATION_CODE invalid for for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
		exit 28
	    fi
	fi

	# form the mastodon url from the mastodon handle
	#
	export MASTODON_URL=""
	if [[ -n $MASTODON ]]; then
	    # verify mastodon handle is of the form @user@server
	    #
	    case "$MASTODON" in
	    null)
		MASTODON_URL="null";
		;;
	    @*@*)
		AT_MASTODON_USER=${MASTODON%@*}
		if [[ -z $AT_MASTODON_USER ]]; then
		    echo "$0: ERROR: failed to parse @user in MASTODON: $MASTODON is"
			"for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
		    exit 29
		fi
		MASTODON_SERVER=${MASTODON##*@}
		if [[ -z $MASTODON_SERVER ]]; then
		    echo "$0: ERROR: failed to extract server from MASTODON: $MASTODON is"
			"for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
		    exit 30
		fi
		MASTODON_URL="https://$MASTODON_SERVER/$AT_MASTODON_USER"
	        ;;
	    *) echo "$0: ERROR: MASTODON: $MASTODON is not of the form @user@server"
		    "for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	       exit 31
	    esac
	fi

	# for AUTHOR_HANDLE_JSON, we need to translate strings
	#
	SORT_WORD=$("$JSTRENCODE" -n -- "$SORT_WORD" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode SORT_WORD for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 32
	fi
	NAME=$("$JSTRENCODE" -n -- "$NAME" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode NAME for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 33
	fi
	AUTHOR_HANDLE_FROM_AUTHOR_CSV=$("$JSTRENCODE" -n -- "$AUTHOR_HANDLE_FROM_AUTHOR_CSV" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 34
	fi
	URL=$("$JSTRENCODE" -n -- "$URL" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode URL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 35
	fi
	EMAIL=$("$JSTRENCODE" -n -- "$EMAIL" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode EMAIL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 36
	fi
	LOCATION_CODE=$("$JSTRENCODE" -n -- "$LOCATION_CODE" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode LOCATION_CODE for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 37
	fi
	LOCATION_NAME=$("$JSTRENCODE" -n -- "$LOCATION_NAME" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode LOCATION_NAME for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 38
	fi
	DEPRECATED_TWITTER=$("$JSTRENCODE" -n -- "$DEPRECATED_TWITTER" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode DEPRECATED_TWITTER for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 39
	fi
	MASTODON=$("$JSTRENCODE" -n -- "$MASTODON" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode MASTODON for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 40
	fi
	MASTODON_URL=$("$JSTRENCODE" -n -- "$MASTODON_URL" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode MASTODON_URL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 41
	fi
	ALTERNATE_URL=$("$JSTRENCODE" -n -- "$ALTERNATE_URL" 2>/dev/null)
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to JSON encode ALTERNATE_URL for author handle $AUTHOR_HANDLE in $AUTHOR_CSV" 1>&2
	    exit 42
	fi

	# determine the winning entry set for the author handle
	#
	WINS=$(grep -v '^#' "$AUTHOR_WINS" 2>/dev/null |
	       grep "^$AUTHOR_HANDLE," 2>/dev/null |
	       sed -e "s/^$AUTHOR_HANDLE,//" -e "s/,$//")

	# verify that the author handle from the AUTHOR_WINS has at least 1 win
	#
	if [[ -z $WINS ]]; then
	    echo "$0: ERROR: author handle $AUTHOR_HANDLE as no win CSV fields in $AUTHOR_WINS" 1>&2
	    exit 43
	fi
	if [[ $V_FLAG -ge 5 ]]; then
	    echo "$0: debug[5]: author handle $AUTHOR_HANDLE wins: $WINS" 1>&2
	fi

	# now that we have all of the data validated write to the AUTHOR_HANDLE_JSON file
	#
        (

	    # print the start of the AUTHOR_HANDLE_JSON file
	    #
	    echo '{'
	    echo '    "no_comment" : "mandatory comment: because comments were removed from the original JSON spec",'
	    echo '    "author_JSON_format_version" : "1.1 2024-02-11",'

	    # print author handle related JSON members from AUTHOR_CSV
	    #
	    echo '    "author_handle" : "'"$AUTHOR_HANDLE"'",'
	    echo '    "full_name" : "'"$NAME"'",'
	    echo '    "sort_word" : "'"$SORT_WORD"'",'
	    if [[ $LOCATION_CODE == null || -z $LOCATION_CODE ]]; then
		echo '    "location_code" : null,'
	    else
		echo '    "location_code" : "'"$LOCATION_CODE"'",'
	    fi
	    if [[ $EMAIL == null || -z $EMAIL ]]; then
		echo '    "email" : null,'
	    else
		echo '    "email" : "'"$EMAIL"'",'
	    fi
	    if [[ $URL == null || -z $URL ]]; then
		echo '    "url" : null,'
	    else
		echo '    "url" : "'"$URL"'",'
	    fi
	    if [[ $ALTERNATE_URL == null || -z $ALTERNATE_URL ]]; then
		echo '    "alt_url" : null,'
	    else
		echo '    "alt_url" : "'"$ALTERNATE_URL"'",'
	    fi
	    if [[ $DEPRECATED_TWITTER == null || -z $DEPRECATED_TWITTER ]]; then
		echo '    "deprecated_twitter_handle" : null,'
	    else
		echo '    "deprecated_twitter_handle" : "'"$DEPRECATED_TWITTER"'",'
	    fi
	    if [[ $MASTODON == null || -z $MASTODON ]]; then
		echo '    "mastodon" : null,'
	    else
		echo '    "mastodon" : "'"$MASTODON"'",'
	    fi
	    if [[ $MASTODON_URL == null || -z $MASTODON_URL ]]; then
		echo '    "mastodon_url" : null,'
	    else
		echo '    "mastodon_url" : "'"$MASTODON_URL"'",'
	    fi
	    echo '    "github" : null,'
	    echo '    "affiliation" : null,'

	    # print the wins
	    #
	    echo '    "winning_entry_set" : ['
	    WIN_COUNT=$(echo "$WINS" | sed -e 's/,/\n/g' | wc -l)
	    export WIN_COUNT
	    export WIN_NUMBER=0
	    echo "$WINS" | sed -e 's/,/\n/g' | while read -r ENTRY_ID; do
		((++WIN_NUMBER))
		if [[ $WIN_NUMBER -lt $WIN_COUNT ]]; then
		    echo '	{ "entry_id" : "'"$ENTRY_ID"'" },'
		else
		    echo '	{ "entry_id" : "'"$ENTRY_ID"'" }'
		fi
	    done
	    echo '    ]'

	    # print the end of the AUTHOR_HANDLE_JSON file
	    #
	    echo '}'
	) > "$AUTHOR_HANDLE_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: failed to write $AUTHOR_HANDLE_JSON: error code: $status" 1>&2
	    exit 44
	fi

	# make the AUTHOR_HANDLE_JSON file read only
	#
	chmod 0444 "$AUTHOR_HANDLE_JSON"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    echo "$0: ERROR: chmod 0444 $AUTHOR_HANDLE_JSON: error code: $status" 1>&2
	    exit 45
	fi
    done
done

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
