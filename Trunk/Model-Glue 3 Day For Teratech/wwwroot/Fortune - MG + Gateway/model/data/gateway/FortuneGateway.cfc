<cfcomponent>
	
	<cffunction name="init" access="public" hint="I configure and return the Fortune Gateway" output="false" returntype="FortuneGateway">
		<cfargument name="Datasource" hint="I am the datasource to use when reading data" required="yes" type="Fortune.model.config.Datasource">init
		
		<cfset variables.Datasource = arguments.Datasource />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getRandomFortune" access="public" hint="I return a random fortune in the specified category" output="false" returntype="string">
		<cfargument name="categoryId" hint="I am the id of the cateogry to get the fortune from" required="yes" type="numeric" />
		<cfset var fortune = 0 />
		
		<cfquery name="fortune" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT TOP 1 fortune
			FROM Fortune
			WHERE categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryId#" />
			ORDER BY newId()
		</cfquery>
			
		<cfreturn fortune.fortune />
	</cffunction>
	
</cfcomponent>