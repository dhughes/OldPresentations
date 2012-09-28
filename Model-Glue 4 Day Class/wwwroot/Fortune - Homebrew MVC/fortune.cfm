<cfif thistag.ExecutionMode IS "Start">

	<cfquery name="fortune" datasource="#application.datasource#" username="#application.username#" password="#application.password#">
		SELECT TOP 1 fortune
		FROM Fortune
		WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.categoryId#" />
		ORDER BY newId()
	</cfquery>

	<cfset caller[attributes.result] = fortune />

</cfif>

