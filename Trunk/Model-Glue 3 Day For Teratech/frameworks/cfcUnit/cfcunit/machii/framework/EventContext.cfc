<!---
Author: Ben Edwards (ben@ben-edwards.com)

EventContext:
	The framework workhorse. Handles event-queue functionality and event-command execution.
--->
<cfcomponent 
	displayname="EventContext"
	output="false"
	hint="Controls the event queue and event processing mechanism for a request/event lifecycle.">
	
	<!--- PROPERTIES --->
	<cfset variables.eventCount = 0 />
	<cfset variables.viewContext = "" />
	<cfset variables.appManager = "" />
	<cfset variables.eventQueue = "" />
	<cfset variables.currentEventHandler = "" />
	<cfset variables.currentEvent = "" />
	<cfset variables.mappings = StructNew() />
	<cfset variables.exceptionEventName = "" />
	<cfset variables.maxEvents = 10 />
	<cfset variables.isProcessing = false />
	<cfset variables.previousEvent = "" />
	
	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false"
		hint="Initalizes the event-context.">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		
		<cfset var eventQueue = 0 />
		<cfset var viewContext = 0 />
		
		<cfset setAppManager(arguments.appManager) />
		<cfset setExceptionEventName(getAppManager().getPropertyManager().getProperty('exceptionEvent')) />
		<cfset setMaxEvents(getAppManager().getPropertyManager().getProperty('maxEvents')) />
		
		<!--- Setup the event Queue. --->
		<cfset eventQueue = CreateObject('component', 'cfcunit.machii.util.SizedQueue') />
		<cfset eventQueue.init(getMaxEvents()) />
		<cfset setEventQueue(eventQueue) />
		
		<!--- Setup the ViewContext. --->
		<cfset viewContext = CreateObject('component', 'cfcunit.machii.framework.ViewContext') />
		<cfset viewContext.init(getAppManager()) />
		<cfset setViewContext(viewContext) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="announceEvent" access="public" returntype="void" output="true"
		hint="Queues an event for the framework to handle.">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="eventArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var nextEventName = "" />
		<cfset var nextEvent = "" />
		<cfset var exception = "" />
		
		<cftry>
			<!--- Check for an event-mapping. --->
			<cfset nextEventName = getEventMapping(arguments.eventName) />
			<!--- Create the event. --->
			<cfset nextEvent = getAppManager().getEventManager().createEvent(nextEventName, arguments.eventArgs) />
			<!--- Queue the event. --->
			<cfset getEventQueue().put(nextEvent) />
			
			<cfcatch>
				<cfset exception = createException(cfcatch.type, cfcatch.message, cfcatch.errorCode, cfcatch.detail, cfcatch.extendedInfo, cfcatch.tagContext) />
				<cfset handleException(exception, true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="setCurrentEvent" access="private" returntype="void" output="false">
		<cfargument name="currentEvent" type="cfcunit.machii.framework.Event" required="true" />
		<cfset variables.currentEvent = arguments.currentEvent />
	</cffunction>
	<cffunction name="getCurrentEvent" access="public" returntype="cfcunit.machii.framework.Event" output="false">
		<cfreturn variables.currentEvent />
	</cffunction>
	<cffunction name="hasCurrentEvent" access="public" returntype="boolean" output="false">
		<cfreturn IsObject(variables.currentEvent) />
	</cffunction>
	
	<cffunction name="getNextEvent" access="public" returntype="cfcunit.machii.framework.Event" output="false"
		hint="Peeks at the next event in the queue.">
		<cfreturn getEventQueue().peek() />
	</cffunction>
	<cffunction name="hasNextEvent" access="public" returntype="boolean" output="false"
		hint="Peeks at the next event in the queue.">
		<cfreturn hasMoreEvents() />
	</cffunction>
	
	<cffunction name="setPreviousEvent" access="private" returntype="void" output="false">
		<cfargument name="previousEvent" type="cfcunit.machii.framework.Event" required="true" />
		<cfset variables.previousEvent = arguments.previousEvent />
	</cffunction>
	<cffunction name="getPreviousEvent" access="public" returntype="cfcunit.machii.framework.Event" output="false"
		hint="Returns the previous handled event.">
		<cfreturn variables.previousEvent />
	</cffunction>
	<cffunction name="hasPreviousEvent" access="public" returntype="boolean" output="false"
		hint="Returns whether or not getPreviousEvent() can be called to return an event.">
		<cfreturn IsObject(variables.previousEvent) />
	</cffunction>
	
	<cffunction name="hasMoreEvents" access="public" returntype="boolean" output="false">
		<cfreturn NOT getEventQueue().isEmpty() />
	</cffunction>
	
	<cffunction name="setEventMapping" access="public" returntype="string" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfargument name="mappingName" type="string" required="true" />
		<cfset variables.mappings[arguments.eventName] = arguments.mappingName />
	</cffunction>
	<cffunction name="getEventMapping" access="public" returntype="string" output="false">
		<cfargument name="eventName" type="string" required="true" />
		<cfif StructKeyExists(variables.mappings, arguments.eventName)>
			<cfreturn variables.mappings[arguments.eventName] />
		<cfelse>
			<cfreturn arguments.eventName />
		</cfif>
	</cffunction>
	<cffunction name="clearEventMappings" access="public" returntype="void" output="false">
		<cfset StructClear(variables.mappings) />
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="true">
		<cfargument name="exception" type="cfcunit.machii.util.Exception" required="true" />
		<cfargument name="clearEventQueue" type="boolean" required="false" default="true" />
		
		<cfset var nextEventName = "" />
		<cfset var exceptionEvent = "" />
		
		<cftry>
			<cfset nextEventName = getEventMapping(getExceptionEventName()) />
			<cfset exceptionEvent = getAppManager().getEventManager().createEvent(nextEventName) />
			
			<cfset exceptionEvent.setArg('exception', arguments.exception) />
			<cfif hasCurrentEvent()>
				<cfset exceptionEvent.setArg('exceptionEvent', getCurrentEvent()) />
			</cfif>
			
			<cfset getAppManager().getPluginManager().handleException(this, arguments.exception) />
			
			<cfif arguments.clearEventQueue>
				<cfset variables.clearEventQueue() />
			</cfif>
			
			<!---<cfset handleEvent(exceptionEvent) /> --->
			<!--- Queue the exception event instead of handling it immediately. 
			The queue is cleared by default so it will be handled first anyway. --->
			<cfset getEventQueue().put(exceptionEvent) />
			
			<cfcatch type="any">
				<cfrethrow />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="displayView" access="public" returntype="void" output="true">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="viewName" type="string" required="true" />
		<cfargument name="contentKey" type="string" required="false" default="" />
		<cfargument name="append" type="boolean" required="false" default="false" />
		
		<!--- Pre-Invoke. --->
		<cfset getAppManager().getPluginManager().preView(this) />
		
		<cfset getViewContext().displayView(arguments.event, arguments.viewName, arguments.contentKey, arguments.append) />
		
		<!--- Post-Invoke. --->
		<cfset getAppManager().getPluginManager().postView(this) />
	</cffunction>
	
	<cffunction name="processEvents" access="public" returntype="void" output="true"
		hint="Begins processing of queued events. Can only be called once.">
	
		<cfset var pluginManager = "" />
		<cfset var eventManager = "" />
		<cfset var exception = "" />
		
		<cfif getIsProcessing()>
			<cfthrow message="The EventContext is already processing the events in the queue. The processEvents() method can only be called once." />
		</cfif>
		<cfset setIsProcessing(true) />
		
		<cfset pluginManager = getAppManager().getPluginManager() />
		<cfset eventManager = getAppManager().getEventManager() />
	
		<!--- Pre-Process. --->
		<cfset pluginManager.preProcess(this) />
		
		<cfloop condition="hasMoreEvents() AND getEventCount() LT getMaxEvents()">
			<cfset handleNextEvent() />
		</cfloop>
		
		<!--- If there are still events in the queue after done processing, then throw an exception. --->
		<cfif NOT getEventQueue().isEmpty()>
			<cfset exception = createException('MaxEventsExceeded', 'The maximum number of events (#getMaxEvents()#) the framework will process for a single request has been exceeded.') />
			<cfset handleException(exception, true) />
		</cfif>
		
		<!--- Post-Process. --->
		<cfset pluginManager.postProcess(this) />
		<cfset setIsProcessing(false) />
	</cffunction>
	
	<cffunction name="setMaxEvents" access="public" returntype="void" output="false">
		<cfargument name="maxEvents" required="true" type="numeric" />
		<cfset variables.maxEvents = arguments.maxEvents />
	</cffunction>
	<cffunction name="getMaxEvents" access="public" returntype="numeric" output="false">
		<cfreturn variables.maxEvents />
	</cffunction>
	
	<cffunction name="setExceptionEventName" access="public" returntype="void" output="false">
		<cfargument name="exceptionEventName" type="string" required="true" />
		<cfset variables.exceptionEventName = arguments.exceptionEventName />
	</cffunction>
	<cffunction name="getExceptionEventName" access="public" returntype="string" output="false">
		<cfreturn variables.exceptionEventName />
	</cffunction>
	
	<cffunction name="clearEventQueue" access="public" returntype="void" output="false"
		hint="Clears the event queue.">
		<cfset getEventQueue().clear() />
	</cffunction>
	
	<cffunction name="getEventCount" access="public" returntype="numeric" output="false"
		hint="Returns the number of events that have been processed for this context.">
		<cfreturn variables.eventCount />
	</cffunction>
	
	<!--- PRIVATE FUNCTIONS --->
	<cffunction name="handleNextEvent" access="private" returntype="void" output="true">
		<cfset var exception = 0 />
		
		<cftry>
			<cfset incrementEventCount() />
			<cfset handleEvent(getEventQueue().get()) />
			
			<cfcatch type="AbortEventException">
				<!--- Do nothing, just continue event processing. --->
			</cfcatch>
			<cfcatch type="any">
				<cfset exception = createException(cfcatch.type, cfcatch.message, cfcatch.errorCode, cfcatch.detail, cfcatch.extendedInfo, cfcatch.tagContext) />
				<cfset handleException(exception, true) />
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="handleEvent" access="private" returntype="void" output="true">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		
		<cfset var eventName = "" />
		<cfset var eventHandler = 0 />
		
		<cfif hasCurrentEvent()>
			<cfset setPreviousEvent(getCurrentEvent()) />
		</cfif>
		<cfset setCurrentEvent(arguments.event) />
		<cfset request.event = arguments.event />
		
		<cfset eventName = arguments.event.getName() />
		
		<cfset eventHandler = getAppManager().getEventManager().getEventHandler(eventName) />
		<cfset setCurrentEventHandler(eventHandler) />
		
		<!--- Pre-Invoke. --->
		<cfset getAppManager().getPluginManager().preEvent(this) />
		
		<cfset eventHandler.handleEvent(arguments.event, this) />
		
		<!--- Post-Invoke. --->
		<cfset getAppManager().getPluginManager().postEvent(this) />
		
		<!--- Event-mappings only live for one event, so clear them when this event is done executing. --->
		<cfset clearEventMappings() />
	</cffunction>
	
	<cffunction name="setCurrentEventHandler" access="private" returntype="void" output="false">
		<cfargument name="currentEventHandler" type="cfcunit.machii.framework.EventHandler" required="true" />
		<cfset variables.currentEventHandler = arguments.currentEventHandler />
	</cffunction>
	<cffunction name="getCurrentEventHandler" access="private" returntype="cfcunit.machii.framework.EventHandler" output="false">
		<cfreturn variables.currentEventHandler />
	</cffunction>
	
	<cffunction name="createException" access="private" returntype="cfcunit.machii.util.Exception" output="false">
		<cfargument name="type" type="string" required="false" default="" />
		<cfargument name="message" type="string" required="false" default="" />
		<cfargument name="errorCode" type="string" required="false" default="" />
		<cfargument name="detail" type="string" required="false" default="" />
		<cfargument name="extendedInfo" type="string" required="false" default="" />
		<cfargument name="tagContext" type="array" required="false" default="#ArrayNew(1)#" />
		
		<cfset var exception = CreateObject('component', 'cfcunit.machii.util.Exception') />
		<cfset exception.init(arguments.type, arguments.message, arguments.errorCode, arguments.detail, arguments.extendedInfo, arguments.tagContext) />
		
		<cfreturn exception />
	</cffunction>
	
	<cffunction name="incrementEventCount" access="private" returntype="void" output="false">
		<cfset variables.eventCount = variables.eventCount + 1 />
	</cffunction>
	
	<cffunction name="getAppManager" access="private" type="cfcunit.machii.framework.AppManager" output="false">
		<cfreturn variables.appManager />
	</cffunction>
	<cffunction name="setAppManager" access="private" returntype="void" output="false">
		<cfargument name="appManager" type="cfcunit.machii.framework.AppManager" required="true" />
		<cfset variables.appManager = arguments.appManager />
	</cffunction>
	
	<cffunction name="getViewContext" access="private" type="cfcunit.machii.framework.ViewContext" output="false">
		<cfreturn variables.viewContext />
	</cffunction>
	<cffunction name="setViewContext" access="private" returntype="void" output="false">
		<cfargument name="viewContext" type="cfcunit.machii.framework.ViewContext" required="true" />
		<cfset variables.viewContext = arguments.viewContext />
	</cffunction>
	
	<cffunction name="setEventQueue" access="private" returntype="void" output="false">
		<cfargument name="eventQueue" type="cfcunit.machii.util.SizedQueue" required="true" />
		<cfset variables.eventQueue = arguments.eventQueue />
	</cffunction>
	<cffunction name="getEventQueue" access="private" returntype="cfcunit.machii.util.SizedQueue" output="false">
		<cfreturn variables.eventQueue />
	</cffunction>
	
	<cffunction name="setIsProcessing" access="private" returntype="void" output="false">
		<cfargument name="isProcessing" type="boolean" required="true" />
		<cfset variables.isProcessing = arguments.isProcessing />
	</cffunction>
	<cffunction name="getIsProcessing" access="private" returntype="boolean" output="false">
		<cfreturn variables.isProcessing />
	</cffunction>

</cfcomponent>
