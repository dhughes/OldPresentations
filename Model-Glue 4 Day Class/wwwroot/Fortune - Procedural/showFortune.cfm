
<cfquery name="fortune" datasource="#datasource#" username="#username#" password="#password#">
	SELECT TOP 1 fortune
	FROM Fortune
	WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.categoryId#" />
	ORDER BY newId()
</cfquery>

<h1>Your Fortune...</h1>

<p>
	<pre><cfoutput>#fortune.fortune#</cfoutput></pre>
</p>

<p><a href="index.cfm">Start over</a></p>
