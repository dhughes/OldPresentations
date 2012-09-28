
<cfcomponent 
	displayname="EventFilter"
	extends="cfcunit.machii.framework.BaseComponent"
	output="false"
	hint="Base EventFilter component.">
	
	<!--- PROPERTIES --->
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="EventFilter" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfargument name="parameters" type="struct" required="false" default="#StructNew()#" />
		
		<cfset super.init(arguments.appManager, arguments.parameters) />
		
		<cfreturn this />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="filterEvent" access="public" returntype="boolean"
		hint="Override (be sure to keep the same arguments and returntype) to provide event filtering logic.">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>
