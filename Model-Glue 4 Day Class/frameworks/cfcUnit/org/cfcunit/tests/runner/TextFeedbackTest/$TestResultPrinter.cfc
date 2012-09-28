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

<cfcomponent displayname="TestResultPrinter" extends="org.cfcunit.textui.ResultPrinter" output="false" hint="">
	
	<!---------------------------------------------------------------------->
	
	<cffunction name="init" returntype="$TestResultPrinter" access="public" output="false">
		<cfset super.init()>
		
		<cfreturn this/>
	</cffunction>
	
	<!---------------------------------------------------------------------->
	
	<cffunction name="elapsedTimeAsString" returntype="string" access="private" output="false"
		hint="Spoof printing time so the tests are deterministic">
		
		<cfargument name="runTime" type="numeric" required="true"/>
		
		<cfreturn "0"/>
	</cffunction>
	
	<!---------------------------------------------------------------------->

</cfcomponent>