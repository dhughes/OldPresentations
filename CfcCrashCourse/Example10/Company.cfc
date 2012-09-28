<cfcomponent>

	<cfset variables.name = "" />
	<cfset variables.employees = arrayNew(1) />

	<cffunction name="getName" access="public" hint="Getter for name" output="false" returnType="string">
		<cfreturn variables.name />
	</cffunction>

	<cffunction name="setName" access="public" hint="Setter for name" output="false" returnType="void">
		<cfargument name="name" hint="I am the company name" required="yes" type="string" />
		<cfset variables.name = arguments.name />
	</cffunction>

	<cffunction name="getEmployees" access="public" hint="Getter for employees" output="false" returnType="array">
		<cfreturn variables.employees />
	</cffunction>

	<cffunction name="addEmployee" access="public" hint="I add an employee to the company" output="false" returnType="void">
		<cfargument name="employee" hint="I am an emplouee to add to the company" required="yes" type="Employee" />
		<cfset ArrayAppend(variables.employees, arguments.employee) />
	</cffunction>

</cfcomponent>