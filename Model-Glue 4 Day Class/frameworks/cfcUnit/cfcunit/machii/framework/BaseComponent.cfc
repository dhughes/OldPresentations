<!---
Author: Ben Edwards (ben@ben-edwards.com)

MachComponent:
	Base Mach-II component.
--->
<cfcomponent
	displayname="Mach II Base Component">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.parameters = StructNew() />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false"
		hint="Used by the framework to initialize the component.">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true"
			hint="The framework instances' AppManager." />
		<cfargument name="parameters" type="struct" required="false" default="#StructNew()#"
			hint="The initial set of configuration parameters." />
		
		<cfset setAppManager(arguments.appManager) />
		<cfset setParameters(arguments.parameters) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Override to provide custom configuration logic. Called after init().">
		<!--- Override to provide custom configuration logic. Called after init(). --->
	</cffunction>
	
	<cffunction name="announceEvent" access="public" returntype="void" output="false"
		hint="Announces a new event to the framework.">
		<cfargument name="eventName" type="string" required="true"
			hint="The name of the event to announce." />
		<cfargument name="eventArgs" type="struct" required="false" default="#StructNew()#"
			hint="A struct of arguments to set as the event's args." />
		
		<cfif structKeyExists(request,"eventContext")>
			<cfset request.eventContext.announceEvent(arguments.eventName, arguments.eventArgs) />
		<cfelse>
			<cfthrow message="The EventContext necessary to announce events is not set in 'request.eventContext.'" />
		</cfif>
	</cffunction>
	
	<cffunction name="setParameter" access="public" returntype="void" output="false"
		hint="Sets a configuration parameter.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfargument name="value" required="true"
			hint="The parameter value." />
		<cfset variables.parameters[arguments.name] = arguments.value />
	</cffunction>
	<cffunction name="getParameter" access="public" returntype="any" output="false"
		hint="Gets a configuration parameter value, or a default value if not defined.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfargument name="defaultValue" type="string" required="false" default=""
			hint="The default value to return if the parameter is not defined. Defaults to a blank string." />
		<cfif isParameterDefined(arguments.name)>
			<cfreturn variables.parameters[arguments.name] />
		<cfelse>
			<cfreturn arguments.defaultValue />
		</cfif>
	</cffunction>
	<cffunction name="isParameterDefined" access="public" returntype="boolean" output="false"
		hint="Checks to see whether or not a configuration parameter is defined.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfreturn StructKeyExists(variables.parameters, arguments.name) />
	</cffunction>
	<cffunction name="hasParameter" access="public" returntype="boolean" output="false"
		hint="Checks to see whether or not a configuration parameter is defined.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfreturn StructKeyExists(variables.parameters, arguments.name) />
	</cffunction>
	
	<cffunction name="setParameters" access="public" returntype="void" output="false"
		hint="Sets the full set of configuration parameters for the component.">
		<cfargument name="parameters" type="struct" required="true" />
		<cfset var key = '' />
		<cfloop collection="#arguments.parameters#" item="key">
			<cfset setParameter(key, parameters[key]) />
		</cfloop>
	</cffunction>
	<cffunction name="getParameters" access="public" returntype="struct" output="false"
		hint="Gets the full set of configuration parameters for the component.">
		<cfreturn variables.parameters />
	</cffunction>
	
	<cffunction name="setAppManager" access="private" returntype="void" output="false"
		hint="Sets the components AppManager instance.">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true"
			hint="The AppManager instance to set." />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="package" returntype="cfcunit.machii.framework.AppManager" output="false"
		hint="Gets the components AppManager instance.">
		<cfreturn variables.appManager />
	</cffunction>

	<cffunction name="getProperty" access="public" returntype="any" output="false"
		hint="Gets the specified property - this is just a shortcut for getAppManager().getPropertyManager().getProperty()">
		<cfargument name="propertyName" type="string" required="yes"
			hint="The name of the property to return"/>
		<cfif not structKeyExists(variables,"propMgr")>
			<cfset variables.propMgr = getAppManager().getPropertyManager()/>
		</cfif>
		<cfreturn variables.propMgr.getProperty(arguments.propertyName) />
	</cffunction>
	
	<cffunction name="setProperty" access="public" returntype="any" output="false"
		hint="Sets the specified property - this is just a shortcut for getAppManager().getPropertyManager().setProperty()">
		<cfargument name="propertyName" type="string" required="yes"
			hint="The name of the property to set"/>
		<cfargument name="propertyValue" type="any" required="yes" 
			hint="The value to store in the property" />
		<cfif not structKeyExists(variables,"propMgr")>
			<cfset variables.propMgr = getAppManager().getPropertyManager()/>
		</cfif>
		<cfreturn variables.propMgr.setProperty(arguments.propertyName, arguments.propertyValue) />
	</cffunction>

</cfcomponent>
