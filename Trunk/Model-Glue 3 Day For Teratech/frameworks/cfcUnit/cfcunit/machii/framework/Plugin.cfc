
<cfcomponent 
	displayname="Plugin" 
	extends="cfcunit.machii.framework.BaseComponent"
	output="false"
	hint="Base Plugin component.">

	<!--- PROPERTIES --->
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="Plugin" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfargument name="parameters" type="struct" required="false" />
		
		<cfset super.init(arguments.appManager, arguments.parameters) />
		
		<cfreturn this />
	</cffunction>
	
	<!--- PLUGIN POINT FUNCTIONS --->
	<cffunction name="preProcess" access="public" returntype="void" output="true"
		hint="Plugin point called before event processing begins. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="true"
		hint="Plugin point called before each event is processed. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="true"
		hint="Plugin point called after each event is processed. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="true"
		hint="Plugin point called before each view is processed. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="true"
		hint="Plugin point called after each view is processed. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="true"
		hint="Plugin point called after event processing finishes. Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="true"
		hint="Plugin point called when an exception occurs (before exception event is handled). Override to provide custom functionality.">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfargument name="exception" type="cfcunit.machii.util.Exception" required="true" />
		<!--- Override to provide custom functionality. --->
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="abortEvent" access="public" returntype="void" output="false"
		hint="Call this function to abort processing of the current event. When called, an AbortEventException exception is thrown, caught, and handled by the framework.">
		<cfargument name="message" type="string" required="false" default="" />
		<cfthrow type="AbortEventException" message="#arguments.message#" />
	</cffunction>
	
</cfcomponent>
