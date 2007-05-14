
<cfcomponent 
	displayname="PluginManager"
	output="false"
	hint="Manages registered Plugins for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.plugins = StructNew() />
	<cfset variables.pluginArray = arrayNew(1) />
	<cfset variables.nPlugins = 0 />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var xnPlugins = 0 />
		<cfset var xnParams = 0 />
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var paramName = 0 />
		<cfset var paramValue = 0 />
		<cfset var plugin = 0 />
		<cfset var pluginName = 0 />
		<cfset var pluginType = 0 />
		<cfset var pluginParams = 0 />
		
		<cfset setAppManager(arguments.appManager) />
		
		<cfset xnPlugins = XMLSearch(configXML, "//plugins/plugin" ) />
		<cfloop from="1" to="#ArrayLen(xnPlugins)#" index="i">
			<cfset pluginName = xnPlugins[i].XmlAttributes['name'] />
			<cfset pluginType = xnPlugins[i].XmlAttributes['type'] />
			
			<!--- for each plugin, parse all the parameters --->
			<cfset pluginParams = StructNew() />
			<cfset xnParams = XMLSearch(xnPlugins[i], "./parameters/parameter")>
			<cfloop from="1" to="#ArrayLen(xnParams)#" index="j">
				<cfset paramName = xnParams[j].XmlAttributes['name'] />
				<cfset paramValue = xnParams[j].XmlAttributes['value'] />
				
				<cfset StructInsert(pluginParams, paramName, paramValue, true) />
			</cfloop>
			
			<cfset plugin = CreateObject('component', pluginType) />
			<cfset plugin.init(arguments.appManager, pluginParams) />
			
			<cfset addPlugin(pluginName, plugin) />
		</cfloop>
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
		<cfset var key = 0 />
		<cfloop collection="#variables.plugins#" item="key">
			<cfset getPlugin(key).configure() />
		</cfloop>
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="addPlugin" access="public" returntype="void" output="false">
		<cfargument name="pluginName" type="string" required="true" />
		<cfargument name="plugin" type="cfcunit.machii.framework.Plugin" required="true" />
		<cfset variables.plugins[arguments.pluginName] = arguments.plugin />
		<cfset variables.nPlugins = variables.nPlugins + 1 />
		<cfset variables.pluginArray[variables.nPlugins] = arguments.plugin />
	</cffunction>
	
	<cffunction name="getPlugin" access="public" returntype="cfcunit.machii.framework.Plugin" output="false">
		<cfargument name="pluginName" type="string" required="true" />
		<cfreturn variables.plugins[arguments.pluginName] />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
	<!---
		PLUGIN METHODS called from EventContext.cfc
	--->
	<cffunction name="preProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.preProcess(arguments.eventContext) />
		</cfloop>
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.preEvent(arguments.eventContext) />
		</cfloop>
	</cffunction>

	<cffunction name="postEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.postEvent(arguments.eventContext) />
		</cfloop>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.preView(arguments.eventContext) />
		</cfloop>
	</cffunction>

	<cffunction name="postView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.postView(arguments.eventContext) />
		</cfloop>
	</cffunction>

	<cffunction name="postProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.postProcess(arguments.eventContext) />
		</cfloop>
	</cffunction>

	<cffunction name="handleException" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfargument name="exception" type="cfcunit.machii.util.Exception" required="true" />
		<cfset var aPlugin = 0 />
		<cfset var i = 0 />
		<cfloop index="i" from="1" to="#variables.nPlugins#">
			<cfset aPlugin = variables.pluginArray[i] />
			<cfset aPlugin.handleException(arguments.eventContext, arguments.exception) />
		</cfloop>
	</cffunction>
	
</cfcomponent>