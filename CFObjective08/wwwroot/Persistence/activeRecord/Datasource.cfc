<cfcomponent>
	
	<cffunction name="init" access="public" hint="I configure and return a Datasource config object" output="false" returntype="Datasource">
		<cfargument name="datasource" hint="I am the coldfusion datasource to use" required="true" type="string" />
		<cfargument name="username" hint="I am the username to user" required="no" type="string" default="" />
		<cfargument name="password" hint="I am the password to use" required="no" type="string" default="" />
		
		<cfset variables.datasource = arguments.datasource />
		<cfset variables.username = arguments.username />
		<cfset variables.password = arguments.password />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getDatasource" access="public" hint="I get coldfusion datasource to use" output="false" returntype="string">
		<cfreturn variables.datasource />
	</cffunction>
	
	<cffunction name="getUsername" access="public" hint="I get username to use" output="false" returntype="string">
		<cfreturn variables.username />
	</cffunction>
	
	<cffunction name="getPassword" access="public" hint="I get password to use" output="false" returntype="string">
		<cfreturn variables.password />
	</cffunction>

</cfcomponent>