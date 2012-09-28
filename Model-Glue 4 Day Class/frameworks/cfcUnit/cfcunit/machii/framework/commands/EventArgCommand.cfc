<!---
Author: Ben Edwards (ben@ben-edwards.com)
--->
<cfcomponent 
	displayname="EventArgCommand" 
	extends="cfcunit.machii.framework.EventCommand"
	output="false"
	hint="An EventCommand for putting an event arg into the current event.">

	<!--- PROPERTIES --->
	<cfset variables.argName = "" />
	<cfset variables.argValue = "" />
	<cfset variables.argVariable = "" />

	<!--- CONSTRUCTOR --->
	<cffunction name="init" access="public" returntype="void" output="false">
		<cfargument name="argName" type="string" required="true" />
		<cfargument name="argValue" type="string" required="false" default="" />
		<cfargument name="argVariable" type="string" required="false" default="" />
		
		<cfset setArgName(arguments.argName) />
		<cfset setArgValue(arguments.argValue) />
		<cfset setArgVariable(arguments.argVariable) />
	</cffunction>
	
	<!--- PUBLIC FUNCTIONS --->
	<cffunction name="execute" access="public" returntype="boolean">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" />
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" />
		
		<cfset var value = "" />
		
		<cfif isArgVariableDefined()>
			<cfset value = getArgVariableValue() />
		<cfelseif isArgValueDefined()>
			<cfset value = getArgValue() />
		<cfelse>
			<cfset value = "" />
		</cfif>
		
		<cfset arguments.event.setArg(getArgName(), value) />
		
		<cfreturn true />
	</cffunction>
	
	<cffunction name="setArgName" access="private" returntype="void" output="false">
		<cfargument name="argName" type="string" required="true" />
		<cfset variables.argName = arguments.argName />
	</cffunction>
	<cffunction name="getArgName" access="private" returntype="string" output="false">
		<cfreturn variables.argName />
	</cffunction>
	
	<cffunction name="setArgValue" access="private" returntype="void" output="false">
		<cfargument name="argValue" type="string" required="true" />
		<cfset variables.argValue = arguments.argValue />
	</cffunction>
	<cffunction name="getArgValue" access="private" returntype="string" output="false">
		<cfreturn variables.argValue />
	</cffunction>
	<cffunction name="isArgValueDefined" access="private" returntype="boolean" output="false">
		<cfreturn NOT getArgValue() EQ '' />
	</cffunction>
	
	<cffunction name="setArgVariable" access="private" returntype="void" output="false">
		<cfargument name="argVariable" type="string" required="true" />
		<cfset variables.argVariable = arguments.argVariable />
	</cffunction>
	<cffunction name="getArgVariable" access="private" returntype="string" output="false">
		<cfreturn variables.argVariable />
	</cffunction>
	<cffunction name="isArgVariableDefined" access="private" returntype="boolean" output="false">
		<cfreturn NOT getArgVariable() EQ '' />
	</cffunction>
	<cffunction name="getArgVariableValue" access="private" returntype="any" output="false">
		<cfset var value = "" />
		<cfif IsDefined(getArgVariable())>
			<cfset value = Evaluate(getArgVariable()) />
		</cfif>
		<cfreturn value />
	</cffunction>

</cfcomponent>