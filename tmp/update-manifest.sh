#!/usr/bin/env bash
# 
# update-manifest.sh - temporary interactive script to update the IOCCC manifest
# step by step post manifest.csv export.
#
# Written by Cody Boone Ferguson in 2024 to greatly simplify fixing and
# improving the manifest of winning IOCCC entries. This script WILL GO AWAY when
# both the manifest and html issues are completed.
#

export UPDATE_MANIFEST_VERSION="0.0.1-1 2024-28-01" # format: major.minor.patch-release YYYY-DD-MM
NAME="$(basename "$0")"; export NAME

export V_FLAG=0
export A_FLAG=
# default -v 3 for other tools
export CAP_D_FLAG=3
export TOPDIR=".."
GIT="$(type -P git)"
export GIT

# usage
#
export USAGE="usage: $0 [-h] [-v level] [-D] [-g git] [-a]

	-h		print help message and exit
	-v level	set verbosity level (def level: $V_FLAG)
	-D level	set verbosity level (via -v level) in tool: (def level: $CAP_D_FLAG)

	-t topdir	path to top of the local GitHub repo tree (def: $TOPDIR)

	-a		automatically run git add an git commit commands (when prompted)
			    

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    user told us there is a problem
     5	    a tool exited non-zero

$NAME version: $UPDATE_MANIFEST_VERSION"

# parse command line
#
while getopts :hv:D:t:g:a flag; do
  case "$flag" in
    h) echo "$USAGE"
	exit 2
	;;
    v)	V_FLAG="$OPTARG"
	;;
    D)	CAP_D_FLAG="$OPTARG"
	;;
    t)	TOPDIR="$OPTARG"
    	;;
    g)	GIT="$OPTARG"
	;;
    a)	A_FLAG="-a"
	;;
    \?) echo "$0: ERROR: invalid option: -$OPTARG" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    :)	echo "$0: ERROR: option -$OPTARG requires an argument" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
    *)	echo "$0: ERROR: unexpected value from getopts: $flag" 1>&2
	echo 1>&2
	echo "$USAGE" 1>&2
	exit 3
	;;
  esac
done

# print running info if verbose
#
if [[ $V_FLAG -ge 3 ]]; then
    echo "$0: debug[3]: V_FLAG=$V_FLAG" 1>&2
    echo "$0: debug[3]: TOPDIR=$TOPDIR" 1>&2
fi

# first determine if git is executable
if [[ -z "$GIT" || ! -f "$GIT" || ! -x "$GIT" ]]; then
    echo "$0: ERROR: git not a regular executable file: $GIT" 1>&2
    exit 3
fi

# check that topdir is a directory and a git repo
#

# first verify $TOPDIR is not empty and that it's a directory
if [[ -z "$TOPDIR" ]]; then
    echo "$0: ERROR: topdir is empty: $TOPDIR" 1>&2
    exit 3
fi
if [[ ! -d "$TOPDIR" ]]; then
    echo "$0: ERROR: topdir not a directory: $TOPDIR" 1>&2
    exit 3
fi

# now cd to directory
#
if ! cd "$TOPDIR"; then
    echo "$0: could not cd to topdir: $TOPDIR" 1>&2
    exit 3
fi

# I have found problems using git rev-parse to verify that we're in a git repo
# and we need the user to see git status anyway so use git status instead.
if ! "$GIT" status 1>&2; then
    echo "$USAGE" 1>&2
    echo 1>&2
    echo "ERROR: ${PWD} is not a git repository" 1>&2
    exit 3
fi

echo 1>&2
echo "NOTE: manifest.numbers and manifest.csv may be modified here BUT NOTHING ELSE" 1>&2
echo "MAY BE UNLESS IT IS RELATED TO THE MANIFEST UPDATE ITSELF (e.g. rerunning to fix" 1>&2
echo "a problem or if the need for the manifest to be updated is because of the other" 1>&2
echo "changes)." 1>&2
read -r -p "Do you have a clean state from git status (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo 1>&2
    echo "exiting 4 due to user telling us that manifest.numbers and/or" 1>&2
    echo "manifest.csv NOT UPDATED." 1>&2
    exit 4
fi

# ask user if they're on the correct branch
#
echo "Showing branches: " 1>&2
"$GIT" branch 1>&2
read -r -p "Are you on the right branch (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo "exiting 4 due to user telling us they're on the WRONG BRANCH." 1>&2
    exit 4
fi

# now cd to the tmp directory
#
if ! cd tmp; then
    echo "$0: could not cd to tmp subdirectory of topdir: $TOPDIR"
    exit 3
fi

# now check that manifest.csv is a regular readable file
#
if [[ ! -f manifest.csv || ! -r manifest.csv ]]; then
    echo "manifest.csv does not exist or not a regular readable file" 1>&2
    exit 3
fi

# now ask user if they sorted the manifest.numbers AND exported it to the CSV
# file
echo "We will now try and update the manifest files. Are you sure that you updated" 1>&2
read -r -p "AND sorted the manifest.numbers spreadsheet AND exported to manifest.csv (Y/N)? "
if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
    echo "exiting 4 due to user not updating manifest files before running this tool" 1>&2
    exit 4
fi

# run ./fix_csv.sh first
#
echo "$(basename "$0"): now will run: ./fix_csv.sh -v $CAP_D_FLAG" 1>&2
if ! ./fix_csv.sh -v "$CAP_D_FLAG" ; then
    echo "fix_csv.sh failed, try updating manifest.csv and try again." 1>&2
    exit 5
fi

# run ./gen_path_list.found.sh
#
echo "$(basename "$0"): now will run: ./gen_path_list.found.sh -v $CAP_D_FLAG" 1>&2
if ! ./gen_path_list.found.sh -v "$CAP_D_FLAG" ; then
    echo "gen_path_list.found.sh failed, try updating manifest.csv and try again." 1>&2
    exit 5
fi

# now run git diff path_list.found.txt
#
read -r -n 1 -p "Press any key to run: $GIT diff path_list.found.txt: "
echo 1>&2
"$GIT" diff path_list.found.txt

read -r -p "Does everything look okay (Y/N)? "
if [[ "$REPLY" != "y" && "$REPLY" != "Y" ]]; then
    echo "exiting 4 due to user telling us that git diff path_list.found.txt DOES" 1>&2
    echo "NOT LOOK OKAY." 1>&2
    exit 4
fi

# run ./check_path_list.sh
#
echo "$(basename "$0"): now will run: ./check_path_list.sh -v $CAP_D_FLAG" 1>&2
if ! ./check_path_list.sh -v "$CAP_D_FLAG"; then
    echo "check_path_list.sh failed, try updating manifest.csv and try again." 1>&2
    exit 5
fi

echo "$0: now will run: $GIT archive HEAD manifest.numbers | tar -tvf - manifest.numbers" 1>&2
"$GIT" archive HEAD manifest.numbers | tar -tvf - manifest.numbers
read -r -p "Does everything look okay (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo "$0: exiting 4 due to user telling us there's a problem." 1>&2
    exit 4
fi

if [[ -n "$A_FLAG" ]]; then
    echo "Do you wish to automatically run the commands:" 1>&2
    echo "    $GIT add -u" 1>&2
    echo "    $GIT status" 1>&2
    echo "    $GIT commit -m'update manifest as per recent file changes'" 1>&2

    read -r -p "Enter your choice (Y/N): "
    if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
	echo "Now you should run the following commands in another terminal," 1>&2
	echo "making sure you're on the appropriate branch:"
	echo 1>&2
	echo "    git add -u" 1>&2
	echo "    git status" 1>&2
	echo "    git commit -m'update manifest as per recent file changes'" 1>&2
	echo 1>&2
	read -r -n 1 -p "Press any key when this is done: "
	echo 1>&2
    else
	"$GIT" add -u
	"$GIT" status
	"$GIT" commit -m'update manifest as per recent file changes'
    fi
else
    # user did not use -a, don't prompt: make them run commands in another
    # terminal first.
    echo "Now you should run the following commands in another terminal," 1>&2
    echo "making sure you're on the appropriate branch:"
    echo 1>&2
    echo "    git add -u" 1>&2
    echo "    git status" 1>&2
    echo "    git commit -m'update manifest as per recent file changes'" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key when this is done: "
    echo 1>&2
fi

echo 1>&2
echo "$(basename "$0"): now will run ./run_all.sh -v $CAP_D_FLAG ./gen_entry_json.sh" 1>&2
echo "NOTE: this step will take a while." 1>&2
if ! ./run_all.sh -v "$CAP_D_FLAG" ./gen_entry_json.sh; then
    echo "problem with ./run_all.sh, fix manifest and try again." 1>&2
    exit 5
fi

read -r -n 1 -p "Press any key to run: $GIT diff: "
echo 1>&2
"$GIT" diff
read -r -p "Does everything look okay (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo "$0: exiting 4 due to user telling us there's a problem." 1>&2
    exit 4
fi

if [[ -n "$A_FLAG" ]]; then
    echo "Do you wish to automatically run the commands:" 1>&2
    echo "    $GIT add -u" 1>&2
    echo "    $GIT status" 1>&2
    echo "    $GIT commit -m'update .entry.json files per recent manifest changes'" 1>&2

    read -r -p "Enter your choice (Y/N): "
    if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
	echo "Now you should run the following commands in another terminal," 1>&2
	echo "making sure you're on the appropriate branch:"
	echo 1>&2
	echo "    $GIT add -u" 1>&2
	echo "    $GIT status" 1>&2
	echo "    $GIT commit -m'update .entry.json files per recent manifest changes'" 1>&2
	echo 1>&2
	read -r -n 1 -p "Press any key when this is done: "
	echo 1>&2
    else
	"$GIT" add -u
	"$GIT" status
	"$GIT" commit -m'update .entry.json files per recent manifest changes'
    fi
else
    echo "Now you should run the following commands in another terminal," 1>&2
    echo "making sure you're on the appropriate branch:"
    echo 1>&2
    echo "    $GIT add -u" 1>&2
    echo "    $GIT status" 1>&2
    echo "    $GIT commit -m'update .entry.json files per recent manifest changes'" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key when this is done: "
    echo 1>&2
fi

# now cd to top level directory
cd ..

read -r -n 1 -p "Press any key to continue: "
echo 1>&2

echo "$(basename "$0"): will now update index.html files." 1>&2
read -r -p "Do you wish to use quick-readme2index.sh (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo "$(basename "$0"): now will run: bin/all-run.sh -v $CAP_D_FLAG bin/readme2index.sh -v $CAP_D_FLAG" 1>&2
    if ! bin/all-run.sh -v "$CAP_D_FLAG" bin/readme2index.sh -v "$CAP_D_FLAG"; then
	echo "problem running bin/all-run bin/readme2index.sh, fix and try again." 1>&2
	exit 5
    fi
else
    echo "$(basename "$0"): now will run: bin/all-run.sh -v $CAP_D_FLAG bin/quick-readme2index.sh -v $CAP_D_FLAG"
    echo "NOTE: this will take a while." 1>&2
    if ! bin/all-run.sh -v "$CAP_D_FLAG" bin/quick-readme2index.sh -v "$CAP_D_FLAG"; then
	echo "problem running bin/all-run bin bin/quick-readme2index.sh, fix and try again." 1>&2
	exit 5
    fi
fi

echo "$(basename "$0"): now will run: bin/gen-other-html.sh -v $CAP_D_FLAG"
echo "NOTE: this can take a while." 1>&2
if ! bin/gen-other-html.sh -v "$CAP_D_FLAG"; then
    echo "problem running bin/gen-other-html.sh, fix and try again." 1>&2
    exit 5
fi


read -r -n 1 -p "Press any key to run: $GIT diff: "
echo 1>&2
"$GIT" diff

read -r -p "Does everything look okay (Y/N)? "
if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
    echo "$0: exiting 4 due to user telling us git diff DOES NOT LOOK OKAY." 1>&2
    exit 4
fi

if [[ -n "$A_FLAG" ]]; then
    echo "Do you wish to automatically run the commands:" 1>&2
    echo "    git add -u" 1>&2
    echo "    git status" 1>&2
    echo "    git commit -m'update index.html and .entry.json per recent manifest changes'" 1>&2
    read -r -p "Enter your choice (Y/N): "
    if [[ "$REPLY" != "Y" && "$REPLY" != "y" ]]; then
	echo "Now you should run the following commands in another terminal," 1>&2
	echo "making sure you're on the appropriate branch:"
	echo 1>&2
	echo "    git add -u" 1>&2
	echo "    git status" 1>&2
	echo "    git commit -m'update index.html and .entry.json per recent manifest changes'" 1>&2
	echo 1>&2
	read -r -n 1 -p "Press any key when this is done: "
	echo 1>&2
    else
	"$GIT" add -u
	"$GIT" status
	"$GIT" commit -m'update index.html and .entry.json per recent manifest changes'
    fi
else
    echo "Now you should run the following commands in another terminal," 1>&2
    echo "making sure you're on the appropriate branch:"
    echo 1>&2
    echo "    git add -u" 1>&2
    echo "    git status" 1>&2
    echo "    git commit -m'update index.html and .entry.json per recent manifest changes'" 1>&2
    echo 1>&2
    read -r -n 1 -p "Press any key when this is done: "
    echo 1>&2
fi

echo 1>&2
echo 1>&2

echo "All done. Make sure to push the commits and open a GitHub pull request." 1>&2
exit 0
