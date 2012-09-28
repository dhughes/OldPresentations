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

<cfcomponent displayname="DoubleTestCase" extends="org.cfcunit.framework.Test" hint="">

	<!--------------------------------------------------------------->
	
	<cfproperty name="fTestCase" type="org.cfcunit.framework.TestCase" hint=""/>
	
	<cfset variables.fTestCase = NULL>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="init" returntype="DoubleTestCase" access="public" output="false">
		<cfargument name="testCase" type="org.cfcunit.framework.TestCase" required="true"/>
		
		<cfset variables.fTestCase = arguments.testCase>
		
		<cfreturn this/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="countTestCases" returntype="numeric" access="public" output="false">
		<cfreturn 2/>
	</cffunction>
	
	<!--------------------------------------------------------------->
	
	<cffunction name="run" returntype="void" access="public" output="false">
		<cfargument name="result" type="org.cfcunit.framework.TestResult" required="true"/>
		<!--- --->
		<cfset var prot = newObject("org.cfcunit.tests.framework.TestImplementorTest.DoubleTestCase$Protectable")>
		
		<cfset prot.init(variables)>
		
		<cfset arguments.result.startTest(this)>
		<cfset arguments.result.runProtected(this, prot)>
		<cfset arguments.result.endTest(this)>
	</cffunction>
	
	<!--------------------------------------------------------------->

</cfcomponent>