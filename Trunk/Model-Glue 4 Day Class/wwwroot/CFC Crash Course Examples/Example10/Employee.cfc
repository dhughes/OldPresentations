<cfcomponent>
	
	<cfset variables.firstName = "" />
	<cfset variables.lastName = "" />
	<cfset variables.Boss = "" />

	<cffunction name="getFirstName" access="public" hint="Getter for firstName" output="false" returnType="string">
		<cfreturn variables.firstName />
	</cffunction>

	<cffunction name="setFirstName" access="public" hint="Setter for firstName" output="false" returnType="void">
		<cfargument name="firstName" hint="I am the employee's first name" required="yes" type="string" />
		<cfset variables.firstName = arguments.firstName />
	</cffunction>

	<cffunction name="getLastName" access="public" hint="Getter for lastName" output="false" returnType="string">
		<cfreturn variables.lastName />
	</cffunction>

	<cffunction name="setLastName" access="public" hint="Setter for lastName" output="false" returnType="void">
		<cfargument name="lastName" hint="I am the employee's last name" required="yes" type="string" />
		<cfset variables.lastName = arguments.lastName />
	</cffunction>

	<cffunction name="getBoss" access="public" hint="Getter for Boss" output="false" returnType="Boss">
		<cfreturn variables.Boss />
	</cffunction>

	<cffunction name="setBoss" access="public" hint="Setter for Boss" output="false" returnType="void">
		<cfargument name="Boss" hint="I am the employee's Boss" required="yes" type="Boss" />
		<cfset variables.Boss = arguments.Boss />
	</cffunction>
	
</cfcomponent>