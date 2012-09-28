

<cfset contact = viewState.getValue("contact") />


<cfset val = viewState.getValue("contactValidation", structNew()) />

<h3>Contact Info</h3>

<!---
<font color="#FF0000"><cfoutput>#message#</cfoutput></font>
--->

<cfoutput>
<form action="index.cfm?event=CommitContact" method="post">
	<input type="hidden" name="id" value="#contact.getId()#"><br>
	First Name: <input type="text" name="firstName" value="#contact.getFirstName()#"><br>
	<cfoutput><cfif structKeyExists(val, "firstname")><font color="##FF0000">#val.firstname[1]#</font><br /></cfif></cfoutput>
	Last Name: <input type="text" name="lastName" value="#contact.getLastName()#"><br>
	<cfoutput><cfif structKeyExists(val, "lastName")><font color="##FF0000">#val.lastName[1]#</font><br /></cfif></cfoutput>
	Street: <input type="text" name="street" value="#contact.getStreet()#"><br>
	City: <input type="text" name="city" value="#contact.getCity()#"><br>
	State: <input type="text" name="state" value="#contact.getState()#"><br>
	Zip Code: <input type="text" name="zip" value="#contact.getZip()#"><br>
	<br>
	<input type="submit" value="#viewState.getValue("submitLabel")#">
</form>

<form action="index.cfm?event=CancelEditContact" method="post">
	<input type="submit" value="Cancel">
</form>
</cfoutput>

