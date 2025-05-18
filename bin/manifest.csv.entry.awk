#!/usr/bin/env awk
#
# manifest.csv.entry.awk - output manifest csv from a entry's manifest as found in its .entry.json file
#
# usage:
#
#	awk -f bin/manifest.csv.entry.awk YYYY/dir/.entry.json
#
# where:
#
#	YYYY		IOCCC year or mock
#	dir		name of entry's directory under YYYY containing .entry.json
#
# For example:
#
#	awk -f bin/manifest.csv.entry.awk 1984/mullender/.entry.json

# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the .entry.json file  - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX

BEGIN {

    # setup
    #
    VERSION="1.0.1 2025-05-17"
    NAME = "manifest.csv.entry.awk"
    found_manifest_array = 0;	# 1 ==> we found the manifest ARRAY
    within_manifest_array = 0;	# 1 ==> found start of "manifest" : [ JSON array
    begin_manifest_element = 0;	# 1 ==> we have found the start of the manifest array element

    # extract YYYY and dir from file argument
    #
    YYYY = "";
    dir = "";
    tmp = ARGV[1];
    gsub(/\.entry\.json$/, "", tmp);
    arg_path_count = split(tmp, part, "/");
    if (arg_path_count >= 2) {
	dir=part[arg_path_count-1];
	YYYY=part[arg_path_count-2];
    }
    if (length(dir) == 0) {
	exit 211;	# END section will output ERROR message about cannot find dir
    }
    if (length(YYYY) == 0) {
	exit 212;	# END section will output ERROR message about cannot find YYYY
    }

    # error if YYYY is not a number in the range [1984, 9999]
    #
    if (YYYY !~ /^[[:digit:]]+$/ || YYYY < 1984 || YYYY > 9999) {
        exit 213;       # invalid year
    }
}

# look for the start of "manifest" JSON array
#
# We look for a line with 3 tokens:
#
#	"manifest" : [
#
NF == 3 && $1 ~ /^"manifest"$/ && $2 ~ /^:$/ && $3 ~ /^\[$/ {

    # note we have found the start of "manifest" JSON array
    #
    found_manifest_array = 1;
    within_manifest_array = 1;
    begin_manifest_element = 0;
}

# after start of "manifest" JSON array, process start of a manifest array element
#
# We have just seen the start of "manifest" JSON array:
#
#	"manifest" : [
#
# Now, when we see a line of this form:
#
#	{
#
# we know that we are about to see the start of one of the manifest array elements.
#
within_manifest_array == 1 && NF == 1 && $1 ~ /^{$/ {

    # note the start of the manifest array element
    #
    begin_manifest_element = 1;

    # clear values for the JSON members of this manifest array elements
    #
    file_path = "";
    inventory_order = "";
    OK_to_edit = "";
    display_as = "";
    display_via_github = "";
    entry_text = "";

    # clear unquoted values for the JSON members of this manifest array elements
    #
    unquote_file_path = "";
    unquote_inventory_order = "";
    unquote_OK_to_edit = "";
    unquote_display_as = "";
    unquote_display_via_github = "";
    unquote_entry_text = "";
}

# record file_path from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"file_path" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"file_path"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    file_path = $0;

    # Remove any trailing ,
    #
    if (file_path ~ /,$/) {
	file_path = substr(file_path, 1, length(file_path)-1);
    }

    # remove any enclosing double quotes
    #
    if (file_path ~ /^".*"$/) {
	unquote_file_path = substr(file_path, 2, length(file_path)-2);
    } else {
	unquote_file_path = file_path;
    }
}

# record inventory_order from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"inventory_order" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"inventory_order"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    inventory_order = $0;

    # Remove any trailing ,
    #
    if (inventory_order ~ /,$/) {
	inventory_order = substr(inventory_order, 1, length(inventory_order)-1);
    }

    # remove any enclosing double quotes
    #
    if (inventory_order ~ /^".*"$/) {
	unquote_inventory_order = substr(inventory_order, 2, length(inventory_order)-2);
    } else {
	unquote_inventory_order = inventory_order;
    }
}

# record OK_to_edit from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"OK_to_edit" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"OK_to_edit"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    OK_to_edit = $0;

    # Remove any trailing ,
    #
    if (OK_to_edit ~ /,$/) {
	OK_to_edit = substr(OK_to_edit, 1, length(OK_to_edit)-1);
    }

    # remove any enclosing double quotes
    #
    if (OK_to_edit ~ /^".*"$/) {
	unquote_OK_to_edit = substr(OK_to_edit, 2, length(OK_to_edit)-2);
    } else {
	unquote_OK_to_edit = OK_to_edit;
    }
}

# record display_as from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"display_as" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"display_as"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    display_as = $0;

    # Remove any trailing ,
    #
    if (display_as ~ /,$/) {
	display_as = substr(display_as, 1, length(display_as)-1);
    }

    # remove any enclosing double quotes
    #
    if (display_as ~ /^".*"$/) {
	unquote_display_as = substr(display_as, 2, length(display_as)-2);
    } else {
	unquote_display_as = display_as;
    }
}

# record display_via_github from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"display_via_github" : something,
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"display_via_github"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    display_via_github = $0;

    # Remove any trailing ,
    #
    if (display_via_github ~ /,$/) {
	display_via_github = substr(display_via_github, 1, length(display_via_github)-1);
    }

    # remove any enclosing double quotes
    #
    if (display_via_github ~ /^".*"$/) {
	unquote_display_via_github = substr(display_via_github, 2, length(display_via_github)-2);
    } else {
	unquote_display_via_github = display_via_github;
    }
}

# record entry_text from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"entry_text" : something
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"entry_text"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    entry_text = $0;

    # Remove any trailing ,
    #
    if (entry_text ~ /,$/) {
	entry_text = substr(entry_text, 1, length(entry_text)-1);
    }

    # remove any enclosing double quotes
    #
    if (entry_text ~ /^".*"$/) {
	unquote_entry_text = substr(entry_text, 2, length(entry_text)-2);
    } else {
	unquote_entry_text = entry_text;
    }
}

# process end of manifest array element - print manifest csv line for this entry
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF == 1 && $1 ~ /^},?$/ {

    # verify we have seen a file_path JSON member
    #
    if (length(file_path) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a file_path JSON member in:", ARGV[1] > "/dev/stderr";
	exit 213;
    }

    # verify we have seen a inventory_order JSON member
    #
    if (length(inventory_order) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a inventory_order JSON member in:", ARGV[1] > "/dev/stderr";
	exit 214;
    }

    # verify we have seen a OK_to_edit JSON member
    #
    if (length(OK_to_edit) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a OK_to_edit JSON member in:", ARGV[1] > "/dev/stderr";
	exit 215;
    }

    # verify we have seen a display_as JSON member
    #
    if (length(display_as) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a display_as JSON member in:", ARGV[1] > "/dev/stderr";
	exit 216;
    }

    # verify we have seen a display_via_github JSON member
    #
    if (length(display_via_github) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a display_via_github JSON member in:", ARGV[1] > "/dev/stderr";
	exit 217;
    }

    # verify we have seen a entry_text JSON member
    #
    if (length(entry_text) == 0) {
	print "ERROR:", NAME ": manifest array JSON member did not have a entry_text JSON member in:", ARGV[1] > "/dev/stderr";
	exit 218;
    }

    # print manifest csv line for this entry
    #
    print YYYY "," dir "," unquote_file_path "," unquote_inventory_order "," unquote_OK_to_edit "," unquote_display_as "," unquote_display_via_github "," unquote_entry_text;

    # note the end of the manifest array element
    #
    begin_manifest_element = 0;

    # note if we found the end of the manifest array
    #
    if ($1 ~ /^}$/) {
	within_manifest_array = 0;
    }
}

END {

    # case: invalid YYYY
    #
    if (length(YYYY) == 0) {
	print "ERROR:", NAME ": cannot determine YYYY from:", ARGV[1] > "/dev/stderr";
	exit 220;	# END section will output ERROR message about cannot find YYYY
    }
    if (YYYY !~ /^[[:digit:]]+$/ || YYYY < 1984 || YYYY > 9999) {
	print "ERROR:", NAME ": YYYY: must be 4 digit integer >= 1984 and <= 9999, found: " YYYY;
        exit 221;       # invalid year
    }

    # case: we quit because we could not determine dir from ARGV[1]
    #
    if (length(dir) == 0) {
	print "ERROR:", NAME ": cannot determine dir from:", ARGV[1] > "/dev/stderr";
	exit 222;	# END section will output ERROR message about cannot find dir
    }

    # case: no manifest array was found
    #
    if (!found_manifest_array) {
	print "ERROR:", NAME ": we did not find a manifest JSON array in:", ARGV[1] > "/dev/stderr";
	exit 223;
    }

    # case: manifest array was found, but manifest array element did not finish
    #
    if (begin_manifest_element) {
	print "ERROR:", NAME ": manifest JSON array element did not end in:", ARGV[1] > "/dev/stderr";
	exit 224;
    }

    # case: manifest array did not end
    #
    if (within_manifest_array) {
	print "ERROR:", NAME ": manifest JSON array did not end in:", ARGV[1] > "/dev/stderr";
	exit 225;
    }
}
