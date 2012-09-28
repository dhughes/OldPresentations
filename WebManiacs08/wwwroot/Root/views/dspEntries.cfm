<cfset EntryQuery = viewstate.getValue("EntryQuery") />
<cfset myself = viewstate.getValue("myself") />
<cfset xe.view = viewstate.getValue("xe.view") />

<cfoutput query="EntryQuery">
	<div>
		<h2><a href="#myself##xe.view#&entryId=#EntryQuery.entryId#">#EntryQuery.title#</a></h2>
		
		<p>#Left(EntryQuery.Body, 500)#...</p>
		
		<p><small>Published: #DateFormat(EntryQuery.date, "m/d/yy")#</small></p>	
	</div>
	<hr />

</cfoutput>
