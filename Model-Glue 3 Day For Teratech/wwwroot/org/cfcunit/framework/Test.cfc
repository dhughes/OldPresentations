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

<cfcomponent displayname="Interface: Test" extends="org.cfcunit.Object" output="false" 
	hint="A Test can be run and collect its results.">

	<!--------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false" hint="Runs a test and collects its result in a TestResult instance.">
		<cfargument name="result" type="TestResult" required="true"/>
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false" hint="Counts the number of test cases that will be run by this test.">
		<cfthrow type="Error.AbstractMethod"/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="toStringValue" returntype="string" access="public" output="false">
		<cfreturn super.toStringValue()/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
</cfcomponent>