	

<cfset contact = viewState.getValue("contact") />


<h3>View Contact</h3>

<cfoutput>
<table border="1" cellspacing="1" cellpadding="1">
	<tr>
	<tr>
		<td valign="top"><b>Name</b></td>
		<td valign="top">
			#contact.getFirstName()# #contact.getLastName()#
			(<a href="index.cfm?event=editContact&id=#contact.getId()#">Edit</a>)
		</td>
	</tr>
	</tr>
	<tr>
		<td valign="top"><b>Address</b></td>
		<td valign="top">
			#contact.getStreet()# <br>
			#contact.getCity()#, #contact.getState()#   #contact.getZip()# <br>
		</td>
	</tr>
</table>
</cfoutput>
<br>