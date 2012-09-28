
<cfcomponent 
	displayname="ListenerInvoker"
	output="false"
	hint="Base Invoker component.">

	<!--- PROPERTIES --->
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="invokeListener" access="public" returntype="void">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="target" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultKey" type="string" required="false" default="" />
		
		<!--- Overwrite in Sub-Type --->
	</cffunction>

</cfcomponent>
