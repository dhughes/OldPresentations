<cfcomponent extends="org.cfcunit.framework.TestCase" output="false" >

	<!--- setup the test --->
	<cffunction name="setup" returntype="void" access="private"> 
		<cfsetting showdebugoutput="false" />
		<cfset ColdSpring = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
		<cfset ColdSpring.loadBeans("/Fortune - ColdSpring/config/ColdSpring.xml") />
		
		<cfset CategoryGateway = ColdSpring.getBean("CategoryGateway") />
	</cffunction>
	
	<!--- test getCategories --->
	<cffunction name="testGetCategories" returntype="void" access="public"> 
		<cfset var categories = CategoryGateway.getCategories() />
		<cfset var columns = categories.columnList />
		<cfset var sampleCategory = categories.category />
		
		<!--- we need this query to have two columns named categoryId and category --->
		<cfset assertTrue(ListFindNoCase(columns, "categoryId"), "Query did not include a column named categoryId") />
		<cfset assertTrue(ListFindNoCase(columns, "category"), "Query did not include a column named category") />
		
		<!--- the last part of the category name should be the number of fortunes in parenthesis --->
		<cfset assertRegexMatch("", sampleCategory, "Category name does not end with number of fortunes.")>
		
	</cffunction>
	
</cfcomponent>