<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<head>
	<title>HelloWorld Model-Glue + Tartan Test</title>
</head>

<body>
<table align="center" border="1">
	<tr><td><strong>Your Greeting:</strong></td></tr>
	<tr><td align="center"><cfoutput>#viewstate.getValue("greeting")#</cfoutput></td></tr>
	<tr><th align="center">Also available in:</th></tr>
	<tr><td align="center"><a href="index.cfm?lang=English">English</a></td></tr>
	<tr><td align="center"><a href="index.cfm?lang=French">French</a></td></tr>
	<tr><td align="center"><a href="index.cfm?lang=German">German</a></td></tr>
	<tr><td align="center"><a href="index.cfm?lang=Spanish">Spanish</a></td></tr>
	<tr><td align="center"><a href="index.cfm?lang=Martian">Martian</a></td></tr>
</table>
</body>

</html>