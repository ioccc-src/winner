#!/usr/bin/env bash

cat <<'-EOT-'
HTTP/1.0 200 OK
Content-Type: text/html

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Hibachi/1.0 Shell Test 0 - Display Enviroment
</title>
<link rel="stylesheet" type="text/css" href="../../style.css">
</head>
<body background="../../Img/hot-coal-edge-110-indent.png" style="margins: 0 0 0 0; padding: 0 0 0 0;">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="130">
		<img alt="" src="../../Img/mrpixel.gif" width="130" height="1">
	</td>
	<td class="normal">

<div align="center">
<h3>Results from Simple GET request</h3>
<table border="0" cellspacing="0" cellpadding="0">
<caption><h3>Assertions</h3></caption>
-EOT-

if [[ "$PATH" == '/usr/local/bin:/usr/bin:/bin' ]]; then

	echo "<tr><td>[ OK  ] PATH</td></tr>"
else
	echo "<tr><td>[ BAD ] PATH</td></tr>"
fi

if [[ -z $ENV ]]; then
	echo "<tr><td>[ OK  ] ENV</td></tr>"
else
	echo "<tr><td>[ BAD ] ENV</td></tr>"
fi

if [[ -z $CDPATH ]]; then
	echo "<tr><td>[ OK  ] CDPATH</td></tr>"
else
	echo "<tr><td>[ BAD ] CDPATH</td></tr>"
fi

if [[ -z $REQUEST_METHOD ]]; then REQUEST_METHOD=''; fi
if [[ $REQUEST_METHOD == 'GET' ]]; then
	echo "<tr><td>[ OK  ] REQUEST_METHOD</td></tr>"
else
	echo "<tr><td>[ BAD ] REQUEST_METHOD</td></tr>"
fi

if [[ -z $DOCUMENT_ROOT ]]; then
	echo "<tr><td>[ OK  ] DOCUMENT_ROOT</td></tr>"
else
	echo "<tr><td>[ BAD ] DOCUMENT_ROOT</td></tr>"
fi

# Test for existence only, since the location changes.
if [[ -z $SCRIPT_FILENAME ]]; then
	echo "<tr><td>[ BAD ] SCRIPT_FILENAME</td></tr>"
else
	echo "<tr><td>[ OK  ] SCRIPT_FILENAME</td></tr>"
fi

# Test for existence only, since the default value might change.
if [[ -z $SERVER_PORT ]]; then
	echo "<tr><td>[ BAD ] SERVER_PORT</td></tr>"
else
	echo "<tr><td>[ OK  ] SERVER_PORT</td></tr>"
fi

if [[ -z $SERVER_SOFTWARE ]]; then SERVER_SOFTWARE=''; fi
if [[ $SERVER_SOFTWARE == 'hibachi/1.0' ]]; then
	echo "<tr><td>[ OK  ] SERVER_SOFTWARE</td></tr>"
else
	echo "<tr><td>[ BAD ] SERVER_SOFTWARE</td></tr>"
fi

if [[ -z $GATEWAY_INTERFACE ]]; then GATEWAY_INTERFACE=''; fi
if [[ $GATEWAY_INTERFACE == 'CGI/0.0' ]]; then
	echo "<tr><td>[ OK  ] GATEWAY_INTERFACE</td></tr>"
else
	echo "<tr><td>[ BAD ] GATEWAY_INTERFACE</td></tr>"
fi

echo "</table>"

if [[ -z $DOCUMENT_ROOT ]]; then DOCUMENT_ROOT='.'; fi
# We want to source the file, but for SC1091 the file is not available at the time of this edit.
#
# SC1091 (info): Not following: ./test/shell/dump.sh was not specified as input (see shellcheck -x).
# https://www.shellcheck.net/wiki/SC1091
# shellcheck disable=SC1091
source "$DOCUMENT_ROOT/test/shell/dump.sh"

cat <<'-EOT-'
<br>
<form method="GET" action="test1.sh">
<b>Next Test: <input type="submit" name="example" value="GET REQUEST WITH QUERY-STRING">
<input type="hidden" name="garibaldi" value="peek-a-boo"></b>
</form>
</div>
<hr>
<a href="../../#Test">Return to HIBACHI</a>
	</td>
</tr>
</table>

</body>
</html>
-EOT-

exit 0
