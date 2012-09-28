
<cfcomponent 
	displayname="RequestHandler"
	output="false"
	hint="Handles request to event conversion for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false"
		hint="Initializes the RequestHandler.">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset setAppManager(arguments.appManager) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="handleRequest" access="public" returntype="void" output="true">
		<!--- Set the EventArgs scope with Form/URL parameters. --->
		<cfset var eventArgs = getRequestEventArgs() />
		<!--- Get Event. --->
		<cfset var eventName = getEventName(eventArgs) />
		<cfset handleEventRequest(eventName, eventArgs) />
	</cffunction>
	
	<cffunction name="handleEventRequest" access="public" returntype="void" output="true">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventArgs" type="struct" required="true" default="#StructNew()#" />
		
		<cfset var exception = "" />
		<cfset var eventContext = getAppManager().createEventContext() />
		<cfset request.eventContext = eventContext />
		
		<cftry>
			<cfif NOT getAppManager().getEventManager().isEventDefined(arguments.eventName)>
				<cfthrow message="Event-handler for event #arguments.eventName# is not defined." />
			</cfif>
			
			<cfif getAppManager().getEventManager().isEventPublic(arguments.eventName)>
				<cfset eventContext.announceEvent(arguments.eventName, arguments.eventArgs) />
			<cfelse>
				<cfthrow message="Event-handler for event #arguments.eventName# is not accessible." />
			</cfif>
			
			<!--- Handle any errors with the exception event. --->
			<cfcatch type="any">
				<cfset exception = CreateObject('component', 'cfcunit.machii.util.Exception') />
				<cfset exception.init(cfcatch.type, cfcatch.message, cfcatch.errorCode, cfcatch.detail, cfcatch.extendedInfo, cfcatch.tagContext) />
				<cfset eventContext.handleException(exception, true) />
			</cfcatch>
		</cftry>
		
		<!--- Start the event processing. --->
		<cfset eventContext.processEvents() />
	</cffunction>
	
	<!--- PROTECTED EVENTS --->
	<cffunction name="getEventName" access="private" returntype="string" output="false">
		<cfargument name="eventArgs" type="struct" required="true" />
	
		<cfset var eventParam = getAppManager().getPropertyManager().getProperty('eventParameter') />
		<cfset var eventName = "" />
		
		<cfif StructKeyExists(arguments.eventArgs, eventParam)>
			<cfset eventName = arguments.eventArgs[eventParam] />
		<cfelse>
			<cfset eventName = getAppManager().getPropertyManager().getProperty('defaultEvent') />
		</cfif>
		
		<cfreturn eventName />
	</cffunction>
	
	<cffunction name="getRequestEventArgs" access="private" returntype="struct" output="false">
		<cfset var eventArgs = StructNew() />
		<cfset var paramPrecedence = getAppManager().getPropertyManager().getProperty('parameterPrecedence') />
		<cfset var overwriteFormParams = (paramPrecedence EQ 'url') />
		
		<cfset StructAppend(eventArgs, form) />
		<cfset StructAppend(eventArgs, url, overwriteFormParams) />
		
		<cfreturn eventArgs />
	</cffunction>
	
	<cffunction name="setAppManager" access="private" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" output="false" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="private" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>

</cfcomponent>