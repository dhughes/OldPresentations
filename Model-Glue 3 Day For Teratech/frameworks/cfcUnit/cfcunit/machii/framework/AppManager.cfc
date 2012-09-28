<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="AppManager" 
	output="false"
	hint="The main framework manager.">
	
	<!--- PROPERTIES --->
	<cfset variables.propertyManager = "" />
	<cfset variables.listenerManager = "" />
	<cfset variables.filterManager = "" />
	<cfset variables.eventManager = "" />
	<cfset variables.pluginManager = "" />
	<cfset variables.viewManager = "" />
	<cfset variables.requestHandler = "" />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfset variables.requestHandler = CreateObject('component', 'cfcunit.machii.framework.RequestHandler') />
		<cfset variables.requestHandler.init(this) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="configure" access="public" returntype="void">
		<cfset getPropertyManager().configure() />
		<cfset getPluginManager().configure() />
		<cfset getListenerManager().configure() />
		<cfset getFilterManager().configure() />
		<cfset getEventManager().configure() />
		<cfset getViewManager().configure() />
	</cffunction>
	
	<cffunction name="createEventContext" access="public" returntype="cfcunit.machii.framework.EventContext" output="false">
		<cfset var eventContext = CreateObject('component', 'cfcunit.machii.framework.EventContext') />
		<cfset eventContext.init(this) />
		<cfreturn eventContext />
	</cffunction>
	
	<cffunction name="createRequestHandler" access="public" returntype="cfcunit.machii.framework.RequestHandler" output="false">
		<cfset var requestHandler = CreateObject('component', 'cfcunit.machii.framework.RequestHandler') />
		<cfset requestHandler.init(this) />
		<cfreturn requestHandler />
	</cffunction>
	
	<cffunction name="getRequestHandler" access="public" returntype="cfcunit.machii.framework.RequestHandler" output="false">
		<cfargument name="createNew" type="boolean" required="false" default="false" />
		
		<cfif arguments.createNew>
			<cfreturn createRequestHandler() />
		<cfelse>
			<cfreturn variables.requestHandler />
		</cfif>
	</cffunction>
	
	<cffunction name="getEventManager" access="public" returntype="cfcunit.machii.framework.EventManager" output="false">
		<cfreturn variables.eventManager />
	</cffunction>
	<cffunction name="setEventManager" access="public" returntype="void" output="false">
		<cfargument name="eventManager" type="cfcunit.machii.framework.EventManager" required="true" />
		<cfset variables.eventManager = arguments.eventManager />
	</cffunction>
	
	<cffunction name="getFilterManager" access="public" returntype="cfcunit.machii.framework.FilterManager" output="false">
		<cfreturn variables.filterManager />
	</cffunction>
	<cffunction name="setFilterManager" access="public" returntype="void" output="false">
		<cfargument name="filterManager" type="cfcunit.machii.framework.FilterManager" required="true" />
		<cfset variables.filterManager = arguments.filterManager />
	</cffunction>
	
	<cffunction name="getListenerManager" access="public" returntype="cfcunit.machii.framework.ListenerManager" output="false">
		<cfreturn variables.listenerManager />
	</cffunction>
	<cffunction name="setListenerManager" access="public" returntype="void" output="false">
		<cfargument name="listenerManager" type="cfcunit.machii.framework.ListenerManager" required="true" />
		<cfset variables.listenerManager = arguments.listenerManager />
	</cffunction>
	
	<cffunction name="getPropertyManager" access="public" returntype="cfcunit.machii.framework.PropertyManager" output="false">
		<cfreturn variables.propertyManager />
	</cffunction>
	<cffunction name="setPropertyManager" access="public" returntype="void" output="false">
		<cfargument name="propertyManager" type="cfcunit.machii.framework.PropertyManager" required="true" />
		<cfset variables.propertyManager = arguments.propertyManager />
	</cffunction>
	
	<cffunction name="getPluginManager" access="public" returntype="cfcunit.machii.framework.PluginManager" output="false">
		<cfreturn variables.pluginManager />
	</cffunction>
	<cffunction name="setPluginManager" access="public" returntype="void" output="false">
		<cfargument name="pluginManager" type="cfcunit.machii.framework.PluginManager" required="true" />
		<cfset variables.pluginManager = arguments.pluginManager />
	</cffunction>
	
	<cffunction name="getViewManager" access="public" returntype="cfcunit.machii.framework.ViewManager" output="false">
		<cfreturn variables.viewManager />
	</cffunction>
	<cffunction name="setViewManager" access="public" returntype="void" output="false">
		<cfargument name="viewManager" type="cfcunit.machii.framework.ViewManager" required="true" />
		<cfset variables.viewManager = arguments.viewManager />
	</cffunction>
	
</cfcomponent>