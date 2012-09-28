
<cfcomponent 
	displayname="PropertyManager"
	output="false"
	hint="Manages defined properties for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.properties = StructNew()>
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var xnProperties = 0 />
		<cfset var i = 0 />
		
		<cfset setAppManager(arguments.appManager) />
		
		<!--- Set the properties from the XML file. --->
		<cfset xnProperties = XMLsearch(configXML,'//property') />
		<cfloop from="1" to="#ArrayLen(xnProperties)#" index="i">
			<cfset setProperty(xnProperties[i].xmlAttributes.name, xnProperties[i].xmlAttributes.value) />
		</cfloop>
		
		<!--- Make sure required properties are set: 
			defaultEvent, exceptionEvent, applicationRoot, eventParameter, parameterPrecedence, maxEvents. --->
		<cfif NOT hasProperty('defaultEvent')>
			<cfset setProperty('defaultEvent', 'defaultEvent') />
		</cfif>
		<cfif NOT hasProperty('exceptionEvent')>
			<cfset setProperty('exceptionEvent', 'exceptionEvent') />
		</cfif>
		<cfif NOT hasProperty('applicationRoot')>
			<cfset setProperty('applicationRoot', '') />
		</cfif>
		<cfif NOT hasProperty('eventParameter')>
			<cfset setProperty('eventParameter', 'event') />
		</cfif>
		<cfif NOT hasProperty('parameterPrecedence')>
			<cfset setProperty('parameterPrecedence', 'form') />
		</cfif>
		<cfif NOT hasProperty('maxEvents')>
			<cfset setProperty('maxEvents', 10) />
		</cfif>
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="getProperty" access="public" returntype="any" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfif isPropertyDefined(arguments.propertyName)>
			<cfreturn variables.properties[arguments.propertyName] />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>
	<cffunction name="setProperty" access="public" returntype="void" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfargument name="propertyValue" required="true" />
		<cfset variables.properties[arguments.propertyName] = arguments.propertyValue />
	</cffunction>
	
	<cffunction name="getProperties" access="public" returntype="struct" output="false">
		<cfreturn variables.properties />
	</cffunction>
	
	<cffunction name="isPropertyDefined" access="public" returntype="boolean" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn StructKeyExists(variables.properties, arguments.propertyName) />
	</cffunction>
	
	<cffunction name="hasProperty" access="public" returntype="boolean" output="false">
		<cfargument name="propertyName" required="true" type="string" />
		<cfreturn StructKeyExists(variables.properties, arguments.propertyName) />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
</cfcomponent>