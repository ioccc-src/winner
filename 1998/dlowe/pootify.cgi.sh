#!/usr/bin/env bash
#
# pootify.cgi.sh - a sample CGI pootifier
#
POOT="./dlowe"
LYNX="lynx"
ECHO="echo"
EXPR="expr"

${ECHO} "Content-type: text/html"
${ECHO}

QUERY_STRING="$1"
if [[ -z "${QUERY_STRING}" ]]; then
    ${ECHO} "QUERY_STRING not found"
else
    URL="$(${EXPR} "$QUERY_STRING" : '[Uu][Rr][Ll]=\(.*\)')"
    if [[ -z "${URL}" ]]; then
	${ECHO} "No URL given in QUERY_STRING"
    elif [[ X"$(${EXPR} "${URL}" : '[Ff][Ii][Ll][Ee]:')" != X0 ]]; then
    	${ECHO} "file: based URLs are not allowed"
    else
	${LYNX} -restrictions=all -source "${URL}" | ${POOT}
    fi
fi
