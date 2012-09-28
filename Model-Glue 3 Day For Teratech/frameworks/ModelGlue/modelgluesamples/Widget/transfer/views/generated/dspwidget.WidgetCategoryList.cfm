    
<cfset viewEvent = viewstate.getValue("myself") & viewstate.getValue("xe.view") />
<cfset editEvent = viewstate.getValue("myself") & viewstate.getValue("xe.edit") />
<cfset deleteEvent = viewstate.getValue("myself") & viewstate.getValue("xe.delete") />
<cfset widget.WidgetCategoryQuery = viewstate.getValue("widget.WidgetCategoryQuery") />

    
<cfoutput>
<div id="breadcrumb">Widget Categorys / <a href="#editEvent#">Add New Widget Category</a></div>
</cfoutput>
<br />
<table class="list">
<thead>
<tr>
  <cfset displayedColumns = 1 />
  
		  <cfset displayedColumns = displayedColumns + 1 />
	 		<th>Name</th>
    
	<th>&nbsp;</th>
</tr>
</thead>
<tbody>
<cfif not widget.WidgetCategoryQuery.recordcount>
	<tr>
		<cfoutput><td colspan="#displayedColumns#"><em>No Records</em></td></cfoutput>
	</tr>
</cfif>
<cfoutput query="widget.WidgetCategoryQuery">
	<cfset keyString = "&widgetCategoryId=#urlEncodedFormat(widget.WidgetCategoryQuery.widgetCategoryId)#" />
	<tr <cfif widget.WidgetCategoryQuery.currentRow mod 2 eq 0>class="even"</cfif>>
    
			 		<td><a href="#viewEvent##keystring#">#htmlEditFormat(name)#</a></td>
				
		<td>
			<a href="#editEvent##keystring#">Edit</a>	
			<a href="##" onclick="if (confirm('Are you sure you want to delete this Widget Category?')) { document.location.replace('#deleteEvent##keystring#') }; return false">Delete</a>
		</td>
	</tr>
</cfoutput>
</tbody>
</table>
                 
	
