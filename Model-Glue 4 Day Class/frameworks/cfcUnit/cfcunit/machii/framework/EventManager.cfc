
<cfcomponent 
	displayname="EventManager"
	output="false"
	hint="Manages registered EventHandlers for the framework.">

	<!--- PROPERTIES --->
	<cfset variables.appManager = "" />
	<cfset variables.handlers = StructNew() />
	<!--- temps --->
	<cfset variables.listenerMgr = "" />
	<cfset variables.filterMgr = "" />

	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="configXML" type="string" required="true" />
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var i = 0 />
		<cfset var j = 0 />
		<cfset var commandNodes = "" />
		<cfset var commandNode = "" />
		<cfset var eventNodes = "" />
		<cfset var eventHandler = "" />
		<cfset var eventAccess = "" />
		<cfset var eventName = "" />
		<cfset var eventCommand = "" />
		
		<cfset setAppManager(arguments.appManager) />
		
		<!--- Set temps. --->
		<cfset variables.listenerMgr = arguments.appManager.getListenerManager() />
		<cfset variables.filterMgr = arguments.appManager.getFilterManager() />

		<cfset eventNodes = XMLSearch(configXML,"//event-handlers/event-handler") />
		<cfloop from="1" to="#ArrayLen(eventNodes)#" index="i">
			<cfset eventName = eventNodes[i].xmlAttributes['event'] />
			<cfif StructKeyExists(eventNodes[i].xmlAttributes, 'access')>
				<cfset eventAccess = eventNodes[i].xmlAttributes['access'] />
			<cfelse>
				<cfset eventAccess = 'public' />
			</cfif>
			
			<cfset eventHandler = CreateObject('component', 'cfcunit.machii.framework.EventHandler') />
			<cfset eventHandler.init() />
			<cfset eventHandler.setAccess(eventAccess) />
			<cfset variables.handlers[eventName] = eventHandler />
			
			<cfset commandNodes = XMLSearch(eventNodes[i], "./*") />
			<cfloop from="1" to="#ArrayLen(commandNodes)#" index="j">
				<cfset commandNode = commandNodes[j] />
				<cfset eventCommand = createEventCommand(commandNode) />
				<cfset eventHandler.addCommand(eventCommand) />
			</cfloop>
		</cfloop>
		
		<!--- Clear temps. --->
		<cfset variables.listenerMgr = "" />
		<cfset variables.filterMgr = "" />
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void">
	</cffunction>

	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="createEvent" access="public" returntype="cfcunit.machii.framework.Event" output="true">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventArgs" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="eventType" type="string" required="false" default="cfcunit.machii.framework.Event" />
		
		<cfset var event = 0 />
		
		<cfif isEventDefined(arguments.eventName)>
			<cfset event = CreateObject('component', arguments.eventType) />
			<cfset event.init(arguments.eventName, arguments.eventArgs) />
			<cfreturn event />
		<cfelse>
			<cfthrow type="EventHandlerNotDefined" message="EventHandler for event #arguments.eventName# is not defined." errorcode="2010" />
		</cfif>
		<!---<cfreturn event /> --->
	</cffunction>
	
	<cffunction name="getEventHandler" access="public" returntype="cfcunit.machii.framework.EventHandler">
		<cfargument name="eventName" type="string" required="true" />
		
		<cfset var eventHandler = 0 />
		
		<cfif isEventDefined(arguments.eventName)>
			<cfset eventHandler = variables.handlers[arguments.eventName] />
			<cfreturn eventHandler />
		<cfelse>
			<cfthrow type="EventHandlerNotDefined" message="EventHandler for event #arguments.eventName# is not defined." errorcode="2010" />
		</cfif>
		<!---<cfreturn eventHandler /> --->
	</cffunction>
	
	<cffunction name="isEventDefined" access="public" returntype="boolean" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfreturn StructKeyExists(variables.handlers, arguments.eventName) />
	</cffunction>
	
	<cffunction name="isEventPublic" access="public" returntype="boolean" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfset var eventHandler = 0 />
		<cfset eventHandler = getEventHandler(arguments.eventName) />
		<cfreturn eventHandler.getAccess() EQ 'public' />
	</cffunction>
	
	<cffunction name="setAppManager" access="public" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	<cffunction name="getAppManager" access="public" returntype="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	
	
	<!--- PRIVATE FUNCTIONS --->
	<cffunction name="createEventCommand" access="private" returntype="cfcunit.machii.framework.EventCommand" output="false">
		<cfargument name="commandNode" required="true" />
		
		<cfset var eventCommand = "" />
		<cfset var filterName = "" />
		<cfset var filterParams = 0 />
		<cfset var paramNodes = 0 />
		<cfset var k = 0 />
		<cfset var paramName = "" />
		<cfset var paramValue = "" />
		<cfset var filter = 0 />
		<cfset var argName = "" />
		<cfset var argValue = "" />
		<cfset var argVariable = "" />
		<cfset var mappingEventName = "" />
		<cfset var mappingName = "" />
		<cfset var notifyListener = 0 />
		<cfset var notifyMethod = 0 />
		<cfset var notifyResultKey = 0 />
		<cfset var listener = 0 />
		<cfset var announceEvent = 0 />
		<cfset var copyEventArgs = 0 />
		<cfset var viewName = 0 />
		<cfset var contentKey = 0 />
		<cfset var appendContent = 0 />
		<cfset var beanName = 0 />
		<cfset var beanType = 0 />
		<cfset var beanFields = 0 />
		
		<cfswitch expression="#commandNode.xmlName#">
			<!--- filter --->
			<cfcase value="filter">
				<cfset filterName = commandNode.xmlAttributes['name'] />
				<cfset filterParams = StructNew() />
				<cfset paramNodes = XMLSearch(commandNode, "./parameter") />
				<cfloop from="1" to="#ArrayLen(paramNodes)#" index="k">
					<cfset paramName = paramNodes[k].xmlAttributes['name'] />
					<cfset paramValue = paramNodes[k].xmlAttributes['value'] />
					<cfset filterParams[paramName] = paramValue />
				</cfloop>
				<cfset filter = variables.filterMgr.getFilter(filterName) />
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.FilterCommand') />
				<cfset eventCommand.init(filter, filterParams) />
			</cfcase>
			<!--- event-arg --->
			<cfcase value="event-arg">
				<cfset argName = commandNode.xmlAttributes['name'] />
				<cfif StructKeyExists(commandNode.xmlAttributes, 'value')>
					<cfset argValue = commandNode.xmlAttributes['value'] />
				<cfelse>
					<cfset argValue = "" />
				</cfif>
				<cfif StructKeyExists(commandNode.xmlAttributes, 'variable')>
					<cfset argVariable = commandNode.xmlAttributes['variable'] />
				<cfelse>
					<cfset argVariable = "" />
				</cfif>
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.EventArgCommand') />
				<cfset eventCommand.init(argName, argValue, argVariable) />
			</cfcase>
			<!--- event-mapping --->
			<cfcase value="event-mapping">
				<cfset mappingEventName = commandNode.xmlAttributes['event'] />
				<cfset mappingName = commandNode.xmlAttributes['mapping'] />
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.EventMappingCommand') />
				<cfset eventCommand.init(mappingEventName, mappingName) />
			</cfcase>
			<!--- notify --->
			<cfcase value="notify">
				<cfset notifyListener = commandNode.xmlAttributes['listener'] />
				<cfset notifyMethod = commandNode.xmlAttributes['method'] />
				<cfif StructKeyExists(commandNode.xmlAttributes, 'resultKey')>
					<cfset notifyResultKey = commandNode.xmlAttributes['resultKey'] />
				<cfelse>
					<cfset notifyResultKey = '' />
				</cfif>
				<cfset listener = variables.listenerMgr.getListener(notifyListener) />
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.NotifyCommand') />
				<cfset eventCommand.init(listener, notifyMethod, notifyResultKey) />
			</cfcase>
			<!--- announce --->
			<cfcase value="announce">
				<cfset announceEvent = commandNode.xmlAttributes['event'] />
				<cfif StructKeyExists(commandNode.xmlAttributes, 'copyEventArgs')>
					<cfset copyEventArgs = commandNode.xmlAttributes['copyEventArgs'] />
				<cfelse>
					<cfset copyEventArgs = true />
				</cfif>
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.AnnounceCommand') />
				<cfset eventCommand.init(announceEvent, copyEventArgs) />
			</cfcase>
			<!--- view-page --->
			<cfcase value="view-page">
				<cfset viewName = commandNode.xmlAttributes['name'] />
				<cfif StructKeyExists(commandNode.xmlAttributes, 'contentKey')>
					<cfset contentKey = commandNode.xmlAttributes['contentKey'] />
				<cfelse>
					<cfset contentKey = '' />
				</cfif>
				<cfif StructKeyExists(commandNode.xmlAttributes, 'append')>
					<cfset appendContent = commandNode.xmlAttributes['append'] />
				<cfelse>
					<cfset appendContent = '' />
				</cfif>
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.ViewPageCommand') />
				<cfset eventCommand.init(viewName, contentKey, appendContent) />
			</cfcase>
			<!--- event-bean --->
			<cfcase value="event-bean">
				<cfset beanName = commandNode.xmlAttributes['name'] />
				<cfset beanType = commandNode.xmlAttributes['type'] />
				<cfif StructKeyExists(commandNode.xmlAttributes, 'fields')>
					<cfset beanFields = commandNode.xmlAttributes['fields'] />
				<cfelse>
					<cfset beanFields = '' />
				</cfif>
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.commands.EventBeanCommand') />
				<cfset eventCommand.init(beanName, beanType, beanFields) />
			</cfcase>
			<!--- default/unrecognized command --->
			<cfdefaultcase>
				<cfset eventCommand = CreateObject('component', 'cfcunit.machii.framework.EventCommand') />
				<cfset eventCommand.init() />
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn eventCommand />
	</cffunction>
	
</cfcomponent>