<cfset categories = viewstate.getValue("categories") />
<cfset xe.submit = viewstate.getValue("xe.submit") />
<cfset myself = viewstate.getValue("myself")>

<cfform name="CategoryForm" action="#myself##xe.submit#">
	<p>
		<label>Category:</label>
		<cfselect name="categoryId" query="categories" display="category" value="categoryId" />
	</p>
	
	<p>
		<cfinput type="submit" name="Submit" value="Fortune Me!" />
	</p>
</cfform>