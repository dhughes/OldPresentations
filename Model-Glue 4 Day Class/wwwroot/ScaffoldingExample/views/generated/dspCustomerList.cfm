    
<cfset viewEvent = viewstate.getValue("myself") & viewstate.getValue("xe.view") />
<cfset editEvent = viewstate.getValue("myself") & viewstate.getValue("xe.edit") />
<cfset deleteEvent = viewstate.getValue("myself") & viewstate.getValue("xe.delete") />
<cfset CustomerQuery = viewstate.getValue("CustomerQuery") />

    
<cfoutput>
<div id="breadcrumb">Customers / <a href="#editEvent#">Add New Customer</a></div>
</cfoutput>
<br />
<table class="list">
<thead>
<tr>
  <cfset displayedColumns = 1 />
  
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>First Name</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Last Name</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Address Id</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Deleted</th>
    
	<th>&nbsp;</th>
</tr>
</thead>
<tbody>
<cfif not CustomerQuery.recordcount>
	<tr>
		<cfoutput><td colspan="#displayedColumns#"><em>No Records</em></td></cfoutput>
	</tr>
</cfif>
<cfoutput query="CustomerQuery">
	<cfset keyString = "&customerId=#urlEncodedFormat(CustomerQuery.customerId)#" />
	<tr <cfif CustomerQuery.currentRow mod 2 eq 0>class="even"</cfif>>
    
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(firstName)#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(lastName)#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(addressId)#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(deleted)#</a></td>
				
		<td>
			<a href="#editEvent##keystring#">Edit</a>	
			<a href="##" onclick="if (confirm('Are you sure you want to delete this Customer?')) { document.location.replace('#deleteEvent##keystring#') }; return false">Delete</a>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>
                 
	
