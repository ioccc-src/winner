#!/usr/bin/env bash
#
# check_path_list.sh - look for problems with path_list.* files
#
# XXX - This is a temporary utility that will be replaced when
#	the .entry.json files are built
#

# setup
#
export REQUIRED_PATH_LIST="path_list.required.txt"
export BUILT_PATH_LIST="path_list.built.txt"
export MANIFEST_LIST="path_list.manifest.txt"
export FOUND_LIST="path_list.found.txt"
export EXIT_CODE=0

# firewall
#
if [[ ! -f $REQUIRED_PATH_LIST ]]; then
    echo "$0: ERROR: missing REQUIRED_PATH_LIST: $REQUIRED_PATH_LIST" 1>&2
    exit 10
fi
if [[ ! -s $REQUIRED_PATH_LIST ]]; then
    echo "$0: ERROR: REQUIRED_PATH_LIST is empty: $REQUIRED_PATH_LIST" 1>&2
    exit 11
fi
if [[ ! -f $BUILT_PATH_LIST ]]; then
    echo "$0: ERROR: missing BUILT_PATH_LIST: $BUILT_PATH_LIST" 1>&2
    exit 12
fi
if [[ ! -s $BUILT_PATH_LIST ]]; then
    echo "$0: ERROR: BUILT_PATH_LIST is empty: $BUILT_PATH_LIST" 1>&2
    exit 13
fi
if [[ ! -f $MANIFEST_LIST ]]; then
    echo "$0: ERROR: missing MANIFEST_LIST: $MANIFEST_LIST" 1>&2
    exit 14
fi
if [[ ! -s $MANIFEST_LIST ]]; then
    echo "$0: ERROR: MANIFEST_LIST is empty: $MANIFEST_LIST" 1>&2
    exit 15
fi
if [[ ! -f $FOUND_LIST ]]; then
    echo "$0: ERROR: missing FOUND_LIST: $FOUND_LIST" 1>&2
    exit 16
fi
if [[ ! -s $FOUND_LIST ]]; then
    echo "$0: ERROR: FOUND_LIST is empty: $FOUND_LIST" 1>&2
    exit 17
fi

# look for missing required files
#
export TMP_FILE="tmp.$$.missing"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
comm -23 "$REQUIRED_PATH_LIST" "$FOUND_LIST" | sort -t/ > "$TMP_FILE"
if [[ -s $TMP_FILE ]]; then
    COUNT=$(wc -l < "$TMP_FILE" | sed -e 's/^ *//')
    echo "# $0: Warning: missing required file count: $COUNT"
    EXIT_CODE=18	# exit 18
    echo "#"
    echo "# $0: missing required file list starts below"
    cat "$TMP_FILE"
    echo "# $0: missing required file list ends above"
fi
rm -f "$TMP_FILE"

# look for found files not in the manifest
#
export TMP_FILE="tmp.$$.missing"
trap 'rm -f $TMP_FILE; exit' 0 1 2 3 15
comm -13 "$MANIFEST_LIST" "$FOUND_LIST" | sort -t/ > "$TMP_FILE"
if [[ -s $TMP_FILE ]]; then
    COUNT=$(wc -l < "$TMP_FILE" | sed -e 's/^ *//')
    echo "# $0: Warning: found files not in the manifest count: $COUNT"
    EXIT_CODE=19	# exit 19
    echo "#"
    echo "# $0: found files not in the manifest list starts below"
    cat "$TMP_FILE"
    echo "# $0: found files not in the manifest list ends above"
fi
rm -f "$TMP_FILE"

# All Done!!! All Done!!! -- Jessica Noll, Age 2
#
if [[ $EXIT_CODE -ne 0 ]]; then
    echo "$0: Warning: about to exit: $EXIT_CODE" 1>&2
fi
exit "$EXIT_CODE"
