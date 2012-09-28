
<cfset recent = viewState.getValue("recentContacts") />

<h3>Menu</h3>

<a href="index.cfm?event=editContact">Add a new Contact</a>
<br>

<a href="index.cfm?event=listContacts">List all Contacts</a>
<br>
<br>


<!--- List the most recent contacts accessed. --->
Recent Contacts: <br>
<cfloop index="i" from="1" to="#ArrayLen(recent)#">
	<cfset contact = recent[i] />
	
	<cfoutput>
	<a href="index.cfm?event=viewContact&id=#contact.getId()#">
		<cfoutput>#contact.getFirstName()# #contact.getLastName()#</cfoutput>
	</a>
	</cfoutput>
	<br>
</cfloop>
