<cfcomponent name="" hint="">

	<cfset variables.datasource = "" />

	<cffunction name="getDatasource" access="public" hint="Getter for datasource" output="false" returnType="string">
		<cfreturn variables.datasource />
	</cffunction>

	<cffunction name="setDatasource" access="public" hint="Setter for datasource" output="false" returnType="void">
		<cfargument name="datasource" hint="I am the dsn" required="yes" type="string" />
		<cfset variables.datasource = arguments.datasource />
	</cffunction>

</cfcomponent>