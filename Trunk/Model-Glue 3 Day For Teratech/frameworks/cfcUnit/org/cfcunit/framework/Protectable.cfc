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

<cfcomponent displayname="Protectable" extends="org.cfcunit.Object" output="false" 
	hint="A <em>Protectable</em> can be run and can throw an exception.">

	<!-------------------------------------------------------->
	
	<cfset variables.fContext = NULL>
	
	<!-------------------------------------------------------->
	
	<cffunction name="init" returntype="Protectable" access="public" output="false">
		<cfargument name="context" type="struct" required="true"/>
		
		<cfset variables.fContext = arguments.context>
		
		<cfreturn this/>
	</cffunction>
	
	<!-------------------------------------------------------->
	
	<cffunction name="protect" returntype="void" access="public" output="false" modifiers="abstract"
		throws="Application"
		hint="Run the the following method protected.">
		
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!-------------------------------------------------------->

</cfcomponent>