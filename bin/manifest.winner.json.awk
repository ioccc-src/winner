#!/usr/bin/env awk
#
# manifest.winner.json.awk - output manifest table from a winner .winner.json file
#
# usage:
#
#	awk -v github=REPO_URL -f bin/manifest.winner.json.awk YYYY/dir/.winner.json
#
# where:
#
#	YYYY		IOCCC year or mock
#	dir		name of winner directory under YYYY containing .winner.json
#	REPO_URL	GitHub repo URL, e.g., https://github.com/ioccc-src/winner

# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have the jnamval command, we must FAKE PARSE the .winner.json file - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX

BEGIN {

    # setup
    #
    VERSION="1.0 2024-01-14"
    found_manifest_array = 0;	# 1 ==> we found the manifest ARRAY
    within_manifest_array = 0;	# 1 ==> found start of "manifest" : [ JSON array
    begin_manifest_element = 0;	# 1 ==> we have found the start of the manifest array element

    # error if github is not set via -v github=REPO_URL
    #
    if (length(github) == 0) {
	exit 200;	# END section will output ERROR message about github not set
    }

    # extract YYYY and dir from file argument
    #
    yyyy = "";
    dir = "";
    tmp = ARGV[1];
    gsub(/\.winner\.json$/, "", tmp);
    arg_path_count = split(tmp, part, "/");
    if (arg_path_count >= 2) {
	dir=part[arg_path_count-1];
	yyyy=part[arg_path_count-2];
    }
    if (length(dir) == 0) {
	exit 201;	# END section will output ERROR message about cannot find dir
    }
    if (length(yyyy) == 0) {
	exit 202;	# END section will output ERROR message about cannot find yyyy
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
    winners_text = "";

    # clear unquoted values for the JSON members of this manifest array elements
    #
    unquote_file_path = "";
    unquote_inventory_order = "";
    unquote_OK_to_edit = "";
    unquote_display_as = "";
    unquote_display_via_github = "";
    unquote_winners_text = "";
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

# record winners_text from an manifest array element
#
# We are looking for a JSON member line of the form:
#
#	"winners_text" : something
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF >= 3 && $1 ~ /^"winners_text"$/ && $2 ~ /^:$/ {

    # save JSON member value
    #
    # The JSON member value starts after the 1st and 2nd fields.
    # We remove any leading leading whitespace, such as the FS
    # between the 1st and 2nd fields, and between the 2nd and 3rd field.
    #
    $1 = ""; # remove 1st field
    $2 = ""; # remove 2nd field
    gsub(/^[[:space:]]+/, "", $0); # any leading whitespace
    winners_text = $0;

    # Remove any trailing ,
    #
    if (winners_text ~ /,$/) {
	winners_text = substr(winners_text, 1, length(winners_text)-1);
    }

    # remove any enclosing double quotes
    #
    if (winners_text ~ /^".*"$/) {
	unquote_winners_text = substr(winners_text, 2, length(winners_text)-2);
    } else {
	unquote_winners_text = winners_text;
    }
}

# process end of manifest array element
#
within_manifest_array == 1 && begin_manifest_element == 1 && NF == 1 && $1 ~ /^},?$/ {

    # verify we have seen a file_path JSON member
    #
    if (length(file_path) == 0) {
	print "ERROR: manifest array JSON member did not have a file_path JSON member in:", ARGV[1] > "/dev/stderr";
	exit 203;
    }

    # verify we have seen a inventory_order JSON member
    #
    if (length(inventory_order) == 0) {
	print "ERROR: manifest array JSON member did not have a inventory_order JSON member in:", ARGV[1] > "/dev/stderr";
	exit 204;
    }

    # verify we have seen a OK_to_edit JSON member
    #
    if (length(OK_to_edit) == 0) {
	print "ERROR: manifest array JSON member did not have a OK_to_edit JSON member in:", ARGV[1] > "/dev/stderr";
	exit 206;
    }

    # verify we have seen a display_as JSON member
    #
    if (length(display_as) == 0) {
	print "ERROR: manifest array JSON member did not have a display_as JSON member in:", ARGV[1] > "/dev/stderr";
	exit 207;
    }

    # verify we have seen a display_via_github JSON member
    #
    if (length(display_via_github) == 0) {
	print "ERROR: manifest array JSON member did not have a display_via_github JSON member in:", ARGV[1] > "/dev/stderr";
	exit 209;
    }

    # verify we have seen a winners_text JSON member
    #
    if (length(winners_text) == 0) {
	print "ERROR: manifest array JSON member did not have a winners_text JSON member in:", ARGV[1] > "/dev/stderr";
	exit 210;
    }

    # print manifest information
    #
    # print "# debug: file_path:", file_path;
    # print "# debug: inventory_order:", inventory_order;
    # print "# debug: OK_to_edit:", OK_to_edit;
    # print "# debug: display_as:", display_as;
    # print "# debug: display_via_github:", display_via_github;
    # print "# debug: winners_text:", winners_text;
    #
    # print "# debug: unquote_file_path:", unquote_file_path;
    # print "# debug: unquote_inventory_order:", unquote_inventory_order;
    # print "# debug: unquote_OK_to_edit:", unquote_OK_to_edit;
    # print "# debug: unquote_display_as:", unquote_display_as;
    # print "# debug: unquote_display_via_github:", unquote_display_via_github;
    # print "# debug: unquote_winners_text:", unquote_winners_text;
    #
    if (unquote_display_via_github == "false") {
        url = unquote_file_path;
    } else {
	url = github "/blob/master/" yyyy "/" dir "/" unquote_file_path;
    }
    print inventory_order, "* [" unquote_file_path "](" url ") -", unquote_winners_text;

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

    # case: we quit due to github unset
    #
    if (length(github) == 0) {
	print "ERROR: github variable not set, call with -v github=REPO_URL" > "/dev/stderr";
	exit 200;	# use 200 to match exit code from BEGIN
    }

    # case: we quit because we could not determine dir from ARGV[1]
    #
    if (length(dir) == 0) {
	print "ERROR: cannot determine dir from:", ARGV[1] > "/dev/stderr";
	exit 201;	# END section will output ERROR message about cannot find dir
    }

    if (length(yyyy) == 0) {
	print "ERROR: cannot determine yyyy from:", ARGV[1] > "/dev/stderr";
	exit 202;	# END section will output ERROR message about cannot find yyyy
    }

    # case: no manifest array was found
    #
    if (!found_manifest_array) {
	print "ERROR: we did not find a manifest JSON array in:", ARGV[1] > "/dev/stderr";
	exit 211;
    }

    # case: manifest array was found, but manifest array element did not finish
    #
    if (begin_manifest_element) {
	print "ERROR: manifest JSON array element did not end in:", ARGV[1] > "/dev/stderr";
	exit 212;
    }

    # case: manifest array did not end
    #
    if (within_manifest_array) {
	print "ERROR: manifest JSON array did not end in:", ARGV[1] > "/dev/stderr";
	exit 213;
    }
}
