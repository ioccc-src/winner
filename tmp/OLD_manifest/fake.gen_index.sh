#!/usr/bin/env bash
#
# fake.gen_index.sh - generate a fake index.html file for an entry
#
# XXX - This is a temporary utility that will be replaced when
#	the .winner.json files are built
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

# setup
#
export VERSION="1.0.5 2023-10-31"
NAME=$(basename "$0"); export NAME
#
export V_FLAG=0
export DOMAIN="ioccc-src.github.io"
export DOCPATH="/temp-test-ioccc"
export GITHUB_REPO="https://github.com/ioccc-src/temp-test-ioccc"
export TOPDIR=".."

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-d www.domain.org] [-p /path/to/docroot] [-g github_url ] [-t topdir] year[/dir] [dir]

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)

	-d www.domain.org	change domain (def: $DOMAIN)
	-p /path/to/docroot	use path under domain to document root (def: $DOCPATH)
	-g github_url		path to the GitHub repo (def: $GITHUB_REPO)
	-t topdir		path to top of the local GitHub repo tree (def: $TOPDIR)

	year[/dir]		path to winner directory (or just year if there is a path arg
	[dir]			optional winner directory (1st arg is just year)

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find writable winner directory
 >= 10	    internal error

$NAME version: $VERSION"

# parse command line
#
while getopts :hv:d:p:g:t: flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v) V_FLAG="$OPTARG"
	;;
    d) DOMAIN="$OPTARG"
	;;
    p) DOCPATH="$OPTARG"
	;;
    g) GITHUB_REPO="$OPTARG"
	;;
    t) TOPDIR="$OPTARG"
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
# verify arg count and parse args
#
export WINNER_PATH
export YEAR
export WINNER
case "$#" in
1) WINNER_PATH="$1"
   YEAR="${WINNER_PATH%/*}"
   WINNER="${WINNER_PATH#*/}"
   ;;
2) WINNER_PATH="$1/$2"
   YEAR="$1"
   WINNER="$2"
   ;;
*) echo "$0: ERROR: expected 1 or 2 args, found: $#" 1>&2
   echo "$USAGE" 1>&2
   exit 3
   ;;
esac
export FULL_WINNER_PATH="$TOPDIR/$WINNER_PATH"

# form full URL
#
export URL_PATH="https://$DOMAIN$DOCPATH/$YEAR/$WINNER"
export URL_BASENAME="index.html"
export URL="$URL_PATH/$URL_BASENAME"
export GITHUB_URL_PATH="$GITHUB_REPO/$YEAR/$WINNER"
export GITHUB_URL="$GITHUB_URL_PATH/$URL_BASENAME"

# form Nu Html Checker doc url string
#
VALIDATOR_ENCODED_URL=$(echo "$URL" | sed -e 's;/;%2F;g' -e 's;:;%3A;')
export VALIDATOR_ENCODED_URL

# print running info if verbose
#
if [[ $V_FLAG -ge 5 ]]; then
    echo "$0: debug[5]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[5]: DOMAIN=$DOMAIN" 1>&2
    echo "$0: debug[5]: DOCPATH=$DOCPATH" 1>&2
    echo "$0: debug[5]: GITHUB_REPO=$GITHUB_REPO" 1>&2
    echo "$0: debug[5]: TOPDIR=$TOPDIR" 1>&2
    echo "$0: debug[5]: WINNER_PATH=$WINNER_PATH" 1>&2
    echo "$0: debug[5]: YEAR=$YEAR" 1>&2
    echo "$0: debug[5]: WINNER=$WINNER" 1>&2
    echo "$0: debug[5]: WINNER_PATH=$WINNER_PATH" 1>&2
    echo "$0: debug[5]: URL_PATH=$URL_PATH" 1>&2
    echo "$0: debug[5]: URL_BASENAME=$URL_BASENAME" 1>&2
    echo "$0: debug[5]: URL=$URL" 1>&2
    echo "$0: debug[5]: GITHUB_URL_PATH=$GITHUB_URL_PATH" 1>&2
    echo "$0: debug[5]: GITHUB_URL=$GITHUB_URL" 1>&2
    echo "$0: debug[5]: VALIDATOR_ENCODED_URL=$VALIDATOR_ENCODED_URL" 1>&2
fi

# make is easier to process CSV files
#
IFS="$IFS,"

# verify winner directory is writable
#
if [[ ! -e $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH does not exist: $FULL_WINNER_PATH" 1>&2
    exit 4
fi
if [[ ! -d $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH is not a directory: $FULL_WINNER_PATH" 1>&2
    exit 4
fi
if [[ ! -w $FULL_WINNER_PATH ]]; then
    echo  "$0: ERROR: FULL_WINNER_PATH is not a writable directory: $FULL_WINNER_PATH" 1>&2
    exit 4
fi

# build the index.html file
#
export INDEX_PATH="$FULL_WINNER_PATH/$URL_BASENAME"
export TMP_FILE="$FULL_WINNER_PATH/tmp.$$.$URL_BASENAME"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
cat > "$TMP_FILE" << EOF
<!DOCTYPE html>
<!-- -->
<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
<!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
<!-- !!! DO NOT MODIFY THIS FILE - This file is generated by a tool !!! -->
<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<!-- -->
<!-- file: $WINNER_PATH/$URL_BASENAME created by: $NAME version: $VERSION -->
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$YEAR $WINNER</title>
<meta name="description" content="IOCCC year: $YEAR IOCCC winner: $WINNER winner index page">
<meta name="keywords" content="IOCCC,$YEAR,$WINNER,winner index page">
</head>

<body>

<h1>$YEAR $WINNER</h1>

<p>XXX - fake content until readme2index is working - XXX</p>

<hr style="width:50%;text-align:left;margin-left:0">

<!-- Start Nu Html Checker -->
<p><a href="https://validator.w3.org/nu/?doc=$VALIDATOR_ENCODED_URL">Nu Html check $URL</a></p>
<!-- End Nu Html Checker -->

</body>
</html>
EOF

# update index.html if needed
#
if ! cmp -s "$TMP_FILE" "$INDEX_PATH"; then

    # replace index.html file
    #
    if [[ $V_FLAG -ge 1 ]]; then
	echo "$0: debug[1]: updating $INDEX_PATH"
    fi
    if [[ $V_FLAG -ge 1 ]]; then
	mv -f -v "$TMP_FILE" "$INDEX_PATH"
	status="$?"
    else
	mv -f "$TMP_FILE" "$INDEX_PATH"
	status="$?"
    fi
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $INDEX_PATH failed, error: $status" 1>&2
	exit 10
    fi

else

    # index.html is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_FILE ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 11
    fi
fi

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
exit 0
