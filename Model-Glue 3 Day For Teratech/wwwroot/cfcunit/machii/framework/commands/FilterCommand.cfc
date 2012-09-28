<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="FilterCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for processing an EventFilter.">

	<!--- PROPERTIES --->
	<cfset variables.filter = "" />
	<cfset variables.paramArgs = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="filter" type="cfcunit.machii.framework.EventFilter" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset setFilter(arguments.filter) />
		<cfset setParamArgs(arguments.paramArgs) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset var continue = false />
		
		<cfinvoke component="#getFilter()#" method="filterEvent" returnVariable="continue">
			<cfinvokeargument name="event" value="#arguments.event#" />
			<cfinvokeargument name="eventContext" value="#arguments.eventContext#" />
			<cfinvokeargument name="paramArgs" value="#getParamArgs()#" />
		</cfinvoke>
		
		<cfreturn continue />
	</cffunction>
	
	<cffunction name="setFilter" access="private" returntype="void" output="false">
		<cfargument name="filter" type="cfcunit.machii.framework.EventFilter" required="true" />
		<cfset variables.filter = arguments.filter />
	</cffunction>
	<cffunction name="getFilter" access="private" returntype="cfcunit.machii.framework.EventFilter" output="false">
		<cfreturn variables.filter />
	</cffunction>
	
	<cffunction name="setParamArgs" access="private" returntype="void" output="false">
		<cfargument name="paramArgs" type="struct" required="true" />
		<cfset variables.paramArgs = arguments.paramArgs />
	</cffunction>
	<cffunction name="getParamArgs" access="private" returntype="struct" output="false">
		<cfreturn variables.paramArgs />
	</cffunction>

</cfcomponent>