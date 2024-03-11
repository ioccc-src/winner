#!/usr/bin/env bash

cat <<'EOT'
<table border="1" cellspacing="0" cellpadding="0">
<caption><h3>Environment Variables</h3></caption>
EOT

env | sed -e 's/^\(.[^\=]*\)=\(.*\)$/<tr><td class="normal">\1<\/td><td class="normal">\2\&nbsp;<\/td><\/tr>/'

echo "</table>"

	if [[ -z $REQUEST_METHOD ]]; then REQUEST_METHOD=''; fi
	if [[ $REQUEST_METHOD == "POST" && -n $CONTENT_LENGTH ]]; then
STUFF=$(dd bs=1 count="$CONTENT_LENGTH" 2>/dev/null)
COUNT=$(printf "%s" "$STUFF" | wc -c)

cat <<EOT
<table border="1" cellspacing="0" cellpadding="0">
<caption><h3>Standard Input</h3></caption>
<tr><td class="normal"><pre>Length: $COUNT</pre></td></tr>
<tr><td class="normal"><pre>$STUFF</pre></td></tr>
</table>
EOT

if [[ $CONTENT_LENGTH -eq $COUNT ]]; then
	echo "[ OK  ] CONTENT_LENGTH = bytes read"
else
	echo "[ BAD ] CONTENT_LENGTH != bytes read"
fi

	fi
