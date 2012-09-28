<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="ViewPageCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for processing a view.">

	<!--- PROPERTIES --->
	<cfset variables.viewName = "" />
	<cfset variables.contentKey = "" />
	<cfset variables.append = false />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="contentKey" type="string" required="false" default="" />
		<cfargument name="append" type="string" required="false" default="false" />
		
		<cfset setViewName(arguments.viewName) />
		<cfset setContentKey(arguments.contentKey) />
		<cfset setAppend(arguments.append) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean" output="true">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset arguments.eventContext.displayView(arguments.event, getViewName(), getContentKey(), getAppend()) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setViewName" access="private" returntype="void" output="false">
		<cfargument name="viewName" type="string" required="true" />
		<cfset variables.viewName = arguments.viewName />
	</cffunction>
	<cffunction name="getViewName" access="private" returntype="string" output="false">
		<cfreturn variables.viewName />
	</cffunction>
	
	<cffunction name="setContentKey" access="private" returntype="void" output="false">
		<cfargument name="contentKey" type="string" required="true" />
		<cfset variables.contentKey = arguments.contentKey />
	</cffunction>
	<cffunction name="getContentKey" access="private" returntype="string" output="false">
		<cfreturn variables.contentKey />
	</cffunction>
	<cffunction name="hasContentKey" access="private" returntype="boolean" output="false">
		<cfreturn NOT getContentKey() IS '' />
	</cffunction>

	<cffunction name="setAppend" access="private" returntype="void" output="false">
		<cfargument name="append" type="string" required="true" />
		<cfset variables.append = (arguments.append is "true") />
	</cffunction>
	<cffunction name="getAppend" access="private" returntype="boolean" output="false">
		<cfreturn variables.append />
	</cffunction>

</cfcomponent>
