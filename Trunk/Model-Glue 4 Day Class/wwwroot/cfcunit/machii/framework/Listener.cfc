
<cfcomponent
	displayname="Listener"
	extends="cfcunit.machii.framework.BaseComponent"
	output="false"
	hint="Base Listener component.">

	<!--- PROPERTIES --->
	<cfset variables.invoker = "" />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="Listener" output="false"
		hint="Used by the framework. Do not override.">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfargument name="parameters" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="invoker" type="cfcunit.machii.framework.ListenerInvoker" required="false" />
		
		<cfset super.init(arguments.appManager, arguments.parameters) />
		
		<cfif structKeyExists(arguments,'invoker')>
			<cfset setInvoker(arguments.invoker) />
		</cfif>
		<cfreturn this />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="setInvoker" access="public" returntype="void" output="false">
		<cfargument name="invoker" type="cfcunit.machii.framework.ListenerInvoker" required="true" />
		<cfset variables.invoker = arguments.invoker />
	</cffunction>
	<cffunction name="getInvoker" access="public" type="cfcunit.machii.framework.ListenerInvoker" output="false">
		<cfreturn variables.invoker />
	</cffunction>

</cfcomponent>
