<cfcomponent extends="org.cfcunit.framework.TestCase" output="false" >

	<!--- setup the test --->
	<cffunction name="setup" returntype="void" access="private"> 
		<cfsetting showdebugoutput="false" />

		<cfset Fortune = CreateObject("Component", "Fortune - Data Access.model.Fortune").init("Fortune", "", "") />
	</cffunction>
	
	<!--- test getCategories --->
	<cffunction name="testGetCategories" returntype="void" access="public"> 
		<cfset var categories = Fortune.getCategories() />
		<cfset var columns = categories.columnList />
		<cfset var sampleCategory = categories.category />
		
		<!--- we need this query to have two columns named categoryId and category --->
		<cfset assertTrue(ListFindNoCase(columns, "categoryId"), "Query did not include a column named categoryId") />
		<cfset assertTrue(ListFindNoCase(columns, "category"), "Query did not include a column named category") />
		
		<!--- the last part of the category name should be the number of fortunes in parenthesis --->
		<cfset assertRegexMatch("", sampleCategory, "Category name does not end with number of fortunes.")>
		
	</cffunction>
	
	<!--- test getFortune --->
	<cffunction name="testGetFortune" returntype="void" access="public"> 
		<cfset var categories = Fortune.getCategories() />
		
		<!--- get a fortune for the first specified categoryId --->
		<cfset var result = Fortune.getFortune(categories.categoryId) />
		
		<!--- assert that the fortune is a simple value --->
		<cfset assertSimpleValue(result, "Fortune returned is not a simple value")>
		
		<!--- get a fortune for an invalid category.  This should thrown an error! --->
		<cftry>
			<cfset result = Fortune.getFortune(-1) />		
			<!--- fail the test, this should have thrown an error --->
			<cfset fail("Invalid category did not throw error") />
			
			<cfcatch type="Fortune.getFortune.NoFortune">
				<!--- do nothing, we succeeded! --->
			</cfcatch>
			<cfcatch>
				<!--- fail the test, we didn't throw the correct error! --->
				<cfset fail("Invalid category did not throw error") />
			</cfcatch>
		</cftry>
	</cffunction>
	
</cfcomponent>