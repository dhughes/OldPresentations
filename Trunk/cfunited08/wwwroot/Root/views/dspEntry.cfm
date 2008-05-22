<cfset Entry = viewstate.getValue("EntryRecord") />
<cfset Categories = Entry.getCategoryIterator().getQuery() />

<cfoutput>
	<h1>#Entry.getTitle()#</h1>

	<p><small>Categories:
	<cfif Categories.recordcount>
		<cfloop query="Categories">
			#categories.name#,
		</cfloop>
	<cfelse>
		None
	</cfif>
	</small></p>

	<p>#Replace(Entry.getBody(), chr(13), "<br />", "all")#</p>

	<p><small>Published: #DateFormat(Entry.getDate(), "m/d/yy")#</small></p>	
</cfoutput>