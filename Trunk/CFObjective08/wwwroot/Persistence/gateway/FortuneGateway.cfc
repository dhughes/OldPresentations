<cfcomponent>
	
	<cffunction name="init" access="public" hint="I configure and return the Fortune Gateway" output="false" returntype="FortuneGateway">
		<cfargument name="Datasource" hint="I am the datasource to use when reading data" required="yes" type="Datasource">
		
		<cfset variables.Datasource = arguments.Datasource />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getFortunes" access="public" hint="I return a query of random fortunes" output="false" returntype="query">
		<cfargument name="limit" hint="I am the number of rows to return" required="true" type="numeric" />
		<cfargument name="keyword" hint="I am a string that is searched for" required="false" type="string" />
		<cfset var fortune = 0 />
		
		<cfquery name="fortune" datasource="#variables.Datasource.getDatasource()#" username="#variables.Datasource.getUsername()#" password="#variables.Datasource.getPassword()#">
			SELECT TOP #arguments.limit# *
			FROM Fortune as f
			<cfif StructKeyExists(arguments, "keyword")>
				WHERE f.fortune like <cfqueryparam value="%#arguments.keyword#%" />
			</cfif>
			ORDER BY newId()
		</cfquery>
			
		<cfreturn fortune />
	</cffunction>
	
</cfcomponent>