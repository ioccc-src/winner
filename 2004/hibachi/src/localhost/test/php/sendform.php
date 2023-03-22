#!/usr/bin/php
<?
header("HTTP/1.0 299 OK");
header("Content-Type: text/html");

///////////////////////////////////////////////////////////////////////
// CHANGE THE VALUES BELOW HERE
///////////////////////////////////////////////////////////////////////

$SEND_TO = 'achowe@snert.com';
$SUBJECT = 'From the web form...';

///////////////////////////////////////////////////////////////////////
// CHANGE THE VALUES ABOVE HERE
///////////////////////////////////////////////////////////////////////

$maxWidth = 0;

foreach ($_GET as $name => $value) {
	if ($maxWidth < strlen($name))
		$maxWidth = strlen($name);
}

foreach ($_POST as $name => $value) {
	if ($maxWidth < strlen($name))
		$maxWidth = strlen($name);
}

$body = '';
$fmt = "%{$maxWidth}s: %s\n";

foreach ($_GET as $name => $value) {
	$body .= sprintf($fmt, $name, $value);
}

foreach ($_POST as $name => $value) {
	$body .= sprintf($fmt, $name, $value);
}

//mail($SEND_TO, $SUBJECT, $body);

///////////////////////////////////////////////////////////////////////
// 
///////////////////////////////////////////////////////////////////////
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Hibachi - Form Processing Example in PHP
</title>
<link rel="stylesheet" type="text/css" href="../../style.css">
</head>
<body background="../../Img/hot-coal-edge-110-indent.png" style="margins: 0 0 0 0; padding: 0 0 0 0;">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="130">
		<img alt="" src="../../Img/mrpixel.gif" width="130" height="1">
	</td>
	<td>

<h2>Form Processing Example in PHP</h2>

<p>Formatted output of web form as would be seen in an email message (without decorations).
This example does not send any actual email, though it could with some minor changes.
</p>
<pre>
<?= $body; ?>
</pre>
<hr>
<a href="../../#Test">Return to HIBACHI</a>

	</td>
</tr>
</table>

</body>
</html>


