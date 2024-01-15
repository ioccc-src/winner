#!/usr/bin/env awk
#
# subst.winner-navbar.awk - output substitutions for navbar on behalf of a winner
#
# usage:
#
#	awk -v winner_path=YYYY/dir -f bin/subst.winner-navbar.awk YYYY/.year
#
# where:
#
#	YYYY	IOCCC year or mock
#	dir	name of winner directory under YYYY

BEGIN {

    # setup
    #
    VERSION="1.0 2024-01-14"
    process_next_line = 0;	# 1 ==> we found our winner_path, now process the next line
    found_winner_path = 0;	# 1 ==> we found our winner_path
    prev_line = "";		# the previous YYYY/dir line
    topnav_phase = "mid";	# topnav name to use (-H topnav=topnav_phase)

    # error if github is not set via -v github=REPO_URL
    #
    if (length(winner_path) == 0) {
	exit 200;
    }
}

# process YYYY/dir lines
#
$0 ~ /[^\/]+\/[^\/]+/ {

    # split line into year (file[1]) and dir (file[2])
    #
    len = split($0, file, "/");
    if (len != 2) {
	# ERROR: invalid split of a YYYY/dir line
	print "-e 'invalid split of:", $0, "expected 2 part, found:", len "'";
	print "-E 201";
	exit
    }
    year = file[1];
    dir = file[2];

    # if we need the line after we found our winner_path
    #
    if (process_next_line) {

	# process the line after we found our winner_path
	#
	# report the previous entry for this year
	print "-s 'RIGHT_LINK=../" dir "/index.html'";
	print "-s 'RIGHT_TEXT=" dir "'";
	process_next_line = 0;

    # if we found our winner_path
    #
    } else if (winner_path == $0) {

	# in case our our winner_path is the 1st line
	#
	if (NR == 1) {
	    # no previous line winner_path is the 1st line
	    topnav_phase = "first";
	}

	# process the previous YYYY/dir line with this match
	#
	if (prev_line) {

	    # split previous line into year (file[1]) and dir (file[2])
	    #
	    prev_len = split(prev_line, file, "/");
	    if (prev_len != 2) {
		# ERROR: invalid split of a previous YYYY/dir line
		print "-e 'invalid split of:", prev_line "expected 2 part, found:", prev_len "'";
		print "-E 202";
		exit
	    }
	    prev_year = file[1];
	    prev_dir = file[2];
	    if (year != prev_year) {
		# ERROR: previous YYYY/dir YYYY does not match current line
		print "-e 'previous line:", prev_line "year:", prev_year, "!= current line year:", year "'";
		print "-E 203";
	    }

	    # report the next entry for this year
	    print "-s 'LEFT_LINK=../" prev_dir "/index.html'";
	    print "-s 'LEFT_TEXT=" prev_dir "'";
	}

	# process our found winner_path
	#
	# report up link top year index.html
	print "-s 'UP_LINK=../index.html'";
	print "-s 'UP_TEXT=" year "'";
	process_next_line = 1;
	found_winner_path = 1;
    }

    # save the line as the next previous line
    #
    prev_line = $0;
}

# report any non-YYYY/dir line
#
$0 !~ /[^\/]+\/[^\/]+/ {

    # bogus line found
    print "-e 'found a non-YYYY/dir line in", ARGV[1] ":", $0 "'";
    print "-E 204";
    exit
}

END {

    # error if github is not set via -v github=REPO_URL
    #
    if (length(winner_path) == 0) {
	print "-e 'ERROR: github variable not set, call with -v github=REPO_URL'";
	print "-E 200";		# use 200 to match exit code from BEGIN
	exit 200		# use 200 to match exit code from BEGIN
    }

    # output inventory link information
    #
    print "-s 'INVENTORY_LINK=#inventory'";
    print "-s 'INVENTORY_TEXT=Inventory'";

    # case: we did not find our winner_path
    #
    if (!found_winner_path) {
	# ERROR: winner_path was not found
	print "-e 'we did not find:", winner_path "'";
	print "-E 205";
	exit

    } else if (process_next_line) {
	# no next line winner_path is the last line
	topnav_phase = "last";
    }

    # output the topnav phase name
    #
    print "-H 'topnav=" topnav_phase "'";
}
