<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="EventHandler"
	output="false"
	hint="Handles processing of EventCommands for an Event.">
	
	<!--- PROPERTIES --->
	<cfset variables.commands = ArrayNew(1) />
	<cfset variables.access = "public" />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="handleEvent" access="public" returntype="void" output="true">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset var continue = true />
		<cfset var command = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#ArrayLen(variables.commands)#">
			<cfset command = variables.commands[i] />
			<cfset continue = command.execute(arguments.event, arguments.eventContext) />
			<cfif continue IS false>
				<cfbreak />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="addCommand" access="public" returntype="void" output="false">
		<cfargument name="command" type="cfcunit.machii.framework.EventCommand" required="true" />
		<cfset ArrayAppend(variables.commands, arguments.command) />
	</cffunction>
	
	<cffunction name="setAccess" access="public" returntype="void" output="false">
		<cfargument name="access" type="string" required="true" />
		<cfset variables.access = arguments.access />
	</cffunction>
	<cffunction name="getAccess" access="public" returntype="string" output="false">
		<cfreturn variables.access />
	</cffunction>
	
</cfcomponent>