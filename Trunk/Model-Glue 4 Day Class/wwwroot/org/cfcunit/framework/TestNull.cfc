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

<cfcomponent displayname="TestNull" extends="org.cfcunit.framework.Test" hint="Represents NULL Test object.">

	<!--------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="true">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false">
		<cfreturn 0/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn "NULL(Test)"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="isNull" returntype="boolean" access="public" output="false">
		<cfreturn TRUE/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
</cfcomponent>