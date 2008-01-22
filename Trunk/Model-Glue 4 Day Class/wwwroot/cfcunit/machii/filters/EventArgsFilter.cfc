<!---
Author: Ben Edwards (ben@ben-edwards.com)

EventArgsFilter
	This event-filter adds args to the current event being handled.
	
Configuration Parameters:
	None.
	
Event-Handler Parameters:
	The name/value of each parameter are the name/value of the args added to the event.
--->
<cfcomponent 
	displayname="EventArgsFilter" 
	extends="cfcunit.machii.framework.EventFilter"
	output="false"
	hint="An EventFilter for adding args to the current event being handled.">
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="configure" access="public" returntype="void" output="false">
	</cffunction>
	
	<cffunction name="filterEvent" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var paramArgKeys = StructKeyArray(arguments.paramArgs) />
		<cfset var i = 0 />
		<cfset var argName = 0 />

		<cfloop index="i" from="1" to="#ArrayLen(paramArgKeys)#">
			<cfset argName = paramArgKeys[i] />
			<cfset arguments.event.setArg(argName, paramArgs[argName]) />
		</cfloop>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>