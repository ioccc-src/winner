#!/usr/bin/ruby

require 'cgi'
require ENV['DOCUMENT_ROOT'] + '/test/ruby/LUHN'

if ENV['QUERY_STRING'].nil? then
	answer = ''
	numebr = ''
else
	query = CGI.parse(ENV['QUERY_STRING'])
	number = query['number'].to_s

	case query['action'].to_s
	when 'Validate'
		is_valid = LUHN.valid?(number)
		answer = number
	when 'Generate'
		digit = LUHN.generate(number)
		answer = "#{number}" + digit.to_s
		is_valid = ! digit.nil?
	end
end

puts <<"EOT"
HTTP/1.0 200 OK
Content-Type: text/html

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
Hibachi - Playing with LUHN checksums in Ruby
</title>
</head>
<link rel="stylesheet" type="text/css" href="../../style.css">
</head>
<body background="../../Img/hot-coal-edge-110-indent.png" style="margins: 0 0 0 0; padding: 0 0 0 0;">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td width="130">
		<img alt="" src="../../Img/mrpixel.gif" width="130" height="1">
	</td>
	<td>

<table border="0" cellpadding="0" cellspacing="0" width="500">
<tr>
	<td>
	
		<h2>Playing with LUHN checksums in Ruby<br/>"mod 10 Double-Add-Double"</h2>
		<p>Enter an alpha-numeric string like a credit card number or International Securities Identification Number (ISO 6166).
		Click validate to test if the entered string is correct. Click generate to append the check digit to the string.
		</p>
		<form name="luhn" method="GET" action="index.rb">
		<textarea name="number" wrap="virtual" rows="2" cols="30">#{answer}</textarea>
		<br/><b>#{ is_valid ? "Is valid." : "Is NOT valid." }</b>
		<br/>
		<br/>
		<input type="submit" name="action" value="Validate">
		&nbsp;&nbsp;
		<input type="submit" name="action" value="Generate">
		&nbsp;&nbsp;
		<input type="button" value="Clear" onclick="this.form.number.value = ''">
		</form>
		<hr>
		<a href="../../#Test">Return to HIBACHI</a>
	
	</td>
</tr>
</table>

	</td>
</tr>
</table>

</body>
</html>
EOT

exit(0)
