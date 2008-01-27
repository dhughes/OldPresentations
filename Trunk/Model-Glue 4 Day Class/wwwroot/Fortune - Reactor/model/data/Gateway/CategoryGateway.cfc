
<cfcomponent hint="I am the database agnostic custom Gateway object for the Category object.  I am generated, but not overwritten if I exist.  You are safe to edit me."
	extends="reactor.project.ReactorFortune.Gateway.CategoryGateway" >
	<!--- Place custom code here, it will not be overwritten --->
	
	<cffunction name="getCountedQuery" access="public" hint="I return a query of categories counted" output="false" returntype="query">
		<cfset var categories = 0 />
		
		<cfquery name="categories" datasource="#_getConfig().getDsn()#" username="#_getConfig().getUsername()#" password="#_getConfig().getPassword()#">
			SELECT c.categoryId, c.category + ' (' + Convert(varchar, count(f.fortuneId)) + ')' as category
			FROM Category as c JOIN Fortune as f
				ON c.categoryId = f.categoryId
			GROUP BY c.categoryId, c.category
			ORDER BY c.category
		</cfquery>
			
		<cfreturn categories />
	</cffunction>
	
</cfcomponent>
	
