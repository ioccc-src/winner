#!/usr/bin/env bash
#
# fix_numbers_csv - fix the exported CSV files from numbers
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
export MISSING_MANIFEST_CSV="missing_manifest.csv"
export FULL_MANIFEST_CSV="full_manifest.csv"
export TMP_CSV

# process files that exist
#
for i in "$MANIFEST_CSV" "$MISSING_MANIFEST_CSV"; do

    # process if non-empty file exists
    #
    if [[ -s $i ]]; then

	# setup temp file
	#
	TMP_CSV="tmp.$$.$i"
	rm -f "$TMP_CSV"
	if [[ -e $TMP_CSV ]]; then
	    echo "$0: ERROR: TMP_CSV cannot be removed: $TMP_CSV" 1>&2
	    exit 10
	fi

	# remove carriage returns
	#
	trap 'rm -f $TMP_CSV; exit' 0 1 2 3 15
	tr -d '\015' < "$i" > "$TMP_CSV"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s failed, error: %s\n" "$i" "$TMP_CSV" "$status" 1>&2
	    exit 11
	fi
	if [[ ! -s $TMP_CSV ]]; then
	    printf "$0: ERROR: TMP_CSV: tr -d '\\\015' < %s > %s produced a empty file" "$i" "$TMP_CSV" 1>&2
	    exit 12
	fi

	# sort file and remove duplicates
	#
	sort -u -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 "$TMP_CSV" -o "$TMP_CSV"
	status="$?"
	if [[ $status -ne 0 ]]; then
	    printf "$0: ERROR: sort -u -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 %s -o %s failed, error: %s\n" "$TMP_CSV" "$TMP_CSV" "$status" 1>&2
	    exit 13
	fi

	# append newline if last line is not empty
	#
	LAST_CHAR=$(tail -c 1 "$TMP_CSV")
	if [[ -n $LAST_CHAR ]]; then
	    echo "" >> "$TMP_CSV"
	fi

	# replace CSV file if different
	#
	if ! cmp -s "$TMP_CSV" "$i"; then

	    # replace CSV file with a better formatted version
	    #
	    echo "$0: updating $i"
	    mv -f -v "$TMP_CSV" "$i"
	    status="$?"
	    if [[ $status -ne 0 ]]; then
		echo "$0: ERROR: mv -f -v $TMP_CSV $i failed, error: $status" 1>&2
		exit 14
	    fi

	else

	    # CSV file is OK, remove the tmp file
	    #
	    rm -f "$TMP_CSV"
	    if [[ -e $TMP_CSV ]]; then
		echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
		exit 15
	    fi
	fi
    fi
done

# setup the full manifest
#
TMP_CSV="tmp.$$.$FULL_MANIFEST_CSV"
sed -e '/^# -/d' "$MANIFEST_CSV" "$MISSING_MANIFEST_CSV" |
    sort -u -t, -k1,1 -k2d,2 -k3g,3 -k4d,10 > "$TMP_CSV"
if [[ ! -s $TMP_CSV ]]; then
    echo "$0: ERROR: sorted $MANIFEST_CSV $MISSING_MANIFEST_CSV is empty" 1>&2
    exit 16
fi
if ! cmp -s "$TMP_CSV" "$FULL_MANIFEST_CSV"; then

    # replace full CSV file if different
    #
    echo "$0: updating $FULL_MANIFEST_CSV"
    mv -f -v "$TMP_CSV" "$FULL_MANIFEST_CSV"
    status="$?"
    if [[ $status -ne 0 ]]; then
	echo "$0: ERROR: mv -f -v $TMP_CSV $FULL_MANIFEST_CSV failed, error: $status" 1>&2
	exit 17
    fi

else

    # fill CSV file is OK, remove the tmp file
    #
    rm -f "$TMP_CSV"
    if [[ -e $TMP_CSV ]]; then
	echo "$0: ERROR: TMP_CSV cannot be removed for cleanup: $TMP_CSV" 1>&2
	exit 18
    fi
fi

# All Done!!! -- Jessica Noll, Age 2
#
exit 0
