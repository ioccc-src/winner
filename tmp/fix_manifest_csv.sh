#!/usr/bin/env bash
#
# fix_numbers_csv - fix the exported manifest CSV file, form path_list.* files
#
# When Apple numbers exports a CSV file from manifest.numbers,
# and exports a CSV file from missing-manifest.numbers,
# the CSV file lines are separated by carriage returns (\015)
# and is not terminated by a newline.  This script will "correct"
# these issues.
#
# XXX - This is a temporary utility that will be removed when
#	the .winner.json files are built

# setup
#
export MANIFEST_CSV="manifest.csv"
export TMP_CSV

if [[ ! -f $MANIFEST_CSV ]]; then
    echo "$0: ERROR: MANIFEST_CSV is missing: $MANIFEST_CSV" 1>&2
    exit 10
fi
if [[ ! -s $MANIFEST_CSV ]]; then
    echo "$0: ERROR: MANIFEST_CSV is empty: $MANIFEST_CSV" 1>&2
    exit 11
fi

# setup temp manifest CSV file
#
TMP_CSV="tmp.$$.$MANIFEST_CSV"
rm -f "$TMP_CSV"
if [[ -e $TMP_CSV ]]; then
    echo "$0: ERROR: TMP_CSV cannot be removed: $TMP_CSV" 1>&2
    exit 12
fi

# remove carriage returns in manifest CSV file
#
trap 'rm -f $TMP_CSV; exit' 0 1 2 3 15
tr -d '\015' < "$MANIFEST_CSV" > "$TMP_CSV"
status="$?"
if [[ $status -ne 0 ]]; then
    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s failed, error: %s\n" "$MANIFEST_CSV" "$TMP_CSV" "$status" 1>&2
    exit 13
fi
if [[ ! -s $TMP_CSV ]]; then
    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s produced an empty file" "$MANIFEST_CSV" "$TMP_CSV" 1>&2
    exit 14
fi

# fix manifest CSV
#

# sort manifest CSV file
#
sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 "$TMP_CSV" -o "$TMP_CSV"
status="$?"
if [[ $status -ne 0 ]]; then
    printf "$0: ERROR: sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 %s -o %s failed, error: %s\n" "$TMP_CSV" "$TMP_CSV" "$status" 1>&2
    exit 15
fi

# append newline if last line of manifest CSV file if not empty
#
LAST_CHAR=$(tail -c 1 "$TMP_CSV")
if [[ -n $LAST_CHAR ]]; then
    echo "" >> "$TMP_CSV"
fi

# replace manifest CSV file if different
#
if ! cmp -s "$TMP_CSV" "$MANIFEST_CSV"; then

    # replace CSV file with a better formatted version
    #
    echo "$0: updating $MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $MANIFEST_CSV failed, error: $status" 1>&2
	exit 16
    fi

else

    # CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 17
    fi
fi

# setup the full manifest path list
#
TMP_CSV="tmp.$$.$MANIFEST_CSV"
sed -e '/^# -/d' "$MANIFEST_CSV" |
    sort -u |
    sort -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 > "$TMP_CSV"
if [[ ! -s $TMP_CSV ]]; then
    echo "$0: ERROR: sorted $MANIFEST_CSV is empty" 1>&2
    exit 18
fi
if ! cmp -s "$TMP_CSV" "$MANIFEST_CSV"; then

    # replace full CSV file if different
    #
    echo "$0: updating $MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $MANIFEST_CSV failed, error: $status" 1>&2
	exit 19
    fi

else

    # fill CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 20
    fi
fi

# build required file path list
#
export REQUIRED_PATH_LIST="path_list.required.txt"
export TMP_FILE="tmp.$$.$REQUIRED_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && $5 == "null" { print $1 "/" $2 "/" $4; }' "$MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for required file list, is empty: $TMP_CSV" 1>&2
    exit 21
fi
if ! cmp -s "$TMP_FILE" "$REQUIRED_PATH_LIST"; then

    # replace required file
    #
    echo "$0: updating $REQUIRED_PATH_LIST"
    mv -f -v "$TMP_FILE" "$REQUIRED_PATH_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $REQUIRED_PATH_LIST failed, error: $status" 1>&2
	exit 22
    fi

else

    # required file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 23
    fi
fi

# build the built file path list
#
export BUILT_PATH_LIST="path_list.built.txt"
export TMP_FILE="tmp.$$.$BUILT_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
awk -F, '$1 !~ "^#" && $5 != "null" { print $1 "/" $2 "/" $4; }' "$MANIFEST_CSV" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for built file list, is empty: $TMP_CSV" 1>&2
    exit 24
fi
if ! cmp -s "$TMP_FILE" "$BUILT_PATH_LIST"; then

    # replace built file
    #
    echo "$0: updating $BUILT_PATH_LIST"
    mv -f -v "$TMP_FILE" "$BUILT_PATH_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $BUILT_PATH_LIST failed, error: $status" 1>&2
	exit 25
    fi

else

    # built file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 26
    fi
fi

# build manifest file list
#
export MANIFEST_LIST="path_list.manifest.txt"
export TMP_FILE="tmp.$$.$BUILT_PATH_LIST"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
cat "$REQUIRED_PATH_LIST" "$BUILT_PATH_LIST" | sort -t/ > "$TMP_FILE"
if [[ ! -s $TMP_FILE ]]; then
    echo "$0: ERROR: TMP_FILE, for manifest file list, is empty: $TMP_CSV" 1>&2
    exit 27
fi
if ! cmp -s "$TMP_FILE" "$MANIFEST_LIST"; then

    # replace manifest file
    #
    echo "$0: updating $MANIFEST_LIST"
    mv -f -v "$TMP_FILE" "$MANIFEST_LIST"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_FILE $MANIFEST_LIST failed, error: $status" 1>&2
	exit 28
    fi

else

    # manifest file list is OK, remove the tmp file
    #
    rm -f "$TMP_FILE"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_FILE cannot be removed for cleanup: $TMP_FILE" 1>&2
	exit 29
    fi
fi

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
