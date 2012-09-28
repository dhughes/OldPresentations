
<h1>Fortune!</h1>

<cfquery name="categories" datasource="#datasource#" username="#username#" password="#password#">
	SELECT c.categoryId, c.category + ' (' + Convert(varchar, count(f.fortuneId)) + ')' as category
	FROM Category as c JOIN Fortune as f
		ON c.categoryId = f.categoryId
	GROUP BY c.categoryId, c.category
	ORDER BY c.category
</cfquery>

<cfform name="CategoryForm" action="showFortune.cfm">
	<p>
		<label>Category:</label>
		<cfselect name="categoryId" query="categories" display="category" value="categoryId" />
	</p>
	
	<p>
		<cfinput type="submit" name="Submit" value="Fortune Me!" />
	</p>
</cfform>