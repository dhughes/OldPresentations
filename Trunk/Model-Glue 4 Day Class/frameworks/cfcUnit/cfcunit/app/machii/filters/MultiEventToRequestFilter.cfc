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

<cfcomponent name="MultiEventToRequestFilter" extends="cfcunit.machii.framework.EventFilter" output="false"
	hint='
<pre>
Usage syntax:

   <code>
   &lt;event-handler ... &gt;
      ...

      &lt;filter name="multiEventToRequest"&gt;
         &lt;parameter name="eventKeyList" value="[list of event keys]"/&gt;
         &lt;parameter name="requestKeyList" value="[list of request keys]"/&gt;
         &lt;parameter name="delimiter" value="[list delimiter character]"/&gt;
      &lt;/filter&gt;

      ...
   &lt;/event-handler&gt;
   </code>
</pre>'>

	<!--------------------------------------------------------------->
	
	<cfproperty name="delimiter" type="string" hint=""/>
	
	<cfset NULL = "">
	
	<cfset variables["delimiter"] = NULL>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="configure" returntype="void" access="public" output="false" hint="">
		<cfset variables.delimiter = getParameter("delimiter", ",")>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="filterEvent" returntype="boolean" access="public" output="false" hint="">
		<cfargument name="event" type="cfcunit.machii.framework.Event" required="true" hint=""/>
		<cfargument name="eventContext" type="cfcunit.machii.framework.EventContext" required="true" hint=""/>
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" hint=""/>
		<!--- --->
		<cfset var curEvent = arguments.event>
		<cfset var params = arguments.paramArgs>
		<cfset var eventKeys = NULL>
		<cfset var requestKeys = NULL>
		<cfset var delimiter = NULL>
		<cfset var i = 0>
		<cfset var eventKey = NULL>
		<cfset var requestKey = NULL>		
		
		<cfif StructKeyExists(params, "delimiter")>
			<cfset delimiter = params.delimiter>
		<cfelse>
			<cfset delimiter = variables.delimiter>
		</cfif>
	
		<cfif StructKeyExists(params, "eventKeyList")>
			<cfset eventKeys = ListToArray(params.eventKeyList, delimiter)>
		<cfelse>
			<cfthrow type="Exception.Filter.MissingParameters" message="Filter parameter EVENTKEYLIST is a required parameter." detail="eventKeyList"/>
		</cfif>
		
		<cfif StructKeyExists(params, "requestKeyList")>
			<cfset requestKeys = ListToArray(params.requestKeyList, delimiter)>
		<cfelse>
			<cfset requestKeys = eventKeys>
		</cfif>
		
		<cfif ArrayLen(eventKeys) NEQ ArrayLen(requestKeys)>
			<cfthrow type="Exception.Filter.ListSizesMismatch" message="Lists specified for EVENTKEYLIST and REQUESTKEYLIST are not the same length."/>
		</cfif>

		<cfloop index="i" from="1" to="#ArrayLen(eventKeys)#">
			<cfset request[requestKeys[i]] = arguments.event.getArg(eventKeys[i])>
		</cfloop>
		
		<cfreturn TRUE/>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>