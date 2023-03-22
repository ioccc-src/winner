#!/usr/bin/php
<?
header("HTTP/1.0 299 OK");
header("Content-Type: text/html");
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Hibachi - A Calendar Generator in PHP
</title>
<link rel="stylesheet" type="text/css" href="../../style.css">
<style>
<!--
.smCalendarTable {
	font-family: Arial, Verdana, Helvetica, sans-serif;
	font-size: 9pt;
	border-spacing: 0;
	border-width: 1;
	border-style: groove;
}
.smCalendarCell {
	padding: 3;
	text-align: right;
}
.smCalendarMonthTitle {
	color: #ff0000;
	text-align: center;
	border-collapse: collapse;
	border-color: #000000;
	border-width: 2 0 0 0;
	border-style: solid;
}
.smCalendarDayTitle {
	color: #0000cc;
	text-align: center;
	border-collapse: collapse;
	border-color: #000000;
	border-width: 1 0 1 0;
	border-style: solid;
}
.smCalendarWeekNumber {
	color: #cc00cc;
	font-weight: bold;
	background-color: #eeeeee;
}
.smCalendarDay {
	color: #0000cc;
}
.smCalendarWeekend {
	color: #0000cc;
	background-color: #cae4ff;
}
.smCalendarThisWeek {
	color: #0000cc;
	background-color: #ffcccc;
}
.smCalendarThisDay {
	padding: 1;
	border-color: #ff0000;
	border-width: 2;
	border-style: solid;
}
-->
</style>
</head>
<body background="../../Img/hot-coal-edge-110-indent.png" style="margins: 0 0 0 0; padding: 0 0 0 0;">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="130">
		<img alt="" src="../../Img/mrpixel.gif" width="130" height="1">
	</td>
	<td>

<div align="center">
<table border="0" cellspacing="0" cellpadding="5">
<h2>A Calendar Generator in PHP</h2>
<?
include('Date.php');
$date = new Date();

	for ($i = 0; $i < 12; $i++) {
		if ($i % 4 == 0)
			print("<tr valign='top'>\n");

		print("<td>");
		print Date::getSmallCalendar($date->getYear(), $i+1);
		print("</td>\n");
		
		if ($i % 4 == 3)
			print("</tr>\n");
	}
?>
</table>
</div>

<hr>
<a href="../../#Test">Return to HIBACHI</a>

	</td>
</tr>
</table>

</body>
</html>
