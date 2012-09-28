
<cfcomponent 
	displayname="CFCInvoker_Event" 
	output="false"
	extends="cfcunit.machii.framework.ListenerInvoker">

	<!--- PROPERTIES --->
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
	</cffunction>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="invokeListener" access="public" returntype="void">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="listener" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultKey" type="string" required="false" default="" />
	
		<cftry>
			<cfinvoke 
				component="#arguments.listener#" 
				method="#arguments.method#" 
				event="#arguments.event#" 
				returnvariable="#arguments.resultKey#" />
			
			<cfcatch type="Any">
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>
