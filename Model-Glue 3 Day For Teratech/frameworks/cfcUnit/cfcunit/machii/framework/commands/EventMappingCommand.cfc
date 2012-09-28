<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="EventMappingCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for setting up an event mapping for an event handler.">

	<!--- PROPERTIES --->
	<cfset variables.eventName = "" />
	<cfset variables.mappingName = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="mappingName" type="string" required="true" />
		
		<cfset setEventName(arguments.eventName) />
		<cfset setMappingName(arguments.mappingName) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset arguments.eventContext.setEventMapping(getEventName(), getMappingName()) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setEventName" access="private" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset variables.eventName = arguments.eventName />
	</cffunction>
	<cffunction name="getEventName" access="private" returntype="string" output="false">
		<cfreturn variables.eventName />
	</cffunction>
	
	<cffunction name="setMappingName" access="private" returntype="void" output="false">
		<cfargument name="mappingName" type="string" required="true" />
		<cfset variables.mappingName = arguments.mappingName />
	</cffunction>
	<cffunction name="getMappingName" access="private" returntype="string" output="false">
		<cfreturn variables.mappingName />
	</cffunction>

</cfcomponent>