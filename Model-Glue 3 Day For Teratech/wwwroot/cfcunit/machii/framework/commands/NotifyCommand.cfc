<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="NotifyCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for notifying a Listener.">

	<!--- PROPERTIES --->
	<cfset variables.listener = "" />
	<cfset variables.method = "" />
	<cfset variables.resultKey = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="listener" type="cfcunit.machii.framework.Listener" required="true" />
		<cfargument name="method" type="string" required="true" />
		<cfargument name="resultKey" type="string" required="true" />
		
		<cfset setListener(arguments.listener) />
		<cfset setMethod(arguments.method) />
		<cfset setResultKey(arguments.resultKey) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
			
		<cfset var listener = getListener() />
		<cfset var invoker = listener.getInvoker() />
		<cfset invoker.invokeListener(arguments.event, listener, getMethod(), getResultKey()) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setListener" access="private" returntype="void" output="false">
		<cfargument name="listener" type="cfcunit.machii.framework.Listener" required="true" />
		<cfset variables.listener = arguments.listener />
	</cffunction>
	<cffunction name="getListener" access="private" returntype="cfcunit.machii.framework.Listener" output="false">
		<cfreturn variables.listener />
	</cffunction>
	
	<cffunction name="setMethod" access="private" returntype="void" output="false">
		<cfargument name="method" type="string" required="true" />
		<cfset variables.method = arguments.method />
	</cffunction>
	<cffunction name="getMethod" access="private" returntype="string" output="false">
		<cfreturn variables.method />
	</cffunction>
	
	<cffunction name="setResultKey" access="private" returntype="void" output="false">
		<cfargument name="resultKey" type="string" required="true" />
		<cfset variables.resultKey = arguments.resultKey />
	</cffunction>
	<cffunction name="getResultKey" access="private" returntype="string" output="false">
		<cfreturn variables.resultKey />
	</cffunction>
	<cffunction name="hasResultKey" access="private" returntype="boolean" output="false">
		<cfreturn NOT getResultKey() IS '' />
	</cffunction>

</cfcomponent>