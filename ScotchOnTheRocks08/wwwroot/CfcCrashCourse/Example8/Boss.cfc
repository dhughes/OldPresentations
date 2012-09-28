<cfcomponent extends="Employee">

	<cfset variables.subordinates = arrayNew(1) />

	<cffunction name="getSubordinates" access="public" hint="Getter for subordinates" output="false" returnType="array">
		<cfreturn variables.subordinates />
	</cffunction>

	<cffunction name="setSubordinates" access="public" hint="Setter for subordinates" output="false" returnType="void">
		<cfargument name="subordinates" hint="I am a collection of Employees managed by this Boss." required="yes" type="array" />
		<cfset variables.subordinates = arguments.subordinates />
	</cffunction>

</cfcomponent>