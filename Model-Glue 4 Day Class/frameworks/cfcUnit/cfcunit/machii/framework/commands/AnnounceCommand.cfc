<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="AnnounceCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for announcing an event.">

	<!--- PROPERTIES --->
	<cfset variables.eventName = "" />
	<cfset variables.copyEventArgs = true />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="copyEventArgs" type="boolean" required="false" default="true" />
		
		<cfset setEventName(arguments.eventName) />
		<cfset variables.copyEventArgs = arguments.copyEventArgs />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean" output="false">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset var eventArgs = 0 />
		<cfif isCopyEventArgs()>
			<cfset eventArgs = event.getArgs() />
		<cfelse>
			<cfset eventArgs = StructNew() />
		</cfif>
		
		<cfset arguments.eventContext.announceEvent(getEventName(), eventArgs) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setEventName" access="private" returntype="void" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset variables.eventName = arguments.eventName />
	</cffunction>
	<cffunction name="getEventName" access="private" returntype="string" output="false">
		<cfreturn variables.eventName />
	</cffunction>
	
	<cffunction name="setCopyEventArgs" access="private" returntype="void" output="false">
		<cfargument name="copyEventArgs" type="boolean" required="false" default="true" />
		<cfset variables.copyEventArgs = arguments.copyEventArgs />
	</cffunction>
	<cffunction name="isCopyEventArgs" access="private" returntype="boolean" output="false">
		<cfreturn variables.copyEventArgs />
	</cffunction>

</cfcomponent>