<html>
<head>
	<title>Model-Glue Fortune Example</title>
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css" media="screen" />
</head>

<cfset myself = viewstate.getValue("myself") />
<cfset xe.Home = viewstate.getValue("xe.Home") />
<cfset xe.Recent = viewstate.getValue("xe.Recent") />


<body>
<div>
	<div id="banner">Fortune!  (A Model-Glue Example)</div>
	<p>
		<cfoutput>
			<a href="#myself##xe.home#">Home</a>
			<a href="#myself##xe.recent#">Recent Fortunes</a>
		</cfoutput>
	</p>
	<hr />
	<div>
		<div>
			<cfoutput>#viewcollection.getView("body")#</cfoutput>
		</div>
	</div>
</div>
</body>
</html>	