
<h1>Fortune!</h1>

<cfset Fortune = CreateObject("Component", "Fortune").init(datasource, username, password) />
<cfset categories = Fortune.getCategories() />

<cfform name="CategoryForm" action="showFortune.cfm">
	<p>
		<label>Category:</label>
		<cfselect name="categoryId" query="categories" display="category" value="categoryId" />
	</p>
	
	<p>
		<cfinput type="submit" name="Submit" value="Fortune Me!" />
	</p>
</cfform>