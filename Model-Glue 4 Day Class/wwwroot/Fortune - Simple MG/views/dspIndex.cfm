<cfset categories = viewstate.getValue("categories") />

<cfform name="CategoryForm" action="index.cfm?event=Fortune.ShowFortune">
	<p>
		<label>Category:</label>
		<cfselect name="categoryId" query="categories" display="category" value="categoryId" />
	</p>
	
	<p>
		<cfinput type="submit" name="Submit" value="Fortune Me!" />
	</p>
</cfform>