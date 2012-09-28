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

<cfcomponent displayname="StandardTestSuiteLoader" extends="org.cfcunit.runner.TestSuiteLoader" output="false" 
	hint="The standard test suite loader.">

	<!------------------------------------------------------------------------------>

	<cffunction name="init" returntype="StandardTestSuiteLoader" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="load" returntype="WEB-INF.cftags.component" access="public" output="false">
		<cfargument name="class" type="string" required="true"/>
		
		<cfreturn newObject(arguments.class)/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="reload" returntype="WEB-INF.cftags.component" access="public" output="false">
		<cfargument name="object" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		<cfset var metadata = getMetadata(arguments.object)>
		<cfset var componentName = metadata.name>

		<cfreturn newObject(componentName)/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>

</cfcomponent>