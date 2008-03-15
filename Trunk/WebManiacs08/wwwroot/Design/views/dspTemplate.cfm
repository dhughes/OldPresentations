<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<cfset myself = viewstate.getValue("myself") />
<cfset xe.Home = viewstate.getValue("xe.Home") />
<cfset xe.Login = viewstate.getValue("xe.Login") />
<cfset xe.Logout = viewstate.getValue("xe.Logout") />
<cfset xe.Entries = viewstate.getValue("xe.Entries") />
<cfset xe.Categories = viewstate.getValue("xe.Categories") />
<cfset loggedIn = viewstate.getValue("loggedIn") />

<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
<meta name="description" content=""/>
<meta name="keywords" content=""/> 
<meta name="author" content=""/> 
<link rel="stylesheet" type="text/css" href="Design/css/style.css" media="screen"/>
<link rel="stylesheet" type="text/css" href="Design/css/stylesheet.css" media="screen"/>

<title>Ye Olde Blog</title>

</head>

<body>

<div id="wrapper">
<div id="container">

<div class="title">
	
	<h1><a href="index.cfm">Ye Olde Blog</a></h1>

</div>

<div class="header"></div>

<div class="navigation">
	<!---  id="active" --->
	<cfoutput>
		<a href="#myself##xe.Home#">Home</a>
		<cfif loggedIn>
			<a href="#myself##xe.Entries#">Manage Entries</a>
			<a href="#myself##xe.Categories#">Manage Categories</a>
			<a href="#myself##xe.Logout#">Logout</a>
		<cfelse>
			<a href="#myself##xe.Login#">Login</a>
		</cfif>
		
	</cfoutput>
	<div class="clearer"></div>

</div>

<div class="main">

	<div class="content">

		<cfoutput>#viewcollection.getView("body")#</cfoutput>
	</div>


	<div class="bottom">

		<div class="left">
		
			<h2>Ye Olde Bottom Nav</h2>

			<ul class="block">
				<cfoutput>
					<li><a href="#myself##xe.Home#"><span>Home</span></a></li>
					<cfif loggedIn>
						<li><a href="#myself##xe.Entries#"><span>Entries</span></a></li>
						<li><a href="#myself##xe.Categories#"><span>Categories</span></a></li>
						<li><a href="#myself##xe.Logout#"><span>Logout</span></a></li>
					<cfelse>
						<li><a href="#myself##xe.Login#"><span>Login</span></a></li>
					</cfif>
				</cfoutput>
			</ul>
			
		</div>

		<div class="right">

			<h2>About</h2>

			<p>The Ye Olde Blog is an example of highly excellent coding practices.  At least, thats the goal.</p>

<!--- 			<h2>From the gallery</h2>

			<table>
			<tr>
				<td><img src="img/thumb.gif" width="110" height="90" alt="" /></td>
				<td style="width:5px"></td>
				<td><img src="img/thumb.gif" width="110" height="90" alt="" /></td>
				<td style="width:5px"></td>
				<td><img src="img/thumb.gif" width="110" height="90" alt="" /></td>
			</tr>
			</table> --->
			
		</div>

		<div class="clearer"></div>

	</div>


	<div class="footer">

		<div class="left">
			Copyright &copy; 2008 <a href="http://www.Ye Olde.com" target="_blank">Ye Olde Inc.</a>
		</div>

		<div class="right">
			<a href="http://templates.arcsin.se">Website template</a> by <a href="http://arcsin.se">Arcsin</a>
		</div>

		<div class="clearer"></div>

	</div>

</div>

</div>
</div>

</body>
</html>