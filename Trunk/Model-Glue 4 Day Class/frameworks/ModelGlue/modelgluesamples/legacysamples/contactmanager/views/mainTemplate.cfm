
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Contact Manager</title>
</head>


<body>

<h1>Contact Manager</h1>
<a href="index.cfm?event=showHome">Menu</a> | 
<a href="index.cfm?event=listContacts">List Contacts</a> | 
<a href="index.cfm?event=editContact">Add Contact</a>
<hr>
<br>

<cfoutput>#viewCollection.getView("body")#</cfoutput>

<br>
<hr>

</body>
</html>
