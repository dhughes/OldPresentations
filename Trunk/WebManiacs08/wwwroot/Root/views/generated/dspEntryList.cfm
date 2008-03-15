    
<cfset viewEvent = viewstate.getValue("myself") & viewstate.getValue("xe.view") />
<cfset editEvent = viewstate.getValue("myself") & viewstate.getValue("xe.edit") />
<cfset deleteEvent = viewstate.getValue("myself") & viewstate.getValue("xe.delete") />
<cfset EntryQuery = viewstate.getValue("EntryQuery") />

    
<cfoutput>
<div id="breadcrumb">Entrys / <a href="#editEvent#">Add New Entry</a></div>
</cfoutput>
<br />
<table class="list">
<thead>
<tr>
  <cfset displayedColumns = 1 />
  
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Title</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Date</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Deleted</th>
    
	<th>&nbsp;</th>
</tr>
</thead>
<tbody>
<cfif not EntryQuery.recordcount>
	<tr>
		<cfoutput><td colspan="#displayedColumns#"><em>No Records</em></td></cfoutput>
	</tr>
</cfif>
<cfoutput query="EntryQuery">
	<cfset keyString = "&entryId=#urlEncodedFormat(EntryQuery.entryId)#" />
	<tr <cfif EntryQuery.currentRow mod 2 eq 0>class="even"</cfif>>
    
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(title)#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#dateFormat(date, "m/d/yyyy")# #timeFormat(date, "h:mm TT")#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(deleted)#</a></td>
				
		<td>
			<a href="#editEvent##keystring#">Edit</a>	
			<a href="##" onclick="if (confirm('Are you sure you want to delete this Entry?')) { document.location.replace('#deleteEvent##keystring#') }; return false">Delete</a>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>
                 
	
