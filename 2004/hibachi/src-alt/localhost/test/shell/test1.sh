#!/usr/bin/env bash

cat <<'-EOT-'
HTTP/1.0 200 OK
Content-Type: text/html
Set-Cookie: cookie1=test1.sh; path=/
Set-Cookie: cookie2=test1.sh; path=/

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Hibachi/1.0 Shell Test 1
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
<h2>Results of Form GET request</h2>
<table border="0" cellspacing="0" cellpadding="0">
<caption><h3>Assertions</h3></caption>
-EOT-

if [[ $PATH == '/usr/local/bin:/usr/bin:/bin' ]]; then
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

if [[ -z $QUERY_STRING ]]; then QUERY_STRING=''; fi
if [[ $QUERY_STRING == 'example=GET+REQUEST+WITH+QUERY-STRING&garibaldi=peek-a-boo' ]]; then
	echo "<tr><td>[ OK  ] QUERY_STRING</td></tr>"
else
	echo "<tr><td>[ BAD ] QUERY_STRING</td></tr>"
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
<form method="POST" action="test2.sh">
<b>Next Test:</b> <input type="submit" name="example" value="POST REQUEST WITH COOKIES">
<input type="hidden" name="hibachi" value="is not Apache">
<input type="hidden" name="garibaldi" value="peek-a-boo">
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
