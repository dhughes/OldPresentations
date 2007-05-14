
<cfcomponent 
	displayname="ListenerManager"
	output="false"
	hint="Manages registered Listeners for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.listeners = StructNew() />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var listenerNodes = "" />
		<cfset var listenerParams = "" />
		<cfset var i = 0 />
		<cfset var name = 0 />
		<cfset var type = 0 />
		<cfset var paramNodes = 0 />
		<cfset var j = 0 />
		<cfset var paramName = 0 />
		<cfset var paramValue = 0 />
		<cfset var invokerNodes = 0 />
		<cfset var invokerType = 0 />
		<cfset var invoker = 0 />
		<cfset var listener = 0 />
		
		<cfset setAppManager(arguments.appManager) />

		<!--- Setup up each Listener. --->
		<cfset listenerNodes = XMLSearch(configXML,"//listeners/listener") />
		<cfloop from="1" to="#ArrayLen(listenerNodes)#" index="i">
			<cfset name = listenerNodes[i].xmlAttributes['name'] />
			<cfset type = listenerNodes[i].xmlAttributes['type'] />
		
			<!--- Get the Listener's parameters. --->
			<cfset listenerParams = StructNew() />
			<cfset paramNodes = XMLSearch(listenerNodes[i], "./parameters/parameter") />
			<cfloop from="1" to="#ArrayLen(paramNodes)#" index="j">
				<cfset paramName = paramNodes[j].xmlAttributes['name'] />
				<cfset paramValue = paramNodes[j].xmlAttributes['value'] />
				<cfset listenerParams[paramName] = paramValue />
			</cfloop>
		
			<!--- Setup the Listener's Invoker. --->
			<cfset invokerNodes = XMLSearch(listenerNodes[i], "./invoker") />
			<cfset invokerType = invokerNodes[1].xmlAttributes['type'] />
			
			<cfset invoker = CreateObject('component', invokerType) />
			<cfset invoker.init() />
			
			<!--- Setup the Listener. --->
			<cfset listener = CreateObject('component', type) />
			<cfset listener.init(arguments.appManager, listenerParams) />
			<cfset listener.setInvoker(invoker) />
			<cfset addListener(name, listener) />
		</cfloop> 
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
		<cfset var key = 0 />
		<cfloop collection="#variables.listeners#" item="key">
			<cfset getListener(key).configure() />
		</cfloop>
	</cffunction>

	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="getListener" access="public" returntype="cfcunit.machii.framework.Listener" output="true">
		<cfargument name="listenerName" type="string" required="true">
		
		<cfif isListenerDefined(arguments.listenerName)>
			<cfreturn variables.listeners[arguments.listenerName] />
		<cfelse>
			<cfthrow type="ListenerNotDefined" message="Listener with name #arguments.listenerName# is not defined." errorcode="1010" />
		</cfif>
	</cffunction>
	
	<cffunction name="addListener" access="package" returntype="void" output="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="listener" type="cfcunit.machii.framework.Listener" required="true">
		
		<cfset variables.listeners[arguments.name] = arguments.listener />
	</cffunction>
	
	<cffunction name="isListenerDefined" access="public" returntype="boolean" output="false">
		<cfargument name="listenerName" type="string" required="true" />
		<cfreturn StructKeyExists(variables.listeners, arguments.listenerName) />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
</cfcomponent>