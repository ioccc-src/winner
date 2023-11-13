#!/usr/bin/env bash
#
# Script to download a page and pootify it. You can pipe it through less(1) to
# see the output or you can redirect it to a file and open it in your local
# browser (use the -r option for that).
#
# Note from 2023: this used to be a CGI script that used lynx(1) which has
# security features but lynx does not work with redirects, it would appear, and
# unfortunately links(1) does not have such restrictions. If you wanted to use
# it anyway you could change the -dump to -source and see how it goes. It might
# also be that if it was used as a CGI script it would work well but this has
# not been tested.
#
# Example uses:
#
#   ./pootify.sh URL=https://microsoft.com | less
#
#   ./pootify.sh -r URL=https://microsoft.com > ms.html
#
# and then open ms.html in your local browser. Neither are as nice as a rendered
# html page as a script from another page and certainly it's less convenient but
# you can at least enjoy the output somewhat, the latter one more so, perhaps.
#
POOT="./dlowe"
LINKS="links"
ECHO="echo"
EXPR="expr"
RAW=""
${ECHO} "Content-type: text/html"
${ECHO}
if [[ "$#" -eq 2 ]]; then
    if [[ "$1" = "-r" ]]; then
	RAW="-r"
    fi
    shift 1
fi

QUERY_STRING="$1"
if [[ -z "${QUERY_STRING}" ]]; then
    ${ECHO} "QUERY_STRING not found"
else
    URL="$(${EXPR} "$QUERY_STRING" : '[Uu][Rr][Ll]=\(.*\)')"
    if [[ -z "${URL}" ]]; then
	${ECHO} "No URL given in QUERY_STRING"
    # if used as a CGI script uncomment the below:
    #elif [[ X"$(${EXPR} "${URL}" : '[Ff][Ii][Ll][Ee]:')" != X0 ]]; then
    #	${ECHO} "file: based URLs are not allowed"
    elif [[ -n "$RAW" ]]; then
	${LINKS} -source "${URL}" | ${POOT}
    else
	${LINKS} -dump "${URL}" | ${POOT}
    fi
fi
