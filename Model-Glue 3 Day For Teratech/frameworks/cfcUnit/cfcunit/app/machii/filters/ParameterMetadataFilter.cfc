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

<cfcomponent name="ParameterMetadataFilter" extends="cfcunit.machii.framework.EventFilter" output="false">

	<!------------------------------------------------------------------------------------>
	
	
	<cffunction name="configure" access="public" output="false">
		<cfset var preferences = getProperty("preferences")>
		
		<cfif preferences.getProperty("htmlui.parameters.enabled", false)>
			<cfset variables.metadataFactoryClass = preferences.getProperty("htmlui.parameters.className")>
		</cfif>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>
	

	<cffunction name="filterEvent" returntype="boolean" access="public" output="false" hint="">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" hint=""/>
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" hint=""/>
		
		<cfset var factory = "">
		<cfset var metadata = "">

		<cfif structKeyExists(variables, "metadataFactoryClass") and len(variables.metadataFactoryClass)>
			<!---
			<cfset factory = createObject("component", variables.metadataFactoryClass).init()>
			<cfset metadata = factory.getParameterMetadata()>
		
			<cfset arguments.event.setArg("parameterMetadata", metadata)>
			--->
			<cfset arguments.event.setArg("showTestArgs", true)>
		<cfelse>
			<cfset arguments.event.setArg("showTestArgs", false)>
		</cfif>

		<cfreturn true/>
	</cffunction>
	
	
	<!------------------------------------------------------------------------------------>

</cfcomponent>