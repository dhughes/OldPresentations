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

<cfcomponent displayname="SimpleTestCollector" extends="org.cfcunit.runner.ClassPathTestCollector" output="false" 
	hint="
			An implementation of a TestCollector that considers a class to be a test class 
			when it contains the pattern 'Test' in its name.
		">

	<!------------------------------------------------------------------------------>

	<cffunction name="init" returntype="SimpleTestCollector" access="public" output="false">
		<cfargument name="classPath" type="string" required="true" hint="Semi-colon separated list of file paths."/>
		
		<cfset super.init(arguments.classPath)>
		
		<cfreturn this/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>
	
	<cffunction name="isTestClass" returntype="boolean" access="private" output="false">
		<cfargument name="classFileName" type="string" required="true"/>
		<!--- --->
		<cfset var fileName = getFileFromPath(arguments.classFileName)>
		
		<cfif Right(fileName, 4) IS ".cfc" AND Find("Test", fileName, 1) GT 1>
			<cfreturn TRUE/>
		</cfif>
		
		<cfreturn FALSE/>
	</cffunction>
	
	<!------------------------------------------------------------------------------>

</cfcomponent>