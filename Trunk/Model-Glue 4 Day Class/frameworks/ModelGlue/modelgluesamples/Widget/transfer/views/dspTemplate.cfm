<cfset widgetCount = viewstate.getValue("widgetCountsByType") />

<html>
<head>
	<title>Widget Central: Transfer Powered</title>
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css" media="screen" />
</head>


<body>
<div>
	<div id="banner">Widget Central: Transfer Powered</div>
	<div>
		<div>
			<cfoutput>
				[<a href="#viewstate.getValue("myself")#widget.widget.list">Manage Widgets</a>]
				[<a href="#viewstate.getValue("myself")#widget.widgetType.list">Manage Widget Types</a>]
				[<a href="#viewstate.getValue("myself")#widget.widgetCategory.list">Manage Widget Categories</a>]
			</cfoutput>
			
			<table width="100%">
			<tr>
				<td valign="top">
					<cfoutput>#viewcollection.getView("body")#</cfoutput>
				</td>
				<td width="200" valign="top">
					<h3>Widgets by Type</h3>
					<cfoutput query="widgetCount">
					<a href="#viewstate.getValue("myself")#widget.widgetType.view&widgetTypeId=#widgetTypeId#">#name#</a> - (#widgetCount#)<br />
					</cfoutput>
				</td>
			</tr>
			</table>
		</div>
	</div>
	<div id="footer" style="clear:both">
			<cfoutput>
				<p><a href="http://www.model-glue.com">Model-Glue</a> is &copy; #dateFormat(now(), "yyyy")# Joe Rinehart.  It is Free Open Source Software, distributed under the Lesser GPL.</p>
				
				<p>Many thanks go out to Dave Ross and Chris Scott for developing <a href="http://www.coldspringframework.org">ColdSpring</a>, 
				Doug Hughes for developing <a href="http://www.doughughes.net">Reactor</a>, Mark Mandel for developing <a href="http://transfer.riaforge.org/">Transfer</a>, <a href="http://www.corfield.org">Sean Corfield</a> and 
				<a href="http://www.web-relevant.com/blogs/cfobjective">Jared Rypka-Hauer</a> for their code and advice, 
				<a href="http://ray.camdenfamily.com/">Ray Camden</a> for being a great spokesperson and teacher for Model-Glue, and, especially, 
				my wife Dale for putting up with my hours of coding.</p>
			</cfoutput>
	</div>
</div>
</body>
</html>	