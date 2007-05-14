<!---
   Copyright (c) 2006, Paul Kenney
   All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->

<cfcomponent name="TestRunnerSelector" extends="cfcunit.machii.framework.EventFilter" output="false" hint="">

	<!----------------------------------------------------------------------->
	
	<cffunction name="configure" returntype="void" access="public" output="false" hint="">
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="filterEvent" returntype="boolean" access="public" output="false" hint="">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" hint=""/>
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" hint=""/>
		<!--- --->
		<cfset var runnerType = "">
		<cfset var newEventName = "">
		<cfset var newEventArgs = StructNew()>

		<cfif arguments.event.isArgDefined("runnerType")>
			<cfset runnerType = "runnerType." & arguments.event.getArg("runnerType")>
			
			<cfif StructKeyExists(arguments.paramArgs, runnerType)>
				<cfset newEventName = arguments.paramArgs[runnerType]>
				<cfset newEventArgs = arguments.event.getArgs()>
			<cfelseif StructKeyExists(arguments.paramArgs, "InvalidRunnerTypeEventName")>
				<!--- Specified TestRunner Type is not valid. --->
				<cfset newEventName = arguments.paramArgs["InvalidRunnerTypeEventName"]>
				<cfset newEventArgs = arguments.event.getArgs()>
			</cfif>
		<cfelseif StructKeyExists(arguments.paramArgs, "UndefinedRunnerTypeEventName")>
			<!--- TestRunner Type is not specified in the event. --->
			<cfset newEventName = arguments.paramArgs["UndefinedRunnerTypeEventName"]>
			<cfset newEventArgs = arguments.event.getArgs()>
		</cfif>
		
		<cfif NOT Len(newEventName)>
			<cfthrow type="Exception.MachII.Filter" message="Filter 'TestRunnerSelector' could not determine the next event."/>
		</cfif>
		
		<cfset arguments.eventContext.announceEvent(newEventName, newEventArgs)>
		<cfreturn TRUE/>
	</cffunction>
	
	<!----------------------------------------------------------------------->

</cfcomponent>