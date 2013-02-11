    
<cfset viewEvent = viewstate.getValue("myself") & viewstate.getValue("xe.view") />
<cfset editEvent = viewstate.getValue("myself") & viewstate.getValue("xe.edit") />
<cfset deleteEvent = viewstate.getValue("myself") & viewstate.getValue("xe.delete") />
<cfset WidgetQuery = viewstate.getValue("WidgetQuery") />

    
<cfoutput>
<div id="breadcrumb">Widgets / <a href="#editEvent#">Add New Widget</a></div>
</cfoutput>
<br />
<table class="list">
<thead>
<tr>
  <cfset displayedColumns = 1 />
  
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Name</th>
    
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Is Active</th>
    
	<th>&nbsp;</th>
</tr>
</thead>
<tbody>
<cfif not WidgetQuery.recordcount>
	<tr>
		<cfoutput><td colspan="#displayedColumns#"><em>No Records</em></td></cfoutput>
	</tr>
</cfif>
<cfoutput query="WidgetQuery">
	<cfset keyString = "&widgetId=#urlEncodedFormat(WidgetQuery.widgetId)#" />
	<tr <cfif WidgetQuery.currentRow mod 2 eq 0>class="even"</cfif>>
    
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(name)#</a></td>
				
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(isActive)#</a></td>
				
		<td>
			<a href="#editEvent##keystring#">Edit</a>	
			<a href="##" onclick="if (confirm('Are you sure you want to delete this Widget?')) { document.location.replace('#deleteEvent##keystring#') }; return false">Delete</a>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>
                 
	