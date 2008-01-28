<cfset categories = viewstate.getValue("categories") />
<cfset myself = viewstate.getValue("myself")>
<cfset xe.fortune = viewstate.getValue("xe.fortune")>

<cfform name="CategoryForm" action="#myself##xe.fortune#">
	<p>
		<label>Category:</label>
		<cfselect name="categoryId" query="categories" display="category" value="categoryId" />
	</p>
	
	<p>
		<cfinput type="submit" name="Submit" value="Fortune Me!" />
	</p>
</cfform>

