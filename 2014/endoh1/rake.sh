#!/usr/bin/env bash

if ! type -P rake >/dev/null 2>&1; then
    echo "'rake' cannot be found." 1>&2
    echo "'rake' must be installed to run make rake or $0." 1>&2
    echo "" 1>&2
    if ! type -P gem >/dev/null 2>&1; then
	echo "" 1>&2
	echo "'gem' cannot be found." 1>&2
	echo "To install 'rake' you will need the 'gem' tool." 1>&2
	echo "Please see the following GitHub repo for rubygems:" 1>&2
	echo "" 1>&2
	echo "	    https://github.com/rubygems/rubygems" 1>&2
	echo "" 1>&2
	echo "and then run:" 1>&2
	echo "" 1>&2
	echo "	    cd rubygems && exe/gem install rake" 1>&2
	echo "" 1>&2
	echo "and then try running make rake or running $0 again." 1>&2
    else
	echo "Please run the following command as root or via sudo:" 1>&2
	echo ""
	echo "	   gem install rake" 1>&2
	echo "" 1>&2
	echo "and then try running make rake or running $0 again" 1>&2
    fi
    exit 1
elif ! rake 2>&1; then
    echo "" 1>&2
    echo "It appears that using rake failed. Please try running the following" 1>&2
    echo "command as root or via sudo: " 1>&2
    echo "" 1>&2
    echo "	gem install ruby-minisat" 1>&2; 
    echo "" 1>&2
    echo "and then try running make rake or $0 again" 1>&2
    exit 1
elif [[ ! -x prog ]]; then
    echo "" 1>&2
    echo "could not compile prog" 1>&2
    exit 1
else
    ./prog 1>&2
fi
rm -rf prog.dSYM
