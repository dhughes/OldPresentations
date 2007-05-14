<cfcomponent>
	
	<cffunction name="init" access="public" hint="I configure and return the Cateogory Gateway" output="false" returntype="CategoryGateway">
		<cfargument name="Datasource" hint="I am the datasource to use when reading data" required="yes" type="Datasource">init
		
		<cfset variables.Datasource = arguments.Datasource />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getCategories" access="public" hint="I return a query of categories and the number of fortunes in each" output="false" returntype="query">
		<cfset var categories = 0 />
		
		<cfquery name="categories" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT c.categoryId, c.category + ' (' + Convert(varchar, count(f.fortuneId)) + ')' as category
			FROM Category as c JOIN Fortune as f
				ON c.categoryId = f.categoryId
			GROUP BY c.categoryId, c.category
			ORDER BY c.category
		</cfquery>
			
		<cfreturn categories />
	</cffunction>
	
</cfcomponent>