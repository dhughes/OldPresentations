<cfif thistag.ExecutionMode IS "Start">

	<cfquery name="categories" datasource="#application.datasource#" username="#application.username#" password="#application.password#">
		SELECT c.categoryId, c.category + ' (' + Convert(varchar, count(f.fortuneId)) + ')' as category
		FROM Category as c JOIN Fortune as f
			ON c.categoryId = f.categoryId
		GROUP BY c.categoryId, c.category
		ORDER BY c.category
	</cfquery>

	<cfset caller[attributes.result] = categories />

</cfif>