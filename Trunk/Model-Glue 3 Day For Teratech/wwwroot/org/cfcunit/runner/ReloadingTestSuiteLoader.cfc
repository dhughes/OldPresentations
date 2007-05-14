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

<cfcomponent displayname="ReloadingTestSuiteLoader" extends="org.cfcunit.runner.TestSuiteLoader" output="false" 
	hint="A TestSuite loader that can reload classes.">
	
	<!------------------------------------------------------------------>
	
	<cffunction name="init" returntype="ReloadingTestSuiteLoader" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------>
	
	<cffunction name="createLoader" returntype="org.cfcunit.runner.TestCaseClassLoader" access="public" output="false">
		<cfreturn newObject("org.cfcunit.runner.TestCaseClassLoader")/>
	</cffunction>
	
	<!------------------------------------------------------------------>
	
	<cffunction name="load" returntype="WEB-INF.cftags.component" access="public" output="false">
		<cfargument name="suiteClassName" type="string" required="true"/>
		<!--- --->
		
	</cffunction>
	
	<!------------------------------------------------------------------>
	
	<cffunction name="reload" returntype="WEB-INF.cftags.component" access="public" output="false">
		<cfargument name="class" type="WEB-INF.cftags.component" required="true"/>
		<!--- --->
		
		<cfset var ret = NULL>
		
	
		<cfreturn ret/>
	</cffunction>
	
	<!------------------------------------------------------------------>
	
</cfcomponent>