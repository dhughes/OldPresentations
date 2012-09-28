<!---
Author: Ben Edwards (ben@ben-edwards.com)

RequiredFieldsFilter
	This event-filter tests an event for required fields specified.
	If the required fields are not present (or are blank) then event 
	processing is aborted and a specified event is announced.
	
	If the required fields aren't defined then 'message' and 'missingFields' 
	are set in the event.
	
Configuration Parameters:
	None.
	
Event-Handler Parameters:
	"requiredFields" - a comma delimited list of fields required
	"invalidEvent" - the event to announce if all required fields are not in the event
--->
<cfcomponent 
	displayname="RequiredFieldsFilter" 
	extends="cfcunit.machii.framework.EventFilter"
	output="false"
	hint="An EventFilter for testing that an event's args contain a list of required fields.">
	
	<!--- PROPERTIES --->
	<cfset this.REQUIRED_FIELDS_PARAM = "requiredFields" />
	<cfset this.INVALID_EVENT_PARAM = "invalidEvent" />
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="configure" access="public" returntype="void" output="false">
	</cffunction>
	
	<cffunction name="filterEvent" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var isContinue = true />
		<cfset var missingFields = '' />
		<cfset var requiredFields = '' />
		<cfset var invalidEvent = '' />
		<cfset var field = 0 />
		<cfset var newEventArgs = 0 />
		
		<cfif StructKeyExists(arguments.paramArgs,this.REQUIRED_FIELDS_PARAM) 
				AND StructKeyExists(arguments.paramArgs,this.INVALID_EVENT_PARAM)>
			<cfset requiredFields = arguments.paramArgs[this.REQUIRED_FIELDS_PARAM] />
			<cfset invalidEvent = arguments.paramArgs[this.INVALID_EVENT_PARAM] />
			
			<cfloop index="field" list="#requiredFields#" delimiters=",">
				<cfif (NOT event.isArgDefined(field)) OR (event.getArg(field,'') EQ '')>
					<cfset missingFields = ListAppend(missingFields, field, ',') />
					<cfset isContinue = false />
				</cfif>
			</cfloop>
		<cfelse>
			<cfset throwUsageException() />
		</cfif>
		
		<cfif isContinue>
			<cfreturn true />
		<cfelse>
			<cfset newEventArgs = arguments.event.getArgs() />
			<cfset newEventArgs['message'] = "Please provide all required fields. Missing fields: " & ReplaceNoCase(missingFields,',',', ','all') & "." />
			<cfset newEventArgs['missingFields'] = missingFields />
			<cfset arguments.eventContext.announceEvent(invalidEvent, newEventArgs) />
			
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<!--- PROTECTED FUNCTIONS --->
	<cffunction name="throwUsageException" access="private" returntype="void" output="false">
		<cfset var throwMsg = "RequiredFieldsFilter requires the following usage parameters: " & this.REQUIRED_FIELDS_PARAM & ", " & this.INVALID_EVENT_PARAM & "." />
		<cfthrow message="#throwMsg#" />
	</cffunction>
	
</cfcomponent>